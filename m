Return-Path: <stable+bounces-185890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ED3BE22E3
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F02E4EDBB1
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D615303A03;
	Thu, 16 Oct 2025 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wzLXWOrU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5287F2FB0A0
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603990; cv=none; b=IHn7bmYo34XwTMQbOpUGEF6knK42OTxRcaGlqRBLr80kZwNftQXEid/rlGcjTF5ElxrDYlFUeIdUNjqBv5af03B+ecgCBfVZRFF5DH5IxoHdTeqxwH5PkbzMdCmVfNeTbWEkrZlxYioo2dOaVoSJbpP6zOBrUPD0N5TrJdsPwFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603990; c=relaxed/simple;
	bh=7FJQJT+urbyHID8xZ8QmnFeO3viCpPKXnKcVgGMg4Rk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mrn6RI3r+WiMV8BfUFs3x3d/0N7WyXxQpjDaibshoCxUTmvmb8+0dNTK3DrNQWICTQW55JXlo393+gbuftEN2UG2nC3vhAfPl1FteZbiEaatQY/5b9g+Ta3RgugWZBzdcYIG/MzAYBARaBmiixUdG+SdxCQzYUjKja7j8QK7ikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wzLXWOrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69B5C4CEFB;
	Thu, 16 Oct 2025 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760603990;
	bh=7FJQJT+urbyHID8xZ8QmnFeO3viCpPKXnKcVgGMg4Rk=;
	h=Subject:To:Cc:From:Date:From;
	b=wzLXWOrUXIvg2drWjx192nGYopItjV8ySQv+Be2ImBzaslwIm2FwHT953aq5khJ8B
	 Uu83z5hPWDU88DSfexrvwMmJoiTOMBMDVKd3/djY8Qcugmq6jXE3x8YYsC+1+hpAWd
	 Qmh6NakXfl8PIL3Do/wVoF9YgEdIMZTWpXwgZwm0=
Subject: FAILED: patch "[PATCH] ACPI: property: Do not pass NULL handles to" failed to apply to 6.17-stable tree
To: rafael.j.wysocki@intel.com,sakari.ailus@linux.intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 10:39:47 +0200
Message-ID: <2025101647-crushable-wiring-b094@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x baf60d5cb8bc6b85511c5df5f0ad7620bb66d23c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101647-crushable-wiring-b094@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From baf60d5cb8bc6b85511c5df5f0ad7620bb66d23c Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Mon, 15 Sep 2025 20:28:52 +0200
Subject: [PATCH] ACPI: property: Do not pass NULL handles to
 acpi_attach_data()

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

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index f4776a4085e0..c086786fe84c 100644
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


