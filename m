Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658FD74C27B
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjGILVJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjGILVI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AF418C
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14AE860BB7
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A73C433C7;
        Sun,  9 Jul 2023 11:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901661;
        bh=BrHVtI39Tbrh68XMJrHlBDtfg+7kGQHajXHqZzLBf2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqaCojkXNYHFCz+JxFWjR717cBfqte59CXD0miEuTXJBloAv6UUNxqGInIMFI01mw
         9UA06vwhyPiFyhPYOafxUpP1udW5aKsaPOsQoXlR5y65UGwmWl87Jiob4ZD6jfVpFP
         bt8+50JwtAmxYTRCDESqL/GIzv8pI+OKT0LA2ZhQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yafang Shao <laoar.shao@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>, Jiri Olsa <olsajiri@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 092/431] bpf: Fix memleak due to fentry attach failure
Date:   Sun,  9 Jul 2023 13:10:40 +0200
Message-ID: <20230709111453.309608267@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit 108598c39eefbedc9882273ac0df96127a629220 ]

If it fails to attach fentry, the allocated bpf trampoline image will be
left in the system. That can be verified by checking /proc/kallsyms.

This meamleak can be verified by a simple bpf program as follows:

  SEC("fentry/trap_init")
  int fentry_run()
  {
      return 0;
  }

It will fail to attach trap_init because this function is freed after
kernel init, and then we can find the trampoline image is left in the
system by checking /proc/kallsyms.

  $ tail /proc/kallsyms
  ffffffffc0613000 t bpf_trampoline_6442453466_1  [bpf]
  ffffffffc06c3000 t bpf_trampoline_6442453466_1  [bpf]

  $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep "FUNC 'trap_init'"
  [2522] FUNC 'trap_init' type_id=119 linkage=static

  $ echo $((6442453466 & 0x7fffffff))
  2522

Note that there are two left bpf trampoline images, that is because the
libbpf will fallback to raw tracepoint if -EINVAL is returned.

Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <song@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>
Link: https://lore.kernel.org/bpf/20230515130849.57502-2-laoar.shao@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/trampoline.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 213d9b3cb06ad..fecb8d2d885a3 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -279,11 +279,8 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 	return tlinks;
 }
 
-static void __bpf_tramp_image_put_deferred(struct work_struct *work)
+static void bpf_tramp_image_free(struct bpf_tramp_image *im)
 {
-	struct bpf_tramp_image *im;
-
-	im = container_of(work, struct bpf_tramp_image, work);
 	bpf_image_ksym_del(&im->ksym);
 	bpf_jit_free_exec(im->image);
 	bpf_jit_uncharge_modmem(PAGE_SIZE);
@@ -291,6 +288,14 @@ static void __bpf_tramp_image_put_deferred(struct work_struct *work)
 	kfree_rcu(im, rcu);
 }
 
+static void __bpf_tramp_image_put_deferred(struct work_struct *work)
+{
+	struct bpf_tramp_image *im;
+
+	im = container_of(work, struct bpf_tramp_image, work);
+	bpf_tramp_image_free(im);
+}
+
 /* callback, fexit step 3 or fentry step 2 */
 static void __bpf_tramp_image_put_rcu(struct rcu_head *rcu)
 {
@@ -465,7 +470,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 					  &tr->func.model, tr->flags, tlinks,
 					  tr->func.addr);
 	if (err < 0)
-		goto out;
+		goto out_free;
 
 	set_memory_rox((long)im->image, 1);
 
@@ -494,7 +499,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	}
 #endif
 	if (err)
-		goto out;
+		goto out_free;
 
 	if (tr->cur_image)
 		bpf_tramp_image_put(tr->cur_image);
@@ -505,6 +510,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		tr->flags = orig_flags;
 	kfree(tlinks);
 	return err;
+
+out_free:
+	bpf_tramp_image_free(im);
+	goto out;
 }
 
 static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
-- 
2.39.2



