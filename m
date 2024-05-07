Return-Path: <stable+bounces-43309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C98BF199
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6887B1C232CE
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B679E1411CF;
	Tue,  7 May 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saCZg6kK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB313FD85;
	Tue,  7 May 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123338; cv=none; b=OpUix9ovEMUp0OWc5twyk9bXu+yhtG3+6GcZawnnM3YFh/Gv0vda/9JHPGl0BN2Z0EIDYfUzY79+IQk4QkIG39LO760B+/IGWdZOlP+7GQ4qD4/dtkhQ710+WTM+9puxzv36jYogIcPmjIrVnly+D031s/Yb6KQBsfjozlMSNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123338; c=relaxed/simple;
	bh=Vjg4Fmi6G6fzx0gO2iQTTiPmXRNi21IOpym6rx+7TWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfECzM2DbAVmTZibJFDFiq7/E6u0YxaT7H75C12o5yin8SjGAVu5OpZ484k8b9eMmsTWaTuZyaiLomvh0pclcd3mahlff7V/v3jRWKGDOobdxnFdeR+ZYOIsOBNJJv103Iln7G376u6sEy2h07njd3cusaaHg/64Kv26f3WyVoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saCZg6kK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E52C3277B;
	Tue,  7 May 2024 23:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123338;
	bh=Vjg4Fmi6G6fzx0gO2iQTTiPmXRNi21IOpym6rx+7TWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=saCZg6kKNHrC4lsu82H76hiAiEq85E7rhlpx7ntF1Uygo6fGEqohWe/bAi37ZDr1w
	 XMuXF5Ks6ZDYmSx4jhuZI7bzPSmm9MrR1JZRHKXdDIphYs6UEpNk3OLazQ666ndMrK
	 XE3VsHunBtqPk9pZ1gTcf6QAHwsA3ko2chK9uDw/SdCaZJ7PObANnSRa1uLRFT4RcD
	 moW5Q0Ks1jV3ov0x/NOsqx4cjKTPp/Z59n3hB9wkJG/FH1J7tauifxYY1HTd0dEEWS
	 MMspwjNSRLzS/Y0xlMJ6prbPo6AIyc3Jmg+z7ceJ8QgvG7MePTHslcWA7HVHiHRQqU
	 PNSWV8gED6VsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 30/52] platform/x86: ISST: Add Grand Ridge to HPM CPU list
Date: Tue,  7 May 2024 19:06:56 -0400
Message-ID: <20240507230800.392128-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 515a3c3a5489a890c7c3c1df3855eb4868a27598 ]

Add Grand Ridge (ATOM_CRESTMONT) to hpm_cpu_ids, so that MSR 0x54 can be
used.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20240422212222.3881606-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 08df9494603c5..84fe2e5a06044 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -720,6 +720,7 @@ static struct miscdevice isst_if_char_driver = {
 
 static const struct x86_cpu_id hpm_cpu_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
 	{}
 };
-- 
2.43.0


