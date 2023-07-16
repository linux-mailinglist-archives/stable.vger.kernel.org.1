Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0CD755309
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjGPUOi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjGPUOi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:14:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDF690
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:14:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E48BF60EB3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D6EC433C7;
        Sun, 16 Jul 2023 20:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538476;
        bh=p6M69ZO0XbkZdjNADJARWO8RMiGy2uNYuolHUJzP1w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CfQhZZGprbU6ryAWoAqE4xI2KIEL6THloGCpkiKU3VLxMpfqqYbpGpMCoCS5oPgYs
         4rBDeLmnx2CpJ8ZuYkC8Mpoge7zlXn7KRM8Tj1DVsA4G9NG8ux50xvFY8QicrIXtXu
         gZ+ZzsnhgsQ8a2Wx8thrVr7Z8e/I1aCSRiwdQ06M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xi Pardee <xi.pardee@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 457/800] platform/x86:intel/pmc: Remove Meteor Lake S platform support
Date:   Sun, 16 Jul 2023 21:45:10 +0200
Message-ID: <20230716194959.697793269@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xi Pardee <xi.pardee@intel.com>

[ Upstream commit 416a87c972b978d71ab828442d1d48e3bd194855 ]

commit c5ad454a12c6 ("platform/x86: intel/pmc/core: Add Meteor Lake
support to pmc core driver") was supposed to add support for Meter
Lake P/M and mistakenly added support for Meteor Lake S instead. Meteor
Lake P/M support was added later and MTL-S support needs to be removed
since its currently assigned to the wrong register maps.

Fixes: c5ad454a12c6 ("platform/x86: intel/pmc/core: Add Meteor Lake support to pmc core driver")
Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Link: https://lore.kernel.org/r/20230601004706.871528-1-xi.pardee@intel.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/pmc/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index da6e7206d38b5..b8711330e4112 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1039,7 +1039,6 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        tgl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		adl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	adl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,          mtl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	mtl_core_init),
 	{}
 };
-- 
2.39.2



