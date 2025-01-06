Return-Path: <stable+bounces-107730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D1A02E07
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685E01886673
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F63C1DE3D6;
	Mon,  6 Jan 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKbluuwE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EFA1DE3A6;
	Mon,  6 Jan 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181723; cv=none; b=uBNPY4Se9Sz5y/tdJU00RQCf5s8ljJmiUrj3v2/qjiL4rOAeqApEp2QGpRC4a+VdwbyHaCdbca7mQOSEXWIjbHng/c4dJCWwnlARjaKcRkcBkJOs94l8aHfTpZJg5sLDf7vzRg0O9k4NoPi0gHRsLxHkpz9UOEC2DSVeduFo2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181723; c=relaxed/simple;
	bh=xZJEykeh9AUW0fTeB90KDujGpmntRW19r3hrBecyQdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbD4snEodvWNYuCPXTuQbs8CkevU+ZjA0fXab8CrPCPtHWLuQ/uufXng5EC6+pBxy3nG9T7XEfRwcFX7sJ2lZ+COp8S5VGt56O/N+je+SBcDqI4EqX0sslUjRxdMHY14Mvaysw2MfSQhLCVbidWqbs3lFd+H6JI7aWsNTMumATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKbluuwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FC2C4CEE1;
	Mon,  6 Jan 2025 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181722;
	bh=xZJEykeh9AUW0fTeB90KDujGpmntRW19r3hrBecyQdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKbluuwEsNT3L5Vna8ycSkmQzuTN4wI6reMRQ7rP5phTkTbTcTe6EjXXhk5+uNOTB
	 DrNhepQUBpbua4IKSb3TS+wqev5yRBv3PFcOCQzdp8/9Ho0t8cKsm/3MGscTSC7dMq
	 9OSYAtCNR8qGe4gVkwPzbGMdw0YWjLTcbybxeoZckW/LnRnZMSBIAndPH2cFAmZ+nm
	 zBWRV18eVzT/sZcxUYTvMa1Xr/dC7R0XVmo/fma7kk0GrobVU281of/qQHCM9XRxrk
	 0ULcfUhT90TY4fjvAyAE8Nwh9B0u1ZBBw/Nhc0d1+D1taPYL1piMN290Uq1K5sHBW4
	 QNGCMNG7aWl+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vishnu Sankar <vishnuocv@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	corbet@lwn.net,
	hmh@hmh.eng.br,
	hdegoede@redhat.com,
	linux-doc@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 7/8] platform/x86: thinkpad-acpi: Add support for hotkey 0x1401
Date: Mon,  6 Jan 2025 11:41:07 -0500
Message-Id: <20250106164138.1122164-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106164138.1122164-1-sashal@kernel.org>
References: <20250106164138.1122164-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.8
Content-Transfer-Encoding: 8bit

From: Vishnu Sankar <vishnuocv@gmail.com>

[ Upstream commit 7e16ae558a87ac9099b6a93a43f19b42d809fd78 ]

F8 mode key on Lenovo 2025 platforms use a different key code.
Adding support for the new keycode 0x1401.

Tested on X1 Carbon Gen 13 and X1 2-in-1 Gen 10.

Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://lore.kernel.org/r/20241227231840.21334-1-vishnuocv@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/laptops/thinkpad-acpi.rst | 10 +++++++---
 drivers/platform/x86/thinkpad_acpi.c                |  4 +++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
index 7f674a6cfa8a..4ab0fef7d440 100644
--- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
+++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
@@ -445,8 +445,10 @@ event	code	Key		Notes
 0x1008	0x07	FN+F8		IBM: toggle screen expand
 				Lenovo: configure UltraNav,
 				or toggle screen expand.
-				On newer platforms (2024+)
-				replaced by 0x131f (see below)
+				On 2024 platforms replaced by
+				0x131f (see below) and on newer
+				platforms (2025 +) keycode is
+				replaced by 0x1401 (see below).
 
 0x1009	0x08	FN+F9		-
 
@@ -506,9 +508,11 @@ event	code	Key		Notes
 
 0x1019	0x18	unknown
 
-0x131f	...	FN+F8	        Platform Mode change.
+0x131f	...	FN+F8		Platform Mode change (2024 systems).
 				Implemented in driver.
 
+0x1401	...	FN+F8		Platform Mode change (2025 + systems).
+				Implemented in driver.
 ...	...	...
 
 0x1020	0x1F	unknown
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 6371a9f765c1..2cfb2ac3f465 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -184,7 +184,8 @@ enum tpacpi_hkey_event_t {
 						   */
 	TP_HKEY_EV_AMT_TOGGLE		= 0x131a, /* Toggle AMT on/off */
 	TP_HKEY_EV_DOUBLETAP_TOGGLE	= 0x131c, /* Toggle trackpoint doubletap on/off */
-	TP_HKEY_EV_PROFILE_TOGGLE	= 0x131f, /* Toggle platform profile */
+	TP_HKEY_EV_PROFILE_TOGGLE	= 0x131f, /* Toggle platform profile in 2024 systems */
+	TP_HKEY_EV_PROFILE_TOGGLE2	= 0x1401, /* Toggle platform profile in 2025 + systems */
 
 	/* Reasons for waking up from S3/S4 */
 	TP_HKEY_EV_WKUP_S3_UNDOCK	= 0x2304, /* undock requested, S3 */
@@ -11200,6 +11201,7 @@ static bool tpacpi_driver_event(const unsigned int hkey_event)
 		tp_features.trackpoint_doubletap = !tp_features.trackpoint_doubletap;
 		return true;
 	case TP_HKEY_EV_PROFILE_TOGGLE:
+	case TP_HKEY_EV_PROFILE_TOGGLE2:
 		platform_profile_cycle();
 		return true;
 	}
-- 
2.39.5


