Return-Path: <stable+bounces-220513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IT1EXI6o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:56:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1EC1C6706
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96D48311600D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FBA3CB812;
	Sat, 28 Feb 2026 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB4SYnls"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A73CB80B;
	Sat, 28 Feb 2026 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300397; cv=none; b=LUdIKRWbj2W1kntdoldOPymmPsdbTjTKRj0wIwcbKpnvGW/0L9djlTwrn3GQEPrkYKFng11HTfSVLpe9lu72SqhBXYZNspynd4b8Cc2TZCJlRoIDjJQchxsK+DQLszPGxI/oM8BznvioTBZAiZT+cQahd9SBlyMGW/kFJ5yuR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300397; c=relaxed/simple;
	bh=10LD9H4CBUJb42a3buQSMpkNQAa4if+Msqqc8c9f7nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHp8wWj5m9fWJGqHAWKRCTAln+a8XfSr5x3U+HcoAHhsqvZCNoYnjy4532nggrM2Idd1ZmTtz630pIEtwciGB7ZtW87SxDjqpIPBCic8RJ9zkLQjZmXdR1viqELxZMMnPm4qOFSFx05FkXGSGInjPTvJgpawt6lWdIskj+DAaCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB4SYnls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AC1C19423;
	Sat, 28 Feb 2026 17:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300397;
	bh=10LD9H4CBUJb42a3buQSMpkNQAa4if+Msqqc8c9f7nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dB4SYnlsbD5qMCVJNfpxyr4qKCNv81XdIurWM4vxf3GtVpenMZuDJdR9V6wWn9EWH
	 SNkkV71Fe+J7GH36p82bB+FQKfLjaauLD/HTTopmkLziRKrrDpo/aSSnqLWWaBSqjm
	 wHa9DbSWvomAT6wW6BHA4K79AfvZ7GsbBmPR3vTDFfDaXMTMU2QEMNhP0fwsY6WJb4
	 UIJPZ/z9dMw/O+tSN4c0ppZ0y4FHNVCqUewOhj2BOTdMyuR3WcqC5bWaetp5b4rXag
	 5fxmzSTU5Nujwhvrmm1flV+Si8rD7z7VTIId2fQyTur3HhOx/WKrwjCOnZswAOdKpD
	 4RoKQjmhNA0uA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: decce6 <decce6@proton.me>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 434/844] drm/radeon: Add HAINAN clock adjustment
Date: Sat, 28 Feb 2026 12:25:47 -0500
Message-ID: <20260228173244.1509663-435-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220513-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DE1EC1C6706
X-Rspamd-Action: no action

From: decce6 <decce6@proton.me>

[ Upstream commit 908d318f23d6b5d625bea093c5fc056238cdb7ff ]

This patch limits the clock speeds of the AMD Radeon R5 M420 GPU from
850/1000MHz (core/memory) to 800/950 MHz, making it work stably. This
patch is for radeon.

Signed-off-by: decce6 <decce6@proton.me>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/si_dpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 9deb91970d4df..f12227145ef08 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -2925,6 +2925,11 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
 			max_sclk = 60000;
 			max_mclk = 80000;
 		}
+		if ((rdev->pdev->device == 0x666f) &&
+		    (rdev->pdev->revision == 0x00)) {
+			max_sclk = 80000;
+			max_mclk = 95000;
+		}
 	} else if (rdev->family == CHIP_OLAND) {
 		if ((rdev->pdev->revision == 0xC7) ||
 		    (rdev->pdev->revision == 0x80) ||
-- 
2.51.0


