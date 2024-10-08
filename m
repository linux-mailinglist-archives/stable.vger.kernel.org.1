Return-Path: <stable+bounces-82945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD802994F9A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760EE1F22783
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C691E1040;
	Tue,  8 Oct 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NtcrWdsi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D31E103B;
	Tue,  8 Oct 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393962; cv=none; b=M0mgaDmtMSVnQ/dElQU0239p5jdRUZVwP1269SpdQUFVoDlTem/7kGFJ7e0dTH2Z1CsFm+wBfwscQm/KciB9u5323k9aQWGfwLk6GHKJ6MU+N5Xl1yvpyDnVwoEjLAyw6Kp8UlrZ7wOmLlMKfHUDn9Bfbu54lmOj0gI9MrO4Kxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393962; c=relaxed/simple;
	bh=w5Zx6jQBU/+VV6E/tSya82b5DU2pzAAyZgiYNS+jHC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJ8VuPJxisjBWdfqsOI317N4uyzcql5mDqirf4ky3xAmpyOaiMoFNOKWjnkKWbp2dXpGWgQIKLbUfJfSkaQ7/aRFrHQ9LG/jqcTCH9UpmuRtLcz2PhWaINXKt/qHTDmPgrUJ2tjymcBF9GwyKeirzgCyZTOKa/iH+tJiYzbaAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NtcrWdsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEEEC4CEC7;
	Tue,  8 Oct 2024 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393961;
	bh=w5Zx6jQBU/+VV6E/tSya82b5DU2pzAAyZgiYNS+jHC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtcrWdsiT2nI+5C+uNxjuKcQUN/7mTUeTN5lMrm82ye0TSlFn9wxB5plCwqpy59bo
	 H90CPXn3jG/et2rXffavMtFrG/O0pJfPZuG7BxRejjZAOjUfAyt4Oy/Qk+fgmEDkSx
	 YQAclCUBI3o9dI/i7kFe6P7heIHEFhm/u3nydXUY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lamome Julien <julien.lamome@wanadoo.fr>,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.6 306/386] ACPI: resource: Add Asus Vivobook X1704VAP to irq1_level_low_skip_override[]
Date: Tue,  8 Oct 2024 14:09:11 +0200
Message-ID: <20241008115641.426440815@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 2f80ce0b78c340e332f04a5801dee5e4ac8cfaeb upstream.

Like other Asus Vivobook models the X1704VAP has its keybopard IRQ (1)
described as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh
which breaks the keyboard.

Add the X1704VAP to the irq1_level_low_skip_override[] quirk table to fix
this.

Reported-by: Lamome Julien <julien.lamome@wanadoo.fr>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1078696
Closes: https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20240927141606.66826-3-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/resource.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -440,6 +440,13 @@ static const struct dmi_system_id asus_l
 		},
 	},
 	{
+		/* Asus Vivobook X1704VAP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "X1704VAP"),
+		},
+	},
+	{
 		.ident = "Asus ExpertBook B1402CBA",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),



