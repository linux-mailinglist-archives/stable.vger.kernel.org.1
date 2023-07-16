Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDD7755196
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGPT6J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGPT6I (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:58:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9465E199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:58:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so2437880b3a.0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689537486; x=1692129486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jagK6W3Oq8o4h/qY3DcH94VOC4EH9NpTXk44VjvlGnQ=;
        b=DR6QdxaJaVp0ziX8DImyhwSo3wxUR0BISAkY84DZxE1N6RlBkYGHSGGN5kK91YpX65
         +MqQR6zI9VjZW6UD2Z8KNmHPQGsH+qk9sPXw0Maq0HGCiBHBsCoIowt9I9APi7cdeb2n
         wXAtbPc7mKfIi+/YCongIkQpbq69LcBLEYj3J8DGrzs5XiLGXiH7y7OHEEuy0mxDsP6H
         6mXWPKrZM7FjK4nfNVqACkYcHQVVXZHOFXL2ry88GNxDG2g2tDvNRJCRo56evyRHzkbk
         ain8fgnOORYYxRDfGLb2INNGyr2Ud2+jOgsCNl6a3SC2cNIrzgrK1ZpAzkRuA3B2pypw
         Q0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689537486; x=1692129486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jagK6W3Oq8o4h/qY3DcH94VOC4EH9NpTXk44VjvlGnQ=;
        b=IDqDTGGkX2N917kYs9/lHce0XDylpqgb3DqkRkXrAHB3BlUQ7aNdtZPeWFkfdBJ2iM
         Wh6tBPAyolgWX6CePWAqs6hl5siTTdjx/gzeCdWEf7CD4JQmj2ncwbVsCrYnEsm9Eeos
         kMOmG/NSDf3l0GZUxabbe6IFndhwmKIYrOeFcXnqAY2lC6kj4pwmlI9ifEOSc7vhwsqh
         I5bteAUf8X0N9y3NE1XC5eJf0Nb7NMZvUe3tRvW+LMYhl7sOw/Q40/nwe5DFfCFxfac8
         Jf+g2BmqI6bk2HIxToGvKTWIarGtYSl8tetQ0x3O+fDOKjxVGBDmzHRLhFVjmlk1eCQA
         rqaA==
X-Gm-Message-State: ABy/qLYkAAUGXHnU2e6Ls6LzxG8GPcgynUF7xmBk2WSxb/yRjapu9aqK
        Kg6v7GObZW3EKRvYhoTnmfomlZLlDt8=
X-Google-Smtp-Source: APBJJlHv1pasNJIRYDN1JTIGmDw82XRQAE86npAtUWUref42ofKSKN4q7SAAkz2licFsgoUmDSD06w==
X-Received: by 2002:a05:6a20:a110:b0:132:c73a:88fd with SMTP id q16-20020a056a20a11000b00132c73a88fdmr11460361pzk.48.1689537485922;
        Sun, 16 Jul 2023 12:58:05 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:210:18ff:fe59:7883? ([2001:df0:0:200c:210:18ff:fe59:7883])
        by smtp.gmail.com with ESMTPSA id e26-20020a62aa1a000000b006749c22d079sm10420050pff.167.2023.07.16.12.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 12:58:05 -0700 (PDT)
Message-ID: <48b276d9-13e8-ae60-40ef-3fec2fe495cb@gmail.com>
Date:   Mon, 17 Jul 2023 07:58:00 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.10.y] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     Greg KH <greg@kroah.com>
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <2023071116-umbrella-fog-a65f@gregkh>
 <20230715232820.8735-1-schmitzmic@gmail.com>
 <2023071639-senorita-vigorous-bcd6@gregkh>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <2023071639-senorita-vigorous-bcd6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Thanks Greg!

On 17/07/23 03:21, Greg KH wrote:
> On Sun, Jul 16, 2023 at 11:28:20AM +1200, Michael Schmitz wrote:
>> The Amiga partition parser module uses signed int for partition sector
>> address and count, which will overflow for disks larger than 1 TB.
>>
>> Use u64 as type for sector address and size to allow using disks up to
>> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
>> format allows to specify disk sizes up to 2^128 bytes (though native
>> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
>> u64 overflow carefully to protect against overflowing sector_t.
>>
>> Bail out if sector addresses overflow 32 bits on kernels without LBD
>> support.
>>
>> This bug was reported originally in 2012, and the fix was created by
>> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
>> discussed and reviewed on linux-m68k at that time but never officially
>> submitted (now resubmitted as patch 1 in this series).
>> This patch adds additional error checking and warning messages.
>>
>> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
>> Cc: <stable@vger.kernel.org> # 5.2
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Reviewed-by: Christoph Hellwig <hch@infradead.org>
>> Link: https://lore.kernel.org/r/20230620201725.7020-4-schmitzmic@gmail.com
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> (cherry picked from commit b6f3f28f604ba3de4724ad82bea6adb1300c0b5f)
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>
>> ---
>>
>> Changes since 5.10-stable:
>>
>> - fix merge conflicts
>> ---
> All now queued up, thanks.
>
> greg k-h
Just to clarify: that does include

https://git.kernel.dk/cgit/linux/commit/?h=block-6.5&id=7eb1e47696aa231b1a567846bbe3a1e1befe1854

queued up by Jens, which does not have a stable tag (as per our 
discussion earlier)?

Link: https://lore.kernel.org/r/2023070456-vertigo-fanfare-1a8e@gregkh
Link: https://lore.kernel.org/r/c9bcd3ca-8260-3f29-26d1-0c00e2b098a3@kernel.dk

Cheers,

     Michael


