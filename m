Return-Path: <stable+bounces-245263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEKcGfv7AWomnAEAu9opvQ
	(envelope-from <stable+bounces-245263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:55:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6116511A63
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB96230EDD88
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3FD40F8DC;
	Mon, 11 May 2026 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxU92nbn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736AF40DFBD;
	Mon, 11 May 2026 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514421; cv=none; b=NgS3mitwjpvmkoWcdsRDYwJhHvsqHECAZEaKkPPZzpzvbLh1YvVS3oCoW708+EXonpOui23OmtLAFs3b2mV8QeDO3HxP0HcLJ9QHhk1/yOmkjQsTdxoW8+YDlRq3keXYKOHza9GRbtxlDSuYFiGnEMbZJgA/kiAT7uir35e1VQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514421; c=relaxed/simple;
	bh=875ceNXWDGdvQ7I0OyeVxJ2mbgg70m3Ihld1Lkt9Y1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l43w40n3b5qq8svcZTjv/o1yn1lrnZobDoQ9EoSpfbx7GVl5S8XR9moPoEyMKbr9eWFtKrveXg//pxzA58z7vG2hU+QyfGlKFk93iErgmGnC4PFqyMZVR4kuQ4c3z/JDJhyJM/hpU0AoaUJiZV/dZWsVp8qXP3Vb8L9uIHRq/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxU92nbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D972C2BCC9;
	Mon, 11 May 2026 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778514421;
	bh=875ceNXWDGdvQ7I0OyeVxJ2mbgg70m3Ihld1Lkt9Y1g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AxU92nbnUi5RpyTlHE1q46LvAPGVPlkzn3B1sL8GGpYZD1UjHjeukqYS0yUbuF1VZ
	 /vbDOCLiLx077JAwCsqEwaYXQsVZS93Pt7nb+eJULhs9ZFiUypfQH4QVycYClz9127
	 8z6oQufxKdlj1kZl4x+EVbN6+qy3AKbWvYe7fKAjTAvE3EBBBGpFXtYyF7aSPFrB+P
	 ul1NlZPQ1UrdbwcmeFEIbNuvH2RwXfpoPFmkVN8tJ5TgdsbwIrDfkkqj9QoaKh6JWA
	 qZpC95O8aE3VTIF53P1FF5TP4LcK46QUCoTZuF5Hk0hCC3+o9G1NG10Byi5CIPgm0u
	 fhl5Fnj/3Gu5w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 11 May 2026 17:46:30 +0200
Subject: [PATCH net 4/5] mptcp: reset rcv wnd on disconnect
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-4-5ee57cb2b7eb@kernel.org>
References: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-0-5ee57cb2b7eb@kernel.org>
In-Reply-To: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-0-5ee57cb2b7eb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Eric Dumazet <edumaze@google.com>, netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mAbY17mEam5+3zBGBgEjswNy0Y5ydPBnaOl3wDshqq4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIYfz4rkL1bH6pvPvPktI2erEuilxq2T3yf8N7a8Y7m1
 G1T7JxDO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbyaRojw81pepu8+HmD9zay
 zt+14eDlZerBFav1mO7f6jsk9aHW0p/hf+XGSsEEVvUjTM8Xaq59Y1ZlzHbhf7dZxKc3vOt2vdD
 czAEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: D6116511A63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245263-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Paolo Abeni <pabeni@redhat.com>

If the MPTCP socket fallback to TCP before the MP handshake completion,
the IASN remain 0, and the rcv_wnd_sent field is not explicitly
initialized, just incremented over time with the data transfer.

At disconnect time such value is not cleared. If the next connection falls
back to TCP before the MP handshake completion, the data transfer will
keep incrementing the receive window end sequence starting from the last
value used in the previous connection: the announced window will be
unrelated from the actual receiver buffer size and likely too big.

Address the issue zeroing the field at disconnect time.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 859df49e16dc..a72a6ad6ee8b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3487,6 +3487,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
+	atomic64_set(&msk->rcv_wnd_sent, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);

-- 
2.53.0


