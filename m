Return-Path: <stable+bounces-215205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBy4DpTyiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:43:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF61E110C86
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4DD7304C979
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F164E37C101;
	Mon,  9 Feb 2026 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xK6Uo4ot"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53CF2222B2;
	Mon,  9 Feb 2026 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648024; cv=none; b=YXEbDrM4Oe5JByja219s0AtP1b0klMCOWAZ6lNF56mxxAglcWUDgnX/DRF375LQaS8IL6bI+HybBhC1TV5FZXrtfmxDZw73tbrOlr9o5v7p72hlLnuGqVCPc4M+JM9mzVWWeKtX5Qg0iaG5dAXDz6fcsGL9yk04lTSuoPjjyQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648024; c=relaxed/simple;
	bh=bKf5b+AL2R/VHUVeA/embFOXDuo3qMTl/AHkRlQzqmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrm/fa0zqbhMKeBm8wAoqBGy5zubirCpTHc0kSKOU8hoSb5bNQzzakMqq4kR1bVcwIWq83pOyyAK48aNGxIxhcE5glFo/fTs3B0QWTGq/tvocX+8zoE+DbtpdoAfdZpKB2Zsvk8ewou0OixP85Jaz9V1+JtN0aMO41Qf2qY9nvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xK6Uo4ot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C233AC116C6;
	Mon,  9 Feb 2026 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648024;
	bh=bKf5b+AL2R/VHUVeA/embFOXDuo3qMTl/AHkRlQzqmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xK6Uo4ot3VAOT1o0rR1x5j4Ic2BLo+pUzDRnz83LywKj+2HFs6CBVf94c5cfO0fbu
	 8QBr5+nLn9wQAdpWg28NrTEq8+RnUXmvBG4i+UHKyhkAQjCLiPFxLDipw+lU9Hi1wJ
	 HTDRb6CqJui1FvHrkybAtrnE445XFionHEAp5Zp0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Veerendranath Jakkam <veerendranath.jakkam@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 065/113] wifi: cfg80211: Fix bitrate calculation overflow for HE rates
Date: Mon,  9 Feb 2026 15:23:34 +0100
Message-ID: <20260209142312.529899404@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215205-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,qualcomm.com:email,intel.com:email]
X-Rspamd-Queue-Id: CF61E110C86
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 6aff651a9b68d..5be4ccb871411 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1588,12 +1588,14 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
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




