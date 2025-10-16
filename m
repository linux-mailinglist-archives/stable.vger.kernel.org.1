Return-Path: <stable+bounces-186175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18515BE471B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 18:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3061A64F1F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A164232D0D1;
	Thu, 16 Oct 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG5Yih1x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14B32D0C9
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630688; cv=none; b=mpRMKm+U7PqXuvslXmM0eCdzyADWqFfvg2ZLNqwLQ98dhbipBcXad1VJDYSwZCW3JjGibVyTty2O4orbeRwSReEWqjVJOs67eEjNgy1RciIPVKZnw6JRN0cBBN5vMWxGh1jO/Q43JNV+dCB5q3nNSelV3Dpy/aE2cMQOHHVODvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630688; c=relaxed/simple;
	bh=ladAiyNb7gxEyiGGBqRcYQYcTzd8MmcCZPk0FKTiGRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl+jrHvEzCIZ9ScRFzQg07zFDNwRcgWHHqKuIdXSIZ3Ov0LXqjCd1GE3nqLXbP/MfAvKYZF8a4uXe5toNbR7H4TYTj02amQLouY63/55jS841LizA77iq0kRz0zehF7h222lvCKhXz24V6ov9KhRIgPzTB1ApGinaRVYeEYZMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG5Yih1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5E1C4CEFB;
	Thu, 16 Oct 2025 16:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630687;
	bh=ladAiyNb7gxEyiGGBqRcYQYcTzd8MmcCZPk0FKTiGRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eG5Yih1xjoOLkcex1mmqW//Ngz6+XCeMcw/6g05ghvndYhYffgL/AE9UAL6NCbJ2G
	 YjyPD9XVAqa+jr4/3BO9W1P44PRBBBlDx6ruzrDfAOiyp7XmAWhHZ3Y9JXP9a8NN69
	 H/OYZ5W2Txs7LR06w5F0LRLphtQbXymxT0SfW494EnVd4YmMK0snOC7PPPn29oZuZw
	 sOLtTz/ZT2l0ndlZCIbL5KDM1bSPVPUb9/j2+HsDMuP1uKMlrZfHvO4hNLTMHkqk+p
	 yuwRAHEucGoER/mgpoEWxzsghz9Aq+FkA9ZuemHWj53kmjp64V1kRJhrcRPqipFDD6
	 I2inJYhtSZfvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/4] ACPI: property: Disregard references in data-only subnode lists
Date: Thu, 16 Oct 2025 12:04:41 -0400
Message-ID: <20251016160443.3328083-2-sashal@kernel.org>
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

[ Upstream commit d06118fe9b03426484980ed4c189a8c7b99fa631 ]

Data-only subnode links following the ACPI data subnode GUID in a _DSD
package are expected to point to named objects returning _DSD-equivalent
packages.  If a reference to such an object is used in the target field
of any of those links, that object will be evaluated in place (as a
named object) and its return data will be embedded in the outer _DSD
package.

For this reason, it is not expected to see a subnode link with the
target field containing a local reference (that would mean pointing
to a device or another object that cannot be evaluated in place and
therefore cannot return a _DSD-equivalent package).

Accordingly, simplify the code parsing data-only subnode links to
simply print a message when it encounters a local reference in the
target field of one of those links.

Moreover, since acpi_nondev_subnode_data_ok() would only have one
caller after the change above, fold it into that caller.

Link: https://lore.kernel.org/linux-acpi/CAJZ5v0jVeSrDO6hrZhKgRZrH=FpGD4vNUjFD8hV9WwN9TLHjzQ@mail.gmail.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Stable-dep-of: baf60d5cb8bc ("ACPI: property: Do not pass NULL handles to acpi_attach_data()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/property.c | 51 ++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 83b03dce576c5..5b7c10a2824d6 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -124,32 +124,12 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 	return false;
 }
 
-static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
-					const union acpi_object *link,
-					struct list_head *list,
-					struct fwnode_handle *parent)
-{
-	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
-	acpi_status status;
-
-	status = acpi_evaluate_object_typed(handle, NULL, NULL, &buf,
-					    ACPI_TYPE_PACKAGE);
-	if (ACPI_FAILURE(status))
-		return false;
-
-	if (acpi_nondev_subnode_extract(buf.pointer, handle, link, list,
-					parent))
-		return true;
-
-	ACPI_FREE(buf.pointer);
-	return false;
-}
-
 static bool acpi_nondev_subnode_ok(acpi_handle scope,
 				   const union acpi_object *link,
 				   struct list_head *list,
 				   struct fwnode_handle *parent)
 {
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
 	acpi_handle handle;
 	acpi_status status;
 
@@ -161,7 +141,17 @@ static bool acpi_nondev_subnode_ok(acpi_handle scope,
 	if (ACPI_FAILURE(status))
 		return false;
 
-	return acpi_nondev_subnode_data_ok(handle, link, list, parent);
+	status = acpi_evaluate_object_typed(handle, NULL, NULL, &buf,
+					    ACPI_TYPE_PACKAGE);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	if (acpi_nondev_subnode_extract(buf.pointer, handle, link, list,
+					parent))
+		return true;
+
+	ACPI_FREE(buf.pointer);
+	return false;
 }
 
 static bool acpi_add_nondev_subnodes(acpi_handle scope,
@@ -174,7 +164,6 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 
 	for (i = 0; i < links->package.count; i++) {
 		union acpi_object *link, *desc;
-		acpi_handle handle;
 		bool result;
 
 		link = &links->package.elements[i];
@@ -186,22 +175,26 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 		if (link->package.elements[0].type != ACPI_TYPE_STRING)
 			continue;
 
-		/* The second one may be a string, a reference or a package. */
+		/* The second one may be a string or a package. */
 		switch (link->package.elements[1].type) {
 		case ACPI_TYPE_STRING:
 			result = acpi_nondev_subnode_ok(scope, link, list,
 							 parent);
 			break;
-		case ACPI_TYPE_LOCAL_REFERENCE:
-			handle = link->package.elements[1].reference.handle;
-			result = acpi_nondev_subnode_data_ok(handle, link, list,
-							     parent);
-			break;
 		case ACPI_TYPE_PACKAGE:
 			desc = &link->package.elements[1];
 			result = acpi_nondev_subnode_extract(desc, NULL, link,
 							     list, parent);
 			break;
+		case ACPI_TYPE_LOCAL_REFERENCE:
+			/*
+			 * It is not expected to see any local references in
+			 * the links package because referencing a named object
+			 * should cause it to be evaluated in place.
+			 */
+			acpi_handle_info(scope, "subnode %s: Unexpected reference\n",
+					 link->package.elements[0].string.pointer);
+			fallthrough;
 		default:
 			result = false;
 			break;
-- 
2.51.0


