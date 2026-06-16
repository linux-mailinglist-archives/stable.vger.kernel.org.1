Return-Path: <stable+bounces-264698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uCJoJV59MWrQkgUAu9opvQ
	(envelope-from <stable+bounces-264698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:44:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD1769266E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:44:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=WIqbTCTG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264698-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264698-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43B68302356C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2F4508F2;
	Tue, 16 Jun 2026 16:29:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D982425CEE;
	Tue, 16 Jun 2026 16:29:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627360; cv=none; b=J/4rGp6Gb9wfc5RX2mNb51gx4ZUmpSNyRpPB1DSzt1tbJwSA1xeAHv0A8eyGgCHHaN5XrJFMgWEyyc5jJ4SLvc1A/+fNAKOOn5c237hMb0N+ZCQxj8KtWrrXObLsYwycXtRe5Y1gaPvcUCQl3S5txvLKlnocVmiOQFd8n3I8GPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627360; c=relaxed/simple;
	bh=fYYpAe/G0UcGPhORsYajpUKUKP1Sc6mMsJaxBwQ4cf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHYln+puwCZUzkzWg/QOtoDJEk5hiU4BXkvkx2Kz5fv0OnOIGWVF3nMGHrKmdkWOiqVFmKttEdnXwkxdcOeYBP6Sv53N7va+VwCJQCVXW9pCWnMIk9Bkhct9Tos9lvgyiP7w9TjrvieA/upqe0gAIbDjrs3uAEe+WI82lTwxIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WIqbTCTG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCBE1F000E9;
	Tue, 16 Jun 2026 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627358;
	bh=NvA2o5aYZ2ygYTLZFUY41sCvposuWY7gq58bNyVcrY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WIqbTCTGz1LjhyttACWDTResMfKDxqSVbIi2WpvnSMewx+WY7yL+06NVl3bQ88JTV
	 ISLCWLuV+URS+wRQrdecyoWecd0bCDaAFnfVq5pJxLn6E78p5v+eQGUWPrr8PYAmrO
	 ptbgMAMxKHSQNWTkrZrz0QYZi1cjBz80H8/7gp1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yuqi Xu <xuyuqiabc@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.12 162/261] wifi: nl80211: reject oversized EMA RNR lists
Date: Tue, 16 Jun 2026 20:30:00 +0530
Message-ID: <20260616145052.579309789@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,intel.com];
	TAGGED_FROM(0.00)[bounces-264698-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:xuyuqiabc@gmail.com,m:n05ec@lzu.edu.cn,m:johannes.berg@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lzu.edu.cn:email,vger.kernel.org:from_smtp,intel.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FD1769266E

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuqi Xu <xuyuqiabc@gmail.com>

commit 4cd92957e8f8cc4ebfe8a5d4203c14c592fde6b1 upstream.

nl80211_parse_rnr_elems() stores the parsed element count in a
u8-backed cfg80211_rnr_elems::cnt field and uses that count to size
the flexible array allocation.

Reject nested NL80211_ATTR_EMA_RNR_ELEMS input once the count reaches
255, before incrementing it again. This keeps the parser aligned with
the data structure it fills and matches the existing bound check used
by nl80211_parse_mbssid_elems().

Fixes: dbbb27e183b1 ("cfg80211: support RNR for EMA AP")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Link: https://patch.msgid.link/20260529152542.1412734-1-n05ec@lzu.edu.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5591,6 +5591,9 @@ nl80211_parse_rnr_elems(struct wiphy *wi
 		if (ret)
 			return ERR_PTR(ret);
 
+		if (num_elems >= 255)
+			return ERR_PTR(-EINVAL);
+
 		num_elems++;
 	}
 



