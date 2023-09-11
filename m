Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74079B9D7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355226AbjIKV5a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbjIKOcW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:32:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBFCF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:32:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EBFC433C9;
        Mon, 11 Sep 2023 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442738;
        bh=37dmBk4kAbcH0Y8cCGjrgwUAPWfG+l8wfN96T4UOTeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aO6zQOt/pKEyYM+vYI2nORZlYUYID1BaCSpRncaX1/6rb+F7MooeNi5fNK+BPM49b
         tml3o6Oi8DDRSmySNbfypqFH0QZUhtsJ9Ak4V50/DWPxvxNA+WHv3IoBYQoI33qMt6
         Sq3LfADspkD5LP/zV+Xybs7HQwyXJxiannGZ+JYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 131/737] ACPI: x86: s2idle: Post-increment variables when getting constraints
Date:   Mon, 11 Sep 2023 15:39:50 +0200
Message-ID: <20230911134654.162008842@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 3c6b1212d20bbbffcad5709ab0f2d5ed9b5859a8 ]

When code uses a pre-increment it makes the reader question "why".
In the constraint fetching code there is no reason for the variables
to be pre-incremented so adjust to post-increment.
No intended functional changes.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 9cc8cd086f05 ("ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/s2idle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index e499c60c45791..3a9195df1aab3 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -122,13 +122,13 @@ static void lpi_device_get_constraints_amd(void)
 			acpi_handle_debug(lps0_device_handle,
 					  "LPI: constraints list begin:\n");
 
-			for (j = 0; j < package->package.count; ++j) {
+			for (j = 0; j < package->package.count; j++) {
 				union acpi_object *info_obj = &package->package.elements[j];
 				struct lpi_device_constraint_amd dev_info = {};
 				struct lpi_constraints *list;
 				acpi_status status;
 
-				for (k = 0; k < info_obj->package.count; ++k) {
+				for (k = 0; k < info_obj->package.count; k++) {
 					union acpi_object *obj = &info_obj->package.elements[k];
 
 					list = &lpi_constraints_table[lpi_constraints_table_size];
@@ -213,7 +213,7 @@ static void lpi_device_get_constraints(void)
 		if (!package)
 			continue;
 
-		for (j = 0; j < package->package.count; ++j) {
+		for (j = 0; j < package->package.count; j++) {
 			union acpi_object *element =
 					&(package->package.elements[j]);
 
@@ -245,7 +245,7 @@ static void lpi_device_get_constraints(void)
 
 		constraint->min_dstate = -1;
 
-		for (j = 0; j < package_count; ++j) {
+		for (j = 0; j < package_count; j++) {
 			union acpi_object *info_obj = &info.package[j];
 			union acpi_object *cnstr_pkg;
 			union acpi_object *obj;
-- 
2.40.1



