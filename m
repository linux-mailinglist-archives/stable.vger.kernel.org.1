Return-Path: <stable+bounces-256556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJFCHj1SGWrzuQgAu9opvQ
	(envelope-from <stable+bounces-256556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:45:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE20D5FF65F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62E7330F8864
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895343B8127;
	Fri, 29 May 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHMARlFF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48739348C56
	for <stable@vger.kernel.org>; Fri, 29 May 2026 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044160; cv=none; b=kjoeXkce3RMAENy2VHwJwUssJXydyvhhU0bHtDlcKIzvdEovF2FfmuaT/678jHRfGeILx0tGwMQkCg/s6TA++YQ3mmXdhwCgwx62Xt1bKjzBsvMyBL3/NtFTsjye8WQOqpMXwhRtvqNJp9SCNNgx23Q03US4hcXMDoMNxEnsQEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044160; c=relaxed/simple;
	bh=mTWswh9R61Zhs1P/k875NFvKPWf1xd/eVFotsY6cH9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMglS8J7KQg448moQMBUC8iCJ29+8BT1mhohKCXK3Ni9yRE77zKsRN7pduTkYzIYnhqaXL25A8LyC10itxNpRn2oN+FbcieivBtvlYrtuZ8Dr9HDlTg4FerfqoIuSvvevB9y9WTdObAnrZyOQDtm5ZfIL9h8A/NDYfeE6GRA2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHMARlFF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780044158; x=1811580158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mTWswh9R61Zhs1P/k875NFvKPWf1xd/eVFotsY6cH9s=;
  b=lHMARlFFTSY/E/Wki7b0ET2Bq1wK0wWjiW+WY+zS5tCPan/Y1pUxzdDb
   m4A8NAas7x7mwyW1YueZiSsXJdK50ZJSKalbO/J2Oa+hXW/KxuY7tYZMS
   pLd72TAVFGXxRw+VuvtQyfItaAZBYQ9TMuQIfVYQ/qbUPd0aIDV7XBXv9
   mITvGr/qahGkpMIcwPHU8u39GZZb3vU9g7yCqlMCPry7khaoJNZwfWFeF
   AHyPiK6W72tt6pefwLBl/1aJ8eHLaImaG5xH1YcTDJ4UNCCsnim7b3ZqM
   Xbj4NUaVBiqeL51wCkfhbqyNZqMP3obS3TkxpM8nPHvqk4lUJCwpZYyxE
   Q==;
X-CSE-ConnectionGUID: rTY/S8YaRfqyYxvOB/mV5A==
X-CSE-MsgGUID: cvcx0FkQQF+jJCfwoDrLIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80922453"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="80922453"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:42:37 -0700
X-CSE-ConnectionGUID: LSP1j1JARren1uKr010/7Q==
X-CSE-MsgGUID: Jc4EGZmkRrmT2B35oiFq7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="266418804"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.54])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:42:35 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: Suraj Kandpal <suraj.kandpal@intel.com>,
	Arun R Murthy <arun.r.murthy@intel.com>,
	Ben Kao <ben.kao@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Subject: [PATCH 6.1.y 2/4] drm/dp: Add eDP 1.5 bit definition
Date: Fri, 29 May 2026 11:41:56 +0300
Message-ID: <20260529084158.459248-2-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529084158.459248-1-jouni.hogander@intel.com>
References: <2026052828-boaster-whenever-f598@gregkh>
 <20260529084158.459248-1-jouni.hogander@intel.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256556-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EE20D5FF65F
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
index b235d6833e27..7d3700490b68 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -955,6 +955,7 @@
 # define DP_EDP_14			    0x03
 # define DP_EDP_14a                         0x04    /* eDP 1.4a */
 # define DP_EDP_14b                         0x05    /* eDP 1.4b */
+# define DP_EDP_15			    0x06    /* eDP 1.5 */
 
 #define DP_EDP_GENERAL_CAP_1		    0x701
 # define DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP		(1 << 0)
-- 
2.43.0


