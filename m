Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E19970C6D4
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjEVTXI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbjEVTXC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:23:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850891A1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2240462852
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC4BC433D2;
        Mon, 22 May 2023 19:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783370;
        bh=Vy5+BQO3VbhljkkvwLP/PGF/MlHEjNVSyO2vB46eA/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCCeEhLskzqW+kOSkWWAiXjIVbWg7FMCOYOnyiDDmDEPkPlBHCQTpuhNN6TAl/+lV
         y7QLhnJ+bbrAFjg+POtO013n4udwQfgX0sLk9LfAUTwO+8KENnPrT43Ui9YINhFh0u
         Kutp3+4oySehM5h9oh+c2PJlFilHhYkKQ35umzp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kristoffer Ericson <Kristoffer.ericson@gmail.com>,
        patches@armlinux.org.uk,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 003/292] ARM: 9296/1: HP Jornada 7XX: fix kernel-doc warnings
Date:   Mon, 22 May 2023 20:06:00 +0100
Message-Id: <20230522190405.971336566@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 46dd6078dbc7e363a8bb01209da67015a1538929 ]

Fix kernel-doc warnings from the kernel test robot:

jornada720_ssp.c:24: warning: Function parameter or member 'jornada_ssp_lock' not described in 'DEFINE_SPINLOCK'
jornada720_ssp.c:24: warning: expecting prototype for arch/arm/mac(). Prototype was for DEFINE_SPINLOCK() instead
jornada720_ssp.c:34: warning: Function parameter or member 'byte' not described in 'jornada_ssp_reverse'
jornada720_ssp.c:57: warning: Function parameter or member 'byte' not described in 'jornada_ssp_byte'
jornada720_ssp.c:85: warning: Function parameter or member 'byte' not described in 'jornada_ssp_inout'

Link: lore.kernel.org/r/202304210535.tWby3jWF-lkp@intel.com

Fixes: 69ebb22277a5 ("[ARM] 4506/1: HP Jornada 7XX: Addition of SSP Platform Driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kristoffer Ericson <Kristoffer.ericson@gmail.com>
Cc: patches@armlinux.org.uk
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-sa1100/jornada720_ssp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
index 1dbe98948ce30..9627c4cf3e41d 100644
--- a/arch/arm/mach-sa1100/jornada720_ssp.c
+++ b/arch/arm/mach-sa1100/jornada720_ssp.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  *  arch/arm/mac-sa1100/jornada720_ssp.c
  *
  *  Copyright (C) 2006/2007 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
@@ -26,6 +26,7 @@ static unsigned long jornada_ssp_flags;
 
 /**
  * jornada_ssp_reverse - reverses input byte
+ * @byte: input byte to reverse
  *
  * we need to reverse all data we receive from the mcu due to its physical location
  * returns : 01110111 -> 11101110
@@ -46,6 +47,7 @@ EXPORT_SYMBOL(jornada_ssp_reverse);
 
 /**
  * jornada_ssp_byte - waits for ready ssp bus and sends byte
+ * @byte: input byte to transmit
  *
  * waits for fifo buffer to clear and then transmits, if it doesn't then we will
  * timeout after <timeout> rounds. Needs mcu running before its called.
@@ -77,6 +79,7 @@ EXPORT_SYMBOL(jornada_ssp_byte);
 
 /**
  * jornada_ssp_inout - decide if input is command or trading byte
+ * @byte: input byte to send (may be %TXDUMMY)
  *
  * returns : (jornada_ssp_byte(byte)) on success
  *         : %-ETIMEDOUT on timeout failure
-- 
2.39.2



