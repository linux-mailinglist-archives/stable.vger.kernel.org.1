Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4513F70D416
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 08:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjEWGjP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 02:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEWGjP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 02:39:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CFA119
        for <stable@vger.kernel.org>; Mon, 22 May 2023 23:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5598B62F4C
        for <stable@vger.kernel.org>; Tue, 23 May 2023 06:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0D0C4339B;
        Tue, 23 May 2023 06:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684823952;
        bh=+aoUBLQaID9SRd2cfG7UgwPIy2tjIE0h5BBcMKb+z5I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rveZkGRQo8jxFm3CmRHP4V7PqCJRwjYzAWLcDpX9mhcyeBNSkAiElGwXtu7iKf7ZD
         w1J5F5nehw0d8Y1SFyAgbkPiikQxJQq37cKPdrUqV6k7TG1aCAglH3zc8rkwIxd6F5
         MdIQ93bza9BNiruFtI3pUD1SSUSxtz0UtrVZp7NAFRuBImz0sDyfUOkqR0CRLZ55Ir
         m+9m1FKwyPtlHcRsQ5MwIDSArxGXrIh4UfOMdHcvZtUo4MM2pHXSnDY23anpgVgnaO
         RRjUbvwnjkI26pfumZ4LmAIXajBre7le67Ad636FKSEzJ391UNW7mucgM17FMbQyRI
         vOuXFjxePDJFA==
Message-ID: <b13f7dc6-5fa0-f87f-a8f8-4402404f9c6e@kernel.org>
Date:   Tue, 23 May 2023 15:39:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: FAILED: patch "[PATCH] dt-bindings: ata: ahci-ceva: Cover all 4
 iommus entries" failed to apply to 5.15-stable tree
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, gregkh@linuxfoundation.org,
        krzysztof.kozlowski@linaro.org
Cc:     stable@vger.kernel.org
References: <2023052249-duplex-pampered-89cb@gregkh>
 <5450bd82-6a2a-7147-1b99-8c0e1efc724f@kernel.org>
 <19e04104-0ff3-c33a-3649-0b6f1f32c2c9@amd.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <19e04104-0ff3-c33a-3649-0b6f1f32c2c9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 5/23/23 15:19, Michal Simek wrote:
> 
> 
> On 5/23/23 04:25, Damien Le Moal wrote:
>> On 5/23/23 02:58, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 5.15-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x a7844528722619d2f97740ae5ec747afff18c4be
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052249-duplex-pampered-89cb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
>>>
>>> Possible dependencies:
>>>
>>> a78445287226 ("dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries")
>>> f2fb1b50fbac ("dt-bindings: ata: ahci-ceva: convert to yaml")
>>
>> Mikal,
>>
>> Do you need this patch added to 5.15 stable as well ? If yes, then please send a
>> backport. I think the issue is that the bindings file in 5.15 is not yaml format.
> 
> I am fine with not going to 5.15 and earlier.

Thanks.

-- 
Damien Le Moal
Western Digital Research

