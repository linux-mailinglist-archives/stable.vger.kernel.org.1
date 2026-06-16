Return-Path: <stable+bounces-265470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xwkuMfuKMWqcmAUAu9opvQ
	(envelope-from <stable+bounces-265470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:42:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28077693627
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:42:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=AxdX9FEh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265470-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265470-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A83E93051C50
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239DC335081;
	Tue, 16 Jun 2026 17:36:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D32543D4E9;
	Tue, 16 Jun 2026 17:35:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631360; cv=none; b=jNIEvc/r/u+GQrJf5ZY72WF2a69JuqvA+H0D2Zvqse1gbwZ54CRHEUURGz/RUVugyBh8rAumF/JrIBN27zEOKVynp+GSvXuaQT6DUwFkx2T6JKzLo0rBppil6ObYLuzoIkK4eDQmRWmw0ib7rl40l2ZPyB8A0QHiWpLmnqLKaF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631360; c=relaxed/simple;
	bh=lDQXyvqkfEKGIwZaRpsgmOlSMvMX9BybkEEVLbgkxSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMFig12d/G3pwJGJTg6Vxfh6tamhJPqd0RDDoa7oRTAJIuQ3bg363CEQD7EDZZx7axysi7LJj7Chc6rv4+xw9OVoyzRKZh0ZW+KjAMyskQzjh6RGkMx8+GumDaohZeQDQKn4YlNeUhD1xZrVxOh7DjtMY+aOCFzbMLD2xUtxJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AxdX9FEh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524D61F000E9;
	Tue, 16 Jun 2026 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631359;
	bh=RmSKpOstwtv52ufND9ONQjUyMp36KG3iLLantz+Js4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AxdX9FEhYoVyy8ksi+od8prYPyD8gjhCrC1Oxb0cKBvYWIb2p8Ot9gx37RqnGXPGp
	 lgtWcCRy45BUrfr66vviBEALudKGK5iS/zAIf2WctaPZ9VuFb5ZncV8qg5vjx4HDQA
	 NqjbMWBXNQqE45ogKxqrfIJ3fDgIKe23iZeFbRxg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	Alexander Aring <aahringo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 205/522] 6lowpan: fix off-by-one in multicast context address compression
Date: Tue, 16 Jun 2026 20:25:52 +0530
Message-ID: <20260616145135.659851654@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-265470-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:zhaoyz24@mails.tsinghua.edu.cn,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:aahringo@redhat.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn,redhat.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tsinghua.edu.cn:email,seu.edu.cn:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28077693627

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

[ Upstream commit 2a58899d11009bffc7b4b32a571858f381121837 ]

The second memcpy in lowpan_iphc_mcast_ctx_addr_compress() uses
&data[1] as destination and &ipaddr->s6_addr[11] as source, but
both should be offset by one: &data[2] and &ipaddr->s6_addr[12]
respectively.

This off-by-one has two consequences:
1. data[1] is overwritten with s6_addr[11], corrupting the RIID
   field in the compressed multicast address
2. data[5] is never written, so uninitialized kernel stack memory
   is transmitted over the network via lowpan_push_hc_data(),
   leaking kernel stack contents

The correct inline data layout must match what the decompression
function lowpan_uncompress_multicast_ctx_daddr() expects:
  data[0..1] = s6_addr[1..2]  (flags/scope + RIID)
  data[2..5] = s6_addr[12..15] (group ID)

Also zero-initialize the data array as a defensive measure against
similar bugs in the future.

Fixes: 5609c185f24d ("6lowpan: iphc: add support for stateful compression")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Acked-by: Alexander Aring <aahringo@redhat.com>
Link: https://patch.msgid.link/20260527081806.42747-1-zhaoyz24@mails.tsinghua.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/6lowpan/iphc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 52fad5dad9f715..d762c49e722fae 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -1086,12 +1086,12 @@ static u8 lowpan_iphc_mcast_ctx_addr_compress(u8 **hc_ptr,
 					      const struct lowpan_iphc_ctx *ctx,
 					      const struct in6_addr *ipaddr)
 {
-	u8 data[6];
+	u8 data[6] = {};
 
 	/* flags/scope, reserved (RIID) */
 	memcpy(data, &ipaddr->s6_addr[1], 2);
 	/* group ID */
-	memcpy(&data[1], &ipaddr->s6_addr[11], 4);
+	memcpy(&data[2], &ipaddr->s6_addr[12], 4);
 	lowpan_push_hc_data(hc_ptr, data, 6);
 
 	return LOWPAN_IPHC_DAM_00;
-- 
2.53.0




