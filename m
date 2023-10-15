Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CE37C9888
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 12:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjJOKD2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 06:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjJOKD1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 06:03:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E404D9;
        Sun, 15 Oct 2023 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697364199;
        bh=Xywli/LLxATt1O56BUYkhx2IGYH2bax1grDbXN8Buis=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sDuOhglIKCdliRZ0/i8KqEi7rn3qNl+rXH6Mp2V9SMyf4iBHENwSIq1yvPlM1JVqK
         DIg/BAChEgmcGyuPmeD8N8zWcT7CIP/wOVZg/DNy/LzgxfcY7h7Gm/0F+as8NWSzsq
         pqHfvQWeEEt6Gc+HC6WxCCdiVd+3P5ayvIRf2SOZOi7qzWziVyV7o6CNMKaGY+dG6w
         mp1y8EIF3SKVdqN2pCsKB2x8IW/MxY5ho4XbO2uK7indpFxsQKrvKsbPsSxpYBGPlL
         ps0oGYQ3nHY9Y1vBDXtgY5FOOLRlMH6M8PLfXUfNCNJbc037yfzLPGqZoV3Y0ECKuP
         6kKd0P2wkNjTA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7bRC4lP5z4wcZ;
        Sun, 15 Oct 2023 21:03:19 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.ibm.com,
        stable@vger.kernel.org, Naveen N Rao <naveen@kernel.org>
In-Reply-To: <20230929172337.7906-1-atrajeev@linux.vnet.ibm.com>
References: <20230929172337.7906-1-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/platforms/pseries: Fix STK_PARAM access in the hcall tracing code
Message-Id: <169736402374.957740.1615846713594615509.b4-ty@ellerman.id.au>
Date:   Sun, 15 Oct 2023 21:00:23 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 29 Sep 2023 22:53:36 +0530, Athira Rajeev wrote:
> In powerpc pseries system, below behaviour is observed while
> enabling tracing on hcall:
> 	# cd /sys/kernel/debug/tracing/
> 	# cat events/powerpc/hcall_exit/enable
> 	0
> 	# echo 1 > events/powerpc/hcall_exit/enable
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/platforms/pseries: Fix STK_PARAM access in the hcall tracing code
      https://git.kernel.org/powerpc/c/3b678768c0458e6d8d45fadf61423e44effed4cb
[2/2] powerpc/platforms/pseries: Remove unused r0 in the hcall tracing code
      https://git.kernel.org/powerpc/c/dfb5f8cbd5992d5769edfd3e059fad9e0b8bdafb

cheers
