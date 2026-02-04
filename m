Return-Path: <stable+bounces-214230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI8LIjptg2kFmwMAu9opvQ
	(envelope-from <stable+bounces-214230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:00:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B13CE9BBD
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C69C431A06F9
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059BB3B52F5;
	Wed,  4 Feb 2026 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a4V0th/S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD70E2DBF75;
	Wed,  4 Feb 2026 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218996; cv=none; b=dnvjLCfrpB7ag1yG1eStv7l9p5HwSktcJbDwJfajjj1A24+xFXYFkAHo7p6fcb/QjT8NIUpfzfCMcoIAwpgOQgRll0tEi/7ywxOpMqLzappCz1RXgKXyvw+I4H+EfS54kvF+WRBlVX5E7CKOK1IpK1lbRw7QVMWdCMYhpzrGpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218996; c=relaxed/simple;
	bh=4rXIjqdgeBh9pYF036l2UQaA1Ma3ZFh6mTKgfyGexIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJ70ATf71One0Xr8L09oN6QdBOCraLvPY30qNFwN65SllelYO0DH1OWUC3wE086hR8BWOzyKmzLfgfc5+0CbHwk32Yt/Ri9DnGJ/MTerBBSKrPBAz/lCTufIf8tO3h+lbX/leAdLifD7gfNIRyGw8xP+Kgkcwr1f867BE6BBdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a4V0th/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E320C19424;
	Wed,  4 Feb 2026 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218996;
	bh=4rXIjqdgeBh9pYF036l2UQaA1Ma3ZFh6mTKgfyGexIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4V0th/SRPWtJyQa7ftNMR/grrVQ8ZhW6Ta+WTVv1ejUAV1QFcKZnaqXLM8FOjx5p
	 qblggd6xo4BrrYM21Lw+2oIkJBMpEL7h2i4r3spUykVRq9fN38Pgg2rZzVHIB6QD30
	 7VDHeX3mbheDp0cLpbCPPMWpiSWV2gEdmDyHWw/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ruikai Peng <ruikai@pwno.io>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 037/122] wifi: mac80211: correctly decode TTLM with default link map
Date: Wed,  4 Feb 2026 15:40:19 +0100
Message-ID: <20260204143853.195982515@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214230-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[sourmilk.net:query timed out,pwno.io:query timed out];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[ruikai.pwno.io:query timed out,johannes.berg.intel.com:query timed out,flamingice.sourmilk.net:query timed out];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,pwno.io:email]
X-Rspamd-Queue-Id: 2B13CE9BBD
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 1eab33aa63c993685dd341e03bd5b267dd7403fa ]

TID-To-Link Mapping (TTLM) elements do not contain any link mapping
presence indicator if a default mapping is used and parsing needs to be
skipped.

Note that access points should not explicitly report an advertised TTLM
with a default mapping as that is the implied mapping if the element is
not included, this is even the case when switching back to the default
mapping. However, mac80211 would incorrectly parse the frame and would
also read one byte beyond the end of the element.

Reported-by: Ruikai Peng <ruikai@pwno.io>
Closes: https://lore.kernel.org/linux-wireless/CAFD3drMqc9YWvTCSHLyP89AOpBZsHdZ+pak6zVftYoZcUyF7gw@mail.gmail.com
Fixes: 702e80470a33 ("wifi: mac80211: support handling of advertised TID-to-link mapping")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Link: https://patch.msgid.link/20260129113349.d6b96f12c732.I69212a50f0f70db185edd3abefb6f04d3cb3e5ff@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 21c73a65f73f9..dca47a533392a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8,7 +8,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2025 Intel Corporation
+ * Copyright (C) 2018 - 2026 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -6190,8 +6190,10 @@ ieee80211_parse_adv_t2l(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 	}
 
-	link_map_presence = *pos;
-	pos++;
+	if (!(control & IEEE80211_TTLM_CONTROL_DEF_LINK_MAP)) {
+		link_map_presence = *pos;
+		pos++;
+	}
 
 	if (control & IEEE80211_TTLM_CONTROL_SWITCH_TIME_PRESENT) {
 		ttlm_info->switch_time = get_unaligned_le16(pos);
-- 
2.51.0




