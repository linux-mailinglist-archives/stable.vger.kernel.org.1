Return-Path: <stable+bounces-263881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5lT9M89pMWoEiwUAu9opvQ
	(envelope-from <stable+bounces-263881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:20:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591D4690F12
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:20:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=FCCYspG4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263881-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263881-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 870F430506BB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEAB43C05C;
	Tue, 16 Jun 2026 15:16:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB23C43DA53;
	Tue, 16 Jun 2026 15:16:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622963; cv=none; b=KPTf9DO6JixcFvMfaZwb8s0eeFRyuS1roFLF6yqimHJAoPp8Jq3xIDmMETBOdvYQMTcxrjkdZpZlTN0z3J4IXPTBAvLITb0vwniI4tZ6UZkEAdMw289/sq57rCjhDPgI4lfOLpSlaO6uGpcv86QrYKmWuwRACvoy8iPIGdR2uGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622963; c=relaxed/simple;
	bh=vPUSj4SgdZs7no+zH3LE4HSmhnVM2wgPOklf0v7p3YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzPtMnh3MKn15JIPDWnUHMUODVhRDU/PhmLfd4NO3xhzKxoEGCXL6EMFE/IVTz49pZcH0FDob4sJaBXMHNu+e82uicfThgyqiQtyN8CDL/UHFAX5l+G4WuKlmHzUyW3EPc3WISVOyIm1W474BvuFJefByrYi5PI2YYaBHSm4EAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCCYspG4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938BF1F000E9;
	Tue, 16 Jun 2026 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622962;
	bh=hUk0gHHDuQpTeo15xsMihHzTaxalxPIQkfssC9NIG8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FCCYspG49V0R/qZCYaZfjAFRaZfSKL6dGfQkZKXKXkxZ+tMMHNPRXSxkqVnjALFYR
	 NyHOZ1Brs9PkNO+qcAUoiK5b9sfTCQ8tgFsAo+CzCgktHkKmdrhKSgY2fbLUN9CI5L
	 DFUzAoLPiRf5aEoQhPCHWAGi2cFWBMa6U2BJY4Q8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 062/378] geneve: fix length used in GRO hint UDP checksum adjustment
Date: Tue, 16 Jun 2026 20:24:53 +0530
Message-ID: <20260616145113.277476872@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263881-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:pabeni@redhat.com,m:sashiko-bot@kernel.org,m:atenart@kernel.org,m:horms@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 591D4690F12

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <atenart@kernel.org>

[ Upstream commit 1231623fd3b5aa6b41cce799ffb0d82e10914be4 ]

In geneve_post_decap_hint the length used for adjusting the UDP checksum
should be 'skb->len - gro_hint->nested_tp_offset' (UDP length) instead
of 'skb->len - gro_hint->nested_nh_offset' (IP length).

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Cc: Paolo Abeni <pabeni@redhat.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260521131436.748832-1-jhs%40mojatatu.com
Signed-off-by: Antoine Tenart <atenart@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260529144713.780938-1-atenart@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 01cdd06102e0db..8ea9482d52e538 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -633,7 +633,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 	uh = udp_hdr(skb);
 	uh->len = htons(skb->len - gro_hint->nested_tp_offset);
 	if (uh->check) {
-		len = skb->len - gro_hint->nested_nh_offset;
+		len = skb->len - gro_hint->nested_tp_offset;
 		skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
 		if (gro_hint->nested_is_v6)
 			uh->check = ~udp_v6_check(len, &ipv6h->saddr,
-- 
2.53.0




