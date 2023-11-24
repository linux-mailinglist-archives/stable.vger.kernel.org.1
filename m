Return-Path: <stable+bounces-2244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 995DF7F835D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3D21C25649
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA921381CB;
	Fri, 24 Nov 2023 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BKhKWDdV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4C2511F;
	Fri, 24 Nov 2023 19:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228FFC433C7;
	Fri, 24 Nov 2023 19:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853409;
	bh=K7oPFoW9wiZU4POS6VS3uVOusS0G9pJZDnwLGesQ6Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKhKWDdViCeIJ2OfE4H0llxH5xkOIr2EnzDh+dy5iTiv3htA48uwvQvjCa+2o7X4R
	 140SXdZtEKpiY1IxBhypF8VXdTHpM2Ffx9doUnyiYjxqdZ7yYJuzW5cGadab7McSaX
	 mYX92TU2smHaSyUjtgmNW6rWXUtBHBrSREQDakjQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Werner Sembach <wse@tuxedocomputers.com>,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.15 176/297] ACPI: resource: Do IRQ override on TongFang GMxXGxx
Date: Fri, 24 Nov 2023 17:53:38 +0000
Message-ID: <20231124172006.406926638@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Werner Sembach <wse@tuxedocomputers.com>

commit 0da9eccde3270b832c059ad618bf66e510c75d33 upstream.

The TongFang GMxXGxx/TUXEDO Stellaris/Pollaris Gen5 needs IRQ overriding
for the keyboard to work.

Adding an entry for this laptop to the override_table makes the internal
keyboard functional.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: All applicable <stable@vger.kernel.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/resource.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -468,6 +468,18 @@ static const struct dmi_system_id mainge
 		}
 	},
 	{
+		/* TongFang GMxXGxx/TUXEDO Polaris 15 Gen5 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
+		},
+	},
+	{
+		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
+		},
+	},
+	{
 		.ident = "MAINGEAR Vector Pro 2 17",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),



