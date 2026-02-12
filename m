Return-Path: <stable+bounces-215914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN2FFwlzjWn42gAAu9opvQ
	(envelope-from <stable+bounces-215914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 07:28:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB2112AA71
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 07:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3100030C04CA
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 06:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41355299927;
	Thu, 12 Feb 2026 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMbF4axD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9928BAB9
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877685; cv=none; b=m9u1FQ9bKv+wzn5/9DQyBThqt/MMxj6b0mTGZpcWKECrcuwZyEPO/kMXuIicuDzhalGshlOgoHU9AsKjwhbESF9DM3BQ8ubbY7oiwYWnxuPVZsrh1xvRlnsYhQ5kAVxsAGwP9xAY4/vL+6DfCSlMlgll3L3VpjDkp8z1VoJOYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877685; c=relaxed/simple;
	bh=OE1TfbR90USCxaTmJDqR+C3D5xTkUhHvQxZlHBze7i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=useBrOK4WovvkFKocQWHUdvACW4hvPDttGEyVeqRipYf3Y843fT7zLn9XxGzmYCLWSORgAfT6wZLF8dx5+vAJvKjsYXmZvFIpEEMJm87ZJCR7S2+iVpaa93U2e+QmiX5PwqmRZoXj3oQhUDx977Zuu403Io4nYz9UtNGteuwq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMbF4axD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770877684; x=1802413684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OE1TfbR90USCxaTmJDqR+C3D5xTkUhHvQxZlHBze7i4=;
  b=SMbF4axDxCSaBf3o2387xAmiyA/wHJiYTmdf7ZFvuWXqnfdncq6YDPmC
   JsESXpSHKWIH3pqEUPWr9bAJOaEhTiXhqloH8uUZ7A0lVNTGt6sAh32Ej
   +Hytl3CK6KwvJuT7GN5kLH8mdzCAQNErP+gIog4+N77AIIIfTOQ7Kaw+b
   hv85IuPPa3vjVDoNkkXrh8E7QHBxaUONjdkE3prhreEocmcxhN+X2vEqh
   qiDYoHLtDx1+oKoPePhlM3jhEyH3pEPSY/LpBdbTy0br6Ox13gvjkSnOd
   Fl4cME43rPvoD94EgcxRw7+vHnUJ5n2dKVZ8lLQ8U/2igaPZNbPwcO4ys
   Q==;
X-CSE-ConnectionGUID: EV4gh/lTTt+UzRI6xVNFDw==
X-CSE-MsgGUID: 49Aezj9OQ8Gz2ESQOzNHEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71938032"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="71938032"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 22:28:03 -0800
X-CSE-ConnectionGUID: g4tplW4cQFqQ2AC9MeSwNQ==
X-CSE-MsgGUID: p5Oa3qxuQcSsTFhgWh+Miw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="250169188"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 22:28:01 -0800
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Animesh Manna <animesh.manna@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/alpm: ALPM disable fixes
Date: Thu, 12 Feb 2026 08:27:31 +0200
Message-ID: <20260212062731.397801-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215914-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABB2112AA71
X-Rspamd-Action: no action

PORT_ALPM_CTL is supposed to be written only before link training. Remove
writing it from ALPM disable.

Also clearing ALPM_CTL_ALPM_AUX_LESS_ENABLE and is not about disabling ALPM
but switching to AUX-Wake ALPM. Stop touching this bit on ALPM disable.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7153
Fixes: 1ccbf135862b ("drm/i915/psr: Enable ALPM on source side for eDP Panel replay")
Cc: Animesh Manna <animesh.manna@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index e0a4a59dc025..b3334bc4d0f9 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -604,12 +604,7 @@ void intel_alpm_disable(struct intel_dp *intel_dp)
 	mutex_lock(&intel_dp->alpm.lock);
 
 	intel_de_rmw(display, ALPM_CTL(display, cpu_transcoder),
-		     ALPM_CTL_ALPM_ENABLE | ALPM_CTL_LOBF_ENABLE |
-		     ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
-
-	intel_de_rmw(display,
-		     PORT_ALPM_CTL(cpu_transcoder),
-		     PORT_ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
+		     ALPM_CTL_ALPM_ENABLE | ALPM_CTL_LOBF_ENABLE, 0);
 
 	drm_dbg_kms(display->drm, "Disabling ALPM\n");
 	mutex_unlock(&intel_dp->alpm.lock);
-- 
2.43.0


