Return-Path: <stable+bounces-235992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH3yJjrT3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:27:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CF33EB49C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBECA302E840
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27293C2785;
	Mon, 13 Apr 2026 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bP73mLUY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C53C1987
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079441; cv=none; b=Qz6LHsUyAYSOkG1A1qUJdXGn/HIhxrQC4Qqi3OUpM6FcUm7anJiKT7ii7pIGxglOVwM+4eN8dYVkVVjwSy7d4HAVzbEKN+6n978Ne0awf4LIm5A/oeLumhsddo9K+fYZ6MySLVneahMyAeNjYVBbBGsyNkb8y7eu70xSBOUjliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079441; c=relaxed/simple;
	bh=iI/QH+BncmYUzNfTGdAuXn7COAG6QUx6ILaw2qbVcrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BSk/HQX7DKk1pWltGJfKI+SPvafo+iC8MaWJUM5bRxKmdpuzlq2cdbGpb56uci8r86eqe9Xno5BCgPBdSVv8MadjzbSjyIn4rmGiyaJ0p46jgHnTJDWQP2FY3RhBOFEEOaOUmsxN0d94v1h6JKT0F0mBN+lvipKIHW2mJLF3tp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bP73mLUY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776079441; x=1807615441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iI/QH+BncmYUzNfTGdAuXn7COAG6QUx6ILaw2qbVcrA=;
  b=bP73mLUYZ5HDO06DDhaGSurqcm5IyDNp5XO3ZlAYkSN6U2w1UE/c9A/H
   ubJZhFlBBRpqkeWQk6dnubMt9JCh00c4J7rhmeAVL/S8Qh8ZCmwWw9vyb
   DaEx7Wa7fr8oXupw1Y/vh0/NBdOAxAq+/oi80I6d73O+0hQIW3Tginw2P
   XM17z9az4XCkCbU4YmWeuiTpU0DW7EFz/mEiM4sPNM1mpJviSaFblcKnp
   bZCfanNlX4hfm5WnSBsrWjzsuezJA3OqisB5udIuX/+aKdUoyp/zZmn90
   GYz5X1jHl5QWq7PsUOktOGzZzJKb5daofoALPC7Kb2tyFFk8UoH3FsvvL
   Q==;
X-CSE-ConnectionGUID: 8tjKISqQSLOyuuYO1191jQ==
X-CSE-MsgGUID: aDAVK9ClTEuzXs+kWh6c3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="99656713"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="99656713"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:24:00 -0700
X-CSE-ConnectionGUID: burOrOHLT1WSw4+oQ9230w==
X-CSE-MsgGUID: NoJrNgoLQ66n91tb0o9kBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="234681914"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.244.251])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:23:58 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/psr: Init variable to avoid early exit from et alignment loop
Date: Mon, 13 Apr 2026 14:23:45 +0300
Message-ID: <20260413112345.88853-1-jouni.hogander@intel.com>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235992-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 11CF33EB49C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Uninitialized boolean variable may cause unwanted exit from et alignment
loop. Fix this by initializing it as false.

Fixes: 681e12440d8b ("drm/i915/psr: Repeat Selective Update area alignment")
Cc: <stable@vger.kernel.org> # v6.9+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index b4ca5843d098..63c19958a9e3 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3002,7 +3002,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		return ret;
 
 	do {
-		bool cursor_in_su_area;
+		bool cursor_in_su_area = false;
 
 		/*
 		 * Adjust su area to cover cursor fully as necessary
-- 
2.43.0


