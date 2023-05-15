Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709AD7034F3
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243139AbjEOQy0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243098AbjEOQyJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE0B525C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8DF5629BD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E3AC433D2;
        Mon, 15 May 2023 16:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169618;
        bh=PTot+W/82ohb9dl444QtQDd2IeXf7RQWMqbCbZ0yFck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bB2HOeDs8rtT0cMl1eX9zXcd8NEGMq/714/v+Z/lYqftqLvGpilWlsGYRkzb7NSnO
         FVPxs0Du7LwNrjv81Lc3KazxYJiFJA12CnLOeJ4TtqBZgrdxVRn8R4wlftmlXAJs7o
         7irreRB/e05tp379ANTrGV60D9XAACb7M/bECj2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 088/246] dt-bindings: perf: riscv,pmu: fix property dependencies
Date:   Mon, 15 May 2023 18:25:00 +0200
Message-Id: <20230515161725.222432129@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

[ Upstream commit 4d276e4d3bb4a503e75086faab54f92c0a8fd368 ]

Seemingly I mis-implemented the dependencies here. The OpenSBI docs only
point out that the "riscv,event-to-mhpmcounters property is mandatory if
riscv,event-to-mhpmevent is present". It never claims that
riscv,event-to-mhpmcounters requires riscv,event-to-mhpmevent.

Drop the dependency of riscv,event-to-mhpmcounters on
riscv,event-to-mhpmevent.

Fixes: 7e38085d9c59 ("dt-bindings: riscv: add SBI PMU event mappings")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Link: https://lore.kernel.org/r/20230404-tractor-confusing-8852e552539a@spud
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/perf/riscv,pmu.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
index a55a4d047d3fd..c8448de2f2a07 100644
--- a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
+++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
@@ -91,7 +91,6 @@ properties:
 
 dependencies:
   "riscv,event-to-mhpmevent": [ "riscv,event-to-mhpmcounters" ]
-  "riscv,event-to-mhpmcounters": [ "riscv,event-to-mhpmevent" ]
 
 required:
   - compatible
-- 
2.39.2



