Return-Path: <stable+bounces-114754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A950FA3002E
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4C918874C3
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401CF1E5734;
	Tue, 11 Feb 2025 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu56s+Q8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE81E47D9;
	Tue, 11 Feb 2025 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237411; cv=none; b=kkwNsCvzCwzjy+eWQ/h08zB9fUie6yLsTaluIFsFwh+nhquRF/EUrjaVJvyIH0YvVf6FGIMKjNFWT/Hs3lmu23u6/0LYEpW1KXPyFib1S1flZ9qJ01xmRi+h7iccxu/pYOuOy2NUpLS2t8bacfJEPZ11FjW1DsHF9y4H40lMLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237411; c=relaxed/simple;
	bh=sVEkcRzrEhXt9u0KidfaTh9ZsEa8K7TLUmMTnJodGWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARULCb7mArMx4IRdB6xhUE52Hzcg1wcoXflZoo2pej8zn9M70hRHtEkBdfZ9OD/bhNXMnoDS3XMLhKNrn06Adp87tdyM7jmXZRT/RMXrKYXSBtekR5UbtZ2H7UmvSiB1Km7TY5eFZ1rdyh30gd8Jxcc1Bo1xBaCM5e9GoTDeJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tu56s+Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14F7C4CEE5;
	Tue, 11 Feb 2025 01:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237410;
	bh=sVEkcRzrEhXt9u0KidfaTh9ZsEa8K7TLUmMTnJodGWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tu56s+Q8pEUNxq/1jMR19t22aHc1aM+W7NKP/nV8+T7QAkULsk1ybgxDzkt0Nrwxm
	 trBy7zVumd6iuxF/nUhNERdqYj/bEEYBqKszpcr2A9fyC1wrGCEHx63dTMVd4fjzpM
	 ji/Gj5YUpUZ1obh9Crema4TBKFvVezDS4cSYlckdkdX9gDk7cJxtWDyBNCgj1rckDi
	 zR2gB7DEXQDcgNvch7NMz9+dOdwlangRYdh9YaHdHY6bQR54bvSXDDXYZGsvqEB1OD
	 n+XYCwxKVOh84b7HvsnP7/nl8rWnBN0tPL6s66cIYSIu44rrSkGXc59TAwLgp5JUl3
	 oh8NV8OcmNNgg==
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
Subject: [PATCH AUTOSEL 6.13 10/21] platform/x86/intel: pmc: fix ltr decode in pmc_core_ltr_show()
Date: Mon, 10 Feb 2025 20:29:43 -0500
Message-Id: <20250211012954.4096433-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211012954.4096433-1-sashal@kernel.org>
References: <20250211012954.4096433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
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
index 3e7f99ac8c941..c5dae640a0b2b 100644
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


