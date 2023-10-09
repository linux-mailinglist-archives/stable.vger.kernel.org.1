Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010997BDD9E
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376907AbjJINL2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376876AbjJINLH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:11:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A921B1
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:10:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C358FC433C7;
        Mon,  9 Oct 2023 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857031;
        bh=VFGEDoyKozhMBftvcqHkiEnkSKyVWutpJza7nH/fsQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=THxACQKfgfqjR0W2NqebhsDx8Nr9txxeT6lh1ELW+bcMmbQVNx9cN1tk2DT8dpQ43
         qOeeGXr2OkJYu1sfgfz2KGAWxVla2Z5yR5ARZLUanfCQJZLuaOXKidCWDEiU91PdLt
         wPY7KtFd8ObSgQEcAAEYFsBooSNaYZBOsWiQYQvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Song Liu <song@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 073/163] s390/bpf: Let arch_prepare_bpf_trampoline return program size
Date:   Mon,  9 Oct 2023 15:00:37 +0200
Message-ID: <20231009130126.068022883@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Liu <song@kernel.org>

[ Upstream commit cf094baa3e0f19f1f80ceaf205c80402b024386c ]

arch_prepare_bpf_trampoline() for s390 currently returns 0 on success. This
is not a problem for regular trampoline. However, struct_ops relies on the
return value to advance "image" pointer:

bpf_struct_ops_map_update_elem() {
    ...
    for_each_member(i, t, member) {
        ...
        err = bpf_struct_ops_prepare_trampoline();
        ...
        image += err;
    }
}

When arch_prepare_bpf_trampoline returns 0 on success, all members of the
struct_ops will point to the same trampoline (the last one).

Fix this by returning the program size in arch_prepare_bpf_trampoline (on
success). This is the same behavior as other architectures.

Signed-off-by: Song Liu <song@kernel.org>
Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Link: https://lore.kernel.org/r/20230919060258.3237176-2-song@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index de2fb12120d2e..2861e3360affc 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2513,7 +2513,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 			return -E2BIG;
 	}
 
-	return ret;
+	return tjit.common.prg;
 }
 
 bool bpf_jit_supports_subprog_tailcalls(void)
-- 
2.40.1



