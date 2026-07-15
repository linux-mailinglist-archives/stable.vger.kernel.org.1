Return-Path: <stable+bounces-274901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J2HtFzdsV2r8NgEAu9opvQ
	(envelope-from <stable+bounces-274901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:17:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B759E75D79F
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:17:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cG9E8Hhs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274901-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274901-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C745302DB72
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD9641A903;
	Wed, 15 Jul 2026 11:16:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DBD3C9ED5
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:16:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114192; cv=none; b=o0w3ajRvEvJpRW9K85f22YlizctN9+ftfNah4/6seonW8y9fH3kDEGiIoZFcIIQqkDfAXltbF0Ys74/7zCWBFzvBO3OewcUrLWN1bAjBZMtfU40+vQ76+ap7A8VOMxpzqiJ5mHC+ylrUU+e+l3uPfI8PB+ZbnV2XzdjwKGbEsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114192; c=relaxed/simple;
	bh=o2AtSrIus6FhxC5yIf2PaUY8q73CHij10ABtE8H+gII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Od2Q/5JGU12giXdUO+KMbnz4fndJOlQ20FOYJ/sHb4KRYSkH7K5TBKSIIbbZW3drFkPgQ43URhVNjjQOHoWAPnK4exfYhs6B69jhYEKYxD9NdhYA+Oe9CTXXI1pGIY5zggTR84LhQAh3xg0zn2GLqnOmH24LKfC+RcO+qenG34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG9E8Hhs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED5B1F00A3F;
	Wed, 15 Jul 2026 11:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114191;
	bh=5Bd+Xr6sVlqnO0uvcWnjfEtAQEHhEuDBTF6iv9HETjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cG9E8HhszecnC5l/WfVLjZ8V0ZvsncotUyZMmfT8r/CmRT+oFRH+cdblPlA59vyrJ
	 dSl+x9JJz1XORgqKW9QvGoiESzYf0IptydAWLtA9B7taVhs+jD7Pzbzk6fFJERSFCf
	 NWLy45fNp0t/j1Jo9MC7Vh6bsp6oNDrcA160qf2gDfZgfJ02EfVMYBb5XX1J7EJIsI
	 ldPOwOLtstd3I0ROgrAy/veGbXssb34ECqHMM+OHHsXwWl4AN8SE7djdwi7JQDs7pc
	 1JoxFQrh94bME3/HD6SI+TsMMk1IXGZOEeRD3SZIT4lIrib7BLRc6eer0GZuIwHwNH
	 qkNX71OU0y4ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 06/10] staging: rtl8723bs: Remove redundant else branches.
Date: Wed, 15 Jul 2026 07:16:21 -0400
Message-ID: <20260715111625.647536-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715111625.647536-1-sashal@kernel.org>
References: <2026071300-length-drainable-3f8e@gregkh>
 <20260715111625.647536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274901-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sevinj.aghayeva@gmail.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:sevinjaghayeva@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B759E75D79F

From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>

[ Upstream commit 4610e57a7d2edeef14aa852cd945f9920e1759da ]

This patch fixes the following checkpatch.pl warning:

WARNING: else is not generally useful after a break or return

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Link: https://lore.kernel.org/r/20220329140904.GA3566@ubuntu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 29 ++++++++-----------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index d00d7233c298cc..b1b1e72751045e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -98,16 +98,14 @@ int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
 	if (channel > 14) {
 		if (rtw_is_cckrates_included(rate))
 			return WIRELESS_INVALID;
-		else
-			return WIRELESS_11A;
-	} else { /*  could be pure B, pure G, or B/G */
-		if (rtw_is_cckratesonly_included(rate))
-			return WIRELESS_11B;
-		else if (rtw_is_cckrates_included(rate))
-			return	WIRELESS_11BG;
-		else
-			return WIRELESS_11G;
+		return WIRELESS_11A;
 	}
+	/* could be pure B, pure G, or B/G */
+	if (rtw_is_cckratesonly_included(rate))
+		return WIRELESS_11B;
+	if (rtw_is_cckrates_included(rate))
+		return WIRELESS_11BG;
+	return WIRELESS_11G;
 }
 
 u8 *rtw_set_fixed_ie(unsigned char *pbuf, unsigned int len, unsigned char *source,
@@ -158,11 +156,10 @@ u8 *rtw_get_ie(u8 *pbuf, sint index, sint *len, sint limit)
 		if (*p == index) {
 			*len = *(p + 1);
 			return p;
-		} else {
-			tmp = *(p + 1);
-			p += (tmp + 2);
-			i += (tmp + 2);
 		}
+		tmp = *(p + 1);
+		p += (tmp + 2);
+		i += (tmp + 2);
 		if (i >= limit)
 			break;
 	}
@@ -768,9 +765,8 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 			cnt += in_ie[cnt+1]+2;
 
 			break;
-		} else {
-			cnt += in_ie[cnt+1]+2; /* goto next */
 		}
+		cnt += in_ie[cnt+1]+2; /* goto next */
 	}
 
 	return wpsie_ptr;
@@ -820,9 +816,8 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 				*len_attr = attr_len;
 
 			break;
-		} else {
-			attr_ptr += attr_len; /* goto next */
 		}
+		attr_ptr += attr_len; /* goto next */
 	}
 
 	return target_attr_ptr;
-- 
2.53.0


