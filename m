Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BDA713FAE
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjE1Tr5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjE1Trz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:47:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A69C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A77C61FCE
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F0BC4339B;
        Sun, 28 May 2023 19:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303274;
        bh=v9rryK8PwrdhQ9V3i29ygKUbE2jrM25+/Zq1ij0NASo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgE67wSEbIlkBaQkirbnl3ydozEIXGQdA2Ea69OVmAJuVgBsFjHA9AGGuahhBtkcG
         9aXbdWtLaRLHEiRr2H3r0fW/aqcOT8YO6MsaBAbzoc4bMrIy+fvHt2Hmcw1NcGeFhV
         HN14ItEukBg4PIB6gzUD5bcpKZCZD9V1fYkOsBwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gregory Oakes <gregory.oakes@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 5.15 05/69] watchdog: sp5100_tco: Immediately trigger upon starting.
Date:   Sun, 28 May 2023 20:11:25 +0100
Message-Id: <20230528190828.540373134@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
@@ -108,6 +108,10 @@ static int tco_timer_start(struct watchd
 	val |= SP5100_WDT_START_STOP_BIT;
 	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
 
+	/* This must be a distinct write. */
+	val |= SP5100_WDT_TRIGGER_BIT;
+	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
+
 	return 0;
 }
 


