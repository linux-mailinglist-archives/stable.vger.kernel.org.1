Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB93703B8C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbjEOSEJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbjEOSDs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7C819976
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:01:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C693763041
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E1EC4339B;
        Mon, 15 May 2023 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173671;
        bh=hmdACvyceHtfwG6iZa0TlefPkqSpVkF36kkn55rWHqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wMuuH83IQs8T/ThWno6Y4h6DyakEfUKFu7r3ghhySbEOe4P/U+bAEbpMTlYScaNj6
         +yh9UijOWsB4G1t5Xt/mU9BEGzPAodnscTv4VXTmEEww7iWdiDSVjsxGpbZTokSnPg
         JpMKP19mxjJkEc1aSd6vHwuMZ+xIjaCFOBhFukZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Fainelli <f.fainelli@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 139/282] scripts/gdb: bail early if there are no generic PD
Date:   Mon, 15 May 2023 18:28:37 +0200
Message-Id: <20230515161726.385827166@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit f19c3c2959e465209ade1a7a699e6cbf4359ce78 ]

Avoid generating an exception if there are no generic power domain(s)
registered:

(gdb) lx-genpd-summary
domain                          status          children
    /device                                             runtime status
----------------------------------------------------------------------
Python Exception <class 'gdb.error'>: No symbol "gpd_list" in current context.
Error occurred in Python: No symbol "gpd_list" in current context.
(gdb) quit

[f.fainelli@gmail.com: correctly invoke gdb_eval_or_none]
  Link: https://lkml.kernel.org/r/20230327185746.3856407-1-f.fainelli@gmail.com
Link: https://lkml.kernel.org/r/20230323231659.3319941-1-f.fainelli@gmail.com
Fixes: 8207d4a88e1e ("scripts/gdb: add lx-genpd-summary command")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gdb/linux/genpd.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/genpd.py b/scripts/gdb/linux/genpd.py
index 39cd1abd85590..b53649c0a77a6 100644
--- a/scripts/gdb/linux/genpd.py
+++ b/scripts/gdb/linux/genpd.py
@@ -5,7 +5,7 @@
 import gdb
 import sys
 
-from linux.utils import CachedType
+from linux.utils import CachedType, gdb_eval_or_none
 from linux.lists import list_for_each_entry
 
 generic_pm_domain_type = CachedType('struct generic_pm_domain')
@@ -70,6 +70,8 @@ Output is similar to /sys/kernel/debug/pm_genpd/pm_genpd_summary'''
             gdb.write('    %-50s  %s\n' % (kobj_path, rtpm_status_str(dev)))
 
     def invoke(self, arg, from_tty):
+        if gdb_eval_or_none("&gpd_list") is None:
+            raise gdb.GdbError("No power domain(s) registered")
         gdb.write('domain                          status          children\n');
         gdb.write('    /device                                             runtime status\n');
         gdb.write('----------------------------------------------------------------------\n');
-- 
2.39.2



