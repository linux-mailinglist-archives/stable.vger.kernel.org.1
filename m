Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1163876AD9C
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjHAJaw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjHAJae (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:30:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727C41BD3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4557614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A00C433C7;
        Tue,  1 Aug 2023 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882152;
        bh=eROYAVkyYnHhQxzxb0aHGeIlSI/+VDSY16vWeCSiGkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xd5MANCkuQ105K4VVMFacrYkwCb6SLyCebxQA7k3NVUGid8mzJrTR3b/9to1zY/bT
         MX0ul3edIRkqC8WtmWD7pYkiBuBgvlskRyGoLqbRTklYLAplClPTyiYj5HrUSqJpT/
         i/DCaGM6auCjl2mNs8vWDxRrRCwBiuJSz9h+kzQA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pratyush Yadav <ptyadav@amazon.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hagar Hemdan <hagarhem@amazon.de>
Subject: [PATCH 5.15 149/155] ACPI: processor: perflib: Use the "no limit" frequency QoS
Date:   Tue,  1 Aug 2023 11:21:01 +0200
Message-ID: <20230801091915.449228675@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit c02d5feb6e2f60affc6ba8606d8d614c071e2ba6 upstream.

When _PPC returns 0, it means that the CPU frequency is not limited by
the platform firmware, so make acpi_processor_get_platform_limit()
update the frequency QoS request used by it to "no limit" in that case.

This addresses a problem with limiting CPU frequency artificially on
some systems after CPU offline/online to the frequency that corresponds
to the first entry in the _PSS return package.

Reported-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Pratyush Yadav <ptyadav@amazon.de>
Tested-by: Pratyush Yadav <ptyadav@amazon.de>
Tested-by: Hagar Hemdan <hagarhem@amazon.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/processor_perflib.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -53,6 +53,8 @@ static int acpi_processor_get_platform_l
 {
 	acpi_status status = 0;
 	unsigned long long ppc = 0;
+	s32 qos_value;
+	int index;
 	int ret;
 
 	if (!pr)
@@ -72,17 +74,27 @@ static int acpi_processor_get_platform_l
 		}
 	}
 
+	index = ppc;
+
 	pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
-		       (int)ppc, ppc ? "" : "not");
+		 index, index ? "is" : "is not");
 
-	pr->performance_platform_limit = (int)ppc;
+	pr->performance_platform_limit = index;
 
 	if (ppc >= pr->performance->state_count ||
 	    unlikely(!freq_qos_request_active(&pr->perflib_req)))
 		return 0;
 
-	ret = freq_qos_update_request(&pr->perflib_req,
-			pr->performance->states[ppc].core_frequency * 1000);
+	/*
+	 * If _PPC returns 0, it means that all of the available states can be
+	 * used ("no limit").
+	 */
+	if (index == 0)
+		qos_value = FREQ_QOS_MAX_DEFAULT_VALUE;
+	else
+		qos_value = pr->performance->states[index].core_frequency * 1000;
+
+	ret = freq_qos_update_request(&pr->perflib_req, qos_value);
 	if (ret < 0) {
 		pr_warn("Failed to update perflib freq constraint: CPU%d (%d)\n",
 			pr->id, ret);


