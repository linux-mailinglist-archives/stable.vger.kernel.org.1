Return-Path: <stable+bounces-186198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A607BBE53B8
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C41541623
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E82566E2;
	Thu, 16 Oct 2025 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS3kbz+C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1F22424E
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642915; cv=none; b=GSmhMyELzxMdGxs3pF7XS1YNnRDg2giZq1Q1qwYsjurzEehPYr24fg+bwHzzG2tgS4VoOV7dbv8L6wYVr8d5SZ86fLVnZk/NkEVwUu6tcd5WDT25uad8WM9bNi665iedBDeXGG5lNTD/96jT7heEJgYZlP39ZikDNwIsDqQ7v7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642915; c=relaxed/simple;
	bh=PE3fwrHmume9oXZVoXwhXTn+LF+mIG6PT2Qcks0haKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/PI7VFE+bmzW2Vsf6UK+QSK5e1VzvmWeh6kNwerXO1CcMbsNxkDWgybMtDoBHfLTuKyZsKxHWmMudvy04J5LD5pwY/83RlhulpuTWXj7ymxlx+5XvZ7W+XZpKOqYqHoGyJsYR7EBInFEccQxPMzDLRh2UqeRvqCCbve6Mkj/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jS3kbz+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D1BC4CEF1;
	Thu, 16 Oct 2025 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760642914;
	bh=PE3fwrHmume9oXZVoXwhXTn+LF+mIG6PT2Qcks0haKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jS3kbz+C3UknT4IAJNkWbwwkd5fww9BTuAMrAbm27rFz7gOXZ+urfO+SZSRTvtS8a
	 qZX4bgRiFRSpRgWWmEgo6Ct09ERjFHwiQ1LLw+I8HEbwQQ6yTM+9PpYf0b6vBZWRsQ
	 r+IrvSCtk+VtM1cjfnzcD9QA4lRaf3coZZ4JmgVPDPlIu6jVVA0TFwTr9wmb6vsda0
	 +m82sfwbYFGOOeya3+VOxRDWBlpPIqJR1bFqeQy8AAauyOrmyBqebiZXsLhDCPcWUC
	 VZL2LRLCDTBt6prpQI4x5fO98sj/lnO9l/0e3RC2aN7mAnJGia5b4PCjsYYXz4noFN
	 iYRRyUvAmDClA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] ACPI: property: Fix buffer properties extraction for subnodes
Date: Thu, 16 Oct 2025 15:28:29 -0400
Message-ID: <20251016192832.3384290-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101648-surely-manhunt-fac9@gregkh>
References: <2025101648-surely-manhunt-fac9@gregkh>
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
index dca5682308cb3..3058ed410810b 100644
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


