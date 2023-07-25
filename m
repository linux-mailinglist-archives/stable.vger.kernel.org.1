Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EED761552
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjGYL1g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjGYL1f (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:27:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDAB99
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9B2F61683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086F7C433C8;
        Tue, 25 Jul 2023 11:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284453;
        bh=s+usCeWS54WM3fArivoFelxFyjeB6q2DdTANpWsxDMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JudIkLZlIByvTQtHTKO8v73Thzdoi7GLXbNUnuYzPapDHbHSs15GgZJwUo63IZm4V
         RSoV4N6EHdlk0BY0GgLgw9jdTjIBZgwSONYLuQgkubZiMoLoEu8lzftXNM7komkHTY
         oIivgrIYHtf8+tpqKe/YDDwR8kP1w7TW8d5oEd6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Armin Wolf <W_Armin@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 361/509] platform/x86: wmi: Break possible infinite loop when parsing GUID
Date:   Tue, 25 Jul 2023 12:45:00 +0200
Message-ID: <20230725104610.241158599@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 028e6e204ace1f080cfeacd72c50397eb8ae8883 ]

The while-loop may break on one of the two conditions, either ID string
is empty or GUID matches. The second one, may never be reached if the
parsed string is not correct GUID. In such a case the loop will never
advance to check the next ID.

Break possible infinite loop by factoring out guid_parse_and_compare()
helper which may be moved to the generic header for everyone later on
and preventing from similar mistake in the future.

Interestingly that firstly it appeared when WMI was turned into a bus
driver, but later when duplicated GUIDs were checked, the while-loop
has been replaced by for-loop and hence no mistake made again.

Fixes: a48e23385fcf ("platform/x86: wmi: add context pointer field to struct wmi_device_id")
Fixes: 844af950da94 ("platform/x86: wmi: Turn WMI into a bus driver")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230621151155.78279-1-andriy.shevchenko@linux.intel.com
Tested-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/wmi.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 5e4c03f7db7c0..567c28705cb1b 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -130,6 +130,16 @@ static bool find_guid(const char *guid_string, struct wmi_block **out)
 	return false;
 }
 
+static bool guid_parse_and_compare(const char *string, const guid_t *guid)
+{
+	guid_t guid_input;
+
+	if (guid_parse(string, &guid_input))
+		return false;
+
+	return guid_equal(&guid_input, guid);
+}
+
 static const void *find_guid_context(struct wmi_block *wblock,
 				      struct wmi_driver *wdriver)
 {
@@ -142,11 +152,7 @@ static const void *find_guid_context(struct wmi_block *wblock,
 
 	id = wdriver->id_table;
 	while (*id->guid_string) {
-		guid_t guid_input;
-
-		if (guid_parse(id->guid_string, &guid_input))
-			continue;
-		if (guid_equal(&wblock->gblock.guid, &guid_input))
+		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
 			return id->context;
 		id++;
 	}
@@ -804,11 +810,7 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 		return 0;
 
 	while (*id->guid_string) {
-		guid_t driver_guid;
-
-		if (WARN_ON(guid_parse(id->guid_string, &driver_guid)))
-			continue;
-		if (guid_equal(&driver_guid, &wblock->gblock.guid))
+		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
 			return 1;
 
 		id++;
-- 
2.39.2



