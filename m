Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124116FA66A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjEHKTY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjEHKTR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:19:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC34B4BBFA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29DF9624B7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C629C433D2;
        Mon,  8 May 2023 10:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541148;
        bh=DNP96yQY9nrGca48dP+ZcL2Xsh1/Dr2ZHyHJfzZ2Gls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZC3DdNgermt0rYEE2ImMCowwZ0wfhJ+Z4PPl620rnPIGu+dV9sOne0ZOTKsMpsiLu
         skRthhSnZxAy+oU3O/YTUfX2BUQrM7qBNZJja4v71XU7JRmB3vx6aQE7BS1dcDldGH
         PYkHT0/nQTI2harL+6DkglMemJTiIzudKiG7sRHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.2 021/663] ASoC: amd: ps: update the acp clock source.
Date:   Mon,  8 May 2023 11:37:27 +0200
Message-Id: <20230508094429.118740522@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

commit a4d432e9132c0b29d857b09ca2ec4c1f455b5948 upstream.

Updating the clock source from ACLK to default clock

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Link: https://lore.kernel.org/r/20230331052102.2211115-1-Syed.SabaKareem@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/amd/ps/pci-ps.c |    2 --
 1 file changed, 2 deletions(-)

--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -91,7 +91,6 @@ static int acp63_init(void __iomem *acp_
 		dev_err(dev, "ACP reset failed\n");
 		return ret;
 	}
-	acp63_writel(0x03, acp_base + ACP_CLKMUX_SEL);
 	acp63_enable_interrupts(acp_base);
 	return 0;
 }
@@ -106,7 +105,6 @@ static int acp63_deinit(void __iomem *ac
 		dev_err(dev, "ACP reset failed\n");
 		return ret;
 	}
-	acp63_writel(0, acp_base + ACP_CLKMUX_SEL);
 	acp63_writel(0, acp_base + ACP_CONTROL);
 	return 0;
 }


