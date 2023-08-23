Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E4785F2C
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 20:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbjHWSFr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 14:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjHWSFk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 14:05:40 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D2DDE9
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 11:05:39 -0700 (PDT)
Received: from [172.27.136.131] (c-76-104-178-148.hsd1.wa.comcast.net [76.104.178.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id CD92D2126CCC;
        Wed, 23 Aug 2023 11:05:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD92D2126CCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692813938;
        bh=Bsj7/Kgh08UGW05zRxyTKLPaRtGyz2RnR0zc8XAk0rA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g2uNgCXHcTiNMAFYZbdDgLclre0HamvbcYX45IOQlOG0xJ3FkEkhxyTdpJ/rX6gdT
         06Jr7AQC8r90fgJFv5+HRjqUSCnHaOwq0r55qO63Lzwj+296YTeDUyX1Ug9mO/9aWF
         gQnR6aXBM9NHpvrIhqL8aYygMYiStKI2n8o+sfcs=
Message-ID: <20d49c8d-f99e-248a-2122-8a5877de5171@linux.microsoft.com>
Date:   Wed, 23 Aug 2023 11:05:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 0/2] Fixup IOMMU list in MAINTAINERS
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
References: <20230823175706.2739729-1-eahariha@linux.microsoft.com>
 <2023082353-renderer-hypocrite-5935@gregkh>
Content-Language: en-US
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <2023082353-renderer-hypocrite-5935@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/23/23 11:01, Greg KH wrote:
> On Wed, Aug 23, 2023 at 05:57:04PM +0000, Easwar Hariharan wrote:
>> The IOMMU list has moved and emails to the old list bounce. Bring stable
>> in alignment with mainline.
>>
>> Joerg Roedel (1):
>>    MAINTAINERS: Remove iommu@lists.linux-foundation.org
> 
> Who uses MAINTAINERS for submitting new patches?  No one should,
> otherwise we would be syncing these types of changes backwards all the
> time :(
> 
> So why is this needed?
> 
> confused,
> 
> greg k-h

I did, here[0] with cc-cmd=scripts/get_maintainer.pl. :) I'll keep the 
fact that I'm not supposed to in mind for the future. :)

Thanks,
Easwar


[0]: 
https://lore.kernel.org/stable/20230802170227.1590187-1-eahariha@linux.microsoft.com/T/#t
