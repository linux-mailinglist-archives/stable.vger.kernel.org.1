Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16766760075
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 22:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGXU1v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 16:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjGXU1u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 16:27:50 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A8A188
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 13:27:49 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id O29iqjz3ja8FgO29iqVhmt; Mon, 24 Jul 2023 22:27:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690230467;
        bh=nthQGP0J+y1vqKNylVAArmUha3e+ZlF00r9glbojKIk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RsNt35/4KIA7ba4e7OrZ39DVXWD3bnvV2uk/KYshXfx3EYd6qvgau0SPJq101UmoP
         uHu5IabCj5/NoFlAtVLjD5VfbgNlzlVC6xU1NFJRBGHopistjBWwiCjVuUbOYy3Axx
         Cf6LOIaHG/8f/DSe1AnBPuKv15cepxla+AyPceDP++P6I6g59rHqTeb/y3mvSND7cM
         LaOpmg8G0Ul0m4MWAYIbdfhia88kK2wcai/AYzkogbebbAl/qhHzVHiSSJap1gOyCQ
         gSlNB0+PWmHjUYSG0Beae/KXDuC7s3Wj5s7ZRWoyE1SedpWNlbe2Ry69g5clqs8Ysf
         7p7uN1VKE0rsg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Jul 2023 22:27:47 +0200
X-ME-IP: 86.243.2.178
Message-ID: <6c9a6a72-880b-5ebd-f266-4b574a004fe9@wanadoo.fr>
Date:   Mon, 24 Jul 2023 22:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4.y] i2c: busses: i2c-nomadik: Remove a useless call in
 the remove function
Content-Language: fr, en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>
References: <2023072154-animal-dropkick-6a92@gregkh>
 <62fe6800d41e04a4eb5adfa18a9e1090cbc72256.1688160163.git.christophe.jaillet@wanadoo.fr>
 <2023072303-ranking-wife-05ae@gregkh>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <2023072303-ranking-wife-05ae@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


Le 23/07/2023 à 22:34, Greg KH a écrit :
> On Fri, Jul 21, 2023 at 07:47:41PM +0200, Christophe JAILLET wrote:
>> Since commit 235602146ec9 ("i2c-nomadik: turn the platform driver to an amba
>> driver"), there is no more request_mem_region() call in this driver.
>>
>> So remove the release_mem_region() call from the remove function which is
>> likely a left over.
>>
>> Fixes: 235602146ec9 ("i2c-nomadik: turn the platform driver to an amba driver")
>> Cc: <stable@vger.kernel.org> # v3.6+
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> The patch below that should fix a merge conflict related to commit
>> 9c7174db4cdd1 ("i2c: nomadik: Use devm_clk_get_enabled()") has been
>> HAND MODIFIED.
> I don't understand, that commit is not in the stable trees.  What do you
> mean by "hand modified"?
>
>> I hope it is fine, but is provided as-is. Especially line numbers should be
>> wrong, but 'patch' should be able to deal with it. (sorry if it does not apply)
>>
>> I guess that it should also apply to all previous branches.
>>
>> I've left the commit description as it was. Not sure what to do with A-b and R-b
>> tags.
> Why isn't this needed in Linus's tree?

If *this* is the patch --> see my other reply.


If *this* is the A-b and R-b tags, knowing that it is a *modified 
version* of what they agreed, I'm not sure that the tags are still relevant.
They agreed with the patch in a *given context*. That does not mean that 
an updated patch is still correct in another context and that they still 
agree with it.

That' why I wonder.

CJ


>
> confused,
>
> greg k-h
