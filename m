Return-Path: <stable+bounces-215397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHMpI+X0iWkaFAAAu9opvQ
	(envelope-from <stable+bounces-215397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:53:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E81111294
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F10EA3037931
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D4337A488;
	Mon,  9 Feb 2026 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PZoUpkp8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9CB28725B;
	Mon,  9 Feb 2026 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648660; cv=none; b=nENrFH2i1GwUh3kPtsbrCppj96HXQBzppIeULubIIz3wC8qJLvMEyhRBOjvLdbAbtaqQiVXjxuIB3Ks3gwLTafNCR9W4wR4CNKqAYT3492jHeawh4BJxDCrdelC8GKgkgT8edx2H63IOtRD8SKqOJbmT92uuLDL1ruRXTlZwKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648660; c=relaxed/simple;
	bh=ghTOtXGqjiGYlf8iPczgTqhHAhig3wcpoUXLNiqoD4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAgtervCqa/RptFLz9gr0waWUwzGpAiFWKONukhTgc1sxpQcdH73hhuO7ZBHb9imMwOHM/Hux28RkQLElmqIsXUVc/541IjcxegjF3CwEe6qzdwhJynXb0GZBcLF+AgXGwWGzHVzppkT3pncG64eFa5cyZEzSkHpdUOYxP3d32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PZoUpkp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AB0C116C6;
	Mon,  9 Feb 2026 14:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648660;
	bh=ghTOtXGqjiGYlf8iPczgTqhHAhig3wcpoUXLNiqoD4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZoUpkp8BQUgp+lJeWywkNc+zzsB1MRKyCOEpMnQ35Hc0eqN/SAWvzhiK/zBUx8BT
	 Ay8gfeaKmuZv4apkAa+n46Xrtzw8PmU+Kk6WJtc1qzmH6cbzqvrMoIi4QUYjt9miUF
	 NvbQphZ+YlX0l5MbN2izAWeqvraGnyVbQ4X1pEnI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Veerendranath Jakkam <veerendranath.jakkam@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 19/41] wifi: cfg80211: Fix bitrate calculation overflow for HE rates
Date: Mon,  9 Feb 2026 15:24:40 +0100
Message-ID: <20260209142257.503588651@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142256.797267956@linuxfoundation.org>
References: <20260209142256.797267956@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215397-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 19E81111294
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Veerendranath Jakkam <veerendranath.jakkam@oss.qualcomm.com>

[ Upstream commit a3034bf0746d88a00cceda9541534a5721445a24 ]

An integer overflow occurs in cfg80211_calculate_bitrate_he() when
calculating bitrates for high throughput HE configurations.
For example, with 160 MHz bandwidth, HE-MCS 13, HE-NSS 4, and HE-GI 0,
the multiplication (result * rate->nss) overflows the 32-bit 'result'
variable before division by 8, leading to significantly underestimated
bitrate values.

The overflow occurs because the NSS multiplication operates on a 32-bit
integer that cannot accommodate intermediate values exceeding
4,294,967,295. When overflow happens, the value wraps around, producing
incorrect bitrates for high MCS and NSS combinations.

Fix this by utilizing the 64-bit 'tmp' variable for the NSS
multiplication and subsequent divisions via do_div(). This approach
preserves full precision throughout the entire calculation, with the
final value assigned to 'result' only after completing all operations.

Signed-off-by: Veerendranath Jakkam <veerendranath.jakkam@oss.qualcomm.com>
Link: https://patch.msgid.link/20260109-he_bitrate_overflow-v1-1-95575e466b6e@oss.qualcomm.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/util.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 37719fc39f64d..29b8233d4a9c2 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1389,12 +1389,14 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 	tmp = result;
 	tmp *= SCALE;
 	do_div(tmp, mcs_divisors[rate->mcs]);
-	result = tmp;
 
 	/* and take NSS, DCM into account */
-	result = (result * rate->nss) / 8;
+	tmp *= rate->nss;
+	do_div(tmp, 8);
 	if (rate->he_dcm)
-		result /= 2;
+		do_div(tmp, 2);
+
+	result = tmp;
 
 	return result / 10000;
 }
-- 
2.51.0




