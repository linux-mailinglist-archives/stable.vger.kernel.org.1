Return-Path: <stable+bounces-256596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH7XAnZvGWqNwggAu9opvQ
	(envelope-from <stable+bounces-256596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:50:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9071F6011A9
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 646C730488DB
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9691A3C5540;
	Fri, 29 May 2026 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imcgnW2q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AEE261B71
	for <stable@vger.kernel.org>; Fri, 29 May 2026 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051344; cv=none; b=Lt8+xr56dSG0la9nftkxdQcDb3MB/LAI1UFJc31PgBMSafqMpDhoUm0d62pUACetFSZDPm3jwy7deE9AICZVFDDeEXHjOd9WCZC/xV330bY3/twQQ2EpF/IpBzFh3So8KSOV1by5abKygPJyIoAjcpcgp/wp+QMFkjsjlcgBm2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051344; c=relaxed/simple;
	bh=EZcmH9lRgbKPL1JBf4dgtdu5sZnLvXTX7/RJTu+/ztw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqbotAPS5iME/+SUsebVhyWop/g+StJLthibhoUr9qt0G18gVhoxRiYJwIwU6ZS2g6NGRBzWidf4LXvXcCro8DQSdSyAT6AvVY4NFH6hCdBAonyKdyUzR5U7JyM9/2Hdxf/ITu7dLZstMGcoLaBMdDJq/QMPrxVhMk1+L4tULmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imcgnW2q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780051343; x=1811587343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EZcmH9lRgbKPL1JBf4dgtdu5sZnLvXTX7/RJTu+/ztw=;
  b=imcgnW2qxHyd2sWW29i788xc5d1+YmLVwkFaX3xLMd6oa3brgVo4e/as
   rbVJ5YGXvI42o/gzjQ6hC/nbOUbFqxFNKju7eSyjSLaPxtFyE91QtPU43
   Yakht5WpWNMGoh7hl46Gf/BwJwnhTW8KwkTQsV1K39oIoPXJ+anBNYLkZ
   /LuLCW5GXihsiOEpERB9dxQ9OTWJB128DVKRnXUKi2N95/EKV7d6vumHR
   P5hgWDGGiTOI36kiUiHM7ITh+F4AvIlHCjtecC55sPA3fSjSWbLL8T9ms
   QibWlk1nNZZDMyUEaPKHjbQJom6i+ChbL8zda3XvdQgBZ0pL9aTYZZ3gd
   g==;
X-CSE-ConnectionGUID: 35aV+h9+SpqD3Zdz9s+2cQ==
X-CSE-MsgGUID: UiFNK+a0S4Wq28lHZSMdJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="92376498"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="92376498"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 03:42:23 -0700
X-CSE-ConnectionGUID: EjtPEQi0SbKoUxnMmW9ntg==
X-CSE-MsgGUID: ASngpOKKTAKJvTDGHKG81A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="238625161"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.54])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 03:42:21 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: Suraj Kandpal <suraj.kandpal@intel.com>,
	Arun R Murthy <arun.r.murthy@intel.com>,
	Ben Kao <ben.kao@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Subject: [PATCH 6.12.y 3/4] drm/dp: Add eDP 1.5 bit definition
Date: Fri, 29 May 2026 13:42:05 +0300
Message-ID: <20260529104206.758103-3-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529104206.758103-1-jouni.hogander@intel.com>
References: <2026052816-harvest-stinking-041d@gregkh>
 <20260529104206.758103-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256596-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 9071F6011A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Suraj Kandpal <suraj.kandpal@intel.com>

commit 5dfc37a6b77bf6beedbd30d70184b54e1a08ccac upstream.

Add the eDP revision bit value for 1.5.

Spec: eDPv1.5 Table 16-5
Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Arun R Murthy <arun.r.murthy@intel.com>
Tested-by: Ben Kao <ben.kao@intel.com>
Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250206063253.2827017-2-suraj.kandpal@intel.com
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 include/drm/display/drm_dp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 3bd9f482f0c3..dd218400a613 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -997,6 +997,7 @@
 # define DP_EDP_14			    0x03
 # define DP_EDP_14a                         0x04    /* eDP 1.4a */
 # define DP_EDP_14b                         0x05    /* eDP 1.4b */
+# define DP_EDP_15			    0x06    /* eDP 1.5 */
 
 #define DP_EDP_GENERAL_CAP_1		    0x701
 # define DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP		(1 << 0)
-- 
2.43.0


