Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB4F767EB9
	for <lists+stable@lfdr.de>; Sat, 29 Jul 2023 13:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjG2Lb2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 29 Jul 2023 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjG2Lb1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 29 Jul 2023 07:31:27 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DFB180
        for <stable@vger.kernel.org>; Sat, 29 Jul 2023 04:31:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A2CDE60177;
        Sat, 29 Jul 2023 13:31:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690630283; bh=CbT/t2+5t9E5u4xmnlAQy29k4RIz+zzbDTG+w6/9/48=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k7tmA+mEbDnMJmviLKL/o48qm7qEiiFmyxUzQKmWn8TGyXpnsAKSBysMRnlGlBsxp
         y+I0ZPZgNHtGzLzHj1dkg4HRgokaClJCJ4tRwaNJu0Gph8QVpHUAxfe/rzUxQVLbwd
         Jbz0nW6xEttGW8CUEfbli8LlFjI+bKu4WKL8H6WCJdqqP8UUwjy2Gjn2gUoEWvbIUI
         eV3dbh33qorlu6lmBhmZDRzkJIrgnoPrCuXCxUVVj7koO+WqpGgzj1zh6Omtg+RgE4
         c+Clj6coBhbvQrBRQ0rz86BqroVTFKskjgZVrtV03PrurzlphPPV++0YlN5f8/QvMl
         jf7NHaYiXHzgQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zAXzJyNNXAuo; Sat, 29 Jul 2023 13:31:21 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 0FC9C6015E;
        Sat, 29 Jul 2023 13:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690630281; bh=CbT/t2+5t9E5u4xmnlAQy29k4RIz+zzbDTG+w6/9/48=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FycrNL1TiN1unp/MlEaziROzo11RfCO1hzBbccnhdxLbeI8TN1ruSSWhVSIGiHVvV
         abX59AWcUeKREwK+LHi6S7/0wEgcLVc/0tkC8w6NW0bpNCf721dRWUf+0HC6QqL8Oa
         7iAZHUFL4RVBo8IICUKfaAU9OBKI4B678lvmtbWH9ivis0eR4D1TpHcjQsaxQlM9B1
         QyWZIxWFH+P7vopbRiBPm8DPUs2uHSigv39BptC1d6yo4JDZiHnvTaKvvdbXSEYwnA
         qOyS1Cr3PJw2Jeqxz0q1PvuW1ktI+08dSpfkSTABgQ7BEpUgIMdgBGB2DGtFAzHAv0
         swDZsHbPt7S2Q==
Message-ID: <bf2c8919-a735-f051-f0d5-506540564565@alu.unizg.hr>
Date:   Sat, 29 Jul 2023 13:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v4 1/1] test_firmware: fix some memory leaks and
 racing conditions
Content-Language: en-US, hr
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
References: <84fde847-e756-3727-c357-104775ef1c4f@alu.unizg.hr>
 <ZMQd49Qp8EzapxEE@bombadil.infradead.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZMQd49Qp8EzapxEE@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
> 
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
> 
> Furthermore, I see you have other fixes other than this one merged
> already on upstream so if you need those for v5.4 you need to send those
> too.
> 
>   Luis

I've realised what happened: this was the latest version from the old batch,
before I was advised to split the patch into three independent fixes, each one
dealing with one problem. 8-)

Still it is obscure to me how I picked this old thread?

Sorry for your lost time, and I will try hard to learn from my mistake.

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

