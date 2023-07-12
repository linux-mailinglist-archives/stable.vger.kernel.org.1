Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469AC7511B9
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjGLUOl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLUOk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 16:14:40 -0400
Received: from out-3.mta1.migadu.com (out-3.mta1.migadu.com [95.215.58.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97871BF7
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 13:14:39 -0700 (PDT)
Date:   Wed, 12 Jul 2023 20:14:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689192877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HicFuXZ+TFJew/uDO2ovyYUA1NOwa0rshkpJ4NgZ5FI=;
        b=vSENsTxjZG+wLXanCSGVxCizJomoYL8l4CqqgwoxdhwhwO5q+PqffDK+y7nem+K8Vks1kU
        M0VO+Njo3B2aacz/CEcxZKo9of1hjwQKYhnI0Rz5mkQzxL9UQTbB41O7TfqacTR76MH0Y6
        Eao/1lCYLPLPILO4ElMCO4tAOntKZeU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        stable@vger.kernel.org, Xiang Chen <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] KVM: arm64: vgic-v4: Consistently request doorbell irq
 for blocking vCPU
Message-ID: <ZK8JqbLrwWE6sFSe@linux.dev>
References: <20230710175553.1477762-1-oliver.upton@linux.dev>
 <86jzv6x66q.wl-maz@kernel.org>
 <ZK0EPhvLzhaFepGk@linux.dev>
 <14acf0fd-e5eb-8a14-986a-b8fe4a44cec9@huawei.com>
 <86zg41utno.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86zg41utno.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 12, 2023 at 02:49:15PM +0100, Marc Zyngier wrote:
> > Given that making VPE resident on the vcpu block path (i.e., in
> > kvm_vcpu_halt()) makes little sense (right?) and leads to this sort of
> > problem, a crude idea is that we can probably keep track of the
> > "nested" vgic_v4_{put,load} calls (instead of a single vpe->resident
> > flag) and keep VPE *not resident* on the whole block path (like what we
> > had before commit 8e01d9a396e6). And we then rely on
> > kvm_vcpu_wfi/vgic_v4_load to actually schedule the VPE on...
> 
> I'm not sure about the nested tracking part, but it's easy enough to
> have a vcpu flag indicating that we're in WFI. So an *alternative* to
> the current fix would be something like this:

Yeah, I like your approach better. I've gone ahead and backed out my
change and can take this instead once someone tests it out :)

-- 
Thanks,
Oliver
