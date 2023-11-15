Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92707ED46B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbjKOU6D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbjKOU5h (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83601AE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2215C32794;
        Wed, 15 Nov 2023 20:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081365;
        bh=tcOMwWr17hxLD4gvxNIrK6ERt9PAF/lvPtaJJOb+9gY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFwljqXU0nGhXyrqjctNwyys6hZK0nyJ1MYATOf9C+fc6QFw++L6Elh0SaAJLBQYW
         YZb5znn7oveFkLubS71qNHScFd0FtoKvmZPK5bb7IjEgcqw7fl0LZqxycoaIaCFrmo
         LXkESgNKiTyKJZny90zamVE0LoPXBMzNL8Y6uMJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Rui <rui.zhang@intel.com>,
        kernel test robot <lkp@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 082/244] hwmon: (coretemp) Fix potentially truncated sysfs attribute name
Date:   Wed, 15 Nov 2023 15:34:34 -0500
Message-ID: <20231115203553.279547211@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit bbfff736d30e5283ad09e748caff979d75ddef7f ]

When build with W=1 and "-Werror=format-truncation", below error is
observed in coretemp driver,

   drivers/hwmon/coretemp.c: In function 'create_core_data':
>> drivers/hwmon/coretemp.c:393:34: error: '%s' directive output may be truncated writing likely 5 or more bytes into a region of size between 3 and 13 [-Werror=format-truncation=]
     393 |                          "temp%d_%s", attr_no, suffixes[i]);
         |                                  ^~
   drivers/hwmon/coretemp.c:393:26: note: assuming directive output of 5 bytes
     393 |                          "temp%d_%s", attr_no, suffixes[i]);
         |                          ^~~~~~~~~~~
   drivers/hwmon/coretemp.c:392:17: note: 'snprintf' output 7 or more bytes (assuming 22) into a destination of size 19
     392 |                 snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     393 |                          "temp%d_%s", attr_no, suffixes[i]);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

Given that
1. '%d' could take 10 charactors,
2. '%s' could take 10 charactors ("crit_alarm"),
3. "temp", "_" and the NULL terminator take 6 charactors,
fix the problem by increasing CORETEMP_NAME_LENGTH to 28.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Fixes: 7108b80a542b ("hwmon/coretemp: Handle large core ID value")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310200443.iD3tUbbK-lkp@intel.com/
Link: https://lore.kernel.org/r/20231025122316.836400-1-rui.zhang@intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index eaae5de2ab616..5b2057ce5a59d 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -41,7 +41,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 #define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
 #define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
-#define CORETEMP_NAME_LENGTH	19	/* String Length of attrs */
+#define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
 #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
-- 
2.42.0



