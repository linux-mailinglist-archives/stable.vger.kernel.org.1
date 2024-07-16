Return-Path: <stable+bounces-59970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C407932CBF
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE61C22081
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC1519E7CF;
	Tue, 16 Jul 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uBGjOmQ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD65D1DDCE;
	Tue, 16 Jul 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145464; cv=none; b=sdEW/2vSEPzxVf2g08KUMDM3qvDjJvI3uOI1kgZFH+mtyUWshIqH8rLNzWi4TU6EvwWc5FhBj3usBggoWT3KflOhG+O2K+Yy0Wfr9fHVE+ttADy4gLXdC0aoS43nWlLaSf9krbNnoxfphURtQAkKUCVnwmb5wd1ieRL6wKhteSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145464; c=relaxed/simple;
	bh=y86DfBuR18B5TKIZ4qwhBuu2VAD2qmsbD6FMNwahIcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnAhYM473S1LhzM79ogggfRregWo2fS5PcPD/46w2hR1x7usZiwQOmOIk6gaX3hY4J6Qa9Ydy1HB5wilDtnG6O+1C4Yu98arPBjiElAz62E8QmQkNIRPDzzOkzrV0IPz/lUjnul+71n2UE6EAo/6tKgJv3ZDwQOhCm5KGDMzMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uBGjOmQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D0DC116B1;
	Tue, 16 Jul 2024 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145463;
	bh=y86DfBuR18B5TKIZ4qwhBuu2VAD2qmsbD6FMNwahIcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBGjOmQ0giCwB2f9UkwYs/ZF8hqJ7iq6DFi/Tns1ZgHFzRKumKI7YTkqiDh5wEQNW
	 UX2ZU/veRZGYoXgPXgtwXtZlMDmtDsHcLjZPCqyYBLkgs3oxhJIrjpKecsRX1PW7+C
	 OYT8+sWOC8p8IWmY9Hv5iOi9LBbgb4RZ0yGk9Pk0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.1 66/96] platform/x86: toshiba_acpi: Fix array out-of-bounds access
Date: Tue, 16 Jul 2024 17:32:17 +0200
Message-ID: <20240716152749.048010671@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152746.516194097@linuxfoundation.org>
References: <20240716152746.516194097@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

commit b6e02c6b0377d4339986e07aeb696c632cd392aa upstream.

In order to use toshiba_dmi_quirks[] together with the standard DMI
matching functions, it must be terminated by a empty entry.

Since this entry is missing, an array out-of-bounds access occurs
every time the quirk list is processed.

Fix this by adding the terminating empty entry.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407091536.8b116b3d-lkp@intel.com
Fixes: 3cb1f40dfdc3 ("drivers/platform: toshiba_acpi: Call HCI_PANEL_POWER_ON on resume on some models")
Cc: stable@vger.kernel.org
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20240709143851.10097-1-W_Armin@gmx.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/toshiba_acpi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3305,6 +3305,7 @@ static const struct dmi_system_id toshib
 		},
 	 .driver_data = (void *)(QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_HOTKEY_QUICKSTART),
 	},
+	{ }
 };
 
 static int toshiba_acpi_add(struct acpi_device *acpi_dev)



