Return-Path: <stable+bounces-186393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6020DBE968C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D6F0568199
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F435695;
	Fri, 17 Oct 2025 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nbbk3eLZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF63370E3;
	Fri, 17 Oct 2025 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713114; cv=none; b=OEeFTBPgSwFRSpNWEfumAsgocZQrfow2IIUEfQ4vi4OoA4Kk8fkqGqEVAq8C5gIi3wna7X/kVdMVJd5P0gOHUrXJ+nMxn0Yf+Et35U5lkvLbJdOotXKpjCoCHsFF0wppIskha53s6nbQYlUgp33VQY74uGWPgbdmlVr44OsUFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713114; c=relaxed/simple;
	bh=oa1Q0LBkeBN6aMcCnAt5YH6C1U+jKpeaKa9gEsBBYMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhQ0b1Zbw1xJrdVvDGv/p4A2J1BgcP4fOFXkfo6dDvg54S3vvL17QzSW4mdpMQqb05B8on7f17eE6HkddCG3HBZBhiWMShIm+zlx6LruqGrphJAhl6kOgzgQIZf1kI3ivqze8Jf4KqtELNu34mpLfywItpO/GFAsgiPDAkjxSI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nbbk3eLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B721CC4CEE7;
	Fri, 17 Oct 2025 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713114;
	bh=oa1Q0LBkeBN6aMcCnAt5YH6C1U+jKpeaKa9gEsBBYMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbbk3eLZXsUIIskQIEIaOCaXKuLjsYOgsFEAPudYoApBluVvygqkF3pkoOMx1tey2
	 b8hg6vr4aX0pFm6AH5H1KDg1VE/QnnIG4y87wTH0ucUx3ChFbBJ6Qxy9n8YaEJm3l7
	 J3bpcQgDcYdLlM0SpvoNvYJF7fajQPvb6jirqVaQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 6.1 051/168] ACPI: property: Fix buffer properties extraction for subnodes
Date: Fri, 17 Oct 2025 16:52:10 +0200
Message-ID: <20251017145130.898878942@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
References: <20251017145129.000176255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit d0759b10989c5c5aae3d455458c9fc4e8cc694f7 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/property.c |   30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -74,6 +74,7 @@ static bool acpi_nondev_subnode_extract(
 					struct fwnode_handle *parent)
 {
 	struct acpi_data_node *dn;
+	acpi_handle scope = NULL;
 	bool result;
 
 	dn = kzalloc(sizeof(*dn), GFP_KERNEL);
@@ -86,27 +87,18 @@ static bool acpi_nondev_subnode_extract(
 	INIT_LIST_HEAD(&dn->data.properties);
 	INIT_LIST_HEAD(&dn->data.subnodes);
 
-	result = acpi_extract_properties(handle, desc, &dn->data);
+	/*
+	 * The scope for the completion of relative pathname segments and
+	 * subnode object lookup is the one of the namespace node (device)
+	 * containing the object that has returned the package.  That is, it's
+	 * the scope of that object's parent device.
+	 */
+	if (handle)
+		acpi_get_parent(handle, &scope);
 
-	if (handle) {
-		acpi_handle scope;
-		acpi_status status;
-
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



