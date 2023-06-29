Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DAF742C41
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjF2Sri (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjF2SrR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B8830DF
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2853D61575
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A96DC433C8;
        Thu, 29 Jun 2023 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064435;
        bh=GprHvna917IUD3VThEejt+TTe8XAmtOwoj44XOQAXmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiKjhgqFdCBfeYZG8CLLGV/Zx+pMD45MKmeIWjQt/MmiEdDxPMU74IkRe9h0ZhIK4
         WSjNVg0LBk5k/ujcvT9+mEz/02QG8f6lqoWKut41gHnLS6d8HTXWElBT5TzSPnW21U
         0QDzcdyzq5AlGn0VIALgxeUb3ZhCxBmc9knSeGyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Wyes Karny <wyes.karny@amd.com>, Huang Rui <ray.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.3 09/29] cpufreq: amd-pstate: Make amd-pstate EPP driver name hyphenated
Date:   Thu, 29 Jun 2023 20:43:39 +0200
Message-ID: <20230629184152.124264343@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.705870770@linuxfoundation.org>
References: <20230629184151.705870770@linuxfoundation.org>
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

From: Wyes Karny <wyes.karny@amd.com>

commit f4aad639302a07454dcb23b408dcadf8a9efb031 upstream.

amd-pstate passive mode driver is hyphenated. So make amd-pstate active
mode driver consistent with that rename "amd_pstate_epp" to
"amd-pstate-epp".

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Cc: All applicable <stable@vger.kernel.org>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/amd-pstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1272,7 +1272,7 @@ static struct cpufreq_driver amd_pstate_
 	.online		= amd_pstate_epp_cpu_online,
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
-	.name		= "amd_pstate_epp",
+	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
 


