Return-Path: <stable+bounces-40587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5EC8AE472
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C47C1C21927
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18852135413;
	Tue, 23 Apr 2024 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehravjIZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C821353FB;
	Tue, 23 Apr 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872421; cv=none; b=fC8Bc/PUzzJQle9Eoqh+kIVgGnIOId6FHNSdpElMbMjrShgtwQJKK7rh7lQqnkzdzdqu60Z4LIe2SN9pBjoVCU/mSPClpfiV7ViF5WFsRTEAr8+T+yoMFtt0GLeff1EqiRI4ley/0G+WbOEU9PsTtpNIqZuor3CPlHqpcQHOpfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872421; c=relaxed/simple;
	bh=thpwmMppq0jMyh/Y9+nNEhgBSoo66Z14csmNvBjf+Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gywpc+VwztUNaeYdUu3uTpAtB9QN2rYl3S2CRRPK99gubuo85UkqKTkvmpqPa13s/uwW7uP9hvFkw6fU4NvMdzQ7ngi9ALzuOQENUgrqyzioq7m7rc6c7s4o8du09TPHSYp4lhyU+Xc5McCiNNvk9ENNZQ687YBlCW9c31NSgXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehravjIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EB3C116B1;
	Tue, 23 Apr 2024 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872421;
	bh=thpwmMppq0jMyh/Y9+nNEhgBSoo66Z14csmNvBjf+Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehravjIZiw2/sEWoZyNXCiXtr6EPq17x+J/wOSJTJ4zyidhlhuLJ8OvcvHRErmkhX
	 ShxLbbChLRqmDhgZTefNmjBBgSTfcMDp4xdIMKLNWBSW760U+YZVGqm/K+FNOS7Ezr
	 xbkYVYmyf+QQc6hU8ljgmsiYjmxonI7uCUJC2DTfiowG7j0jKHn8nbXejVSDwIogqO
	 OW7a5+/MvEDSKqHJku/2WIRscRb5XoSpX06r9fqdpvdIVPxWiGAu38OswMdIfWSLrP
	 bRsHfsSOrlY11RFxZ8bFUnsMIv5Q7iO2LN4iMYjZSFF2vHCoS3hmB9ZtUPluABnLN6
	 jeWjbk3Q9EPpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Shyam-sundar.S-k@amd.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 13/18] platform/x86/amd: pmf: Decrease error message to debug
Date: Tue, 23 Apr 2024 07:01:09 -0400
Message-ID: <20240423110118.1652940-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 03cea821b82cbf0ee4a285f9dca6cc1d660dbef3 ]

ASUS ROG Zephyrus G14 doesn't have _CRS in AMDI0102 device and so
there are no resources to walk.  This is expected behavior because
it doesn't support Smart PC.  Decrease error message to debug.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218685
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240410140956.385-1-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/amd/pmf/acpi.c
index f2eb07ef855af..1c0d2bbc1f974 100644
--- a/drivers/platform/x86/amd/pmf/acpi.c
+++ b/drivers/platform/x86/amd/pmf/acpi.c
@@ -309,7 +309,7 @@ int apmf_check_smart_pc(struct amd_pmf_dev *pmf_dev)
 
 	status = acpi_walk_resources(ahandle, METHOD_NAME__CRS, apmf_walk_resources, pmf_dev);
 	if (ACPI_FAILURE(status)) {
-		dev_err(pmf_dev->dev, "acpi_walk_resources failed :%d\n", status);
+		dev_dbg(pmf_dev->dev, "acpi_walk_resources failed :%d\n", status);
 		return -EINVAL;
 	}
 
-- 
2.43.0


