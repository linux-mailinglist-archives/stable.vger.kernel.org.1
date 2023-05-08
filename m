Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74DB6FAA1A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjEHK73 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbjEHK6x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7A92CFE2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ABC0629BF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA79C433EF;
        Mon,  8 May 2023 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543461;
        bh=LzhMOySrmXuA5k/i9z9IQwcnngHdDfoxDLAC/s5FWWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGJwMTJc7n2AfJNwCsx71J1wV/nLjy7rLomOVfSL2qQ+bG2WCDkqUGX/5tmQzNQMc
         uUpRrNisHZZwKyeoBiojPm2NRx/ZDT2lRsmSLVJe+IS1YEFNFdZEQuhKqX7ON5Rd5B
         ytm88LRsyzEYeJVb8+u2k27PhSBGFaJuqOHIljnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Risto A. Paju" <teknohog@iki.fi>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "6 . 3+" <stable@kernel.org>
Subject: [PATCH 6.3 080/694] thermal: intel: powerclamp: Fix NULL pointer access issue
Date:   Mon,  8 May 2023 11:38:35 +0200
Message-Id: <20230508094435.132360577@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit b5d68f84f4c62c78bc3d004911d80da5aa22df8b upstream.

If cur_state for the powerclamp cooling device is set to the default
minimum state of 0, without setting first to cur_state > 0, this results
in NULL pointer access.

This NULL pointer access happens in the powercap core idle-inject
function idle_inject_set_duration() as there is no NULL check for
idle_inject_device pointer. This pointer must be allocated by calling
idle_inject_register() or idle_inject_register_full().

In the function powerclamp_set_cur_state(), idle_inject_device pointer
is allocated only when the cur_state > 0. But setting 0 without changing
to any other state, idle_inject_set_duration() will be called with a
NULL idle_inject_device pointer.

To address this, just return from powerclamp_set_cur_state() if the
current cooling device state is the same as the last one. Since the
power-up default cooling device state is 0, changing the state to 0
again here will return without calling idle_inject_set_duration().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 8526eb7fc75a ("thermal: intel: powerclamp: Use powercap idle-inject feature")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=217386
Tested-by: Risto A. Paju <teknohog@iki.fi>
Cc: 6.3+ <stable@kernel.org> # 6.3+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/intel/intel_powerclamp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -703,6 +703,10 @@ static int powerclamp_set_cur_state(stru
 
 	new_target_ratio = clamp(new_target_ratio, 0UL,
 				(unsigned long) (max_idle - 1));
+
+	if (powerclamp_data.target_ratio == new_target_ratio)
+		goto exit_set;
+
 	if (!powerclamp_data.target_ratio && new_target_ratio > 0) {
 		pr_info("Start idle injection to reduce power\n");
 		powerclamp_data.target_ratio = new_target_ratio;


