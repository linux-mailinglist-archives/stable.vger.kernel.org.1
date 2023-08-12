Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D2377A186
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 19:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjHLRwr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 13:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHLRwr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 13:52:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363E11709
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 10:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF6AA61CB4
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 17:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAFEC433C8;
        Sat, 12 Aug 2023 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691862769;
        bh=z2inrZop3bVtFziNddCmf/KSbihDBqkL+Mn0yzvJ6IE=;
        h=Subject:To:Cc:From:Date:From;
        b=l3/eppaTuwguT6nUNyJ6JtC/6jK5WyhKBXxcdi00VVdeF/P/6+TbNgXmQ/PFE9igs
         svV8gXaAaVbdADnngU1yv+gf6qq9fm5vMPVDlJ7Pm3MrzSOfT+gjxx3bu0L1boZWeC
         r5fuRgJcNhvk82X8IsTcPfVvJ78QvfA7umf0sCnQ=
Subject: FAILED: patch "[PATCH] bpf, sockmap: Fix map type error in sock_map_del_link" failed to apply to 5.4-stable tree
To:     xukuohai@huawei.com, john.fastabend@gmail.com,
        martin.lau@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 19:52:38 +0200
Message-ID: <2023081238-calibrate-savanna-77b0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7e96ec0e6605b69bb21bbf6c0ff9051e656ec2b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081238-calibrate-savanna-77b0@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

7e96ec0e6605 ("bpf, sockmap: Fix map type error in sock_map_del_link")
a7ba4558e69a ("sock_map: Introduce BPF_SK_SKB_VERDICT")
b017055255d6 ("sock_map: Kill sock_map_link_no_progs()")
2004fdbd8a2b ("sock_map: Simplify sock_map_link() a bit")
4675e234b9e1 ("sock_map: Make sock_map_prog_update() static")
ae8b8332fbb5 ("sock_map: Rename skb_parser and skb_verdict")
5a685cd94b21 ("skmsg: Get rid of struct sk_psock_parser")
887596095ec2 ("bpf: Clean up sockmap related Kconfigs")
83c11c17553c ("net, sockmap: Don't call bpf_prog_put() on NULL pointer")
ef5659280eb1 ("bpf, sockmap: Allow skipping sk_skb parser program")
743df8b7749f ("bpf, sockmap: Check skb_verdict and skb_parser programs explicitly")
0b17ad25d8d1 ("bpf, sockmap: Add memory accounting so skbs on ingress lists are visible")
10d58d006356 ("bpf, sockmap: Remove skb_orphan and let normal skb_kfree do cleanup")
1e6c62a88215 ("bpf: Introduce sleepable BPF programs")
8ea636848aca ("bpf: Implement bpf_local_storage for inodes")
0813a841566f ("bpf: tcp: Allow bpf prog to write and parse TCP header option")
c9985d09e189 ("bpf: sock_ops: Change some members of sock_ops_kern from u32 to u8")
331fca4315ef ("bpf: tcp: Add bpf_skops_hdr_opt_len() and bpf_skops_write_hdr_opt()")
00d211a4ea6f ("bpf: tcp: Add bpf_skops_parse_hdr()")
72be0fe6ba76 ("bpf: tcp: Add bpf_skops_established()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e96ec0e6605b69bb21bbf6c0ff9051e656ec2b1 Mon Sep 17 00:00:00 2001
From: Xu Kuohai <xukuohai@huawei.com>
Date: Fri, 4 Aug 2023 03:37:37 -0400
Subject: [PATCH] bpf, sockmap: Fix map type error in sock_map_del_link

sock_map_del_link() operates on both SOCKMAP and SOCKHASH, although
both types have member named "progs", the offset of "progs" member in
these two types is different, so "progs" should be accessed with the
real map type.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20230804073740.194770-2-xukuohai@huaweicloud.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 08ab108206bf..8f07fea39d9e 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -146,13 +146,13 @@ static void sock_map_del_link(struct sock *sk,
 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
 		if (link->link_raw == link_raw) {
 			struct bpf_map *map = link->map;
-			struct bpf_stab *stab = container_of(map, struct bpf_stab,
-							     map);
-			if (psock->saved_data_ready && stab->progs.stream_parser)
+			struct sk_psock_progs *progs = sock_map_progs(map);
+
+			if (psock->saved_data_ready && progs->stream_parser)
 				strp_stop = true;
-			if (psock->saved_data_ready && stab->progs.stream_verdict)
+			if (psock->saved_data_ready && progs->stream_verdict)
 				verdict_stop = true;
-			if (psock->saved_data_ready && stab->progs.skb_verdict)
+			if (psock->saved_data_ready && progs->skb_verdict)
 				verdict_stop = true;
 			list_del(&link->list);
 			sk_psock_free_link(link);

