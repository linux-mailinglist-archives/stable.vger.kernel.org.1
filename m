Return-Path: <stable+bounces-93936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F0C9D21A6
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0A3282A87
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3AC19CD19;
	Tue, 19 Nov 2024 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLCddbFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1E19C57C;
	Tue, 19 Nov 2024 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005359; cv=none; b=OTPNx1HDg1CfH0IkXlE4p62BwQjaR2JfqKCu51yGP5gdfpw3N5YCFWzrn7jDpSUwQFJyOX9yrFsacSCNyc6x5A6yAVshY7PvldgmKa73WrAbIJT4qfegGTzN3lAdm8Gzum2/TqSobyFq0oFAFC8NLj1O5Z++M7yviypiAz6pvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005359; c=relaxed/simple;
	bh=SVigSOPIPTXyWyW3BHK5VjXaJj/wyC6EsOpbOIAqhW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cn3+WCEjMEzxyK10JmoFdzf1eOSPaNjXk8bR80DpWRMABHzzX5gYsPefOKMHfBLtj4EPg95gq5GMDWUZ55FYyXnaeoSMDQsvbDd+CDP8uAfztwjtmhOObbD25EdQLVEJx62Qr+EGLDjNu/vJAJOndnPXi8bg/JUCinNbdfoDpb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLCddbFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C905BC4CED1;
	Tue, 19 Nov 2024 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732005358;
	bh=SVigSOPIPTXyWyW3BHK5VjXaJj/wyC6EsOpbOIAqhW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLCddbFR9XKjSisnOP68hCYBjwOcauLCCI/5Mjx5tNKI1bjlHBlCQ/u6GyN00oq3I
	 qVT3dOpbCzql0WAHDxCICRXr2baLp+tRQizrjZVdD7UYq9Vo0d5U2JfrWpLuOR/YYr
	 TVN216mHn+Uruo1UhYA6YhXYDAeY67pr0a+n2y18LlZNXpg3K/ov66j2F9iCIHXsyU
	 kngOKRTtWW2Ws16zj3YhJoOFG/PfKpGA54IVVvZ2NPbu7HQJz7zmOLxnxnMZPL8Qde
	 3j8g1LweJ8E0QQPF6dHz1X8VvJ7h53+kGLHm9BIZK7c9Ooef1yQbG1qYwSVVNCInpw
	 pTEE5UA52ZNYg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 1/7] mptcp: cope racing subflow creation in mptcp_rcv_space_adjust
Date: Tue, 19 Nov 2024 09:35:49 +0100
Message-ID: <20241119083547.3234013-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119083547.3234013-9-matttbe@kernel.org>
References: <20241119083547.3234013-9-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=matttbe@kernel.org; h=from:subject; bh=NsYKbmCRaB8Vh/E7YFJfPDwZvCqJdiPN1sl2VILwj2I=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnPE3jgfPmg0lZ3X480DwZ5pHtLcNIkzaLE7c3u fmnp0fQx0yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzxN4wAKCRD2t4JPQmmg cxL+D/9g3IfLS3G6xyH4MgL/eXC6TXEfLs2nXWQFcXroMVEiJOUNBBXlWV8sTr/EY/xFrwirJf7 J888HhFrP8g4F6Ri3ZlBzr2/QCQCKz4SDEuXAwLnigdU8b8JHpv4g/V4JKCsPbdKjQtEW5/MwPZ iRHXs6jrQBQZf01i0asqgR3Qc4gq2nl2EX8BNLX5FfdVrNW0Evl1Zrk9MPNFnj8vmSJri1a9Jc3 KW/dih115JPnQCfMbAmoFNOhktVjWQxJtWEy6Q0C+kKSMJAHl3TM9JhGOHN2IFdz6tUvv46oTST xfKhxAAtnvq+6j+PcV/FWnGZfcie4TLi7enQBpFPiRtJP79LdddUnKefmxRbBSDXi6FT2+LuM7J dsyHN3nPPnbNjcn9cUGu5VELITL66D6/212/SozrfQZJqN72YE+zM+uOr/G+uPgGxNDUf3xHAYN +YVUTixSRSRo0pVflWDk30RP57BpOhKBWkc6zFfAmrhsJtdddZN6HBlWv7Y033fVxyVgjcbWrcJ pwUyvUbRevECgLO4Qja4lr9wkRarfZLUyFULAo1RW/QsPfHK8IBi3aE5JXSztwVRp4tPGK7F47+ BfYodf/gfuUMdXWIy/ade6JBkHtu5JhjRGBvWBnDR4OQTxOhK2ylgw0EKhq4r5xfS5l8B8DgkQR Tj0D7cAd7IVH9Og==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit ce7356ae35943cc6494cc692e62d51a734062b7d upstream.

Additional active subflows - i.e. created by the in kernel path
manager - are included into the subflow list before starting the
3whs.

A racing recvmsg() spooling data received on an already established
subflow would unconditionally call tcp_cleanup_rbuf() on all the
current subflows, potentially hitting a divide by zero error on
the newly created ones.

Explicitly check that the subflow is in a suitable state before
invoking tcp_cleanup_rbuf().

Fixes: c76c6956566f ("mptcp: call tcp_cleanup_rbuf on subflows")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/02374660836e1b52afc91966b7535c8c5f7bafb0.1731060874.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in protocol.c, because commit f410cbea9f3d ("tcp: annotate
  data-races around tp->window_clamp") has not been backported to this
  version. The conflict is easy to resolve, because only the context is
  different, but not the line to modify. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 78ac5c538e13..1acd4e37a0ea 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2057,7 +2057,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 				slow = lock_sock_fast(ssk);
 				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
 				tcp_sk(ssk)->window_clamp = window_clamp;
-				tcp_cleanup_rbuf(ssk, 1);
+				if (tcp_can_send_ack(ssk))
+					tcp_cleanup_rbuf(ssk, 1);
 				unlock_sock_fast(ssk, slow);
 			}
 		}
-- 
2.45.2


