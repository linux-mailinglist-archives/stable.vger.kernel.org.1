Return-Path: <stable+bounces-166062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C9AB19785
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8B03A6528
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10340188A3A;
	Mon,  4 Aug 2025 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsztAVhj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C342629A2;
	Mon,  4 Aug 2025 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267290; cv=none; b=rUQ+1rLwaL9hGoRhCZgS1f9WT6fCfMwAccXzhoE7c6S1EFq4j8Uancy9lMAyMDaPWElPy/0uHiC9Qcu1UBdBqvzPUVpDp7jIrBts0/RaIMbVHVP3dBNGzD3+fWMWqRLBBqkbUuoXJs7T+951a3spYB0ClyBFxCWOImB19UpwMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267290; c=relaxed/simple;
	bh=f99W5VulwPOjO3tKuSBKnfkpRoqYpb5OBvRC2l+shdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DNAvAROlBNraBciq92S/TP7ED2v/RYkZ7Ah/cXwQWYWHwXIWhFXt9sEy5Gtax78dZfvtkIZAtWM1jAc5vTwinuQR0NQDRKv0dv0ZINWroNC8TuYW+PzddtjrhqFDXZW1Eos61Il8n95swZLZHdevGmh38AqCKWO5L83N33xVW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsztAVhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC9DC4CEEB;
	Mon,  4 Aug 2025 00:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267290;
	bh=f99W5VulwPOjO3tKuSBKnfkpRoqYpb5OBvRC2l+shdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NsztAVhj4N8wbLKFCKMCjoKDEO+u2aGvIKXpZcMUldhOFPnaOt8VGvXrCZnoEMl/K
	 edXjR21PdLMjlwhbCaG/naP25aunl/yjHgPmj6Idk5Mjl1NLdwBXF0fhePHjoz3kVF
	 /NmtUPeA5+1gmeLGuSGlejTRlWD7ukxK6+kEiEF3EBp2EdhfPmVgbUV3Uf6VtzK07a
	 YaYguT2ILBqBT+Ps5z6v8KpYG7/aZmQzADU9lao1adte4wL8y24AzNAU6zrO7UhioU
	 dCSGfrjDwN8lASuqra5jFRTC6wAg76m9RNzWn1uZ5W41sEo1BsYr2mNcn2YGZLSqT2
	 w1yu5pT3kfIkA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	hansg@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	madhu.m@intel.com
Subject: [PATCH AUTOSEL 6.15 06/80] usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default
Date: Sun,  3 Aug 2025 20:26:33 -0400
Message-Id: <20250804002747.3617039-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002747.3617039-1-sashal@kernel.org>
References: <20250804002747.3617039-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.9
Content-Transfer-Encoding: 8bit

From: Benson Leung <bleung@chromium.org>

[ Upstream commit af833e7f7db3cf4c82f063668e1b52297a30ec18 ]

ucsi_psy_get_current_max would return 0mA as the maximum current if
UCSI detected a BC or a Default USB Power sporce.

The comment in this function is true that we can't tell the difference
between DCP/CDP or SDP chargers, but we can guarantee that at least 1-unit
of USB 1.1/2.0 power is available, which is 100mA, which is a better
fallback value than 0, which causes some userspaces, including the ChromeOS
power manager, to regard this as a power source that is not providing
any power.

In reality, 100mA is guaranteed from all sources in these classes.

Signed-off-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Jameson Thies <jthies@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20250717200805.3710473-1-bleung@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Let me analyze the code changes more carefully. The commit introduces a
new constant `UCSI_TYPEC_DEFAULT_CURRENT` set to 100mA and changes the
behavior for BC 1.2 and Default USB power sources from returning 0mA to
returning 100mA.

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Bug Fix for User-Facing Issue**: The commit fixes a clear bug where
   the UCSI driver was reporting 0mA as the maximum current for BC 1.2
   and Default USB power sources. This incorrect value causes userspace
   power managers (specifically mentioned: ChromeOS power manager) to
   incorrectly interpret these power sources as not providing any power.
   This is a functionality bug that affects end users.

2. **Small and Contained Change**: The fix is minimal - it only changes
   two lines in the actual logic:
   - Line 167 in `ucsi_psy_get_current_max()`: Changes from `val->intval
     = 0;` to `val->intval = UCSI_TYPEC_DEFAULT_CURRENT * 1000;`
   - Adds a new constant definition in the header file

3. **Minimal Risk of Regression**: The change is very conservative:
   - It only affects the BC (Battery Charging) and DEFAULT power
     operation modes
   - The 100mA value is the guaranteed minimum from USB 1.1/2.0
     specification (1 unit load)
   - It doesn't change behavior for any other power modes (PD, TypeC
     1.5A, TypeC 3.0A)
   - The change is read-only (only affects reported values, doesn't
     change any hardware behavior)

4. **Clear Technical Justification**: The commit message correctly
   explains that while UCSI cannot distinguish between DCP/CDP or SDP
   chargers, all USB sources in these classes guarantee at least 100mA
   (1 unit load per USB specification). This is technically accurate and
   represents the minimum guaranteed current.

5. **No Architectural Changes**: This is a simple value correction that
   doesn't introduce new features or change any interfaces. It maintains
   the existing API while providing more accurate information.

6. **Fixes Real-World Issues**: The commit explicitly mentions that
   returning 0mA causes problems with userspace power management
   software, which would treat the power source as non-functional. This
   could lead to incorrect battery status reporting or power management
   decisions.

The change follows stable kernel rules by being a targeted fix for a
specific bug that affects users, with minimal code changes and low
regression risk.

 drivers/usb/typec/ucsi/psy.c  | 2 +-
 drivers/usb/typec/ucsi/ucsi.h | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 62ac69730405..62a9d68bb66d 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -164,7 +164,7 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 	case UCSI_CONSTAT_PWR_OPMODE_DEFAULT:
 	/* UCSI can't tell b/w DCP/CDP or USB2/3x1/3x2 SDP chargers */
 	default:
-		val->intval = 0;
+		val->intval = UCSI_TYPEC_DEFAULT_CURRENT * 1000;
 		break;
 	}
 	return 0;
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 70910232a05d..1ae068a92844 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -479,9 +479,10 @@ struct ucsi {
 #define UCSI_MAX_SVID		5
 #define UCSI_MAX_ALTMODES	(UCSI_MAX_SVID * 6)
 
-#define UCSI_TYPEC_VSAFE5V	5000
-#define UCSI_TYPEC_1_5_CURRENT	1500
-#define UCSI_TYPEC_3_0_CURRENT	3000
+#define UCSI_TYPEC_VSAFE5V		5000
+#define UCSI_TYPEC_DEFAULT_CURRENT	 100
+#define UCSI_TYPEC_1_5_CURRENT		1500
+#define UCSI_TYPEC_3_0_CURRENT		3000
 
 struct ucsi_connector {
 	int num;
-- 
2.39.5


