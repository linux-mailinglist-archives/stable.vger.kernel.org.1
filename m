Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4625B7BB9CE
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjJFNwt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 09:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjJFNwt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 09:52:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D983
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 06:52:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB006C433C8;
        Fri,  6 Oct 2023 13:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696600367;
        bh=g1U6JuLSykZRx0MAh7S+nWODKeyFFZX+BjXAb8Ciw0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k6OQnkJ0x/MKE25TsgRMkvr0IYB+JRvWrxqorD4EuvBvR4YW3jE4eMsTwjvXLOJC0
         msvpwy3wSWrJ3D9TrqgeGjE2Nh4fGss0HkeXOK2LoJ/f1FgUotN3a5jSpv3XJjy+g7
         Bi8LnNMP8lNOyZ5x5FP4A2xvdvfTi5IAHTj3IVWh8e8huvV8Ry0gE1/PoFS8ucTP/I
         a0W6Kx5mghPP2VL2KYL564j5ls2e4J1JknSZxNarDxjyIUzlB97Cxup6bY2XD1H6PK
         8mMZLiBtwlv60OSummm4LZEW4XtZDBAIaH6yz6Nh6Hn4EJf5IlmtAXym3/X9Nxabd0
         pSqSULXDAzZRw==
Date:   Fri, 6 Oct 2023 09:52:46 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Easwar Hariharan <eahariha@linux.microsoft.com>
Cc:     stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Rui Zhu <zhurui3@huawei.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6.5] iommu/arm-smmu-v3: Avoid constructing invalid range
 commands
Message-ID: <ZSARLoAx_mPkrG8f@sashalap>
References: <20231005193425.656925-1-eahariha@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231005193425.656925-1-eahariha@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 05, 2023 at 07:34:25PM +0000, Easwar Hariharan wrote:
>From: Robin Murphy <robin.murphy@arm.com>
>
>commit eb6c97647be227822c7ce23655482b05e348fba5 upstream
>
>Although io-pgtable's non-leaf invalidations are always for full tables,
>I missed that SVA also uses non-leaf invalidations, while being at the
>mercy of whatever range the MMU notifier throws at it. This means it
>definitely wants the previous TTL fix as well, since it also doesn't
>know exactly which leaf level(s) may need invalidating, but it can also
>give us less-aligned ranges wherein certain corners may lead to building
>an invalid command where TTL, Num and Scale are all 0. It should be fine
>to handle this by over-invalidating an extra page, since falling back to
>a non-range command opens up a whole can of errata-flavoured worms.
>
>Fixes: 6833b8f2e199 ("iommu/arm-smmu-v3: Set TTL invalidation hint better")
>Reported-by: Rui Zhu <zhurui3@huawei.com>
>Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>Link: https://lore.kernel.org/r/b99cfe71af2bd93a8a2930f20967fb2a4f7748dd.1694432734.git.robin.murphy@arm.com
>Signed-off-by: Will Deacon <will@kernel.org>
>Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Queued this and the ones for older kernels. In general, if it's just a
cherrypick, please just list commit ids as it makes our lives much
easier :)

-- 
Thanks,
Sasha
