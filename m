Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B05775D86
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjHILid (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjHILid (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:38:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE64B1FD7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66819635B0
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A512C433C7;
        Wed,  9 Aug 2023 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581111;
        bh=OZPqh6DPtVNj/6F3HCkbpXeXCAEQ902CoFTvPplyJig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6RlPG+I6nhxAAgpd8WO91599HH2oheWKCZCHz5UmiopOVtDbIN3O/wtEcOBMBOen
         AHOoHzOEjY/pnAKQmTzykoShUM2tFcwY81cDn4O+GzpB3KdIKIHvUzjdRx3xwVKteA
         Kegh1j+ptE4/7T/NmSxD4U0mI7Jnju/5iwyOCPtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hagar Hemdan <hagarhem@amazon.de>
Subject: [PATCH 5.10 109/201] cpufreq: intel_pstate: Drop ACPI _PSS states table patching
Date:   Wed,  9 Aug 2023 12:41:51 +0200
Message-ID: <20230809103647.449848820@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit e8a0e30b742f76ebd0f3b196973df4bf65d8fbbb upstream.

After making acpi_processor_get_platform_limit() use the "no limit"
value for its frequency QoS request when _PPC returns 0, it is not
necessary to replace the frequency corresponding to the first _PSS
return package entry with the maximum turbo frequency of the given
CPU in intel_pstate_init_acpi_perf_limits() any more, so drop the
code doing that along with the comment explaining it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Hagar Hemdan <hagarhem@amazon.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/intel_pstate.c |   14 --------------
 1 file changed, 14 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -443,20 +443,6 @@ static void intel_pstate_init_acpi_perf_
 			 (u32) cpu->acpi_perf_data.states[i].control);
 	}
 
-	/*
-	 * The _PSS table doesn't contain whole turbo frequency range.
-	 * This just contains +1 MHZ above the max non turbo frequency,
-	 * with control value corresponding to max turbo ratio. But
-	 * when cpufreq set policy is called, it will call with this
-	 * max frequency, which will cause a reduced performance as
-	 * this driver uses real max turbo frequency as the max
-	 * frequency. So correct this frequency in _PSS table to
-	 * correct max turbo frequency based on the turbo state.
-	 * Also need to convert to MHz as _PSS freq is in MHz.
-	 */
-	if (!global.turbo_disabled)
-		cpu->acpi_perf_data.states[0].core_frequency =
-					policy->cpuinfo.max_freq / 1000;
 	cpu->valid_pss_table = true;
 	pr_debug("_PPC limits will be enforced\n");
 


