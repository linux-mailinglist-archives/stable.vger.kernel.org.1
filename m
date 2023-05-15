Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC92E7039D0
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244603AbjEORqK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244599AbjEORpq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:45:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF481693C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B51C62E90
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C297C433EF;
        Mon, 15 May 2023 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172620;
        bh=22/0GyGstKxSi5WyUg/SfzoRo+KeW+wvMb1rDRutY3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DD7dE24hXB+xa6lqwFel7YmMypOhHCKbkQBdHIa8JKsQ9/TgE1nJwPe4XHlVbqfyM
         UKzK7rmk/KGEmCHhEj1S2a80uLwkHznOxgeyNZOvYHcJvHyGpwPikIMD5s1rq9PnOC
         9DiGFPM75TKcbxeBTwuSwmTC8JuWDoyK7F8Ipw5M=
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
Subject: [PATCH 5.10 212/381] scripts/gdb: bail early if there are no clocks
Date:   Mon, 15 May 2023 18:27:43 +0200
Message-Id: <20230515161746.357779008@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 1d7adbc74c009057ed9dc3112f388e91a9c79acc ]

Avoid generating an exception if there are no clocks registered:

(gdb) lx-clk-summary
                                 enable  prepare  protect
   clock                          count    count    count        rate
------------------------------------------------------------------------
Python Exception <class 'gdb.error'>: No symbol "clk_root_list" in
current context.
Error occurred in Python: No symbol "clk_root_list" in current context.

Link: https://lkml.kernel.org/r/20230323225246.3302977-1-f.fainelli@gmail.com
Fixes: d1e9710b63d8 ("scripts/gdb: initial clk support: lx-clk-summary")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gdb/linux/clk.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/gdb/linux/clk.py b/scripts/gdb/linux/clk.py
index 061aecfa294e6..7a01fdc3e8446 100644
--- a/scripts/gdb/linux/clk.py
+++ b/scripts/gdb/linux/clk.py
@@ -41,6 +41,8 @@ are cached and potentially out of date"""
             self.show_subtree(child, level + 1)
 
     def invoke(self, arg, from_tty):
+        if utils.gdb_eval_or_none("clk_root_list") is None:
+            raise gdb.GdbError("No clocks registered")
         gdb.write("                                 enable  prepare  protect               \n")
         gdb.write("   clock                          count    count    count        rate   \n")
         gdb.write("------------------------------------------------------------------------\n")
-- 
2.39.2



