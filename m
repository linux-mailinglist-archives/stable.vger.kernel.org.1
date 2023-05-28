Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A82E713DE9
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjE1TaJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjE1TaH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:30:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546A8C9
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D38FE61D48
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CB8C433EF;
        Sun, 28 May 2023 19:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302203;
        bh=e1ibWDqXencHGGF+R5BOTNT8333GZrGkmCoDaZkYzgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmwN55HT/gX7PshTaUYWPtY2ZaetgxT5gFNN4zH6c86DGM3u0J3QH7psoyiVa8JR8
         1gPel5/OBQ19IJ6O2lTtbIaf3MiAp8VFKDhuF4QH5L3Hx0kW9JG7t69Wcl7C3ddZ0i
         FYCG4nWCWryrkVwrXdsZjl5P2JJ5/3H1h3hQGDfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.3 041/127] thermal: intel: int340x: Add new line for UUID display
Date:   Sun, 28 May 2023 20:10:17 +0100
Message-Id: <20230528190837.677878816@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit 5f7fdb0f255756b594cc45c2c08b0140bc4a1761 upstream.

Prior to the commit "763bd29fd3d1 ("thermal: int340x_thermal: Use
sysfs_emit_at() instead of scnprintf()", there was a new line after each
UUID string.

With the newline removed, existing user space like "thermald" fails to
compare each supported UUID as it is using getline() to read UUID and
apply correct thermal table.

To avoid breaking existing user space, add newline after each UUID string.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 763bd29fd3d1 ("thermal: int340x_thermal: Use sysfs_emit_at() instead of scnprintf()")
Cc: 6.3+ <stable@vger.kernel.org> # 6.3+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 810231b59dcd..5e1164226ada 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -131,7 +131,7 @@ static ssize_t available_uuids_show(struct device *dev,
 
 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
 		if (priv->uuid_bitmap & (1 << i))
-			length += sysfs_emit_at(buf, length, int3400_thermal_uuids[i]);
+			length += sysfs_emit_at(buf, length, "%s\n", int3400_thermal_uuids[i]);
 	}
 
 	return length;
@@ -149,7 +149,7 @@ static ssize_t current_uuid_show(struct device *dev,
 
 	for (i = 0; i <= INT3400_THERMAL_CRITICAL; i++) {
 		if (priv->os_uuid_mask & BIT(i))
-			length += sysfs_emit_at(buf, length, int3400_thermal_uuids[i]);
+			length += sysfs_emit_at(buf, length, "%s\n", int3400_thermal_uuids[i]);
 	}
 
 	if (length)
-- 
2.40.1



