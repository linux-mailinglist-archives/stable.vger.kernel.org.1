Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE577775CD6
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjHILbX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjHILbW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:31:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847EB19A1
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 233B0633A8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B4DC433C7;
        Wed,  9 Aug 2023 11:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580681;
        bh=neC51Y0PDL9Aw9f6ud1M8ut0384NXKPeGvxiEUROiD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJSAyVqP7C6NcBrOQcA8PUWsF/6UH4SWR7EOpBGKOjvNigK5mBeFwr69INKzwzOqV
         CKX209QVpId4xZoQ8oZwHLKukuS5uSzWA5yYt8JIipv6qAju0E3eCGCw3xkFpHs+4A
         Yzjz1DG1M7aVUcWU+xHnbw8uhH7IbayO82PsHmEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hagar Hemdan <hagarhem@amazon.de>
Subject: [PATCH 5.4 082/154] ACPI: processor: perflib: Avoid updating frequency QoS unnecessarily
Date:   Wed,  9 Aug 2023 12:41:53 +0200
Message-ID: <20230809103639.705410704@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 99387b016022c29234c4ebf9abd34358c6e56532 upstream.

Modify acpi_processor_get_platform_limit() to avoid updating its
frequency QoS request when the _PPC return value has not changed
by comparing that value to the previous _PPC return value stored in
the performance_platform_limit field of the struct acpi_processor
corresponding to the given CPU.

While at it, do the _PPC return value check against the state count
earlier, to avoid setting performance_platform_limit to an invalid
value, and make acpi_processor_ppc_init() use FREQ_QOS_MAX_DEFAULT_VALUE
as the "no limit" frequency QoS for consistency.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Hagar Hemdan <hagarhem@amazon.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/processor_perflib.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -79,13 +79,16 @@ static int acpi_processor_get_platform_l
 
 	index = ppc;
 
+	if (pr->performance_platform_limit == index ||
+	    ppc >= pr->performance->state_count)
+		return 0;
+
 	pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
 		 index, index ? "is" : "is not");
 
 	pr->performance_platform_limit = index;
 
-	if (ppc >= pr->performance->state_count ||
-	    unlikely(!freq_qos_request_active(&pr->perflib_req)))
+	if (unlikely(!freq_qos_request_active(&pr->perflib_req)))
 		return 0;
 
 	/*
@@ -180,9 +183,16 @@ void acpi_processor_ppc_init(struct cpuf
 		if (!pr)
 			continue;
 
+		/*
+		 * Reset performance_platform_limit in case there is a stale
+		 * value in it, so as to make it match the "no limit" QoS value
+		 * below.
+		 */
+		pr->performance_platform_limit = 0;
+
 		ret = freq_qos_add_request(&policy->constraints,
-					   &pr->perflib_req,
-					   FREQ_QOS_MAX, INT_MAX);
+					   &pr->perflib_req, FREQ_QOS_MAX,
+					   FREQ_QOS_MAX_DEFAULT_VALUE);
 		if (ret < 0)
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);


