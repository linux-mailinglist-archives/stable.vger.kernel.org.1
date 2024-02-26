Return-Path: <stable+bounces-23655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F33867188
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7230128E554
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EDA58AA7;
	Mon, 26 Feb 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DknBfXFH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87F381A1
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943479; cv=none; b=WnTK0+0W0jBZII631Qnwc6nKJIsdFzdykL47kOgJg9wYn39d5J1ifQpoo8huKs/ReRrP7mQL3Es06WYddFL1aIOYzfV5BEKFj49w87D9k/WU6cuj9A1f5CzW5912fPfYjhb0JQnBUSFarmei+aI6GQPKop5FjJMgLAtxPUKa6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943479; c=relaxed/simple;
	bh=y265TzFF0ZMAe4rf0VFJJ9NTdcx1iH3X3133T8Wek4U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A8DIKbe6WD+CmFMgJkf2076WRQhVNDm31djbqnRS5ad0/GrfFA8OkQHZ6ZShL7VnaFHTYgof8I6xLOlE/hFrUeUItEwf0S4MWNUSmi9jflLF1RA05M70U5arVpYfYVpk9Gx0SDrPaBnctByz1gxb7VphgOHSyg41ZZFl+ovZmS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DknBfXFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AA8C433F1;
	Mon, 26 Feb 2024 10:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943479;
	bh=y265TzFF0ZMAe4rf0VFJJ9NTdcx1iH3X3133T8Wek4U=;
	h=Subject:To:Cc:From:Date:From;
	b=DknBfXFHeLR2S7AYGtxAkTSZ97kaQeAANogVpID/ADH/cS7RAE7+Q0/fLEULoWqJD
	 Zxfeia8oyK7m8IFduEZ9wU8/uNzidzqzwNboClXrCS25aNV8H9uOis5+ppnEIG3KP3
	 8n0BNhZnXifgYGSC+VHsoizn1cZPsEINvsIT/CQg=
Subject: FAILED: patch "[PATCH] platform/x86: touchscreen_dmi: Allow partial (prefix) matches" failed to apply to 5.4-stable tree
To: hdegoede@redhat.com,sathyanarayanan.kuppuswamy@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:31:08 +0100
Message-ID: <2024022608-trombone-banker-5ed4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x dbcbfd662a725641d118fb3ae5ffb7be4e3d0fb0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022608-trombone-banker-5ed4@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

dbcbfd662a72 ("platform/x86: touchscreen_dmi: Allow partial (prefix) matches for ACPI names")
87eaede45385 ("platform/x86: touchscreen_dmi: Handle device properties with software node API")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dbcbfd662a725641d118fb3ae5ffb7be4e3d0fb0 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 12 Feb 2024 13:06:07 +0100
Subject: [PATCH] platform/x86: touchscreen_dmi: Allow partial (prefix) matches
 for ACPI names

On some devices the ACPI name of the touchscreen is e.g. either
MSSL1680:00 or MSSL1680:01 depending on the BIOS version.

This happens for example on the "Chuwi Hi8 Air" tablet where the initial
commit's ts_data uses "MSSL1680:00" but the tablets from the github issue
and linux-hardware.org probe linked below both use "MSSL1680:01".

Replace the strcmp() match on ts_data->acpi_name with a strstarts()
check to allow using a partial match on just the ACPI HID of "MSSL1680"
and change the ts_data->acpi_name for the "Chuwi Hi8 Air" accordingly
to fix the touchscreen not working on models where it is "MSSL1680:01".

Note this drops the length check for I2C_NAME_SIZE. This never was
necessary since the ACPI names used are never more then 11 chars and
I2C_NAME_SIZE is 20 so the replaced strncmp() would always stop long
before reaching I2C_NAME_SIZE.

Link: https://linux-hardware.org/?computer=AC4301C0542A
Fixes: bbb97d728f77 ("platform/x86: touchscreen_dmi: Add info for the Chuwi Hi8 Air tablet")
Closes: https://github.com/onitake/gsl-firmware/issues/91
Cc: stable@vger.kernel.org
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240212120608.30469-1-hdegoede@redhat.com

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 7aee5e9ff2b8..969477c83e56 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -81,7 +81,7 @@ static const struct property_entry chuwi_hi8_air_props[] = {
 };
 
 static const struct ts_dmi_data chuwi_hi8_air_data = {
-	.acpi_name	= "MSSL1680:00",
+	.acpi_name	= "MSSL1680",
 	.properties	= chuwi_hi8_air_props,
 };
 
@@ -1821,7 +1821,7 @@ static void ts_dmi_add_props(struct i2c_client *client)
 	int error;
 
 	if (has_acpi_companion(dev) &&
-	    !strncmp(ts_data->acpi_name, client->name, I2C_NAME_SIZE)) {
+	    strstarts(client->name, ts_data->acpi_name)) {
 		error = device_create_managed_software_node(dev, ts_data->properties, NULL);
 		if (error)
 			dev_err(dev, "failed to add properties: %d\n", error);


