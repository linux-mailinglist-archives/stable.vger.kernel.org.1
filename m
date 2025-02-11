Return-Path: <stable+bounces-114774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5F9A3006E
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825433A5E25
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1611F1512;
	Tue, 11 Feb 2025 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN8sMJQO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465501F0E42;
	Tue, 11 Feb 2025 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237462; cv=none; b=CGZX6M4ZUncE2TASsQfCV+GQ9si0VPWwgcRKxjGwh+LMKl87v809tqsCToA0L1CRn0rCxIWFmfAyCQZZNuwrImgJz+ZDHcJR3WXKXo+XX1s4jXXUFpE/h24xHgIqdCeQLPkFqkPpJTMsNn13SX22aWIcz+s3DZ5tZ3WAudDjhMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237462; c=relaxed/simple;
	bh=bjvXG49dTpKT0QJS7J3gn7tqEEJFTEJiy5VTXshl5+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyLA1I7A3iyXhcj27tzuB4qm3GfmjKbShsr9/WaRzvqgwsW3tzCGa8+0ytsQm2PHjoF/C5Al6C6yGn170nDd8X+u4zLbR3WbUenDefXhFjo3uk2Hpt9ShiCZOyTEf/LzhI4K0AQi1KUuNjLQXmOn86zVDifqyfY3eRzc9MX0jKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN8sMJQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A408C4CED1;
	Tue, 11 Feb 2025 01:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237462;
	bh=bjvXG49dTpKT0QJS7J3gn7tqEEJFTEJiy5VTXshl5+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WN8sMJQOyxDhlmYeuoxjX1r0VyNrkXWyCAyxwz/i9DX3IcnY39TKKDSKvOEOikMe5
	 dY+58A6gDyTwtoPgA8w5gI8VpKmZJlaFDMp/J4xDIhI/lEdn6hNfjObAFqtnXu+M9s
	 eMOu3RmQUruX9MMchqAiIhJZRTKP0wZpn2DOv0gvyrVHgY7t6n2+ARvs7zwceuIcbg
	 cC0OA1hfYDEU5ikf7OagnGlelFEM0oJnx8BHOFF3tGmSh4gonP47pW33GoN/qO5Mwj
	 Pox6VJCT1CLM4HtpOotgFin53A1IApsplVAenty7V7HZdelQtn+xp9jdOJO5r7dFy+
	 h/gUQoP2tFmWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 09/19] platform/x86/intel: pmc: fix ltr decode in pmc_core_ltr_show()
Date: Mon, 10 Feb 2025 20:30:37 -0500
Message-Id: <20250211013047.4096767-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
Content-Transfer-Encoding: 8bit

From: Dmitry Kandybka <d.kandybka@gmail.com>

[ Upstream commit 583ef25bb2a094813351a727ddec38b35a15b9f8 ]

In pmc_core_ltr_show(), promote 'val' to 'u64' to avoid possible integer
overflow. Values (10 bit) are multiplied by the scale, the result of
expression is in a range from 1 to 34,326,183,936 which is bigger then
UINT32_MAX. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
Reviewed-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20250123220739.68087-1-d.kandybka@gmail.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/pmc/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 4e9c8c96c8cce..257c03c59fd95 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -625,8 +625,8 @@ static u32 convert_ltr_scale(u32 val)
 static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	u64 decoded_snoop_ltr, decoded_non_snoop_ltr;
-	u32 ltr_raw_data, scale, val;
+	u64 decoded_snoop_ltr, decoded_non_snoop_ltr, val;
+	u32 ltr_raw_data, scale;
 	u16 snoop_ltr, nonsnoop_ltr;
 	unsigned int i, index, ltr_index = 0;
 
-- 
2.39.5


