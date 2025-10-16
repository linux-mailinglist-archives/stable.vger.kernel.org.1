Return-Path: <stable+bounces-185892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E20BE22E7
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20C9483A87
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2797F304BDF;
	Thu, 16 Oct 2025 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BpjNcJm+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751C302CC7
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604001; cv=none; b=g+5k6utQpcDwnBs68rtbJtKoS5nT7d4YO4ZypLtEL6n0k6RyZGJ3eCV3NlcHFDqAOI0uRajcTrJ0czzmkikEk/31T8XdownECTh/iTH9vPBYZNMh++4lGpc467aCAHLrkp7oDG7/ji8vwKC4c246ZtLjC/eicxd2qN7Ajuj3bgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604001; c=relaxed/simple;
	bh=+L50qu2gCiOBHsAvLLcezgWGPTt/dzQwtu6fComKETo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dXBrzUxfaQXgBbyI/lcMr2/wWz7DPOCECiZBo3LRpnYzTRlRPkKrpINVEF5PNg6kclwcr6iA+gaX54t1USEowg2JPUZD/90wouIlMSPAhOwXIXyleU9xZNsERDeJVdvicTKb0tipBX38sBxfMIcszs99V5jA9oDY6WXkB40L05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BpjNcJm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB97C4CEF1;
	Thu, 16 Oct 2025 08:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760604001;
	bh=+L50qu2gCiOBHsAvLLcezgWGPTt/dzQwtu6fComKETo=;
	h=Subject:To:Cc:From:Date:From;
	b=BpjNcJm+KLVV+C79btgx7JIt8vQ8cHK3vOCeQSkyoKo/VFskdiPg7GmqljSDc9jxL
	 0K7+NBBgq+L+ZYD+MT6+4FeZXoVvWNYfKVspNRtGSf77aCQ3jFThFI7uQFfmY3pBbD
	 H/2WxZCYXaBpzGLfjA27vZZTIhy/1rG34WY1BzZk=
Subject: FAILED: patch "[PATCH] ACPI: property: Do not pass NULL handles to" failed to apply to 6.12-stable tree
To: rafael.j.wysocki@intel.com,sakari.ailus@linux.intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 10:39:48 +0200
Message-ID: <2025101647-handiwork-catcall-487b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x baf60d5cb8bc6b85511c5df5f0ad7620bb66d23c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101647-handiwork-catcall-487b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


