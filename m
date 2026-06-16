Return-Path: <stable+bounces-265282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CmfzKhaIMWpdlwUAu9opvQ
	(envelope-from <stable+bounces-265282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:29:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA91169331F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:29:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=l4xqOM6E;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265282-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-265282-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 035CF30638CE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC15478E26;
	Tue, 16 Jun 2026 17:20:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE931A6803;
	Tue, 16 Jun 2026 17:20:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630409; cv=none; b=PCp6gwQJl6aqUO3toaEMc+p1ZWycANAAlLxV1XqRVZ8DRzurXReP0NuKufJTpz/S0uNi7c/83U5fQ23EReiPGer6db3w3DhqXssQyfn7Ahufq9fGCH99zU+RFsxIcZILdUBg736WVt5V0cPR/If98+JvyMz06eQRF2LVr/3v11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630409; c=relaxed/simple;
	bh=Pnh86aQwUvfWwju0qJcsYh83VU0/CvAwTl85BfGfCTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAhlRDXZ5GPxtTlYeAd9tjXs+OZzTr7e/V+MKpmZdP+yrkhlGE+mCbuxRqcXeBtn85cQWqZoZEGHlIXdx75CvlWRPcEo0PMnrNk5cIA7GvQt27mEEEM50eO14ANb3ab/efSH7zv+XvnlxTIEz6BDv+eodi7UkaShjs9Fy4EtVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l4xqOM6E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8A51F000E9;
	Tue, 16 Jun 2026 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630408;
	bh=7bVdzUy++Kh09KOm0r/hCtUGk0U/RpPIh07l8AwgRi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4xqOM6EENQaPtJoDbYH1X1SWroJ7ixN1Rm20xpxdHO9jke83KLy3qtXKMEM3nEzU
	 fMEo0sGtOCUT96fegRwig+aEsvE4hqczDL4GZ78mcPYAqdJHMilpvY8fILUlcL1gs/
	 mYiMwxD96zDyB9UbdXLF2K1Av/P26sfwObu17qP0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luka Gejak <luka.gejak@linux.dev>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 024/522] net: hsr: fix potential OOB access in supervision frame handling
Date: Tue, 16 Jun 2026 20:22:51 +0530
Message-ID: <20260616145126.740024135@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265282-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:luka.gejak@linux.dev,m:fmancera@suse.de,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA91169331F

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luka Gejak <luka.gejak@linux.dev>

[ Upstream commit f229426072fc865654a60978bb7fda790a051ff3 ]

Ensure the entire TLV header is linearized before access by adding
sizeof(struct hsr_sup_tlv) to the pskb_may_pull() calls. Without this,
a truncated frame could cause an out-of-bounds access.

Fixes: eafaa88b3eb7 ("net: hsr: Add support for redbox supervision frames")
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Link: https://patch.msgid.link/20260523130330.61880-1-luka.gejak@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_forward.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 3852fd99509f04..7a596c4f603e2d 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -84,7 +84,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 
 	/* Get next tlv */
 	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
-	if (!pskb_may_pull(skb, total_length))
+	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
 		return false;
 	skb_pull(skb, total_length);
 	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
@@ -100,7 +100,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 
 		/* make sure another tlv follows */
 		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
-		if (!pskb_may_pull(skb, total_length))
+		if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
 			return false;
 
 		/* get next tlv */
-- 
2.53.0




