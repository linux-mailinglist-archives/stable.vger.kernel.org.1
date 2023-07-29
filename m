Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6740767D61
	for <lists+stable@lfdr.de>; Sat, 29 Jul 2023 10:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjG2I5L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 29 Jul 2023 04:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG2I5K (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 29 Jul 2023 04:57:10 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986553AAC
        for <stable@vger.kernel.org>; Sat, 29 Jul 2023 01:57:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id E61B060177;
        Sat, 29 Jul 2023 10:56:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690621017; bh=85KRMoSia1kFL9CgpUazecqe3Fp84KqHuyHmK5fAQkQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mU9IUScpLqM+BNAZUWlMI/UowklMKu9236awXHhRivb6HVZfvuq09amhto3Bi4sD7
         T46r7s4b9x8Zl6zqciztrNk3aAqJiz1D0efEaXJNF8kO6FRO8jRhztjCKOZAATvJNV
         pEjjowLEjJGzkIzUiRF2UbSPLSniZR/Ntl9C4gOAYgpVhAMpiS/uT9zJ+jWIZRxtva
         AgUoVT8OhPcwde4e8f0NhFvh1hiYo2b1lihfZVGJkyQFXfK+vIBYFS6ycZpDZWeda6
         h5nZP878XkcRJe+1uerhdLEcDrPE7aKdavTHgkTYxkQVCC44TVD2T+z8MF8kLbbbuu
         xpQicvQMnK1zg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 583_54CXyh-2; Sat, 29 Jul 2023 10:56:55 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 959436015E;
        Sat, 29 Jul 2023 10:56:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690621015; bh=85KRMoSia1kFL9CgpUazecqe3Fp84KqHuyHmK5fAQkQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hTu4gORzxBdntVSIYb1NEJhtZsek1QTvN7SICDGlrtJ+U0fHRWYDgPOGKUAG6y/D0
         pHGBcq+o+RMoYz5xxMNU+UA1DrQSbYDee17qdYoC24OVRYObSlJ3ZbpIplOhNygKNH
         u4PqxglHTmFFzH24xILisVY+JtsD1bt2Z2iq9V1paqroPDB6oVcT7NErUCVoieWH/Z
         6RVD7yTRIpb/O4/DJKoH7cYeN4KFbaY3uRSZUMoG5+1pJ0rjVNJrG2osJyl+q2GqZA
         aYBH75d6tMJH95fX0bgygY6GBTG1QadB1Tku4b9EWGV233O9u5ZdzJl0vH8u6c8p40
         wlRhlVqsiP1dw==
Message-ID: <eae7de61-76bd-738b-883e-200d35875b36@alu.unizg.hr>
Date:   Sat, 29 Jul 2023 10:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v4 1/1] test_firmware: fix some memory leaks and
 racing conditions
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
References: <84fde847-e756-3727-c357-104775ef1c4f@alu.unizg.hr>
 <ZMQd49Qp8EzapxEE@bombadil.infradead.org>
Content-Language: en-US, hr
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZMQd49Qp8EzapxEE@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 28. 07. 2023. 21:58, Luis Chamberlain wrote:
> On Fri, Jul 28, 2023 at 09:48:08PM +0200, Mirsad Todorovac wrote:
>> v3 -> v4
>>  - fix additional memory leaks of the allocated firmware buffers
>>  - fix noticed racing conditions in conformance with the existing code
>>  - make it a single patch
> 
> This is not quite right.
> 
> Your patch commit 48e156023059 ("test_firmware: fix the memory leak of
> the allocated firmware buffer" is already upstream and now you're taking
> that same patch and modifying it?

Hello, Luis,

Yes, you are right, this was the wrong patch. I don't know how I did this
because I wasn't intoxicated nor high. :-/

Now I saw that I started the entire discussion in the wrong thread, and then
assumed that this was the right patch, so it is entirely my fault.

They say that assumption is the mother of all blunders.

> If you have something else you want to fix you can use the latest
> lib/firmware.c refelected on linux-next and send a patch against that
> to augment with more fixes.
> 
> If your goal however, is to make sure these patches end up in v5.4
> (as I think you are trying based on your last email) you first send
> a patch matching exactly what is in the upstream commit for inclusion
> in v5.4. Do not modify the commit unless you are making changes need
> to be made due to backporting, and if you do you specify that at the
> bottommon of the commit after singed offs of before in brackets
> [like this].

I think I intended just that, for the racing condition fix to be applied to the
v5.4 stable tree, too.

> Furthermore, I see you have other fixes other than this one merged
> already on upstream so if you need those for v5.4 you need to send those
> too.

Thanks,

Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

