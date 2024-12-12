Return-Path: <stable+bounces-101427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7449EEC57
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B248A18870DE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603C2217F5D;
	Thu, 12 Dec 2024 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zlJzmczE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB68217F40;
	Thu, 12 Dec 2024 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017514; cv=none; b=p00VwfgOZaP2BCeI7QLlmrj/jFiUYvqGtAHmk4sFqpYSP3VRAqCWJMQ8PQxYk1vNgNL+LI+sHrVDo5k/zygsvtvM5Tus5dQqPng7ALYE8DTnDfLGX6dKYeb/AL5PYi/PE/uz86C0liBpYvfQU9NZeaAc1b5J2rmKzo6imewFRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017514; c=relaxed/simple;
	bh=EF/Gmb6l0Ko+ZLF4bavDIbJeK5H0Q4HmTRl/CyNCS/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ND3n7BJUmGUBXXVHsPBeLf0VjkNUkFsR4dru3oGhp0VfTTKURBuWkvlINyu4TeNY5Ek5EOp8k8qmsv+ayNt8mbVgCUmhWCQYTg8PooLD4P4nLbWyomytsPIszt3KikE4pzwM0ZUnO3zIZPPLk062j1miXfdWkeK9eqyG/SncEmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zlJzmczE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8781C4CED4;
	Thu, 12 Dec 2024 15:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017513;
	bh=EF/Gmb6l0Ko+ZLF4bavDIbJeK5H0Q4HmTRl/CyNCS/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zlJzmczEw4CgTYAew/iLmDevinrRIWs2q1Pu/nbtP9ynd4NNAiYn7fTN/zuSSBJnv
	 I7HW/a4+KllYcy0CZR5ZwazWg3DDYeTXoYgAAgyYbySxQ/txBlwQfY1mkVnkA8DgFa
	 pSGmTe+JE2pbEbbSsyM3lTqjWZ3mAAiYH06H3GEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Casey G Bowman <casey.g.bowman@intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 027/356] platform/x86: asus-wmi: Fix inconsistent use of thermal policies
Date: Thu, 12 Dec 2024 15:55:46 +0100
Message-ID: <20241212144245.701327359@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 895085ec3f2ed7a26389943729e2904df1f88dc0 ]

When changing the thermal policy using the platform profile API,
a Vivobook thermal policy is stored in throttle_thermal_policy_mode.

However everywhere else a normal thermal policy is stored inside this
variable, potentially confusing the platform profile.

Fix this by always storing normal thermal policy values inside
throttle_thermal_policy_mode and only do the conversion when writing
the thermal policy to hardware. This also fixes the order in which
throttle_thermal_policy_switch_next() steps through the thermal modes
on Vivobook machines.

Tested-by: Casey G Bowman <casey.g.bowman@intel.com>
Fixes: bcbfcebda2cb ("platform/x86: asus-wmi: add support for vivobook fan profiles")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20241107003811.615574-2-W_Armin@gmx.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 25fb5f47f34d ("platform/x86: asus-wmi: Ignore return value when writing thermal policy")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 64 +++++++++++----------------------
 1 file changed, 21 insertions(+), 43 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index d0ba8bd83fc3d..e36c299dcfb17 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3386,10 +3386,28 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 /* Throttle thermal policy ****************************************************/
 static int throttle_thermal_policy_write(struct asus_wmi *asus)
 {
-	u8 value = asus->throttle_thermal_policy_mode;
 	u32 retval;
+	u8 value;
 	int err;
 
+	if (asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO) {
+		switch (asus->throttle_thermal_policy_mode) {
+		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
+			value = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
+			break;
+		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
+			value = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
+			break;
+		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
+			value = ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		value = asus->throttle_thermal_policy_mode;
+	}
+
 	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
 				    value, &retval);
 
@@ -3494,46 +3512,6 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 static DEVICE_ATTR_RW(throttle_thermal_policy);
 
 /* Platform profile ***********************************************************/
-static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus, int mode)
-{
-	bool vivo;
-
-	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
-
-	if (vivo) {
-		switch (mode) {
-		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
-			return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
-		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
-			return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
-		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
-			return ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
-		}
-	}
-
-	return mode;
-}
-
-static int asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus, int mode)
-{
-	bool vivo;
-
-	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
-
-	if (vivo) {
-		switch (mode) {
-		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO:
-			return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
-		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO:
-			return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
-		case ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO:
-			return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
-		}
-	}
-
-	return mode;
-}
-
 static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 					enum platform_profile_option *profile)
 {
@@ -3543,7 +3521,7 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
 	tp = asus->throttle_thermal_policy_mode;
 
-	switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
+	switch (tp) {
 	case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
 		*profile = PLATFORM_PROFILE_BALANCED;
 		break;
@@ -3582,7 +3560,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 		return -EOPNOTSUPP;
 	}
 
-	asus->throttle_thermal_policy_mode = asus_wmi_platform_profile_to_vivo(asus, tp);
+	asus->throttle_thermal_policy_mode = tp;
 	return throttle_thermal_policy_write(asus);
 }
 
-- 
2.43.0




