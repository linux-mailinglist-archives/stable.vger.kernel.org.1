Return-Path: <stable+bounces-91375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A9B9BEDB0
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6ED1F255E5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CB71F12FB;
	Wed,  6 Nov 2024 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ApsHF9Gz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456991E0B84;
	Wed,  6 Nov 2024 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898548; cv=none; b=onTcK28Ye4tTWhrgIzkAkbizPDQTXt0VikSe+V/5XE93mcpttBJEhW1OCO/TeQEk4l8N2dM4dNeDVDd17WFh0rq5RG6QgH6zvQsFhZl8l4FMJpiKmIV6n3t2qkmb1Xp6609nkNt7+0K2DfoAd21PQxeCDFrv/jJp9BLne0AxthU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898548; c=relaxed/simple;
	bh=899Atn33pVJHEskxn4LZcwDt3Kj4B/GH15s5dX9sKGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcAqhHkRVcRuA0fwUPlvj31QiU+4l5CAr5blWfeyRkXbMGMpumZrA9nho3NPm/WL4MMe2xQO5VlZRjx9eyLWtrcIsIynIT/EC2LsjMLgZVnCz1OEzzMKBONx27goCryLysvhwyOQcbtoCXe6ElZAdQtHjZGOML0gkX1EJJVNZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ApsHF9Gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6132C4CED3;
	Wed,  6 Nov 2024 13:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898548;
	bh=899Atn33pVJHEskxn4LZcwDt3Kj4B/GH15s5dX9sKGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApsHF9Gz8QsHBsnDY40my5ryqzDpfVJ6L7f2e90RHMloBxHFHnZMT9wjFV1xxqXLO
	 0fNxv0uo/3quR3VSDank3pcz0ZFswjHZLmQcUHnR4b/1YzLUVZwRLEnEWKlGMZrbfk
	 R+j5y7Fhyry3HyFcckDrDUmKLavQ+xaawuk6tL54=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 276/462] ACPI: resource: Add Asus ExpertBook B2502CVA to irq1_level_low_skip_override[]
Date: Wed,  6 Nov 2024 13:02:49 +0100
Message-ID: <20241106120338.342944098@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 056301e7c7c886f96d799edd36f3406cc30e1822 upstream.

Like other Asus ExpertBook models the B2502CVA has its keybopard IRQ (1)
described as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh
which breaks the keyboard.

Add the B2502CVA to the irq1_level_low_skip_override[] quirk table to fix
this.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217760
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/20240927141606.66826-4-hdegoede@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/resource.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -495,6 +495,13 @@ static const struct dmi_system_id asus_l
 		},
 	},
 	{
+		/* Asus ExpertBook B2502CVA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B2502CVA"),
+		},
+	},
+	{
 		/* TongFang GMxHGxx/TUXEDO Stellaris Slim Gen1 AMD */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),



