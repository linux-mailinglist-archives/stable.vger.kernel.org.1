Return-Path: <stable+bounces-186177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFCFBE4757
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 18:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5820F562A34
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E0532D0DB;
	Thu, 16 Oct 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZATbYRE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8A32D0C9
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630690; cv=none; b=L+fXk12tHV96o7bqacbwJgywp5LandUu1/fIXPQlzHQO7qkIqLVDH0FhXTZcRvUslhpPiDa38h2UuNfGZMpzAZOws/U07NlEvQ5IK1ehTiLFPWEWQm15wk9kQOoIgKV4CORttUosOdMhtak4fvosB0Dz4xnXZTBM4zElvFQWJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630690; c=relaxed/simple;
	bh=7L/RXPQEXXnold31PDF00eHXHb+jI4MmX8l2ogTjETY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdLRb1YVcjRedWy1NrO4N0+26yuyudkIfCxniey64iPw7VWbqvvTCiTRiBZ2YRh773SYrZ2NWQ5ZaQyBMUUCXkVahhg+ioR8oCh+cCrP8bm8EHkVVqBY/BZiRWzjFhqERilUTv5A+JekiAyzed6hqKYbtmX5+QFhxgQa9o7jnrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZATbYRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1731FC4CEF1;
	Thu, 16 Oct 2025 16:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630689;
	bh=7L/RXPQEXXnold31PDF00eHXHb+jI4MmX8l2ogTjETY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZATbYREhx03+ukpd85VP3p7o5oYzTljjfqCVcJi/kcs/JLmlLbfIoV8oIRytOTKe
	 zEejEbjmWA7B3dWPM9Ud8WN9ft+BQYvOOMRf0E6fb2ajq/LnRX2kK3sJ82/BP578Qb
	 1rM23c1P9Ls0ouP4YQEoqO0laPs04x0qJegFiSVGhhHC7isPWsKdvl9sy8/KpzSrW5
	 NGLExsKhdXPWLqKJUHjZ3+lAqzyMJNx0qXoN9YEKXsOcq8NDOPufWNw1IraBzWpn/5
	 0rn5Fjda3yKzTtpmSPsjNQM6LLTXmuX31v2K8zsWVvNMdTm03UFUbRw7zYVU6EJSew
	 lTFUxkm2bOBpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 4/4] ACPI: property: Do not pass NULL handles to acpi_attach_data()
Date: Thu, 16 Oct 2025 12:04:43 -0400
Message-ID: <20251016160443.3328083-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016160443.3328083-1-sashal@kernel.org>
References: <2025101647-crushable-wiring-b094@gregkh>
 <20251016160443.3328083-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit baf60d5cb8bc6b85511c5df5f0ad7620bb66d23c ]

In certain circumstances, the ACPI handle of a data-only node may be
NULL, in which case it does not make sense to attempt to attach that
node to an ACPI namespace object, so update the code to avoid attempts
to do so.

This prevents confusing and unuseful error messages from being printed.

Also document the fact that the ACPI handle of a data-only node may be
NULL and when that happens in a code comment.  In addition, make
acpi_add_nondev_subnodes() print a diagnostic message for each data-only
node with an unknown ACPI namespace scope.

Fixes: 1d52f10917a7 ("ACPI: property: Tie data nodes to acpi handles")
Cc: 6.0+ <stable@vger.kernel.org> # 6.0+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/property.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index f4776a4085e06..c086786fe84cb 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -124,6 +124,10 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 		result = true;
 
 	if (result) {
+		/*
+		 * This will be NULL if the desc package is embedded in an outer
+		 * _DSD-equivalent package and its scope cannot be determined.
+		 */
 		dn->handle = handle;
 		dn->data.pointer = desc;
 		list_add_tail(&dn->sibling, list);
@@ -224,6 +228,8 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 			 * strings because there is no way to build full
 			 * pathnames out of them.
 			 */
+			acpi_handle_debug(scope, "subnode %s: Unknown scope\n",
+					  link->package.elements[0].string.pointer);
 			desc = &link->package.elements[1];
 			result = acpi_nondev_subnode_extract(desc, NULL, link,
 							     list, parent);
@@ -396,6 +402,9 @@ static void acpi_untie_nondev_subnodes(struct acpi_device_data *data)
 	struct acpi_data_node *dn;
 
 	list_for_each_entry(dn, &data->subnodes, sibling) {
+		if (!dn->handle)
+			continue;
+
 		acpi_detach_data(dn->handle, acpi_nondev_subnode_tag);
 
 		acpi_untie_nondev_subnodes(&dn->data);
@@ -410,6 +419,9 @@ static bool acpi_tie_nondev_subnodes(struct acpi_device_data *data)
 		acpi_status status;
 		bool ret;
 
+		if (!dn->handle)
+			continue;
+
 		status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
 		if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
 			acpi_handle_err(dn->handle, "Can't tag data node\n");
-- 
2.51.0


