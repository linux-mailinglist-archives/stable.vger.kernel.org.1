Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12DE7EB492
	for <lists+stable@lfdr.de>; Tue, 14 Nov 2023 17:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjKNQPS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 14 Nov 2023 11:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjKNQPS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 14 Nov 2023 11:15:18 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C112C
        for <stable@vger.kernel.org>; Tue, 14 Nov 2023 08:15:14 -0800 (PST)
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6FAD0423EA;
        Tue, 14 Nov 2023 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699978510;
        bh=AD43JpbWoDP1T3cfd9OM5g8J8M333FKuOopYtyTvuQ0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=DRXTPJiKJFRCjmGA3mxH86vcNaQtBYci+kmxZ1wQ0uZVSwWKZy1Sql/qTcziMpaXL
         zskfKKb3zmjv5HoSVUdAKGgtUnJFmwchrTLp/X7DDSIcgRIFq/IP9RjCSYuO/p7mkg
         xfzHaoAfJ0EqY45vcJqMJfcFR98+We6ydLJzPZjRDHVq+yMbON6lJNCfYjKD0JDw3J
         SA72zlUVchxYzD4n+T0g3e7YMx4lo77cyhiGDCDbUTZIBpmDH7ON4rIg9goFs02MSS
         zlhJvCEySaFNXiEx00Qz3uX/HArS34W1kga0inGOG7YB0E0XcRKV5R5dHLmSTTOpar
         dGfQQ50TVwF6w==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Tom Rini <trini@konsulko.com>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        stable@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] docs: Fix the docs build with Sphinx 6.0
Date:   Tue, 14 Nov 2023 17:15:04 +0100
Message-Id: <20231114161504.20690-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jonathan Corbet <corbet@lwn.net>

Sphinx 6.0 removed the execfile_() function, which we use as part of the
configuration process.  They *did* warn us...  Just open-code the
functionality as is done in Sphinx itself.

Tested (using SPHINX_CONF, since this code is only executed with an
alternative config file) on various Sphinx versions from 2.5 through 6.0.

Reported-by: Martin Liška <mliska@suse.cz>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Rebased for U-Boot
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/sphinx/load_config.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/sphinx/load_config.py b/doc/sphinx/load_config.py
index eeb394b39e..8b416bfd75 100644
--- a/doc/sphinx/load_config.py
+++ b/doc/sphinx/load_config.py
@@ -3,7 +3,7 @@
 
 import os
 import sys
-from sphinx.util.pycompat import execfile_
+from sphinx.util.osutil import fs_encoding
 
 # ------------------------------------------------------------------------------
 def loadConfig(namespace):
@@ -48,7 +48,9 @@ def loadConfig(namespace):
             sys.stdout.write("load additional sphinx-config: %s\n" % config_file)
             config = namespace.copy()
             config['__file__'] = config_file
-            execfile_(config_file, config)
+            with open(config_file, 'rb') as f:
+                code = compile(f.read(), fs_encoding, 'exec')
+                exec(code, config)
             del config['__file__']
             namespace.update(config)
         else:
-- 
2.40.1

