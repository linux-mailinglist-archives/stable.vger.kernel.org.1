Return-Path: <stable+bounces-166320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F41BAB198FB
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C391885AC3
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA31EF091;
	Mon,  4 Aug 2025 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRowd0wa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9866717B50A;
	Mon,  4 Aug 2025 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267943; cv=none; b=Pf1RB1phyMYInHTdrTh+YPEh3syEs9d24sIDYwdLlRPFswSKD6wdpdB+AtOACS5jb3A8o8YVq0x7ubsCOZN8nW4ctPhVHfKU8jf9WilX4nufMV6c0LD54QxaGH2uFtpFHsl53OJzHLRgKEMocIp7JrQoYdQb+/1sE36zzfuL5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267943; c=relaxed/simple;
	bh=NiI4zHJmlmQ7YuWVfSksHs58Sv5/ANF6isUY8PP5QKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JOR+U/QV6P5X39FJZiVvSut1iXNMYzfMucgCtIEqSquq3f5XJuQw8iZMc3tsi95sF2a1C5Tz6S7TNdDLkEe7WHc7+Knz+OfAoSBx+H1HCsh3G4sRaq0MnlBMYdxw6lzN4jz74wbghIHaH/9yxdhKpwiVTrOYfWW2HVJrUko71UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRowd0wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E87C4CEF8;
	Mon,  4 Aug 2025 00:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267943;
	bh=NiI4zHJmlmQ7YuWVfSksHs58Sv5/ANF6isUY8PP5QKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRowd0waGGzJuhM2NwWuKNZ+j+VsqLcq4ygWDsT6Hn+nfCAqdakQUYpM9TXTlyiDB
	 EPdqYWRG/hPRc+jiNbsjgXUR+AO7+YNrbGW4EuRT9/Qfg2NK/Ii8B9ktwtXsQxYXFf
	 d+rij9GXqkCFUOy3IQpE4jWA2OW3crdCip8z87gN1TLSOd6hrdEzcDIWG31E8g6ckr
	 zPyG4YwUWALeNmdj0TKMnv6quUTR2aGCOzj1z4JU/Uhpemt5Zhf6rw3lce3EYK/v6d
	 bdMifjhDm9f7nwMZcgyJoEU4r6OSJRMVTbAtfRu2jmlboIxNVDJrZOEtF16TuG0aiI
	 nvQRnlerRmiWQ==
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
Subject: [PATCH AUTOSEL 5.15 04/44] usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default
Date: Sun,  3 Aug 2025 20:38:09 -0400
Message-Id: <20250804003849.3627024-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003849.3627024-1-sashal@kernel.org>
References: <20250804003849.3627024-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.189
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
index 56bf56517f75..b7d16ad38c44 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -142,7 +142,7 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 	case UCSI_CONSTAT_PWR_OPMODE_DEFAULT:
 	/* UCSI can't tell b/w DCP/CDP or USB2/3x1/3x2 SDP chargers */
 	default:
-		val->intval = 0;
+		val->intval = UCSI_TYPEC_DEFAULT_CURRENT * 1000;
 		break;
 	}
 	return 0;
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 87b1a54d68e8..44c788b4a8b3 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -309,9 +309,10 @@ struct ucsi {
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


