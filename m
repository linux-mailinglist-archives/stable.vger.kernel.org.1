Return-Path: <stable+bounces-186192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4A2BE532A
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F402587A3B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 19:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B5A28A3F2;
	Thu, 16 Oct 2025 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjmNEYn3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E423C4F4
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641950; cv=none; b=QCcvW/gYXOgWv33C0naX+ZslzrKC/Dh+Hjq5HRyUIfqnMWMzEyO1kAy0/qbgwLbDghZjake3ghoEHXak4qvjWNz6g4DFvv4FTr6rYgFJtLOQxjzceb53LXmNDsHQUmWIU4BpcAmcaozRXizh6KH9/22mcjPxc4CZw66Np0sylMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641950; c=relaxed/simple;
	bh=l5uxZiX02S67irQ8OW3xpuWpEMlsh4ZHdqna22/xoJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuTNy4WgUdIL34Cp9nz0yCYgEWYlIt/yMpUoacTMQB3/wIAw+u9M8KugB//z8CqT4hlQZrPMeLuRkGUHtTMU4tWZ5/oDTJGNXvtlwvPl1jdjDZMeUz2AuMl4jDrycDvTiWCapArNwAvVBZAh33oz+1F6hwmE/f+4i+WJOOLXQnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjmNEYn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE00FC4CEF1;
	Thu, 16 Oct 2025 19:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760641950;
	bh=l5uxZiX02S67irQ8OW3xpuWpEMlsh4ZHdqna22/xoJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjmNEYn3VBxnIT1ntd4IvTlSJABCHX5a4yA2zVuwsse7kwS+ucQVKf1FOuRNCpcO9
	 aIPl7vPvxLt4Vgc4/D5I12t8WUfA6Zr/o5gsA3+2J7aG5a+Xp9mr4vp0Uzfx1RBthj
	 9Htyf69UAHNtUx3IDbCNlO2f5s07Cmp1l2GVfi2D0Neg5yyN85acfET6jSt7MnMeYF
	 zrwxc0AfHiVcuXhBgrc4GjOD15p2ekArJBdhJo78u3V0SE3eA0vyyWbLkZolKFzPQH
	 UjW0GORKWWB+96FppRc0d3SSLLYh7E51CflfYYmyIF2GbjBOaJkdd2hvsRtKTlI8vA
	 grBhcatBethtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] ACPI: property: Disregard references in data-only subnode lists
Date: Thu, 16 Oct 2025 15:12:25 -0400
Message-ID: <20251016191227.3377985-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016191227.3377985-1-sashal@kernel.org>
References: <2025101647-handiwork-catcall-487b@gregkh>
 <20251016191227.3377985-1-sashal@kernel.org>
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
index 3d1cdbdcc140b..599d73d34a06b 100644
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


