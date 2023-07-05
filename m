Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481F5749012
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 23:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjGEVo3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 17:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEVo2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 17:44:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2537619BD
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 14:44:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b898cfa6a1so5252735ad.1
        for <stable@vger.kernel.org>; Wed, 05 Jul 2023 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688593464; x=1691185464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLeN5byw/2yTM2aTSNa6jricbe3xA/mbs2Hdqzc0fus=;
        b=Q5P8vVNbURZv8h8VFQLrk0JlDn32UnhsyhHsQax6ycxk34f0gPJdTXdemPBVAx6ix5
         XVQR1gXDISQXpdfjtIGYgNJqA2c40jk+l2jXI5/BSu3Ew5B/DXLTFHpzxm7+kkHuvTqf
         ntYA8PTJzjSrxX+LR2lriqCwq3mxOr/THbQ54Mlh/VtxmI3jc/8rZis9yRj4dZ4oXPz1
         91ivESAKqd3EdleiFskF5YQv6rRj4CurAUZiF1kmnIO9CVkSJLOxr/oVutb6cYvT49VI
         KSW9rXfNdZaYSecXSvRpxtCmZ/kH6y6VZh2dyscY1DuKBREcshlsuXoieE/zYy69cwQe
         75VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688593464; x=1691185464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLeN5byw/2yTM2aTSNa6jricbe3xA/mbs2Hdqzc0fus=;
        b=GEnDe8Zys26H3GOPmFGazj8194sivdcQ15dOkQVRfQI9DJ5GlJxRJkZnFMPvcJGf5j
         QVxsKS1QVq5/Kj8xKzdhsDNtkL2X/Bvz78ACqr+3Ats4Ak6y4K6t3Ko/d/i38xk4rh4m
         YGURApEjxIzM95KRLKKypoMsFQfFPbR+24ka/Awx0dyv3ciwaZUGqZVcokwuw4kIbXk7
         8Vb/M6kQmuL2r3ePX+7Wm7NW1EvmefClGiOLb4Uk5vxinlbsL26u6zJJBmG1DpBx1joi
         MVd6UmicbzjsuEsBD6zKd2B4HL4kh/yH92KfDIn39zM24mcuammtuhf3SLsevsbatbwQ
         jnFg==
X-Gm-Message-State: ABy/qLb2Fx7JBexf/gqho8HIVbq4yn/YKFAWSnptIM19NXahIJTcITvG
        Tzz7OeKFKQn7B50CXy/OPHpB/Q==
X-Google-Smtp-Source: APBJJlE59gel2YEUqbYIdSol53yTFV2xlITWpqvUVCUNsRt8bO/3zMPOP64yxkRiBJ2TfzBqRXo4KA==
X-Received: by 2002:a17:902:f68c:b0:1b8:17e8:547e with SMTP id l12-20020a170902f68c00b001b817e8547emr282949plg.1.1688593464624;
        Wed, 05 Jul 2023 14:44:24 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b001b89b1b99fasm5619084plb.243.2023.07.05.14.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 14:44:23 -0700 (PDT)
Message-ID: <f61ba21f-a8a0-756c-2a41-b831a0302395@kernel.dk>
Date:   Wed, 5 Jul 2023 15:44:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check
 patch
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>, linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <20230704233808.25166-1-schmitzmic@gmail.com>
 <20230704233808.25166-2-schmitzmic@gmail.com>
 <a84267a2-e353-4401-87d0-e9fdcf4c81a0@kernel.dk>
 <6411e623-8928-3b83-4482-6c1d1b5b2407@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6411e623-8928-3b83-4482-6c1d1b5b2407@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/5/23 3:41?PM, Michael Schmitz wrote:
> Hi Jens,
> 
> On 6/07/23 08:42, Jens Axboe wrote:
>> On 7/4/23 5:38?PM, Michael Schmitz wrote:
>>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>>> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
>>> Cc: <stable@vger.kernel.org> # 5.2
>> This is confusing - it's being marked for stable, but also labeled as
>> fixing a commit that isn't even a release yet?
> 
> True - but as you had pointed out, the commit this fixes is set in
> stone. How do we ensure this bugfix is picked up as well when the
> other patches are backported? Does that  happen automatically, or do I
> need to add a Link: tag to the patch being fixed?

This:

Cc: <stable@vger.kernel.org> # 5.2

should be enough for it to go into stable from 5.2 and onwards.

> (Greg didn't seem to object to the Fixes: as such, just to the
> incorrect version prereq)

I think it's really confusing... A patch should only have a Fixes tag if
it's fixing a specific bug in that patch. Either it is, in which case
you would not need Cc stable at all since it's only in 6.5-rc, or it
isn't and you should just have the stable tag with 5.2+ as you already
have.

I'll apply this and remove the Fixes line, and the message id thing
too.

-- 
Jens Axboe

