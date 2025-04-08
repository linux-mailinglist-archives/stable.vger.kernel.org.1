Return-Path: <stable+bounces-129835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 153AFA80169
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3794188FCB2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A621263C90;
	Tue,  8 Apr 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="upDJwgY+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A34207E14;
	Tue,  8 Apr 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112104; cv=none; b=NQJajf0t3Lf0Sm7DYkGDh5EGm5zkt55LIC79KL5GwIaPae9cTWianmmDfF1xl9JUAVMQ4/Cf7R4Yr1Wd+nHNFlw9XG2KuWa70TL0SjcT2d/U1r9fwY0dmvNVI2vxiw4Y8GQrAaYetmbr/Pe3fVtd2Zp9WszlihkGSlBkbixPqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112104; c=relaxed/simple;
	bh=IgzE+j82mkOyZIBJB7URE/Ef9jrA9fBM+A8GGh8WpzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juDhpQzLdmpcFhu7vDmY8KPmxDw0eDW+6GrUsKW99ay9do/BXea1FTTkFU+L+NDCQxo0aixS1W1MM9i4pVLtWyyoptHzy2PC/GNvtnIe2/QRjf1UyCrFqy8ZlNYPUGZjBii/MSOlbZqPBHFJWvH5jKPlEdoaaIk96dpPHOWMA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=upDJwgY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A709EC4CEE5;
	Tue,  8 Apr 2025 11:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112104;
	bh=IgzE+j82mkOyZIBJB7URE/Ef9jrA9fBM+A8GGh8WpzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=upDJwgY+ibQcG8mCJWWb5mJmhMkisnOx6s4MsQIMDd5ZNHXMhtvYUEG+Ny+xVSrMD
	 nj6hbUGvXfkIvvoq9s2cjWwjsXxrNS7fRtmZsc2wAv+GPaLDnl2mrvOJfeRAC7I1pL
	 LjBC/SNOIt+3PvfQhoVR3NPbh29q5OGFQ5YD9tzs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vlastimil Holer <vlastimil.holer@gmail.com>,
	Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>,
	Seyediman Seyedarab <ImanDevel@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.14 675/731] platform/x86: thinkpad_acpi: disable ACPI fan access for T495* and E560
Date: Tue,  8 Apr 2025 12:49:32 +0200
Message-ID: <20250408104929.969064270@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>

commit 2b9f84e7dc863afd63357b867cea246aeedda036 upstream.

T495, T495s, and E560 laptops have the FANG+FANW ACPI methods
(therefore fang_handle and fanw_handle are not NULL) but they do not
actually work, which results in a "No such device or address" error.
The DSDT table code for the FANG+FANW methods doesn't seem to do
anything special regarding the fan being secondary. The bug was
introduced in commit 57d0557dfa49 ("platform/x86: thinkpad_acpi: Add
Thinkpad Edge E531 fan support"), which added a new fan control method
via the FANG+FANW ACPI methods.

Add a quirk for T495, T495s, and E560 to avoid the FANG+FANW methods.
Fan access and control is restored after forcing the legacy non-ACPI
fan control method by setting both fang_handle and fanw_handle to NULL.

Reported-by: Vlastimil Holer <vlastimil.holer@gmail.com>
Fixes: 57d0557dfa49 ("platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan support")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219643
Cc: stable@vger.kernel.org
Tested-by: Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>
Reviewed-by: Kurt Borja <kuurtb@gmail.com>
Signed-off-by: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
Co-developed-by: Seyediman Seyedarab <ImanDevel@gmail.com>
Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
Link: https://lore.kernel.org/r/20250324152442.106113-1-ImanDevel@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/thinkpad_acpi.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8797,6 +8797,7 @@ static const struct attribute_group fan_
 #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
 #define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
 #define TPACPI_FAN_TPR		0x0040		/* Fan speed is in Ticks Per Revolution */
+#define TPACPI_FAN_NOACPI	0x0080		/* Don't use ACPI methods even if detected */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8827,6 +8828,9 @@ static const struct tpacpi_quirk fan_qui
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
 	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
 	TPACPI_Q_LNV('8', 'F', TPACPI_FAN_TPR),		/* ThinkPad x120e */
+	TPACPI_Q_LNV3('R', '0', '0', TPACPI_FAN_NOACPI),/* E560 */
+	TPACPI_Q_LNV3('R', '1', '2', TPACPI_FAN_NOACPI),/* T495 */
+	TPACPI_Q_LNV3('R', '1', '3', TPACPI_FAN_NOACPI),/* T495s */
 };
 
 static int __init fan_init(struct ibm_init_struct *iibm)
@@ -8878,6 +8882,13 @@ static int __init fan_init(struct ibm_in
 		tp_features.fan_ctrl_status_undef = 1;
 	}
 
+	if (quirks & TPACPI_FAN_NOACPI) {
+		/* E560, T495, T495s */
+		pr_info("Ignoring buggy ACPI fan access method\n");
+		fang_handle = NULL;
+		fanw_handle = NULL;
+	}
+
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;



