Return-Path: <stable+bounces-14681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5731E83821E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EAA1C25044
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ECE4F8BF;
	Tue, 23 Jan 2024 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dCEqkCPt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B635CAF;
	Tue, 23 Jan 2024 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974068; cv=none; b=Tf/W+UDr7N/xONg3A1LvPM+htpLRQiwBY0vVSJ/DhmCRNBGPjEh/pO2/jft0Aw+OpbVObWHrWRjEcSP+fa+YtXzzm4LfpxOcTH/19XZFZVLzFtA0QpNAVv0KqEvAokixvoj0v2/aFhOXWwcubu1VbPePRvGcHBAxlj7W7Su83DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974068; c=relaxed/simple;
	bh=k3V6F24Xdy2IjnnyDjYUeOLRbqNx7Ujr/xCI//0ktSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CANelLpBgwrwcTl6w191E7Ec98Az2jXOYtGll0fLADVuMK9I6i2SrNdOfpUC+8wOO8wKJu9kb8ViqcJdWC1dNiBCrE/L8eD7ZxWQBsEVMK4pLWEzw9DWh/zouhvZQ3UBjYo4S56CRqI1vE2TiYERMiU41W+HHdZsfuOybjN4s7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dCEqkCPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975A6C43390;
	Tue, 23 Jan 2024 01:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974067;
	bh=k3V6F24Xdy2IjnnyDjYUeOLRbqNx7Ujr/xCI//0ktSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dCEqkCPtiAAG09tHlhdW9RFCAgYzXpOfrtxonC/+8Sn/lYJEku1ZIBFosh8GZD9ve
	 uEupzdKfhWf4/6CUxdKtjJCIAWCQkC54wRJh9SJzm1qtTAmxHym2lZjzp+wO7PnOJF
	 B6NIYShcOCxnzow9u5bO0Qx/U8t7WLJmB3gNcbpY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Kiryushin <kiryushin@ancud.ru>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 025/583] ACPI: LPIT: Avoid u32 multiplication overflow
Date: Mon, 22 Jan 2024 15:51:16 -0800
Message-ID: <20240122235812.971168101@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Kiryushin <kiryushin@ancud.ru>

[ Upstream commit 56d2eeda87995245300836ee4dbd13b002311782 ]

In lpit_update_residency() there is a possibility of overflow
in multiplication, if tsc_khz is large enough (> UINT_MAX/1000).

Change multiplication to mul_u32_u32().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: eeb2d80d502a ("ACPI / LPIT: Add Low Power Idle Table (LPIT) support")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_lpit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index c5598b6d5db8..794962c5c88e 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -105,7 +105,7 @@ static void lpit_update_residency(struct lpit_residency_info *info,
 		return;
 
 	info->frequency = lpit_native->counter_frequency ?
-				lpit_native->counter_frequency : tsc_khz * 1000;
+				lpit_native->counter_frequency : mul_u32_u32(tsc_khz, 1000U);
 	if (!info->frequency)
 		info->frequency = 1;
 
-- 
2.43.0




