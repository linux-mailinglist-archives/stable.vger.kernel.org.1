Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420FC7A374F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjIQTRV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbjIQTRO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:17:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735FFFA
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:17:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81832C433C7;
        Sun, 17 Sep 2023 19:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978228;
        bh=wvPx/ZrU4qdFqsy2V6IHLdgHm/NgRp0rXseVuNxhHLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVaGhUJwAjX4t1riXTEJ72PjaCwl9lY7roQ2dxw57odyOvBUg4UuxqK3Eqvt6b/RV
         YU1xyZHIADU/vLJY/d+LEJlHQHg9GOTEtPtblskCx9NIPF2y7DI0xBTB6ChNtDp6nt
         toKyy3L6ZKRhmPL7sKT2ym4zttFoVb0UyGxwr7xQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH 5.10 019/406] fsi: master-ast-cf: Add MODULE_FIRMWARE macro
Date:   Sun, 17 Sep 2023 21:07:53 +0200
Message-ID: <20230917191101.657709576@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juerg Haefliger <juerg.haefliger@canonical.com>

commit 3a1d7aff6e65ad6e285e28abe55abbfd484997ee upstream.

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Fixes: 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Link: https://lore.kernel.org/r/20230628095039.26218-1-juerg.haefliger@canonical.com
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/fsi/fsi-master-ast-cf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1440,3 +1440,4 @@ static struct platform_driver fsi_master
 
 module_platform_driver(fsi_master_acf);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FW_FILE_NAME);


