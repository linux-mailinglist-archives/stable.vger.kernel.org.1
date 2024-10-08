Return-Path: <stable+bounces-82005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D5D994A94
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197D01F23911
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D391DE890;
	Tue,  8 Oct 2024 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZniomD1t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B221DE3A2;
	Tue,  8 Oct 2024 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390857; cv=none; b=HDyzvbijio4Yiu8cm8xDXGgZwlITifgC6VyqKBrkIHPuGCdxQOm9+Md4nrBis+HaFAC8TuHM88XVcwVdAViZ7FCU6XPUe8Y3AtjM6Jn7GbRTCqRchlrHKxIT/jGi2/BIjgGhEionaWMxgWyYIuz5ljpcdGqMiQdTR868vo8p3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390857; c=relaxed/simple;
	bh=VvcEpblsPYi93zWLdDd1nTMACvafX6p1KHcTdPZjC8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRq3yEecEqalsdS7tQhSLOtbVjSLDUNwYD6u6im4xM13Op1QsQXa4DqN+JNimtaAQJM32c5gJHTwSHg8OciSs4zzoKqOmea6wZm7vr4s2SkKD/eQY2sCNjRbrcuxbfQnbdXXGgS5bOGIeR+ZFx9rvk8DarcW2MY2oPOy8J8amwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZniomD1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E82C4CEC7;
	Tue,  8 Oct 2024 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390857;
	bh=VvcEpblsPYi93zWLdDd1nTMACvafX6p1KHcTdPZjC8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZniomD1taSRiUuBNmiaRCCoVxpYK5/DwSvWK53pqRjctZhp8r0mSfc4TJcEDXgEWJ
	 JvQUU2wMG5wJXySY8eTqvaWdqfutOI0nEOg5dsSSW9rCbDZkrZuMF9osHB9D/NMuBN
	 9QDwKtiE4t5VC8rENVo14JVI7myXvljE8MgdUqTY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.10 414/482] ACPI: resource: Loosen the Asus E1404GAB DMI match to also cover the E1404GA
Date: Tue,  8 Oct 2024 14:07:57 +0200
Message-ID: <20241008115704.696296280@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 63539defee17bf0cbd8e24078cf103efee9c6633 upstream.

Like other Asus Vivobooks, the Asus Vivobook Go E1404GA has a DSDT
describing IRQ 1 as ActiveLow, while the kernel overrides to Edge_High.

    $ sudo dmesg | grep DMI:.*BIOS
    [    0.000000] DMI: ASUSTeK COMPUTER INC. Vivobook Go E1404GA_E1404GA/E1404GA, BIOS E1404GA.302 08/23/2023
    $ sudo cp /sys/firmware/acpi/tables/DSDT dsdt.dat
    $ iasl -d dsdt.dat
    $ grep -A 30 PS2K dsdt.dsl | grep IRQ -A 1
                IRQ (Level, ActiveLow, Exclusive, )
                    {1}

There already is an entry in the irq1_level_low_skip_override[] DMI match
table for the "E1404GAB", change this to match on "E1404GA" to cover
the E1404GA model as well (DMI_MATCH() does a substring match).

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219224
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20240927141606.66826-2-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/resource.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -504,10 +504,10 @@ static const struct dmi_system_id irq1_l
 		},
 	},
 	{
-		/* Asus Vivobook Go E1404GAB */
+		/* Asus Vivobook Go E1404GA* */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "E1404GAB"),
+			DMI_MATCH(DMI_BOARD_NAME, "E1404GA"),
 		},
 	},
 	{



