Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC42713F6B
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjE1TpN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjE1TpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570699C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD04461F39
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1F0C433D2;
        Sun, 28 May 2023 19:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303111;
        bh=eyqas7sO+vJFszcK8jXe2BwXwaCkO6kpqqhCtjjYa0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ClqV0HheLRaPvM4hb7zCNsV+xoYcpzXiNT0Xyge8168wl5S+/lf+DTG94BV2T8Jk7
         4G/t6wesvDB5qUFnH7HAYfkrK1udmmOHmuJa5BTrqmzUvFlYKNTqIOKOA2JjAwKR7D
         R+NlOfjDLRgTr1hBCvG8DobQ2OO4ssLBzJvTFwZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gregory Oakes <gregory.oakes@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 5.10 159/211] watchdog: sp5100_tco: Immediately trigger upon starting.
Date:   Sun, 28 May 2023 20:11:20 +0100
Message-Id: <20230528190847.455682689@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gregory Oakes <gregory.oakes@amd.com>

commit 4eda19cc8a29cde3580ed73bf11dc73b4e757697 upstream.

The watchdog countdown is supposed to begin when the device file is
opened. Instead, it would begin countdown upon the first write to or
close of the device file. Now, the ping operation is called within the
start operation which ensures the countdown begins. From experimenation,
it does not appear possible to do this with a single write including
both the start bit and the trigger bit. So, it is done as two distinct
writes.

Signed-off-by: Gregory Oakes <gregory.oakes@amd.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230316201312.17538-1-gregory.oakes@amd.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/sp5100_tco.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -104,6 +104,10 @@ static int tco_timer_start(struct watchd
 	val |= SP5100_WDT_START_STOP_BIT;
 	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
 
+	/* This must be a distinct write. */
+	val |= SP5100_WDT_TRIGGER_BIT;
+	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
+
 	return 0;
 }
 


