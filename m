Return-Path: <stable+bounces-108483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58547A0C00F
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57157A21FB
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F131F9A93;
	Mon, 13 Jan 2025 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lquJr4E1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B69C1C5F0A;
	Mon, 13 Jan 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793302; cv=none; b=WasxnzkQFeSdrNprqz8BSW+u/EU2zV17PEKqljJLF9PqdHuKns8mRJH7lqIuc3jRz1Zwxt1s2yF9BdWfWp06DtD5EboTy2gZWuZPcbBhyEBG8uLwjHh/Swg2RsCpeart+wY+l0e0ZoIcEfTgZBG0a/tpXvsBg0fBlsQwRfZumJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793302; c=relaxed/simple;
	bh=O3oD0inCuTEDOQvSP/BTMZROshvZ1iBHYYSPEzj/n+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFJjSBe7tR1SAIh2fvL8LZxtKaRjiRFiOahI3JU+/R63ihDSc8NlwdYwHv5P5MUy+sGxnoFOdKOATvNDuB25x8KxYkoZ5NVZWZvpuitYcbtDKY8eDR0/V9THpFGPuuCujTm+ZIvPfoeVC893gzNKHOffbWaFaRK/iuu1HqOksKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lquJr4E1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A26CC4CED6;
	Mon, 13 Jan 2025 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793301;
	bh=O3oD0inCuTEDOQvSP/BTMZROshvZ1iBHYYSPEzj/n+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lquJr4E13z5FlNAPJxN7eRQU3mUzQ/TjrAzdfFfPufxzxev45FZFma+EM7ZBod7ao
	 Zq4J2/ji6++pdQEICepqlfh4KwHEhPpzGux8K/uPnunXjhnxXKWQxreclJ/ON9Tm6U
	 Z2Aag9TFtxamHb5dUNp8I2cXUe6W561HebtGlFIzhyzlosqJsSpf1Fuim4e+uygt2m
	 kKZ4ZuX+06UUALf0vQTVVX4b0XcPnh8zq6rHa98rYlgoa7FXF28aI1uuj8Avzh/QZg
	 jCdaxaqzqxDrprv/a5qlNjfuuMP+fQEkQotQONSGHxtdXVjmtLttRvO/EEqGgZr6CW
	 FMVsoum6O2zBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	tero.kristo@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 14/20] platform/x86/intel: power-domains: Add Clearwater Forest support
Date: Mon, 13 Jan 2025 13:34:19 -0500
Message-Id: <20250113183425.1783715-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit bee9a0838fd223823e5a6d85c055ab1691dc738e ]

Add Clearwater Forest support (INTEL_ATOM_DARKMONT_X) to tpmi_cpu_ids
to support domaid id mappings.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20250103155255.1488139-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/tpmi_power_domains.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c b/drivers/platform/x86/intel/tpmi_power_domains.c
index 0609a8320f7e..12fb0943b5dc 100644
--- a/drivers/platform/x86/intel/tpmi_power_domains.c
+++ b/drivers/platform/x86/intel/tpmi_power_domains.c
@@ -81,6 +81,7 @@ static const struct x86_cpu_id tpmi_cpu_ids[] = {
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	NULL),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	NULL),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	NULL),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	NULL),
 	X86_MATCH_VFM(INTEL_PANTHERCOVE_X,	NULL),
 	{}
-- 
2.39.5


