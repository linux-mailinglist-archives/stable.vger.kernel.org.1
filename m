Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C7072E8BE
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 18:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjFMQpC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 12:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFMQpA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 12:45:00 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jun 2023 09:44:58 PDT
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDDE11D
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 09:44:58 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glks-stable4@m.gmane-mx.org>)
        id 1q973h-00011k-Vn
        for stable@vger.kernel.org; Tue, 13 Jun 2023 18:39:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     stable@vger.kernel.org
From:   =?UTF-8?Q?Fran=c3=a7ois_Valenduc?= <francoisvalenduc@gmail.com>
Subject: Re: [PATCH 6.1 000/132] 6.1.34-rc1 review
Date:   Tue, 13 Jun 2023 18:39:49 +0200
Message-ID: <u6a64l$bdg$1@ciao.gmane.io>
References: <20230612101710.279705932@linuxfoundation.org>
 <ZIde9VarEXi/BkzI@duo.ucw.cz> <2023061224-bubble-violator-ef08@gregkh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: fr-FR
In-Reply-To: <2023061224-bubble-violator-ef08@gregkh>
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Le 12/06/23 à 20:13, Greg Kroah-Hartman a écrit :
> On Mon, Jun 12, 2023 at 08:07:49PM +0200, Pavel Machek wrote:
>> Hi!
>>
>>> This is the start of the stable review cycle for the 6.1.34 release.
>>> There are 132 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>
>> I notice that origin/queue/6.1 was not updated. Is that an oversight?
>> It was quite useful to see what is coming.
> 
> I have no idea what creates that branch, sorry, it's nothing that I do
> on my end.
> 
> greg k-h
> 
I also noticed. Only the "review-6..." branches updated when a new 
review round is launched for a new stable release. The queue branches 
are not updated anymore since around 10 days. Previously, the queue 
branches were updated each time the git tree for the patches 
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git) 
was updated.

Best regards,

François Valenduc

