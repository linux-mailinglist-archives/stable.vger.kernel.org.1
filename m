Return-Path: <stable+bounces-212711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD88OtuYemms8QEAu9opvQ
	(envelope-from <stable+bounces-212711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 00:16:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEBAA9E33
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 00:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A19383014772
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F2629D265;
	Wed, 28 Jan 2026 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cfmr4kG+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297602DEA6E
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769642202; cv=none; b=XY96eHSU8GcPSAXsjRtHhRfCxfMMabFWLePWQ0TU6Y8tEhAkuse6kbxmggoWJ4HLto8svQc5eKbaKlKh8Oldl3c+WVl6tW75Hu4iMMsRveVVDI1H/dIXByniRqtIO2bF56tbfcAoLoUz22cAAW2zOU/4GZihrmlp9whsOhx1Us4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769642202; c=relaxed/simple;
	bh=6piSAGUydFEVLrWUa1H6WrRq9PKT544OvcATww2IUdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiMVBHrxoMenNtjLkhO7jl6Dzp65ez3QYhXerntc4Kqw1lW13W9Z2iBk+MT/81KB0NfWbwNROrgfGDunAE1Tzzzy06pD8Au5pjS+X+kJK95BjlQzSzRhDCdgmFYwFvz3SYzYL7kzN8LTgNNNLxMzf59b0oFgXv4p9IN8xyi64ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cfmr4kG+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769642200; x=1801178200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6piSAGUydFEVLrWUa1H6WrRq9PKT544OvcATww2IUdc=;
  b=Cfmr4kG+QDYir6Ce5CjLmakhm3wwjSkXf3l1+uQ9Wj/TOJa31dhvRXKX
   AH2JVJyK/2WLZFIo2sbf7GsoHOsqpU6cQpLpst16MWOKzZ7Q3rdcBxLr2
   09NNRQLDe4PNr7ZoODmhN2sQNZStzdH2JoYP9R/GNUYvW8Qt1n6/wuDXU
   W8I6Dp3FLicv00sev+0sx7ZeCCTfgZQvK9B5xs2st577q4+w/KAc9315P
   HhKxlARgTQpq/Ar+OQomLBVW86N+rqbZzT3sQFGYmHCuObdr5Lemsa9v8
   NcyF/ASdAKSkXaqKhbtj1q7oEhCqcpChLEzwnjzgwT8u2dQmF7MqNV+2T
   A==;
X-CSE-ConnectionGUID: rpZk/E5tTmqoA79eBni92Q==
X-CSE-MsgGUID: hiBH/SUzRgu+khVrh5gubg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462222"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="73462222"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:16:36 -0800
X-CSE-ConnectionGUID: tHrcOhpdRe61V8+mKKCRFA==
X-CSE-MsgGUID: sdPp+btKTdmkNxNDh5N51Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213266651"
Received: from guc-pnp-dev-box-1.fm.intel.com ([10.1.39.24])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jan 2026 15:16:36 -0800
From: Zhanjun Dong <zhanjun.dong@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Zhanjun Dong <zhanjun.dong@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v5 5/6] drm/xe/guc: Ensure CT state transitions via STOP before DISABLED
Date: Wed, 28 Jan 2026 18:16:33 -0500
Message-Id: <20260128231634.982494-6-zhanjun.dong@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128231634.982494-1-zhanjun.dong@intel.com>
References: <20260128231634.982494-1-zhanjun.dong@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212711-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanjun.dong@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADEBAA9E33
X-Rspamd-Action: no action

The GuC CT state transition requires moving to the STOP state before
entering the DISABLED state. Update the driver teardown sequence to make
the proper state machine transitions.

Fixes: ee4b32220a6b ("drm/xe/guc: Add devm release action to safely tear down CT")
Cc: stable@vger.kernel.org
Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_ct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index dfbf76037b04..6a658f085e0f 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -345,6 +345,7 @@ static void guc_action_disable_ct(void *arg)
 {
 	struct xe_guc_ct *ct = arg;
 
+	xe_guc_ct_stop(ct);
 	guc_ct_change_state(ct, XE_GUC_CT_STATE_DISABLED);
 }
 
-- 
2.34.1


