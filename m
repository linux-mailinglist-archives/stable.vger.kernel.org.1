Return-Path: <stable+bounces-261118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AQzlDFdGJWrcFgIAu9opvQ
	(envelope-from <stable+bounces-261118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:22:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9335A64F94E
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:22:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=gndwGX6s;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261118-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261118-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD82D3071C54
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244E623392F;
	Sun,  7 Jun 2026 10:15:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F22DB788;
	Sun,  7 Jun 2026 10:15:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827320; cv=none; b=i2IhcJg82ns1ufJCvr8ROPAZxqRlcB7QCixMdlCoel0PanNwtYxK56R/73uW89DlkfCUVv0qBTj2ctBl7QiXlvsfjKWAkFY1HAR2kdAKWpOxM8d+VZ5Tohn/4gLBQXBlajl7nXB8dilFrc02l1YLnfyJthFsSmxC1nruj4Y6P9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827320; c=relaxed/simple;
	bh=EGHT7ZRFtENEP77sV+Z8dEUAcPB9nPIEMKHs0QTIJKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6hQ+F0rvrzSo+sg60ZQicAY679I/Nl4AsDDj4WosNOEGs5+pp24XTwNBy9xnu/a9XX7TJVyzT0E86zOi9VH+tho5hTWbdgNhll+eoEptgI2bjprC5ZZt1r3Uld8KYWiL9/1jKxLP1bzmMYsyh5K13tS6CNMwxlN7Uiy865VCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gndwGX6s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495B51F00893;
	Sun,  7 Jun 2026 10:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827319;
	bh=CZPfWwJl6qnCo0ryfdkjpE7811ZFuIhi3dCSmRvWrDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gndwGX6szK9MyOq+tmnpA0VaVlTjWZBdJk6neBdwhPNse0U+33RF4LzZXCefs3Wuy
	 TTZnV4aN6oD0xwJrocAWodVQ6CZhRzwETci80hSba1jFcZkWKU10WkHKv0mhRNtCBD
	 O3wbU/1Imsyv2OBfSH7WkR0qjKuvZT7DAL/UNOnc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luka Gejak <luka.gejak@linux.dev>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 045/307] net: hsr: fix potential OOB access in supervision frame handling
Date: Sun,  7 Jun 2026 11:57:22 +0200
Message-ID: <20260607095729.360963723@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261118-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:luka.gejak@linux.dev,m:fmancera@suse.de,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,suse.de:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9335A64F94E

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index fa97405c517c70..e3037741a74895 100644
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




