Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A54670B20D
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 01:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjEUXgF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 21 May 2023 19:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUXgE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 21 May 2023 19:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F7CB3;
        Sun, 21 May 2023 16:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A69160DDC;
        Sun, 21 May 2023 23:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DEAC433D2;
        Sun, 21 May 2023 23:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684712162;
        bh=6nUdXTj1YWB3dC08Dz7To7PYeNpaxsKM7k8BJ+xBhyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SS9u1hEromXAd86hzV3s7TFV5ceqSjrEPOnTaHEWmariNPw+WwZhRJkaE27qbhdyn
         xisjpj2zHV1Ulx+SePxbiKlaoqXinaXwg3fLwprg95aLmBRZ8ndW6CifvRP7I5pOYe
         LLNHfKMJUQDCytS9qpT8hzST1l57VIwxd/AZEqHeeqPkqO/aBv6oCDVnn9ga3/QqLb
         fubaH1sZpCp+cL65sSsA23ZFScQfXCpGY1hdeREsuLdFzoOYGKc9oVvq0N8IOvyBjh
         jl52AsY7Ruh5yoiVNxspk7QOhwCFyDo5i3xm180zBPE2zEUS58aPxtc+heGl56lCZy
         l9Wfxfk3/xFwA==
Date:   Sun, 21 May 2023 19:36:01 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     stable@vger.kernel.org, stable-commits@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: Patch "iommu/arm-smmu: Drop if with an always false condition"
 has been added to the 6.3-stable tree
Message-ID: <ZGqq4apFeKPMgUsd@sashalap>
References: <20230520014938.2798196-1-sashal@kernel.org>
 <20230520144018.h6qqwvnsldawu4kx@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230520144018.h6qqwvnsldawu4kx@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 20, 2023 at 04:40:18PM +0200, Uwe Kleine-König wrote:
>Hello,
>
>On Fri, May 19, 2023 at 09:49:37PM -0400, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     iommu/arm-smmu: Drop if with an always false condition
>>
>> to the 6.3-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      iommu-arm-smmu-drop-if-with-an-always-false-conditio.patch
>> and it can be found in the queue-6.3 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>I'd not add that patch to stable. It's just about dropping an
>
>	if (false) {
>		something();
>	}
>
>The compiler probably isn't able to see that the condition is always
>false, so the only benefit is that the patch makes the compiled code a
>bit smaller.

Dropped, thanks!

-- 
Thanks,
Sasha
