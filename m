Return-Path: <stable+bounces-220138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LfbFX0qo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:48:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9481C51D1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E62B0312A9E7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E1481AA0;
	Sat, 28 Feb 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etAsrVsw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4B248A2DD;
	Sat, 28 Feb 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300047; cv=none; b=NweG3qFYNWuGh71fztdzsZbKwpORimng1+5bFgsqyAD2T0UXJH7VFOfXWjD3jiqpshDiwnpJRtzq6Pq2E3SECSJmZAkKAexObXTiUryMDf/NWxuvGE3kNdW7/Q0vR1KgW9hoKYFpL3tEN8kEZ0RoNjJ9Sg4FNKxZnk1gSPYe684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300047; c=relaxed/simple;
	bh=ac4WStoxKfAasctsVBfwXUUhvWrA9GNM2xoK62d7wz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPlWbtSa8pRUj6PAl/ZSQwp1e56S9ZELbK2X+wykT/F3OYoWbfYzil/t7ntxU50QqfEnIgpbBoks9ouexT/klePX0nEtaizj0U8FlboYif9/38iN4bsmnDQvOa7spRUlvs4eo2F2Nmc+cDy2nwwFRLZc7BKZWMXt0sD3ssPVwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etAsrVsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F01C19425;
	Sat, 28 Feb 2026 17:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300047;
	bh=ac4WStoxKfAasctsVBfwXUUhvWrA9GNM2xoK62d7wz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etAsrVswaz6sxnAsvJhjEKT+Xhb/CyFizisBl4ltXFfmju7qSx3MC/GIIttzzSU9n
	 Z1Lm4tCOlRt2QqZ/f8iOYdz3a7souLfjxedVugJMwk19dpQk+F3eejQMgHn8EF4wy8
	 Tlqn4+cxNcSjicy+v+iL8U03jO4FDk8QQ5kSG3d7BpWGsP9OBNJtcHJ9uFTOE+sFEF
	 gZJdWyGNKX/wtCOS/5bDjgblZgwQ2n6gwkSu5n6Qc0iYAjLk1dTTQGV1AN3QBFxpnm
	 zAT6hHUdvxm/oRTx4k8aUpCx1ybbqVm0Mg/FnIf37/6j859POqMF61ccnP8u0AzyoF
	 0OKLPlUoR/KsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Michal Simek <michal.simek@amd.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 060/844] perf/arm-cmn: Support CMN-600AE
Date: Sat, 28 Feb 2026 12:19:33 -0500
Message-ID: <20260228173244.1509663-61-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220138-lists,stable=lfdr.de];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[amperecomputing.com:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,amd.com:email]
X-Rspamd-Queue-Id: 0E9481C51D1
X-Rspamd-Action: no action

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 12a94953c37e834c3eabb839ce057094946fe67a ]

The functional safety features of CMN-600AE have little to no impact on
the PMU relative to the base CMN-600 design, so for simplicity we can
reasonably just treat it as the same thing. The only obvious difference
is that the revision numbers aren't aligned, so we may hide some aliases
for events which do actually exist, but those can still be specified via
the underlying "type,eventid" format so it's not too big a deal.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Tested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm-cmn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 23245352a3fc0..651edd73bfcb1 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -210,6 +210,7 @@ enum cmn_model {
 enum cmn_part {
 	PART_CMN600 = 0x434,
 	PART_CMN650 = 0x436,
+	PART_CMN600AE = 0x438,
 	PART_CMN700 = 0x43c,
 	PART_CI700 = 0x43a,
 	PART_CMN_S3 = 0x43e,
@@ -2266,6 +2267,9 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	reg = readq_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_01);
 	part = FIELD_GET(CMN_CFGM_PID0_PART_0, reg);
 	part |= FIELD_GET(CMN_CFGM_PID1_PART_1, reg) << 8;
+	/* 600AE is close enough that it's not really worth more complexity */
+	if (part == PART_CMN600AE)
+		part = PART_CMN600;
 	if (cmn->part && cmn->part != part)
 		dev_warn(cmn->dev,
 			 "Firmware binding mismatch: expected part number 0x%x, found 0x%x\n",
-- 
2.51.0


