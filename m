Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDA37616A7
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjGYLk6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjGYLkq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1248A18F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5132616A4
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE511C433C9;
        Tue, 25 Jul 2023 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285230;
        bh=HCLC33ytXoiSdWk3Ec1uvJNOlRf9UoaIabqVUoLJ/zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xMHbks/Sm+mKVGYi2iPmFPjzwPdAL8KfBYndKFIUHi7Ok6bLWyxHH98qXnIj+B1VX
         WR+Hp3EZ2F3Yt4kX1t2xK122Fdgge6Gk8XB5rw3I9FssxEw/5IC3OgKmeVj4B+hMls
         9A02oPTlZ3f3mLO7n34YQH62L1e4nZPTMZwT0KJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 131/313] extcon: Fix kernel doc of property fields to avoid warnings
Date:   Tue, 25 Jul 2023 12:44:44 +0200
Message-ID: <20230725104526.687557554@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 7e77e0b7a9f4cdf91cb0950749b40c840ea63efc ]

Kernel documentation has to be synchronized with a code, otherwise
the validator is not happy:

     Function parameter or member 'usb_propval' not described in 'extcon_cable'
     Function parameter or member 'chg_propval' not described in 'extcon_cable'
     Function parameter or member 'jack_propval' not described in 'extcon_cable'
     Function parameter or member 'disp_propval' not described in 'extcon_cable'

Describe the fields added in the past.

Fixes: 067c1652e7a7 ("extcon: Add the support for extcon property according to extcon type")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/extcon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 6b905c3d30f4f..00ad8b637749b 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -196,6 +196,10 @@ static const struct __extcon_info {
  * @attr_name:		"name" sysfs entry
  * @attr_state:		"state" sysfs entry
  * @attrs:		the array pointing to attr_name and attr_state for attr_g
+ * @usb_propval:	the array of USB connector properties
+ * @chg_propval:	the array of charger connector properties
+ * @jack_propval:	the array of jack connector properties
+ * @disp_propval:	the array of display connector properties
  */
 struct extcon_cable {
 	struct extcon_dev *edev;
-- 
2.39.2



