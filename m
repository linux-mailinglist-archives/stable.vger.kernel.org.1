Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABAB7511B6
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 22:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjGLUMn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 16:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjGLUMm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 16:12:42 -0400
Received: from out-46.mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065901BF7
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 13:12:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689192759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/76dSIGCZPJc1ER3XzczF+UfZspzAoA/3QU7AOycVY=;
        b=SvfANLrhEJ0dR1PzUE/XNZtBrvTtJU+KIi1yXQeRJhmEPW3ybheULBfvRZY9rhtvpRhd79
        ithjOWTU35WOH2L7QgTAXAmIxxlKRdtpQiu5NPIJbvLtUtDAwwvzaVwWaq50ORprEAoWqW
        9zl0PhiSQ4z7T78V5QyO2rGgoKmzsbw=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Reiji Watanabe <reijiw@google.com>,
        James Morse <james.morse@arm.com>, stable@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] KVM: arm64: Correctly handle page aging notifiers for unaligned memslot
Date:   Wed, 12 Jul 2023 20:12:29 +0000
Message-ID: <168919265863.2750527.1463103200517783833.b4-ty@linux.dev>
In-Reply-To: <20230627235405.4069823-1-oliver.upton@linux.dev>
References: <20230627235405.4069823-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 27 Jun 2023 23:54:05 +0000, Oliver Upton wrote:
> Userspace is allowed to select any PAGE_SIZE aligned hva to back guest
> memory. This is even the case with hugepages, although it is a rather
> suboptimal configuration as PTE level mappings are used at stage-2.
> 
> The arm64 page aging handlers have an assumption that the specified
> range is exactly one page/block of memory, which in the aforementioned
> case is not necessarily true. All together this leads to the WARN() in
> kvm_age_gfn() firing.
> 
> [...]

Applied to kvmarm/fixes, with Marc's suggestion to add a comment around the
-EAGAIN path to indicate it is impossible while holding the MMU lock for write.

[1/1] KVM: arm64: Correctly handle page aging notifiers for unaligned memslot
      https://git.kernel.org/kvmarm/kvmarm/c/df6556adf27b

--
Best,
Oliver
