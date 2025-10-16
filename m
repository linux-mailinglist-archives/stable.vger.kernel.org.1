Return-Path: <stable+bounces-186201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03963BE53C1
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E65B44E1E4A
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 19:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080192D9EFA;
	Thu, 16 Oct 2025 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5YGUD1S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9122424E
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642917; cv=none; b=K1i06cWGKEW4yorPwZYURGgkhNRtN341t2M75FouogrrGIUxyF1mrvFCf2fWgyHPsw8q3vOtFDfaVLRkeg24IEEsyRo/ploe7gCa9to4vWhZp+l0kWAzrjk7Gz2FojmoN7woacbu0u/snCdpsG5uIgvTmkJBnpqpb3q6mOHmsx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642917; c=relaxed/simple;
	bh=TfUmFm94EBi0iJwCBC0Haw8N5IkWUCG3RixtYqjBdbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0LryGrz4nEIT2i3OWG4zuOrTRTSbQHOtuVybygr004Xz/IAvtAAj+EphAH6gVcc+AqlEWC0P3k3bag+XvDCRh4HynNHEl+BbIIfqTRC9VFYt4SjiFgpmDACfT6yod4PNnCqP6YBKOpYKMr7i4+3Hj65TCIH+XOmdtC7pzWgSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5YGUD1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F13C4AF09;
	Thu, 16 Oct 2025 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760642917;
	bh=TfUmFm94EBi0iJwCBC0Haw8N5IkWUCG3RixtYqjBdbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5YGUD1SdM4/ULl6WptLI5MqWqjcdXgrTEGLQklqkoRVnaOOA7dhMfiDp12ivuuJa
	 SZxjIPpnxampfTv9gmtgXulaoHnPu1uciazWi5i6Rb5mXvftefZpDikPWTQ8xiqqxw
	 EwZZU6Ut95jhvv8GxToQO2JMouUxFa+TRUL4+Cl7Hk2wkIkIuPChjIp3F0yx9AKm7k
	 DLKpiiMBUcyXHg/v+oljSwhp3TMrPk4eVw0+xM8qPbmCQOa9av0Fupr8ZLhbeuX1Pp
	 c7NLIXW1tcxipwxg9JgZ67PXR5WwW+BfMTy9cS0pNcPq1Uzjgr7VU6pHg8Cy5Ucrid
	 vYiklqw67aiVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] ACPI: property: Do not pass NULL handles to acpi_attach_data()
Date: Thu, 16 Oct 2025 15:28:32 -0400
Message-ID: <20251016192832.3384290-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016192832.3384290-1-sashal@kernel.org>
References: <2025101648-surely-manhunt-fac9@gregkh>
 <20251016192832.3384290-1-sashal@kernel.org>
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
index 2d4643a5335dc..5898c3c8c2a7f 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -112,6 +112,10 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 		result = true;
 
 	if (result) {
+		/*
+		 * This will be NULL if the desc package is embedded in an outer
+		 * _DSD-equivalent package and its scope cannot be determined.
+		 */
 		dn->handle = handle;
 		dn->data.pointer = desc;
 		list_add_tail(&dn->sibling, list);
@@ -212,6 +216,8 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
 			 * strings because there is no way to build full
 			 * pathnames out of them.
 			 */
+			acpi_handle_debug(scope, "subnode %s: Unknown scope\n",
+					  link->package.elements[0].string.pointer);
 			desc = &link->package.elements[1];
 			result = acpi_nondev_subnode_extract(desc, NULL, link,
 							     list, parent);
@@ -384,6 +390,9 @@ static void acpi_untie_nondev_subnodes(struct acpi_device_data *data)
 	struct acpi_data_node *dn;
 
 	list_for_each_entry(dn, &data->subnodes, sibling) {
+		if (!dn->handle)
+			continue;
+
 		acpi_detach_data(dn->handle, acpi_nondev_subnode_tag);
 
 		acpi_untie_nondev_subnodes(&dn->data);
@@ -398,6 +407,9 @@ static bool acpi_tie_nondev_subnodes(struct acpi_device_data *data)
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


