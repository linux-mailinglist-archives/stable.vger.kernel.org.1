Return-Path: <stable+bounces-140031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74560AAA420
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F5D18880A0
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF832FB2DC;
	Mon,  5 May 2025 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU9TtSD+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0392FB2C1;
	Mon,  5 May 2025 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483949; cv=none; b=NGWkOBeKI4u94t6zpQPDwgKK6iryFnUArpFQtUgeBgJlh3Qs6Zua/VOI6/UffiKSkewOeolGrM+6oPi0NMdePrqtoaUvwT+SvUu3LO97X5K9u6aVD+6B+QmWalRijhv+aH9Fdza9MUqiPMTnN8oOVitTfNWUXiZ576jpQlcFYe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483949; c=relaxed/simple;
	bh=BuukV9p7q0CplVSlDrk4UoIvI5j7bdvSBn3FGiLexF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QI00CIlE1jb1wo7TZpUuObDWYA7fqI3Sc+VbS6rjHbfrixvYqVirVJF7SI66jY5Nuw+mS+vxA1kUj67CytXfp2ZEZynPCMpJBC9UHWj39bG2E39DEZkXlcVAgYDqm22GXAKart/Skg2c7qT5+/6NGIKA6Se1+At+grodrTthsc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU9TtSD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A07C4CEE4;
	Mon,  5 May 2025 22:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483948;
	bh=BuukV9p7q0CplVSlDrk4UoIvI5j7bdvSBn3FGiLexF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cU9TtSD+dZLxhrv2KVTqnnrlwr/ZveyM4Kudw/uutTDb4ZQOE9QhGQI/D1Ma9JqMC
	 qDWhAwqnPdakcEwb4Tzc6JP5QwdV+EKdWI/gCxm2yqVZTVrDeQVNqKH3uIgCXTuzH8
	 jAT/b4H9TAY8OMh+JC8/P/SkKU0mYo9w9LrZ6KFhQHYIjgukRkL4ZFzX0R4B5u+Cbw
	 z/p8kEYvjI8gmktI7TZou9+bqJlJW+y2BrFXXWjyhYcSUn4yiduQ0UHNbVIMAFJY1Z
	 AEGa/2rPAX2tuzAvBDddBzsfRdV9g0N7iu2cM6OYVwyPh61dAPEt8opnxqq4b5ZEfF
	 1U1IiG0A+b8PA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huisong Li <lihuisong@huawei.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 284/642] hwmon: (acpi_power_meter) Fix the fake power alarm reporting
Date: Mon,  5 May 2025 18:08:20 -0400
Message-Id: <20250505221419.2672473-284-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Huisong Li <lihuisong@huawei.com>

[ Upstream commit 0ea627381eb527a0ebd262c690c3992085b87ff4 ]

We encountered a problem that a fake power alarm is reported to
user on the platform unsupported notifications at the second step
below:
1> Query 'power1_alarm' attribute when the power capping occurs.
2> Query 'power1_alarm' attribute when the power capping is over
   and the current average power is less then power cap value.

The root cause is that the resource->power_alarm is set to true
at the first step. And power meter use this old value to show
the power alarm state instead of the current the comparison value.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Link: https://lore.kernel.org/r/20250220030832.2976-1-lihuisong@huawei.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/acpi_power_meter.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 44afb07409a46..f05986e4f3792 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -437,9 +437,13 @@ static ssize_t show_val(struct device *dev,
 			ret = update_cap(resource);
 			if (ret)
 				return ret;
+			resource->power_alarm = resource->power > resource->cap;
+			val = resource->power_alarm;
+		} else {
+			val = resource->power_alarm ||
+				 resource->power > resource->cap;
+			resource->power_alarm = resource->power > resource->cap;
 		}
-		val = resource->power_alarm || resource->power > resource->cap;
-		resource->power_alarm = resource->power > resource->cap;
 		break;
 	case 7:
 	case 8:
-- 
2.39.5


