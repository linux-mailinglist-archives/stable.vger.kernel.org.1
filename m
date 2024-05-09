Return-Path: <stable+bounces-43507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9F78C1592
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 21:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B22E1F2189C
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 19:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94C07FBAA;
	Thu,  9 May 2024 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XRSGtynW"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657D67F7CA
	for <stable@vger.kernel.org>; Thu,  9 May 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715283713; cv=none; b=j3J7rggvRuseIYsAN1FfPP1A0nHSpV77hnMA9CadkL3SfdV2Zwzw9f24P+2VGF4RnmXIGsys9T+dX5kvlttF3AHV+3rTdEBd8nowRp4FK958MHm6I26oh0RUrJI2iTBSOe5cYQsi52ZvLwlVlzKgP39zoOh2n25V5PVYaSJBftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715283713; c=relaxed/simple;
	bh=HmelgMV9GFf/siGu92i3Q+LvOipEErLjvK9q+1zJXJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qzV7xNchAA7/NOBzgyfa7ft+6wkT9oLIw1t/8PUT23Ik7pX5GkFkKVXKrBDWp4TngSLWBNGcEZOXsWbnguNVc3+zpkOJSCr4AjiUQyeLMAXjMHyNtBBPLcblEdBWRuWAsCPMQCe2BxywDLi5Dz1DJEXT+XzZ0w056+QhhoUvmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XRSGtynW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from rrs24-12-35.corp.microsoft.com (unknown [167.220.2.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id D48BD20B2C87;
	Thu,  9 May 2024 12:41:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D48BD20B2C87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715283711;
	bh=JYpTL5CmAP6Dbg3vj0NZlgNsbjvgSoHleFBuSZbKwRM=;
	h=From:To:Cc:Subject:Date:From;
	b=XRSGtynWFsFZkpNWZnhulHIvS3xDWm3MOAOUr/MMAo5BSHnlTwY6JD5lyM9RQJJSq
	 MEl/ZTkCdHWx2rsxVZinLqqKwndovoMtnvnHC7Wah18h9MxOoJ+YFeMFaMf3XdavU4
	 IypesG3S7BVXMZY7q5cK/WhIKNH5iuzP8NwwQBao=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH RESEND 5.15.y 0/3] Use access_width for _CPC package when provided by the platform firmware
Date: Thu,  9 May 2024 19:41:23 +0000
Message-Id: <20240509194126.3020424-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series backports the original patch[1] and fixes to it[2][3], all marked for
stable, that fix a kernel panic when using the wrong access size when
platform firmware provides the access size to use for the _CPC ACPI
package.

This series was originally sent in response to an automated email
notifying authors, reviewers, and maintainer of a failure to apply patch
[3] to linux-5.15.y at [4].

[1] 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
[2] 92ee782ee ("ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro").
[3] f489c948028b ("ACPI: CPPC: Fix access width used for PCC registers")
[4] https://lore.kernel.org/all/2024042905-puppy-heritage-e422@gregkh/

Easwar Hariharan (1):
  Revert "Revert "ACPI: CPPC: Use access_width over bit_width for system
    memory accesses""

Jarred White (1):
  ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro

Vanshidhar Konda (1):
  ACPI: CPPC: Fix access width used for PCC registers

 drivers/acpi/cppc_acpi.c | 67 +++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 11 deletions(-)


base-commit: 284087d4f7d57502b5a41b423b771f16cc6d157a
-- 
2.34.1


