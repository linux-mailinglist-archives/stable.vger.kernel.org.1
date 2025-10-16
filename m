Return-Path: <stable+bounces-186213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3FCBE5BEB
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 01:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0945C4E1B4C
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EAF2E62B9;
	Thu, 16 Oct 2025 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZ/TORWh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEEA2E6135
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655610; cv=none; b=PkAQuKoLoThRcNPXOfbbjd4AZoH9xy7+HKUdccx8WqBn2SU9mzD983rtQRprTZA6h3xcU/uGVkp50b/8nqjVLNg9t0CAAZGKDwW03J5Pi3VNwSAoVPMjtjF0zcOFNLqxMmt3kf2EXujn5MV8lnKeyg6RwvAvhKH6kBkafe7dskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655610; c=relaxed/simple;
	bh=xFeJkYrzN2TIrG0dyICres1vqkIE6Ffg/vI9qpYfHSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px/BINJlXhtdOsfcCW08yHHoZy1gGbZ4W790QXE1AEYvVzg9M1Xgrr6xIsJ6tbRSzQIRKcHqQp0BDMsKQ3bRHIxHEafBRmYZI1BzVT3fq6GBdEKdJpKOH1sBmoCt5NOPmp4g6NqHbYRpu4icbu03o9oimda6w+7Nphu6xrg0cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZ/TORWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E29C4CEF1;
	Thu, 16 Oct 2025 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655609;
	bh=xFeJkYrzN2TIrG0dyICres1vqkIE6Ffg/vI9qpYfHSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZ/TORWhL0kSVgpl4g5ouXlYALhb2AND80ySaBf0juLjHiq4TKM5IxLP2TdmCvZNB
	 9bmGHBKqRoDR7CfPHKWrtUbufpggwtNgUouFYjDwrqHxJKFSjaZpln6eEaDKTgosuD
	 dv1c7VHBi8RCIP69fhG1+YnaoC7ZBs8I7uP+xHvUDAmlvQXKa/GiAPLyk6lkPl//ir
	 zFrHR3UchWP/ui8q8QXStkKfpR+kS35ogH0z4m/yuiJyWfS9yK9QZJ0K0ObbtXJCyW
	 UYgn7wZFueR2IAF5j6/fE3rRsSJBojTjl6D5oa+EVlkw/ecn1F4FxYQEVz7t8zB4GO
	 yzLseChU/dUGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] ACPI: property: Fix buffer properties extraction for subnodes
Date: Thu, 16 Oct 2025 19:00:04 -0400
Message-ID: <20251016230007.3453571-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101649-bride-landmark-1121@gregkh>
References: <2025101649-bride-landmark-1121@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit d0759b10989c5c5aae3d455458c9fc4e8cc694f7 ]

The ACPI handle passed to acpi_extract_properties() as the first
argument represents the ACPI namespace scope in which to look for
objects returning buffers associated with buffer properties.

For _DSD objects located immediately under ACPI devices, this handle is
the same as the handle of the device object holding the _DSD, but for
data-only subnodes it is not so.

First of all, data-only subnodes are represented by objects that
cannot hold other objects in their scopes (like control methods).
Therefore a data-only subnode handle cannot be used for completing
relative pathname segments, so the current code in
in acpi_nondev_subnode_extract() passing a data-only subnode handle
to acpi_extract_properties() is invalid.

Moreover, a data-only subnode of device A may be represented by an
object located in the scope of device B (which kind of makes sense,
for instance, if A is a B's child).  In that case, the scope in
question would be the one of device B.  In other words, the scope
mentioned above is the same as the scope used for subnode object
lookup in acpi_nondev_subnode_extract().

Accordingly, rearrange that function to use the same scope for the
extraction of properties and subnode object lookup.

Fixes: 103e10c69c61 ("ACPI: property: Add support for parsing buffer property UUID")
Cc: 6.0+ <stable@vger.kernel.org> # 6.0+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Stable-dep-of: baf60d5cb8bc ("ACPI: property: Do not pass NULL handles to acpi_attach_data()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/property.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index f8a56aae97a5a..ee22307e92a6d 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -74,6 +74,7 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 					struct fwnode_handle *parent)
 {
 	struct acpi_data_node *dn;
+	acpi_handle scope = NULL;
 	bool result;
 
 	dn = kzalloc(sizeof(*dn), GFP_KERNEL);
@@ -86,27 +87,18 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 	INIT_LIST_HEAD(&dn->data.properties);
 	INIT_LIST_HEAD(&dn->data.subnodes);
 
-	result = acpi_extract_properties(handle, desc, &dn->data);
-
-	if (handle) {
-		acpi_handle scope;
-		acpi_status status;
+	/*
+	 * The scope for the completion of relative pathname segments and
+	 * subnode object lookup is the one of the namespace node (device)
+	 * containing the object that has returned the package.  That is, it's
+	 * the scope of that object's parent device.
+	 */
+	if (handle)
+		acpi_get_parent(handle, &scope);
 
-		/*
-		 * The scope for the subnode object lookup is the one of the
-		 * namespace node (device) containing the object that has
-		 * returned the package.  That is, it's the scope of that
-		 * object's parent.
-		 */
-		status = acpi_get_parent(handle, &scope);
-		if (ACPI_SUCCESS(status)
-		    && acpi_enumerate_nondev_subnodes(scope, desc, &dn->data,
-						      &dn->fwnode))
-			result = true;
-	} else if (acpi_enumerate_nondev_subnodes(NULL, desc, &dn->data,
-						  &dn->fwnode)) {
+	result = acpi_extract_properties(scope, desc, &dn->data);
+	if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn->fwnode))
 		result = true;
-	}
 
 	if (result) {
 		dn->handle = handle;
-- 
2.51.0


