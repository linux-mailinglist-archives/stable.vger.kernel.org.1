Return-Path: <stable+bounces-108913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B237EA120E5
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0CC3A9AEA
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202A1248BD1;
	Wed, 15 Jan 2025 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Df5rIUjO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9B248BBD;
	Wed, 15 Jan 2025 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938226; cv=none; b=MeXHXjSipqWRxYcreaxOF91BlO45Nhjeg5GiGWQ4zPFtGEBDAvH73wxnrYQR2ia09PuD498woVkWArIlZnxKen+1wTEJdvC/UnlcDBPu9Xmp2xhaF6nG1wls9PstpzzQZyJyG4bx4BP7jFX977Co5VO1hhIAPexiF+9ogu2AeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938226; c=relaxed/simple;
	bh=dCXo+qZDiSITcXY1+yqxQqyudwxgG01gDe9IQ57ltqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzRQOtHxbSXb0I3sGSUeL6V5RhfFxxsNpiPMK7oX1YzIXUmnBpV2HnGTJKXf2EYNtJdJ2ivLOYnJdA03B9MDKQkZbY4xsnqTKCsoRMGcNOWueoWqnLinqfv6JBnTqXMbtVuj3wpuJfgjhoZ60QL75VkEkKR27H/gig/BiEnSZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Df5rIUjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B39FC4CEDF;
	Wed, 15 Jan 2025 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938226;
	bh=dCXo+qZDiSITcXY1+yqxQqyudwxgG01gDe9IQ57ltqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Df5rIUjO6gRC/1Knpc1sF2LVN3MGUmDD/BMtIUXaYBTy5e1/Nhvda6RVKb9xIg57c
	 NlSZ+ElkTHv2FQ4YKK8iy5kYyhxg46Ke2gfN6tTKnD34dVyGiNtFIyjPpdGOWhNXSr
	 V/1hV7zvHGxj1yTSF1T/9BKdO51MJVHp1LgWXwjk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.12 120/189] ACPI: resource: Add Asus Vivobook X1504VAP to irq1_level_low_skip_override[]
Date: Wed, 15 Jan 2025 11:36:56 +0100
Message-ID: <20250115103611.245348009@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 66d337fede44dcbab4107d37684af8fcab3d648e upstream.

Like the Vivobook X1704VAP the X1504VAP has its keyboard IRQ (1) described
as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh which
breaks the keyboard.

Add the X1504VAP to the irq1_level_low_skip_override[] quirk table to fix
this.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219224
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20241220181352.25974-1-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/resource.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -441,6 +441,13 @@ static const struct dmi_system_id irq1_l
 		},
 	},
 	{
+		/* Asus Vivobook X1504VAP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "X1504VAP"),
+		},
+	},
+	{
 		/* Asus Vivobook X1704VAP */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),



