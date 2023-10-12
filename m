Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC3E7C62D0
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 04:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjJLCgy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 22:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjJLCgy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 22:36:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186F4A4
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 19:36:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100F5C433CD;
        Thu, 12 Oct 2023 02:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697078212;
        bh=g5KiW0qunq9HcVtFqYCVKP79dY5DVTJYKJe1r5endNs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VKCrJxUj0vX8xmEBJQgAlzsNBnG4IbLSukEAqAk/trvtaaPqvIiKAuFErBkYDkX93
         JVmdzEjmMM9kyItZOZg/nD28w86ewasl7F2B1D0B1lZLH7H2CjVY4kfdaiLZ+D38gW
         eVnR2jyBmfpCY1IUAE0ZSeWJeiy8lRCUELYcaaeVVm+YSqM6fAd+TtFiz48R8whUVf
         7DX9uPUT4bcg+CqhxsFElCSq3sLEgJ/B3WbWhqccY4oJeHF0LykK4GPKFIoebRHs3O
         kBaT3Lgz+qD8la1oKVeQTT8l4ycfm6wBMIvY52u37o2D7LIoyPrzdv1jc6kKHFetQc
         ZJXJTnElxasJQ==
Message-ID: <23034522-699b-425f-951c-292730a42f30@kernel.org>
Date:   Thu, 12 Oct 2023 11:36:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] ata: libata-scsi: Disable scsi device"
 failed to apply to 6.5-stable tree
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     geert+renesas@glider.be, hare@suse.de, martin.petersen@oracle.com,
        stable@vger.kernel.org
References: <2023100421-numbness-pulsate-f83d@gregkh>
 <b779686d-07e6-50fb-5d94-80ebd5c9b13c@kernel.org>
 <2023100726-puppy-gutter-23af@gregkh>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2023100726-puppy-gutter-23af@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/7/23 20:35, Greg KH wrote:
> On Thu, Oct 05, 2023 at 08:50:27AM +0900, Damien Le Moal wrote:
>> On 10/4/23 23:58, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 6.5-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x aa3998dbeb3abce63653b7f6d4542e7dcd022590
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100421-numbness-pulsate-f83d@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
>>>
>>> Possible dependencies:
>>
>> commit 3cc2ffe5c16dc65dfac354bc5b5bc98d3b397567
> 
> Ok, but that commit does not apply to 6.5.y either :(
> 
> Can you send a working set of backports for 6.5.y if you want to see
> this change there?

Hi Greg,

It looks like all the needed dependencies are now backported and this is the
last fix patch that was needed. I did the above "git send-email ..." to send
you the backport for 6.5.y and did the same for 6.1.y.

Thanks !

> 
> thanks,
> 
> greg k-h

-- 
Damien Le Moal
Western Digital Research

