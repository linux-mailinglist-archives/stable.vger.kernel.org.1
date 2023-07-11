Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2C74F89C
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 22:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjGKUBZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 16:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjGKUBY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 16:01:24 -0400
Received: from out-57.mta1.migadu.com (out-57.mta1.migadu.com [IPv6:2001:41d0:203:375::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0127A1710
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 13:01:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689105681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e2h4ypsBiQOphjGsO3cdI2RjCfYBHTayz+CPJEIH5WE=;
        b=a+aHNmT/WiiOits20IT4rv5ZQt60Or4Nen/DJEKY4oFOXuM6gDrG08MU0uHp/xVNeDG1tc
        DfWqLpkVJBZHXbTDKTd/K62vi0XRsbrmp/VWWCClu09yAErTlqOf0B4uh0UELUS6w98aNl
        eKwYHnuhIvQcHB1NyeF1iHkD4jwO88M=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev
Cc:     Xiang Chen <chenxiang66@hisilicon.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: vgic-v4: Consistently request doorbell irq for blocking vCPU
Date:   Tue, 11 Jul 2023 20:00:47 +0000
Message-ID: <168910562681.2605377.3847832034591317861.b4-ty@linux.dev>
In-Reply-To: <20230710175553.1477762-1-oliver.upton@linux.dev>
References: <20230710175553.1477762-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 10 Jul 2023 17:55:53 +0000, Oliver Upton wrote:
> Xiang reports that VMs occasionally fail to boot on GICv4.1 systems when
> running a preemptible kernel, as it is possible that a vCPU is blocked
> without requesting a doorbell interrupt.
> 
> The issue is that any preemption that occurs between vgic_v4_put() and
> schedule() on the block path will mark the vPE as nonresident and *not*
> request a doorbell irq.
> 
> [...]

Applied to kvmarm/fixes, thanks!

[1/1] KVM: arm64: vgic-v4: Consistently request doorbell irq for blocking vCPU
      https://git.kernel.org/kvmarm/kvmarm/c/d30ea1f31ff5

--
Best,
Oliver
