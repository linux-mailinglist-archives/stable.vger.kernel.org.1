Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3EF79AF84
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379638AbjIKWpN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241447AbjIKPJB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:09:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808D9FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:08:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82DBC433C9;
        Mon, 11 Sep 2023 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444937;
        bh=4/1l3lQwBGUdmieDk5QHaBLH+5/Vy3K8wgxHtj+qosI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1Sx5+FkwWh8+0byKgQrOL5RDM6/IwQVGVozRgFPmypAmELoI7sTAJEP/TihmE+xi
         bNch8zgzfgISaFXOqYfZcSoiYPJHzuFiVb/Maoihx7Q9eObkfft393EVoy/gdLqeGo
         HIW7jbxqAJby9Hoj0xjOTbGXeyxZlxMBqh9bnMjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 130/600] ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
Date:   Mon, 11 Sep 2023 15:42:43 +0200
Message-ID: <20230911134637.454370371@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 9cc8cd086f05d9a01026c65c98da88561e9c619e ]

The constraints table should be resetting the `list` object
after running through all of `info_obj` iterations.

This adjusts whitespace as well as less code will now be included
with each loop. This fixes a functional problem is fixed where a
badly formed package in the inner loop may have incorrect data.

Fixes: 146f1ed852a8 ("ACPI: PM: s2idle: Add AMD support to handle _DSM")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/s2idle.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 3a9195df1aab3..ec84da6cc1bff 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -128,12 +128,11 @@ static void lpi_device_get_constraints_amd(void)
 				struct lpi_constraints *list;
 				acpi_status status;
 
+				list = &lpi_constraints_table[lpi_constraints_table_size];
+
 				for (k = 0; k < info_obj->package.count; k++) {
 					union acpi_object *obj = &info_obj->package.elements[k];
 
-					list = &lpi_constraints_table[lpi_constraints_table_size];
-					list->min_dstate = -1;
-
 					switch (k) {
 					case 0:
 						dev_info.enabled = obj->integer.value;
@@ -148,27 +147,21 @@ static void lpi_device_get_constraints_amd(void)
 						dev_info.min_dstate = obj->integer.value;
 						break;
 					}
+				}
 
-					if (!dev_info.enabled || !dev_info.name ||
-					    !dev_info.min_dstate)
-						continue;
+				if (!dev_info.enabled || !dev_info.name ||
+				    !dev_info.min_dstate)
+					continue;
 
-					status = acpi_get_handle(NULL, dev_info.name,
-								 &list->handle);
-					if (ACPI_FAILURE(status))
-						continue;
+				status = acpi_get_handle(NULL, dev_info.name, &list->handle);
+				if (ACPI_FAILURE(status))
+					continue;
 
-					acpi_handle_debug(lps0_device_handle,
-							  "Name:%s\n", dev_info.name);
+				acpi_handle_debug(lps0_device_handle,
+						  "Name:%s\n", dev_info.name);
 
-					list->min_dstate = dev_info.min_dstate;
+				list->min_dstate = dev_info.min_dstate;
 
-					if (list->min_dstate < 0) {
-						acpi_handle_debug(lps0_device_handle,
-								  "Incomplete constraint defined\n");
-						continue;
-					}
-				}
 				lpi_constraints_table_size++;
 			}
 		}
-- 
2.40.1



