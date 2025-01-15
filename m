Return-Path: <stable+bounces-109058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF281A12198
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3353B1887DF3
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB19248BDF;
	Wed, 15 Jan 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQJN+Hua"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B4248BD0;
	Wed, 15 Jan 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938717; cv=none; b=oVUlBypYpEQiSdl8sicLPe6LFwE+DJ4WRB8cm2infta7qe2/dVz7c8/VLNMIRsu9lZ/XKPFxn/fl5mU+S9gHjhxcoUrjHkbXpgCV5t5ucdalXe33g8mnir0i81TW3gcnHKKqPlBZebB8QPu87AQMgLKVeT+6+RlRR7jrohjfoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938717; c=relaxed/simple;
	bh=2XjCcrfLf2ouHCMYDRwYD55Xb8OsNdfJWbGAl7/rBw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scS5hoLW8uXFd7hb9X3apFv+/fIwbXzrMOfnTmbPkWa9ZkUashLJ2NX6NbvMKZbvBkR+Ve6cQGJcdj9VTFbfIFYGy4t634VNYgMs7S/PrJw8aqy/yu6Zf3Hgbh/4P397MNzKOrMQhibi0G/rz90q8iR+Z67x5pyND1rU6cXGWTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQJN+Hua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760FEC4CEDF;
	Wed, 15 Jan 2025 10:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938716;
	bh=2XjCcrfLf2ouHCMYDRwYD55Xb8OsNdfJWbGAl7/rBw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQJN+HuawNqSW8Or7ngdIqGiB4zxajNzGb3NdrBej+28p2uiAWjTXzi4Nx6Z1mWzE
	 BeKbtVylMMkRb8hlzHtRFAlA1LD/xl13Nv9hG3S+fladVSM2QVq4Kr70/ZGWki6O6C
	 bX4RE7DPrvzj28TmQCxeDbQLoRFFYilLligSoCkE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.6 073/129] ACPI: resource: Add Asus Vivobook X1504VAP to irq1_level_low_skip_override[]
Date: Wed, 15 Jan 2025 11:37:28 +0100
Message-ID: <20250115103557.286754821@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103554.357917208@linuxfoundation.org>
References: <20250115103554.357917208@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -440,6 +440,13 @@ static const struct dmi_system_id asus_l
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



