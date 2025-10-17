Return-Path: <stable+bounces-187355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B67BEA2AE
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3956D18866DB
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D65E330B2F;
	Fri, 17 Oct 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NxKPKIUQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD206330B06;
	Fri, 17 Oct 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715838; cv=none; b=GcQMHnYLbIOS2vTJMQJNTHOVODhe1qrYB371lbzdBf6AN3AjIljIJm28rYE/f/SuTYPxuRJawvHDeCrTD42IiBucvAMajqQAKRhK59s6w0gRSW/EvIv5rt8Q+oWWw5vYo0J8qE0BXdiKxq1Uk/feJjVX4tOeTJHkvsG5GWqtJR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715838; c=relaxed/simple;
	bh=8S9AXY9TcTbSnt0L16Az4kGduXx/xmN417LkeNq2uaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rV5Z5ZhQf81fo1CdIFVqQuJ5N5/WmMKZbdwILoMZ3qqh0dJLSANdsCu+TKINIckh3p/UGu8S/8+iHvRJjBpYYhbw6vp3b7vkX9GSoq4dupI+pRfUOw5/DclR1xzESQty/meeKJKDm9JPXVzQuF9jShqqrGbAnJzSHzI5DKEqEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NxKPKIUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64751C4CEE7;
	Fri, 17 Oct 2025 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715837;
	bh=8S9AXY9TcTbSnt0L16Az4kGduXx/xmN417LkeNq2uaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NxKPKIUQn+6uaO/s5/b3Vc5NwSQNKmF0Otuz8iAmX68z2nQxskOsZ5cIbpoWztPr9
	 DRPLQWEdFCPHR7jMbNRmWJrEFa/x8uCduXZY9a/L5ybCsvyXG6g3JwAfmecvopJIZ3
	 wXc6I4j63z183D1/jHKmWCAuG33y9vV4Pb4brsNI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 355/371] ACPI: property: Disregard references in data-only subnode lists
Date: Fri, 17 Oct 2025 16:55:30 +0200
Message-ID: <20251017145214.930217678@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/property.c |   51 ++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -124,32 +124,12 @@ static bool acpi_nondev_subnode_extract(
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
 
@@ -161,7 +141,17 @@ static bool acpi_nondev_subnode_ok(acpi_
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
@@ -174,7 +164,6 @@ static bool acpi_add_nondev_subnodes(acp
 
 	for (i = 0; i < links->package.count; i++) {
 		union acpi_object *link, *desc;
-		acpi_handle handle;
 		bool result;
 
 		link = &links->package.elements[i];
@@ -186,22 +175,26 @@ static bool acpi_add_nondev_subnodes(acp
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



