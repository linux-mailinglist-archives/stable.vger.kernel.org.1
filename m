Return-Path: <stable+bounces-245119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO64MIGHAWqwcgEAu9opvQ
	(envelope-from <stable+bounces-245119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:38:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E15095FC
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24F393043C30
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE51324B16;
	Mon, 11 May 2026 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="htT7fsja"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA5329C54
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484641; cv=none; b=XT9RAb5hvbC6onCwoq3H4/ncPEIqyrER8hpb+HT37fcVzZf7a9XEUUl0ah9rpHVHskK/LXVYryQRUZMsHX954aryvIzjFKksi2hOfz0PLygnFYi9s0ULy6KXuSKnBXEiZSUcpK/Mj/YdamdCdn0BJgkjVxnwa+i/VnAGEVFBLn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484641; c=relaxed/simple;
	bh=tjm3ZEhc35VabzZoFADkw8/QhRvgUHCjDmHFqBejJf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F2L2WGCqdmSsMNx2XMUHg/fjbJfrz1p/uqiPucRyLsQSebc6hiGtrgzaOGrSWgFxL/YtWlnhIJ0Xm6zHUkMHvZlGCd6G1Gm90aHQbFnUjiIFLCt4f2KA/yOMRoMeMt2wUW5HM1Wwp/mpNGo/UuqkCIJETNoRBj4iadY6neXUZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=htT7fsja; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778484568;
	bh=KjdIqJHowoxVpEK7WVFd42JsQdYJl6fMxtjS9qhH7MQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=htT7fsjay+Wm4ibyplHI3S1LryuHuLktuiVHRKYmrBHImxdYQg2SKbb67V3u8V6FZ
	 o5CG/HY+2eIvI8IyErXmQ53d9BZIhHOp3vKi/304hIiOj6te10lREob9Bfttbdozs3
	 WVpIstKVqgmr6PMI2XYch3sBbJVVq7vJj0hsjtM4=
X-QQ-mid: zesmtpip4t1778484563t7e6fe36d
X-QQ-Originating-IP: mwxHeopkiu049M5/FirOoGmC16V7DrrztqiQx1yGSaM=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 15:29:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6897197227279217065
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: guanwentao@uniontech.com
Cc: dhowells@redhat.com,
	gregkh@linuxfoundation.org,
	imv4bel@gmail.com,
	jiayuan.chen@linux.dev,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 6.12 v2 2/2] rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
Date: Mon, 11 May 2026 15:28:03 +0800
Message-Id: <20260511072803.55131-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260511071833.44144-2-guanwentao@uniontech.com>
References: <20260511071833.44144-2-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NFTN7bD4q20kxBVt9/l9yM2Y/SaATy06hAvT+ZYDfRkVzFdLrl3NCMjm
	UQqfqLMsqjRJIIFA/CE3pnaS70/BkyyMOjqzQEUvmmoQw10S0VYgDip0ZQsnUCqYRZAJa6v
	4QIpHFtflORflGbW0+kqyQshd1Aw0Gftk4zjVcyh1RqDI1vkWVb48I9R7dMFIjX+6dZW4pR
	Tmn7Wi36KWK0PL6AFMsA7YUpxV9a9YRTYrywGXbfx8f5ahsFuMxEghudS3qWOxZFMxakOMr
	RvDc0wGk1rqK8OBHTRaiSBRFbkq90kWIMvOiEuaq2VyDnHRiYnsPz1wSpxh4+gtotKYuBnj
	IRa8exq4WOzZXuM4iVT2cJAsSQgJuHeAPTXVZG8MQR4zdMzGbG0x7QmKWfmgW1n46lwSjrX
	MwJdWVC5tbyhlJODAwXeqVZ4GDCqA3ScFEKYoM04R8UcooK0TLXC5VmFVi+N/L9XfprQOfd
	1bNlYaCOxzFjL4Ku8H9XeGB2uyH+LHkveOnmk5ZgHx3ug4NhxTvSrWjui88Du7kCrAUXrFp
	XDNB6jt6XYbzVmiwqPmdmQu3eyAsMY9ltV/RelhqU0Q/GvjQvnldwoN14lCvq53TGNDL+sh
	uYEIe13/JG2uNKlyEMt4NgRaxHuoyT5gf8YZoNMx/B1R0R5gGMv9aTPY/nReSMVEWjgPx73
	VRbk0Pw6uu4vQnsNXSTa68zoVYIAPTQg7I/AxyH6MPloFpR3rjCLb0+SE/NiEqVIpyIeByF
	FOJvR8ZdSRQsiH9oBPo4exL86URm91tG9oWxfywwbP1Vd386C4hjp+b3H1E5VIZxdcv0sBG
	KV9uj7m2rKylMgqaErHUPyu/o3E25wpL2OJPmr5UGAY6m2t5f1M+z+0BJ2LfiCdsc6DlKkG
	UjKiIQ6U6t5mgl7rEc6K2QNYCtWpfXfQtaTUgo9KJ4vN61wLjyw6v3pgFmM9pbhzvgKfOG0
	JvJtaijVPJ31fitR08wcCNKw7GV0/borcYPYte/7gHGTEDBgpxZaQjwmefeWbNGgScTzLMo
	yVqgZ1k8JrxKfvLCL8ZrJcNZj9itig8WCXh5fwt0DG/c9BBUihCIb9W+A4Sst/Is7gP6BTM
	tXCncxMwaYML0lev/BwKmga2HhjlkIpQe+BzSMzkLHUfFiX6r9g3HbF1gNc/8D0dw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 3A5E15095FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245119-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linuxfoundation.org,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email,linux.dev:email]
X-Rspamd-Action: no action

From: Hyunwoo Kim <imv4bel@gmail.com>

The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
handler in rxrpc_verify_response() copy the skb to a linear one before
calling into the security ops only when skb_cloned() is true.  An skb
that is not cloned but still carries externally-owned paged fragments
(e.g. SKBFL_SHARED_FRAG set by splice() into a UDP socket via
__ip_append_data, or a chained skb_has_frag_list()) falls through to
the in-place decryption path, which binds the frag pages directly into
the AEAD/skcipher SGL via skb_to_sgvec().

Extend the gate to also unshare when skb_has_frag_list() or
skb_has_shared_frag() is true.  This catches the splice-loopback vector
and other externally-shared frag sources while preserving the
zero-copy fast path for skbs whose frags are kernel-private (e.g. NIC
page_pool RX, GRO).  The OOM/trace handling already in place is reused.

Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit aa54b1d27fe0c2b78e664a34fd0fdf7cd1960d71)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/rxrpc/call_event.c | 4 +++-
 net/rxrpc/conn_event.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 62ddaa129ce5a..fda16b39e8e73 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -347,7 +347,9 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 
 		if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
 		    sp->hdr.securityIndex != 0 &&
-		    skb_cloned(skb)) {
+		    (skb_cloned(skb) ||
+		     skb_has_frag_list(skb) ||
+		     skb_has_shared_frag(skb))) {
 			/* Unshare the packet so that it can be modified for
 			 * in-place decryption.
 			 */
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 6dcfaed1f7485..3a58fb9210383 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -231,7 +231,8 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
 {
 	int ret;
 
-	if (skb_cloned(skb)) {
+	if (skb_cloned(skb) || skb_has_frag_list(skb) ||
+	    skb_has_shared_frag(skb)) {
 		/* Copy the packet if shared so that we can do in-place
 		 * decryption.
 		 */
-- 
2.30.2


