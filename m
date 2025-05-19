Return-Path: <stable+bounces-144766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DBDABBB89
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4D417BEC7
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 10:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271D20DD75;
	Mon, 19 May 2025 10:56:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1EBB67A;
	Mon, 19 May 2025 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652177; cv=none; b=UaNXs06gkY9kP0/nQP13NpdEY+jc28SBJTgCIkrAOurSPpnbrZRjWJ0nFMdqjoBv6DNPUIWOsLkU6/8+zrk844lhmrH7HgO/mOmGgn0a+nzPuhQMWANS9DgjF/Aaufe290+5J1zYep+dJNIuf35A4+1sGJPKm/eTPfBf/PckOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652177; c=relaxed/simple;
	bh=7VwxsNrW+cwWOrfAvoZHgDyT4R04Oisli3beyzq8R+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=orZ8v28RpAu5goBMcSSGRL7pCr084gugORp1824L9menrEuiYNj7IgxRzy6nkodR+/NXkjdU60TQmk3ZZS7M0OJ/N0TDUwTguK13TUr0cvDBoLSX3IIiB1S/CvXUvs8WoZtuyiJ3HtHfXJjpWqND7PWw4xW4Ds+epJXyzMvzXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 704CB1655;
	Mon, 19 May 2025 03:56:01 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 715913F6A8;
	Mon, 19 May 2025 03:56:13 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	ilkka@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] perf/arm-cmn: Add CMN S3 ACPI binding
Date: Mon, 19 May 2025 11:56:04 +0100
Message-Id: <7dafe147f186423020af49d7037552ee59c60e97.1747652164.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An ACPI binding for CMN S3 was not yet finalised when the driver support
was originally written, but v1.2 of DEN0093 "ACPI for Arm Components"
has at last been published; support ACPI systems using the proper HID.

Cc: stable@vger.kernel.org
Fixes: 0dc2f4963f7e ("perf/arm-cmn: Support CMN S3")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index e385f187a084..403850b1040d 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2651,6 +2651,7 @@ static const struct acpi_device_id arm_cmn_acpi_match[] = {
 	{ "ARMHC600", PART_CMN600 },
 	{ "ARMHC650" },
 	{ "ARMHC700" },
+	{ "ARMHC003" },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, arm_cmn_acpi_match);
-- 
2.39.2.101.g768bb238c484.dirty


