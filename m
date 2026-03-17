Return-Path: <stable+bounces-226162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJjYL8mDuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:39:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802D52AE28C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C73E530351F1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B563ECBF0;
	Tue, 17 Mar 2026 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs0A/jbs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247A3ECBE5
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765567; cv=none; b=qpE/7QIbq/2hZtWZtdJwTgD8OYQsh+ZleDFWhx2Nm9KHwzIlXx41M7CHPqnCi1RSy73tNWWplrwB2G0RGyo372r44SHN8VklGUc1hF02FzAHEFftpgRyvxgjCGV705qM9SkfpW+JBTpVJyL5EXr2DOPtItByFEXTDBx8fw3k4y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765567; c=relaxed/simple;
	bh=l7CmyKV/pY2bMq7ue7/pKa1AyaB5s4vfyL+5ScxnqbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoyhDWrkGE/n7ln5hEtLmonjwCFGMFy5iq+xEo9fZ7CFHCQ48gn04mM5xbEDX0Bpey/OWY5zJpYs73Akt5+YSrW2YjErhXdiQvIwyVtAKgfmtwM5by1o7fRJh7pgXk9UPInhsMhmYorsaeRzc4L5sNcvOQYHiAKK2O4bQ4gFejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs0A/jbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20F7C2BCB1;
	Tue, 17 Mar 2026 16:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765567;
	bh=l7CmyKV/pY2bMq7ue7/pKa1AyaB5s4vfyL+5ScxnqbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gs0A/jbswCMHnvZIvC2c86NvNnx96Ra1PjVz6whfY4KPNW5hzgplASv8NPNPWUEET
	 Tof0Un8t6HIJw/vhrLi7gjUEu2auMJVkZTeHapb5AIqhNkUBOfijBW0RcJBAjAGHnq
	 q9D7eZBaRf8uK05DlKByOTdEpreoiNIZvuYjDgcNIKfmjr8hJbV99B2wVpaFTL4nHc
	 uUaAZLorsK/N4RYMpymEEp9aTuka3XCwnQ+o6ZqR2AN9XdzAGcBjQfwBJGvwIp9Mrr
	 mR19sm2pSZ3qFZoq+rhjkzuafzgH9+pNeqFOntJTHzPG8hnVb5ClD86q6rXqO9Og3H
	 GmBnR6VA5kRFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: He Lugang <helugang@uniontech.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/8] drm/i915:Remove unused parameter in marco
Date: Tue, 17 Mar 2026 12:39:17 -0400
Message-ID: <20260317163924.220634-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031731-secret-rocket-af05@gregkh>
References: <2026031731-secret-rocket-af05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226162-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,patchwork.freedesktop.org:url,uniontech.com:email]
X-Rspamd-Queue-Id: 802D52AE28C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: He Lugang <helugang@uniontech.com>

[ Upstream commit 09b003ad1dd6a4bf1b364e8f03cba87b2de38d21 ]

The parameter dev_priv is actually not used in macro PORT_ALPM_CTL
and PORT_ALPM_LFPS_CTL,so remove it to simplify the code.

Reviewed-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: He Lugang <helugang@uniontech.com>
Link: https://patchwork.freedesktop.org/patch/msgid/6C2E07E089F0CB73+20240925064016.733173-1-helugang@uniontech.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Stable-dep-of: eb4a7139e973 ("drm/i915/alpm: ALPM disable fixes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     | 4 ++--
 drivers/gpu/drm/i915/display/intel_psr.c      | 2 +-
 drivers/gpu/drm/i915/display/intel_psr_regs.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 186cf4833f716..57afb25191bd9 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -330,7 +330,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 			ALPM_CTL_AUX_LESS_WAKE_TIME(intel_dp->alpm_parameters.aux_less_wake_lines);
 
 		intel_de_write(display,
-			       PORT_ALPM_CTL(display, port),
+			       PORT_ALPM_CTL(port),
 			       PORT_ALPM_CTL_ALPM_AUX_LESS_ENABLE |
 			       PORT_ALPM_CTL_MAX_PHY_SWING_SETUP(15) |
 			       PORT_ALPM_CTL_MAX_PHY_SWING_HOLD(0) |
@@ -338,7 +338,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 				       intel_dp->alpm_parameters.silence_period_sym_clocks));
 
 		intel_de_write(display,
-			       PORT_ALPM_LFPS_CTL(display, port),
+			       PORT_ALPM_LFPS_CTL(port),
 			       PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(10) |
 			       PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(
 				       intel_dp->alpm_parameters.lfps_half_cycle_num_of_syms) |
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 34d61e44c6bd9..16fd393de04fc 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2118,7 +2118,7 @@ static void intel_psr_disable_locked(struct intel_dp *intel_dp)
 			     ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
 
 		intel_de_rmw(display,
-			     PORT_ALPM_CTL(display, cpu_transcoder),
+			     PORT_ALPM_CTL(cpu_transcoder),
 			     PORT_ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_psr_regs.h b/drivers/gpu/drm/i915/display/intel_psr_regs.h
index 25c0424e34db2..8f2b3372bf6c9 100644
--- a/drivers/gpu/drm/i915/display/intel_psr_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_psr_regs.h
@@ -295,7 +295,7 @@
 
 #define _PORT_ALPM_CTL_A			0x16fa2c
 #define _PORT_ALPM_CTL_B			0x16fc2c
-#define PORT_ALPM_CTL(dev_priv, port)		_MMIO_PORT(port, _PORT_ALPM_CTL_A, _PORT_ALPM_CTL_B)
+#define PORT_ALPM_CTL(port)			_MMIO_PORT(port, _PORT_ALPM_CTL_A, _PORT_ALPM_CTL_B)
 #define  PORT_ALPM_CTL_ALPM_AUX_LESS_ENABLE	REG_BIT(31)
 #define  PORT_ALPM_CTL_MAX_PHY_SWING_SETUP_MASK	REG_GENMASK(23, 20)
 #define  PORT_ALPM_CTL_MAX_PHY_SWING_SETUP(val)	REG_FIELD_PREP(PORT_ALPM_CTL_MAX_PHY_SWING_SETUP_MASK, val)
@@ -306,7 +306,7 @@
 
 #define _PORT_ALPM_LFPS_CTL_A					0x16fa30
 #define _PORT_ALPM_LFPS_CTL_B					0x16fc30
-#define PORT_ALPM_LFPS_CTL(dev_priv, port)			_MMIO_PORT(port, _PORT_ALPM_LFPS_CTL_A, _PORT_ALPM_LFPS_CTL_B)
+#define PORT_ALPM_LFPS_CTL(port)				_MMIO_PORT(port, _PORT_ALPM_LFPS_CTL_A, _PORT_ALPM_LFPS_CTL_B)
 #define  PORT_ALPM_LFPS_CTL_LFPS_START_POLARITY			REG_BIT(31)
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK		REG_GENMASK(27, 24)
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN		7
-- 
2.51.0


