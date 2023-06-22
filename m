Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9167399EB
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 10:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjFVIf1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 04:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjFVIfZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 04:35:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0FC1BE2
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 01:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687422923; x=1718958923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G4qJ+ODyBBPW+4GThpxcjwDekCq2tXZuEYLQDlacEWU=;
  b=T2gxQFH+KC3YZJUZpprNLtkPAFMZpNTTQLoiMb85g2jiJLjC89pBk7k6
   qw+ddwTfd3tJ2KGLPw1Vox2JMUn69gs5gwhAs9ZeYY+pZvn6dM7KTzC0I
   7wD32WgAtG5ySJqrXqG2psIXxF78YAY2jN8oQHWcaouX3wzLwYuOcv9NM
   pK/d7a7fWDJtKGM1g5j9YzdC+Jeol+whl8PMX5WSsuiVLzKURa6hQSW2R
   876dUXsFeSxlTcAumgshhzLRkYbK8yoNWE+B0B9mdDvEVRMT3zm0mR5vH
   fKCXfnhRF9Xy352eSAPZWLuCfIospF2zJdkeRP/OFwEUcm14ejUpaFYg9
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="219880865"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2023 01:35:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 22 Jun 2023 01:35:16 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 22 Jun 2023 01:35:15 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] scripts/quilt-mail: add email address for Conor Dooley
Date:   Thu, 22 Jun 2023 09:34:44 +0100
Message-ID: <20230622083443.930823-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Sometimes I miss the stable announcements cos of the delights of our
corporate email setup, so add me to the 0th mail CC list.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I dunno how to test this, but touch wood I've not made a hames of
something trivial...

 scripts/quilt-mail | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/quilt-mail b/scripts/quilt-mail
index 5eb70af702..7b77e2970d 100755
--- a/scripts/quilt-mail
+++ b/scripts/quilt-mail
@@ -177,7 +177,8 @@ CC_NAMES=("linux-kernel@vger\.kernel\.org"
 	  "f\.fainelli@gmail\.com"
 	  "sudipm\.mukherjee@gmail\.com"
 	  "srw@sladewatkins\.net"
-	  "rwarsow@gmx\.de")
+	  "rwarsow@gmx\.de"
+	  "conor@kernel\.org")
 
 #CC_LIST="stable@vger\.kernel\.org"
 CC_LIST="patches@lists.linux.dev"
-- 
2.40.1

