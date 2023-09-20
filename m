Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386817A7D18
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjITMGh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjITMGg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:06:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CAE128
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:06:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10094C433C7;
        Wed, 20 Sep 2023 12:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211585;
        bh=g2fAzvVIAh9m1tSY26evVlhbFYLl2ySMboAYnuD0wlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FcPzh9G/TdAznS4qjzKYiIE6bfy9ArVv2s4/iw8/+NIT2F9g81K260NGBRUb7XHBY
         RSJT2fWfE7IaPdX0/clXN0ctWXLlj3pGiDer0rMv5W4bW6fcG/ShUalIm0oEAm+BdR
         awbh6Cf1OK+I1PaA4uNj3mNpi4y+O4HXrQo22a9Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 148/186] parisc: Drop loops_per_jiffy from per_cpu struct
Date:   Wed, 20 Sep 2023 13:30:51 +0200
Message-ID: <20230920112842.315123162@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 93346da8ff47cc00f953c7f38a2d6ba11977fc42 upstream.

There is no need to keep a loops_per_jiffy value per cpu. Drop it.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/processor.h |    1 -
 arch/parisc/kernel/processor.c      |    5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -108,7 +108,6 @@ struct cpuinfo_parisc {
 	unsigned long cpu_loc;      /* CPU location from PAT firmware */
 	unsigned int state;
 	struct parisc_device *dev;
-	unsigned long loops_per_jiffy;
 };
 
 extern struct system_cpuinfo_parisc boot_cpu_data;
--- a/arch/parisc/kernel/processor.c
+++ b/arch/parisc/kernel/processor.c
@@ -177,7 +177,6 @@ static int __init processor_probe(struct
 	if (cpuid)
 		memset(p, 0, sizeof(struct cpuinfo_parisc));
 
-	p->loops_per_jiffy = loops_per_jiffy;
 	p->dev = dev;		/* Save IODC data in case we need it */
 	p->hpa = dev->hpa.start;	/* save CPU hpa */
 	p->cpuid = cpuid;	/* save CPU id */
@@ -429,8 +428,8 @@ show_cpuinfo (struct seq_file *m, void *
 		show_cache_info(m);
 
 		seq_printf(m, "bogomips\t: %lu.%02lu\n",
-			     cpuinfo->loops_per_jiffy / (500000 / HZ),
-			     (cpuinfo->loops_per_jiffy / (5000 / HZ)) % 100);
+			     loops_per_jiffy / (500000 / HZ),
+			     loops_per_jiffy / (5000 / HZ) % 100);
 
 		seq_printf(m, "software id\t: %ld\n\n",
 				boot_cpu_data.pdc.model.sw_id);


