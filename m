Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F397655BA
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 16:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjG0OQz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 10:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjG0OQv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 10:16:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD3830E1
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 07:16:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31786b71fdcso118525f8f.2
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690467408; x=1691072208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdBiJRTVLQgSDTCqHCKJArVFV2i8PVZZ1iHZaPXIK0o=;
        b=dRXszYkjbAvt4+7iWWT+wIEo5spzaq5kR1dbyYpG87uKy3FO+FN9vZAO67VD7b8F+o
         uYgeM0hIbN8CAO6Jw9lLWOlZTvnBp7JxXG/r0RLWB+740/sw8WmcJHAbJUHFgj8vzgP6
         odfxCQjT0GkN2n4R449rqr2x7vK99wM5amkxQRTZpTDbcnvMGmZd3I3iL6ksyzFWR/Cg
         +IgzkhD0IenXu+qz1O0P7LD/oH/m2x6gWhSfRh12e5zh6uL55xbL45loAZZ7VpG1R/mi
         ENeJ3iD4x0Wdw8yQRGibZWFxLAIssRGUECrfq7z2QKLJ/zli0e7C14yAIWpBliKS58/6
         IxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467408; x=1691072208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdBiJRTVLQgSDTCqHCKJArVFV2i8PVZZ1iHZaPXIK0o=;
        b=UNnv384Md/V+T7HR1/phHzsEOUYMmxTW5cLV08wLFZxfmCHVPuhZuhPWL3pFW/0sPC
         JST0qbFJn1c3Zd9sizhi3p1CkvOuC71RB4nJP2oetPYNlzOZcqTlATLCL8bGvBLSOlZG
         kEuGWD8jk71AvZHPhMKnkXL4p1qTwNLM/spqpVYyXih7HFhh6HW9rxahGf8AhHzffTvz
         QL3oTM49GNC1ryRCtTYf8XcGa9xeCtFvGwrR9a7MEdUpo9156ygRXKmcj/MMp7ByjNTw
         5efVNOIIhE/KdBTvo5Cba+pNVldCqeoYqKPAQCU4XYTRY0tsIx0PN3LW6nk3vvxtfpos
         dizg==
X-Gm-Message-State: ABy/qLZtr8TL4doyg1s0A11WnLddfqbwG3J961mj+230rMhnA0G6f28s
        0EnxNQwwAnNyImcgWVTGtjyM0PakmaPwkJL5UbNbSw==
X-Google-Smtp-Source: APBJJlHrSBnSw3+g+U8/tdnXFBrZ3LwZWvrv37dafUxxWaOfbueT+gAr9x1YJJ3hkciF/NwH4qBgxw==
X-Received: by 2002:a5d:66cf:0:b0:314:336e:d4d8 with SMTP id k15-20020a5d66cf000000b00314336ed4d8mr1888603wrw.8.1690467407965;
        Thu, 27 Jul 2023 07:16:47 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c1d0500b003fbb1ce274fsm17284455wms.0.2023.07.27.07.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:16:47 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     MPTCP Upstream <mptcp@lists.linux.dev>,
        Paolo Abeni <pabeni@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y] mptcp: do not rely on implicit state check in mptcp_listen()
Date:   Thu, 27 Jul 2023 16:16:25 +0200
Message-Id: <20230727141625.2524544-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023072119-skipping-penalize-15f0@gregkh>
References: <2023072119-skipping-penalize-15f0@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=Wnc4qR5ZHikHen649AXud3YY0VIToNZ0CmE0rTOAknU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkwnw5/eLY4LKMKzYBHIw79gyhLoHy3aU2Y5wxL
 V3QTEF2wkCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMJ8OQAKCRD2t4JPQmmg
 cz7yEACN1UHhWpoXRu45Io0XaahFhR0hVaY9BZi+xSEWIRV6yd80f8S3wvTfmLfXAESRxVbtR/6
 eY84RFgb7cIaMj48ZbzThQkZvqL7hgEePlurSEQin2nQxOxTSbo/YjZCzS20QjCd/FcSkGMZd5M
 r6d4Gcf5Xj0vth3pqwPgVMGbSmBYqEMxM+ZbZ9QRxxnzUiuARGw97YuI4yTlG0xbWqvrxFriq4+
 qTT7aJpmeeGxvYf2mdn2OZCw4QjlJ14aW1ORv6sUXGFUNejIfef7W6QWyYqLmyCAZuLk0riHo0T
 bpiE3HwC5YFUwqDGjb8KZ+OlVwZj13N+F6FvcB3362EVTGpDGrcP3Z+0qZtjHALFS8VqVA/BJM6
 dDUzYMOm2Gs9+VCjNXCiCbtBcAWSkMQ6tbM1adjYglI1C2x5IdoMMJdCPpUvLCuIQeBy1oONb2p
 nwzx1D8otLpwTSk+WVDJ4bnLv1jAgFevGezTaXv737oWFoADgFKT2iR1zyZ8axLLJ7J0m0AtqcK
 Led9CFTpHdPuUHbfz7OrXGoR0qjBUwjPQd3VlVmCw/2FSI8fif4sLYg41haDkeWtJ82tSZyKHu2
 JEf7IYsG6p1Uj5xnrzFQPa+DGyq1KlCjBE8MyPeJHk0jNftlUwxDyd+rFrPjhezb6pUBMnxhuFO vUZmTBvUV+2Aqeg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit 0226436acf2495cde4b93e7400e5a87305c26054 upstream.

Since the blamed commit, closing the first subflow resets the first
subflow socket state to SS_UNCONNECTED.

The current mptcp listen implementation relies only on such
state to prevent touching not-fully-disconnected sockets.

Incoming mptcp fastclose (or paired endpoint removal) unconditionally
closes the first subflow.

All the above allows an incoming fastclose followed by a listen() call
to successfully race with a blocking recvmsg(), potentially causing the
latter to hit a divide by zero bug in cleanup_rbuf/__tcp_select_window().

Address the issue explicitly checking the msk socket state in
mptcp_listen(). An alternative solution would be moving the first
subflow socket state update into mptcp_disconnect(), but in the long
term the first subflow socket should be removed: better avoid relaying
on it for internal consistency check.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/414
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Backport notes:
  - Conflicting with a cleanup that has been done after v6.1, see commit
    cfdcfeed6449 ("mptcp: introduce 'sk' to replace 'sock->sk' in
    mptcp_listen()").
  - The conflict was in the context and the new lines didn't need to be
    adapted.
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a6a5c16f2a49..b76cda4187bc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3752,6 +3752,11 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	pr_debug("msk=%p", msk);
 
 	lock_sock(sock->sk);
+
+	err = -EINVAL;
+	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
+		goto unlock;
+
 	ssock = __mptcp_nmpc_socket(msk);
 	if (!ssock) {
 		err = -EINVAL;
-- 
2.40.1

