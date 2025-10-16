Return-Path: <stable+bounces-186176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9929BE4769
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 18:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D2B546DBA
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 16:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF032D0D6;
	Thu, 16 Oct 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6wKvenz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB532D0C9
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630689; cv=none; b=Go+fG24mJMGAwCFv34oSsh4pZ0fxo3Xx3dtDyt0tTcwDcouEVYl26/tW3Zwdnraab50Czn3ka/OMI5eaDxkiYjDaOwux0nTchdkcEVS4cXkbbut/LJJwMq3LXLW2VbTwfT3nPBmutC3IbcLJE3o+0wSNPCYP3vuOsWN7t3QWorQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630689; c=relaxed/simple;
	bh=Gx3xoYqn/lsqmWdZkW85Y3Bzm5o2idJADTl3h5mN4vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVafVA5xVSRFC4CNy7gWWHfgdH5TUifAlAxavk4wIPB76Kluv1YCTBU3IBQSY6/JY/2QDOYWusXfmtA3HnBzrtJ8ygsZBW+igiaw9zBq0LOeH/p6puJERMKvhyAk5gP+PkuM08ethvQsxeqvtse9uJJEktvlevDo7WTKAOMQmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6wKvenz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A561C4CEFE;
	Thu, 16 Oct 2025 16:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630688;
	bh=Gx3xoYqn/lsqmWdZkW85Y3Bzm5o2idJADTl3h5mN4vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6wKvenzL9qefwCMe7ekss1O7Yfn1+QQuH/0K/tsuqP4vcX/TMeOfDpWhVqGKynlW
	 8uTn3vzvdK8A+zr5HbS4D1DQ54UIGs6B3/HFM6zVCMRh1QJevOzp939HSZ1mSUwusU
	 vIgLrJlGYxEjCrBZPlN7WzuNbIdXEz7AFgFC1QtUXzE+xHqZODFzx7Atj0TjvmtXmv
	 xAavRUI2cbDWs8JNGKfTaSWaE2Ii4xxoTa4qZmW+AiPBEorapMr0p3UUfST99rZiir
	 rBP7nkv3GPO8+2BHmvpuzi+7icZVFDP6c4Frcb0lfwN8i3XxTg8VLZlSTPV2UrVm99
	 t1KdVbfUCcO7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 3/4] ACPI: property: Add code comments explaining what is going on
Date: Thu, 16 Oct 2025 12:04:42 -0400
Message-ID: <20251016160443.3328083-3-sashal@kernel.org>
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

[ Upstream commit 737c3a09dcf69ba2814f3674947ccaec1861c985 ]

In some places in the ACPI device properties handling code, it is
unclear why the code is what it is.  Some assumptions are not documented
and some pieces of code are based on knowledge that is not mentioned
anywhere.

Add code comments explaining these things.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Stable-dep-of: baf60d5cb8bc ("ACPI: property: Do not pass NULL handles to acpi_attach_data()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/property.c | 46 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 5b7c10a2824d6..f4776a4085e06 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -108,7 +108,18 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 	if (handle)
 		acpi_get_parent(handle, &scope);
 
+	/*
+	 * Extract properties from the _DSD-equivalent package pointed to by
+	 * desc and use scope (if not NULL) for the completion of relative
+	 * pathname segments.
+	 *
+	 * The extracted properties will be held in the new data node dn.
+	 */
 	result = acpi_extract_properties(scope, desc, &dn->data);
+	/*
+	 * Look for subnodes in the _DSD-equivalent package pointed to by desc
+	 * and create child nodes of dn if there are any.
+	 */
 	if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn->fwnode))
 		result = true;
 
@@ -133,6 +144,12 @@ static bool acpi_nondev_subnode_ok(acpi_handle scope,
 	acpi_handle handle;
 	acpi_status status;
 
+	/*
+	 * If the scope is unknown, the _DSD-equivalent package being parsed
+	 * was embedded in an outer _DSD-equivalent package as a result of
+	 * direct evaluation of an object pointed to by a reference.  In that
+	 * case, using a pathname as the target object pointer is invalid.
+	 */
 	if (!scope)
 		return false;
 
@@ -162,6 +179,10 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 	bool ret = false;
 	int i;
 
+	/*
+	 * Every element in the links package is expected to represent a link
+	 * to a non-device node in a tree containing device-specific data.
+	 */
 	for (i = 0; i < links->package.count; i++) {
 		union acpi_object *link, *desc;
 		bool result;
@@ -171,17 +192,38 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 		if (link->package.count != 2)
 			continue;
 
-		/* The first one must be a string. */
+		/* The first one (the key) must be a string. */
 		if (link->package.elements[0].type != ACPI_TYPE_STRING)
 			continue;
 
-		/* The second one may be a string or a package. */
+		/* The second one (the target) may be a string or a package. */
 		switch (link->package.elements[1].type) {
 		case ACPI_TYPE_STRING:
+			/*
+			 * The string is expected to be a full pathname or a
+			 * pathname segment relative to the given scope.  That
+			 * pathname is expected to point to an object returning
+			 * a package that contains _DSD-equivalent information.
+			 */
 			result = acpi_nondev_subnode_ok(scope, link, list,
 							 parent);
 			break;
 		case ACPI_TYPE_PACKAGE:
+			/*
+			 * This happens when a reference is used in AML to
+			 * point to the target.  Since the target is expected
+			 * to be a named object, a reference to it will cause it
+			 * to be avaluated in place and its return package will
+			 * be embedded in the links package at the location of
+			 * the reference.
+			 *
+			 * The target package is expected to contain _DSD-
+			 * equivalent information, but the scope in which it
+			 * is located in the original AML is unknown.  Thus
+			 * it cannot contain pathname segments represented as
+			 * strings because there is no way to build full
+			 * pathnames out of them.
+			 */
 			desc = &link->package.elements[1];
 			result = acpi_nondev_subnode_extract(desc, NULL, link,
 							     list, parent);
-- 
2.51.0


