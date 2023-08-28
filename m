Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80EA78AA42
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjH1KUh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjH1KUH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CA1CC1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F6B63778
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A3AC433C8;
        Mon, 28 Aug 2023 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217991;
        bh=/jJW5lfBMUWAGxbxs/mB6YB/nzU57QXpGbUcjx7pRrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5ILhOEEckjVTpbP/bdMVNNU6Jy8rrBmA8SdnraB505lpPj7hmZni/wsUXnXVrxtY
         70i8DC2y65vhhpD7ymfQuce7UDXrsgdOo1FhKEsh1aDuAo7x/BZpKe4Xw/v7NNvuP/
         kxgSVgNi0FnySRpnJLpDWjG9BI3z/Cok/U+aQecM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Swapnil Devesh <me@sidevesh.com>,
        =?UTF-8?q?Gerg=C5=91=20K=C3=B6teles?= <soyer@irl.hu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.4 056/129] platform/x86: lenovo-ymc: Add Lenovo Yoga 7 14ACN6 to ec_trigger_quirk_dmi_table
Date:   Mon, 28 Aug 2023 12:12:15 +0200
Message-ID: <20230828101159.232568253@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Swapnil Devesh <me@sidevesh.com>

commit db35610a181c18f7a521a2e157f7acdef7ce425f upstream.

This adds my laptop Lenovo Yoga 7 14ACN6, with Product Name: 82N7
(from `dmidecode -t1 | grep "Product Name"`) to
the ec_trigger_quirk_dmi_table, have tested that this is required
for the YMC driver to work correctly on this model.

Signed-off-by: Swapnil Devesh <me@sidevesh.com>
Reviewed-by: Gergő Köteles <soyer@irl.hu>
Link: https://lore.kernel.org/r/18a08a8b173.895ef3b250414.1213194126082324071@sidevesh.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/lenovo-ymc.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/platform/x86/lenovo-ymc.c
+++ b/drivers/platform/x86/lenovo-ymc.c
@@ -36,6 +36,13 @@ static const struct dmi_system_id ec_tri
 			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
 		},
 	},
+	{
+		/* Lenovo Yoga 7 14ACN6 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82N7"),
+		},
+	},
 	{ }
 };
 


