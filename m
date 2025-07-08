Return-Path: <stable+bounces-160598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C176AFD0E8
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48124189E801
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C12E11DA;
	Tue,  8 Jul 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1/Y5ovzI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946A42A1BA;
	Tue,  8 Jul 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992123; cv=none; b=IFxwzXKCwIu7hvdW4kz6v27BHaBlhwHZNnF2Mbdnpc6vsV61pV/DcVKSIB7Oygwf46H8Pb/aw3CsJ/EETdHtKGzGk1U2OfzJUKKzedJAd4wPGabtXXAdq+uwtnSqsLotv6wGrAaAoN5qurZEA1kxrWUaH59mZpLG9E7/eFsXAhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992123; c=relaxed/simple;
	bh=MeYgRNZk4/WCeSe7Ig9zT/p2TmAb9qukLL2gR0VZafc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P92tJWATlhXGwD2aLzm9WOQvWMbSZhbPdRBVaUIdmScjf+WAmifN630e34cz6e768Uet+rOp4WzBVIxPR51S1e0dIw5r3RO8FBQvMBtfU6FeRi4QzFezR2uTaQqD7t2kCtCWdj27PuTpJg55nYO+JaFqKz9R4YzxjymEb+HBbyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1/Y5ovzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11E3C4CEED;
	Tue,  8 Jul 2025 16:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992123;
	bh=MeYgRNZk4/WCeSe7Ig9zT/p2TmAb9qukLL2gR0VZafc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1/Y5ovzIOG7SbAl3vEWi4GPwNis0yAYpuTKHJpz/QJRsguWoicikAYgZUVL/e5Z37
	 vShAW529sAN7633W3yt2JbNM3tei1ILXftOjOnfbJY+oMRGjTcRY1Xd+X++9vJLzv0
	 ncmI+YgoTmDEuL0xP6IjewpwrRRxe6FcZWRXzQs8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kurt Borja <kuurtb@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 66/81] platform/x86: dell-wmi-sysman: Fix class device unregistration
Date: Tue,  8 Jul 2025 18:23:58 +0200
Message-ID: <20250708162227.065606891@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162224.795155912@linuxfoundation.org>
References: <20250708162224.795155912@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kurt Borja <kuurtb@gmail.com>

[ Upstream commit 314e5ad4782d08858b3abc325c0487bd2abc23a1 ]

Devices under the firmware_attributes_class do not have unique a dev_t.
Therefore, device_unregister() should be used instead of
device_destroy(), since the latter may match any device with a given
dev_t.

Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250625-dest-fix-v1-3-3a0f342312bb@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 660f00173f2ea..fb5eb4342c6ed 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -605,7 +605,7 @@ static int __init sysman_init(void)
 	release_attributes_data();
 
 err_destroy_classdev:
-	device_destroy(fw_attr_class, MKDEV(0, 0));
+	device_unregister(wmi_priv.class_dev);
 
 err_unregister_class:
 	fw_attributes_class_put();
@@ -622,7 +622,7 @@ static int __init sysman_init(void)
 static void __exit sysman_exit(void)
 {
 	release_attributes_data();
-	device_destroy(fw_attr_class, MKDEV(0, 0));
+	device_unregister(wmi_priv.class_dev);
 	fw_attributes_class_put();
 	exit_bios_attr_set_interface();
 	exit_bios_attr_pass_interface();
-- 
2.39.5




