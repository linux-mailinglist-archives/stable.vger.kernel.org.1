Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8373FCD0
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 15:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjF0NZ3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 09:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjF0NZ0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 09:25:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9982943
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 06:25:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31297125334so3970450f8f.0
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687872315; x=1690464315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVOXpy5X1afW0oUVGkH5OMJ/2qjLCE7h8Fvi7leF9aY=;
        b=d2HzVnDe5H5Q0QQuXWGirRXGcEfTzvSGKSFMoXM86yUMpk8Y2nolpt9PJjKw+sfRop
         axXwFP+e32f+iaWRj3r0rxfYSIeqV1fg5IylHaKkQFWP19lm8dgtL0U50GpQXn3FPytZ
         YmwJxVQvWJ/yP2Kvighu328RmrN3R0520QDKE9Lci+iQJvpMUMD/FKk2LRh3592PC7Sc
         l7iS8MnADOnniIgziv+2S5OKFTHPt5rGLC/VAoWFsP/0EhRQWhK0P6NXdM0UQXiB9qe3
         9mFeZv/T07Hs8dZS6elZU0Xba3W4Y+6dvVznyvK979HFI86HaTTHQUxEVk23m7sryuCT
         ONqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687872315; x=1690464315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVOXpy5X1afW0oUVGkH5OMJ/2qjLCE7h8Fvi7leF9aY=;
        b=SmwEAx3RABhIg1gYQhW+TsSCFeBwXXKrM+nkXDAL837pW+cFsmixVx+Tahwlqbt5hr
         BA1WA1scwkVRxSs9MuXmP+kXm1PoN805IJDLau1NtKPDORVC5F2pCobz0IsajEkVOctd
         xF3DHaIk+lReG81kJwFuZDzPo7OgqPGAzSHpWhX/ULeVPwo5oJzFZoSDOhWL4ieLGbbZ
         gQTafxYu4wiunvNDztSlc8oMNYB6tOgQr9NXZiw5W3b5wY3tsmLeHgg6l4GoA4fnM1dr
         RnEL2t4UgkH4DYw53+tzKjlfN6mWMfbceh652Xl9yZHT5a5OVSijx1XQmvG5mLlpRUt6
         Mqig==
X-Gm-Message-State: AC+VfDyaGh5txewk0I1HgDOeSZup7Vza+aNHhUhhDsJG9z4r4H8hnpqf
        aYemeJ9/Bos2LaDEQ2MsIWUb4MyzfCK7Z77/XUcQBw==
X-Google-Smtp-Source: ACHHUZ6FthfO9dsBZWmnZ7Stokbk70mmHetBifjIEmKfMMlCeUufg2dkFxmk5bZdgcfGkicqBAvkfw==
X-Received: by 2002:adf:fa83:0:b0:306:3352:5b8c with SMTP id h3-20020adffa83000000b0030633525b8cmr29503357wrr.7.1687872315507;
        Tue, 27 Jun 2023 06:25:15 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d6ad2000000b00313e90d1d0dsm8529221wrw.112.2023.06.27.06.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:25:15 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     MPTCP Upstream <mptcp@lists.linux.dev>,
        Paolo Abeni <pabeni@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: fix possible divide by zero in recvmsg()
Date:   Tue, 27 Jun 2023 15:25:10 +0200
Message-Id: <20230627132510.2265333-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062346-annoying-sublime-7ac7@gregkh>
References: <2023062346-annoying-sublime-7ac7@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4696; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=DkbpepONqDKmY96usy8COyoWYlTn2Z5Db2UF7nhNSYk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkmuM2IVbLFaiVaMAlmqbsl2sUgfVbDL1uBcRoU
 MVfx9rajMeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJrjNgAKCRD2t4JPQmmg
 c0hYEADVFJvQcQJtltWqh8+pwNetjUTjfUEyh4eZyDurdpYm6TxV7mCENT3zvQivFvx3ZIpSvcD
 qa6uoKwv41HSrMOspeQm3iltBURIh4wVHXUYroqeDNbwi3spmTQZWhQSBHE3De2hLLo3zvjdxEt
 Mq8hmOZH5cIij4XeCeglogj1BK2w06wZ79FJowBbKaHDYTEwztIPPNnJY9+fwNEDRwfQh80clZU
 x6MkpGgKBePlNUNEEzAPdgYJSBpczpCXxxGDCxObzntN/dD68czz8FiIYWjWaVTL8tXX3lHqoXq
 4Gm0rZ0lrlGEV9B+LnwWB3Znv9NbYOws1YN+MtmKUeS3dAScX8nCY77pz5q8Oqv7rKyFxcKMV2E
 EhJNaamL274rGpTyfBEfv4IUjaLHahP0fU7dHCWMcwkPeO/LKSK02dE8e3SZda/3tDALNd8jKVC
 WnRCffs+ym7WY/vpF92Ce126uDzMj6VQ4VAUUFpm0fFhG5POFPhdre5rmFMFrhU74eLXiAlbxyx
 YRJJFNmXE6wttGy9PlgDs80T9XXOuTlX69hOgYUJ2C0FD71kWNIXJlosFCExMosPSHyBwyjaQRH
 lxl18UYz75wqdhjClYRThmrKpzCxrpcIWJAfiB+3H7Hr82EnUSRHkiTHMEViARu/x8CNXSN8yD3 nwMYx/BTLD/IdqA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit 0ad529d9fd2bfa3fc619552a8d2fb2f2ef0bce2e upstream.

Christoph reported a divide by zero bug in mptcp_recvmsg():

divide error: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 19978 Comm: syz-executor.6 Not tainted 6.4.0-rc2-gffcc7899081b #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
RIP: 0010:__tcp_select_window+0x30e/0x420 net/ipv4/tcp_output.c:3018
Code: 11 ff 0f b7 cd c1 e9 0c b8 ff ff ff ff d3 e0 89 c1 f7 d1 01 cb 21 c3 eb 17 e8 2e 83 11 ff 31 db eb 0e e8 25 83 11 ff 89 d8 99 <f7> 7c 24 04 29 d3 65 48 8b 04 25 28 00 00 00 48 3b 44 24 10 75 60
RSP: 0018:ffffc90000a07a18 EFLAGS: 00010246
RAX: 000000000000ffd7 RBX: 000000000000ffd7 RCX: 0000000000040000
RDX: 0000000000000000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 000000000000ffd7 R08: ffffffff820cf297 R09: 0000000000000001
R10: 0000000000000000 R11: ffffffff8103d1a0 R12: 0000000000003f00
R13: 0000000000300000 R14: ffff888101cf3540 R15: 0000000000180000
FS:  00007f9af4c09640(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33824000 CR3: 000000012f241001 CR4: 0000000000170ee0
Call Trace:
 <TASK>
 __tcp_cleanup_rbuf+0x138/0x1d0 net/ipv4/tcp.c:1611
 mptcp_recvmsg+0xcb8/0xdd0 net/mptcp/protocol.c:2034
 inet_recvmsg+0x127/0x1f0 net/ipv4/af_inet.c:861
 ____sys_recvmsg+0x269/0x2b0 net/socket.c:1019
 ___sys_recvmsg+0xe6/0x260 net/socket.c:2764
 do_recvmmsg+0x1a5/0x470 net/socket.c:2858
 __do_sys_recvmmsg net/socket.c:2937 [inline]
 __se_sys_recvmmsg net/socket.c:2953 [inline]
 __x64_sys_recvmmsg+0xa6/0x130 net/socket.c:2953
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x47/0xa0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f9af58fc6a9
Code: 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 37 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007f9af4c08cd8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00000000006bc050 RCX: 00007f9af58fc6a9
RDX: 0000000000000001 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000f00 R11: 0000000000000246 R12: 00000000006bc05c
R13: fffffffffffffea8 R14: 00000000006bc050 R15: 000000000001fe40
 </TASK>

mptcp_recvmsg is allowed to release the msk socket lock when
blocking, and before re-acquiring it another thread could have
switched the sock to TCP_LISTEN status - with a prior
connect(AF_UNSPEC) - also clearing icsk_ack.rcv_mss.

Address the issue preventing the disconnect if some other process is
concurrently performing a blocking syscall on the same socket, alike
commit 4faeee0cf8a5 ("tcp: deny tcp_disconnect() when threads are waiting").

Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/404
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Christoph Paasch <cpaasch@apple.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Conflicting with 3e5014909b56 ("mptcp: cleanup MPJ subflow list handling")
(and 7d803344fdc3 ("mptcp: fix deadlock in fastopen error path")).

I took the new condition that I put first before doing any manipulation
of the join list. Disconnect will be called later.

Applied on top of d2efde0d1c2e ("Linux 5.15.119-rc1").

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b6a38af72e1b..f2977201f8fa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2807,6 +2807,12 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	/* Deny disconnect if other threads are blocked in sk_wait_event()
+	 * or inet_wait_for_connect().
+	 */
+	if (sk->sk_wait_pending)
+		return -EBUSY;
+
 	mptcp_do_flush_join_list(msk);
 
 	mptcp_for_each_subflow(msk, subflow) {
@@ -2845,6 +2851,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 		inet_sk(nsk)->pinet6 = mptcp_inet6_sk(nsk);
 #endif
 
+	nsk->sk_wait_pending = 0;
 	__mptcp_init_sock(nsk);
 
 	msk = mptcp_sk(nsk);
-- 
2.40.1

