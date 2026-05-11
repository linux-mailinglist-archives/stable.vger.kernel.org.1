Return-Path: <stable+bounces-245115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHI6LTiEAWoFcAEAu9opvQ
	(envelope-from <stable+bounces-245115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:24:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C385091A9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A6D23010B9D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A00374E6D;
	Mon, 11 May 2026 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="j0V1iFHf"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95336DA1A
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484051; cv=none; b=sl5eX4AdX97f/+QCmZvij3g/ym0xxFzTueaJ2DfhRQEXVkc60KvOcdNZRYePT9Ev+JgP4vgucUcihjbEuaAnxuqDy9DdcZF9cMZpJSm41AxHyRp1dMLCVP5Dv1aA30LN+LfJrPhYcq3e/8z9zl2FliLwySz6icwVTsz93sW9GWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484051; c=relaxed/simple;
	bh=tjm3ZEhc35VabzZoFADkw8/QhRvgUHCjDmHFqBejJf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VGiZfAK8b3KyeaTYSne8PZWBwfjF056vM341Xx0ohWA7WbXBMEntCjk2BuebVDPaNoKhwkqCTXe/C9jNHVHo9FjP3EH6avWdR1utODZM4BEsj91LZmiOPXOWk8gIZRrpSO19l3hFARNSMlbXJ/7qrCwWNCKIx+LHcZ18TbidExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=j0V1iFHf; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778484010;
	bh=KjdIqJHowoxVpEK7WVFd42JsQdYJl6fMxtjS9qhH7MQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=j0V1iFHfeNqeAzHv8HXITC+l0hbMgkLljedYDPUTMpnVcWmhTWBEaEWGdI+TB0J8/
	 vxtMl53UVc2JvjFwo3oVPRrGNylFhenxgjU3JRAyM+Oq4Z2iCQf5R2qQLJBXobOD2X
	 MSOoUXiYS1Egr4QaHotFgA9hp4bDiwlcRAQtzscE=
X-QQ-mid: zesmtpip3t1778484004t5add0f3c
X-QQ-Originating-IP: 58GXN12X5SxB8aC+7CIvdECzWq9AN2xmrmifBLN7DA0=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 15:20:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13241283081051894806
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: dhowells@redhat.com,
	imv4bel@gmail.com,
	jiayuan.chen@linux.dev,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 2/2] rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
Date: Mon, 11 May 2026 15:18:33 +0800
Message-Id: <20260511071833.44144-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260511071833.44144-1-guanwentao@uniontech.com>
References: <2026051109-ocelot-dwindle-a7e9@gregkh>
 <20260511071833.44144-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Ob0dgDnypcmJ33SYOrA7ZbOQRvGhx7ZDTuzxmksw4Bc2V7WNfuqQn5bn
	x8AOKJA9BCwDHDtQCRjvXTvmAtnKCVeRX7/HtECZoTeD0VnTyW2A9YySB2qfMIQWBHQbKLT
	EG4ouVLU1vkgKIhSbbaWEVxFbya9KSr43CN6kf39nwnQY1TZFC0G0R1BbTsD1C+0+pjTNnb
	CxQlfN7nbEHZl8QobsZv+qEkHPAR6PcI2s9ZRv8v6E3vt4HLi1Y1qcPePUe/53AgIXzZ51v
	7133+nPMZuz3fShG89jZNFZH0Iqe6gFIoCnIINiTNSolsLVTcvCElTaeXyjGnKxkabPO/AX
	bjBAjUMLDKwgztVBjNzjO55lPXhNvrKZinZBYonMo/06FlpYgzS5k6p0itA+VYKrWYsTMok
	Xj34QWcF4aK8zXwLYZHzdJ4smcm9oi+H80GeJ9xP6K9sHceumVfoJUxL6EStfGzex/kcjcl
	rsK+zouFHQ4NOEGm1HvMw4Z4DhJHjoUYfGiMWbfNzto83UbpJqdpe5wRgpwjr88rvGQ23gH
	fouUOuCWeJ67K9G9AFgUXJBW0SwZ55mCcEpnOSflG8apT7KWio+FTw+u/ps4B9+yYq36aJK
	NR+BgzIkCxYj7c5qOQv+3yRTWrslE20bmyrq1eY2OR+ALhC8zBpgoaWK+xKqai0T7UilszO
	k1wjP597T/5nKLKfu7Dg/m+yINsfshetK8HwzejY/Wetv7akYncUb+pArqgZTin1LKfBwLy
	n6yA8i0rJA4++NNt/E73pQ4uuPqgsP6iy4Wt2RXsoaJREriH9dh0xP7bEfZBbfhRkPrlPKt
	kJfEjFswbr/7HmXm3SpgpWWSGQX3NmCv7cl/ThCfb0zQqxGs/bBPClWlmnG/c8jnw4ML8LP
	/6/OyK1iAdFlxF9HUJxAlAF3YAMMGKtYO/UGpwIKvzmPVChJVvUZRIXV4XS4o8lOZrKvhwx
	IcR4UUpNqdtuJp2AI/e9z3sfRkAqszvU2v9zJj73b+rZFsTHC4/B8ctJsu7GyCYXH//ssv7
	HmX9J60ty6wtkKdVSVvWk5w6Ts9CdWLCmiW+zs4yxyrHwjpKCvuWLrmekdrvm9eMjnsfbrN
	+K3MzblSN13
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 52C385091A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org,uniontech.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245115-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
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


