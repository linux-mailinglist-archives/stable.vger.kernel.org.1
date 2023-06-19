Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E855E735248
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjFSKdK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjFSKdH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66857B3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0472F60B6D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B371C433C0;
        Mon, 19 Jun 2023 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170785;
        bh=YWUI4LhLQsaZku+adHmUfwJvksQC3BFmITBA1sBc9Dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkw/tID/99MKSiYMnb7cyHey3KoT7pzuDbSY2QENE4Uzx160lChs1mJUVm/QHm+zz
         uPAEKF/+gCEf4Igv13TJypxOcw6sWZ7LzgRkanCGwu5cWguWGrrntU+y/phIFtNqWM
         Z7+0TZPW3AAUt35Z08NghvP3LwIeWcIjZq0zzkdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Manuel Lauss <manuel.lauss@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 034/187] MIPS: unhide PATA_PLATFORM
Date:   Mon, 19 Jun 2023 12:27:32 +0200
Message-ID: <20230619102159.294328437@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Manuel Lauss <manuel.lauss@gmail.com>

[ Upstream commit 75b18aac6fa39a1720677970cfcb52ecea1eb44c ]

Alchemy DB1200/DB1300 boards can use the pata_platform driver.
Unhide the config entry in all of MIPS.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e2f3ca73f40d6..5b3f1f1dfd164 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -82,6 +82,7 @@ config MIPS
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
+	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.39.2



