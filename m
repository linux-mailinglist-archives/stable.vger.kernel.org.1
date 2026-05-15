Return-Path: <stable+bounces-247910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNA9F6pFB2qgvwIAu9opvQ
	(envelope-from <stable+bounces-247910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:11:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60717552CB1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2BE6303648F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9293FF1DE;
	Fri, 15 May 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jzdHWLBV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE43FF1CD;
	Fri, 15 May 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860387; cv=none; b=Qou/0A1pqnKxbHocCkRFD/f9CcHakz+4tRXOEM/IHEgbjeWnwnV3lEOvx57lN+gqQHagmXPEYmNoxg41wsZ2SGW6uUvBczPLimDZcHOMtBGZ/6xo9bauuuZKYB7zTP/FcRDQu42n54HwyUQsXwwj4/PDE5kbR/cHRBV5ydDGYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860387; c=relaxed/simple;
	bh=Gi1OYat2Ild6KkIMWPLQvKL5KL+xMS//Mk5OjdUdux4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSzG+fQsx6G3Tl7gp/iYIpIQ7BXwIq3BdvWi7TrU6Pv7PTepoOwVa6aduxavo3G9RnUfxe3yDXoeKyYCLJf9RKkn0RbF6OWmoCOpiVeI9WLjF9VcPRC/SljjmPuau2JOverl1pSESRoq/hzQloIFaHgx5qkHa3dmM5bow+aOlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jzdHWLBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91215C2BCB0;
	Fri, 15 May 2026 15:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860386;
	bh=Gi1OYat2Ild6KkIMWPLQvKL5KL+xMS//Mk5OjdUdux4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzdHWLBV0aYvbTxOkUUIVLW5Wkybitj7f+iZlD0zXcUBJXS1kyh/K59ycos7by4rY
	 xtHipdgUkHEc6oFqmA2zwA+i9LpeK0TazWURTy/wa6nxfglbeRKLfc6+Xk/AwzE3ZJ
	 VY71A1YC7XIEPdrhYawP0+yt47Vmxa7O0fR5nuCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 070/144] drm/amd/pm: fix incorrect FeatureCtrlMask setting on smu v14.0.x
Date: Fri, 15 May 2026 17:48:16 +0200
Message-ID: <20260515154655.163730514@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60717552CB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247910-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Wang <kevinyang.wang@amd.com>

commit 504f0098ebd074ac8c0ce3471795d79f68e3d265 upstream.

OverDriveTable.FanMinimumPwm and FeatureCtrlMask.PP_OD_FEATURE_FAN_LEGACY_BIT
have a hard dependency.
Invalid handling of this dependency leads to disabled thermal monitoring
and temperature boundary validation.

v2: squash in typo fix (Yang)

Fixes: 9710b84e2a6a ("drm/amd/pm: add overdrive support on smu v14.0.2/3")
Cc: stable@vger.kernel.org
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2424,6 +2424,7 @@ static int smu_v14_0_2_od_restore_table_
 		}
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		od_table->OverDriveTable.AcousticLimitRpmThreshold =
@@ -2447,7 +2448,8 @@ static int smu_v14_0_2_od_restore_table_
 		od_table->OverDriveTable.FanMinimumPwm =
 					boot_overdrive_table->OverDriveTable.FanMinimumPwm;
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	default:
 		dev_info(adev->dev, "Invalid table index: %ld\n", input);
@@ -2617,6 +2619,7 @@ static int smu_v14_0_2_od_edit_dpm_table
 		od_table->OverDriveTable.FanLinearPwmPoints[input[0]] = input[2];
 		od_table->OverDriveTable.FanMode = FAN_MODE_MANUAL_LINEAR;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
@@ -2686,7 +2689,7 @@ static int smu_v14_0_2_od_edit_dpm_table
 		break;
 
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
-		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_LEGACY_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
@@ -2704,7 +2707,8 @@ static int smu_v14_0_2_od_edit_dpm_table
 
 		od_table->OverDriveTable.FanMinimumPwm = input[0];
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
 	case PP_OD_RESTORE_DEFAULT_TABLE:



