Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBA1789FBE
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 16:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjH0OQV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 10:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjH0OQJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 10:16:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C779F11B
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 07:16:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso300436266b.1
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693145765; x=1693750565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wlWrC7UfFWG2JCIunWH3w3kpsU3Nr7X/K4LLgI+Iuc8=;
        b=kxvQtY0DqiCEoXy/M+9kFNbjNCqEw1HH0H8e4GNTqxIsRkv+HS3zUzWpOR4+Kd3hb5
         /pJrBZ/6KfN0EAPUFzHVwMP6TBSvVVsfP2pvEEgoQzJINnpTqe02zX4AZPjroiF+7fRl
         exukGYQo8rGieLnSv6Zkf+8e1z5eun+2+iqozHm0PH/FkJiKy3IKoI/5/7gj+vxMttct
         k0lbHJhqEpRJY8uAcx7adBc30DWzGy0sM8s9PnVTIKyv0rI0dTNae2fmo7VlfFEhp3rJ
         5D1IivdWdCduZShO6fThQ19L1BzuOuKZCqheZiWSoPLAuJnzVdErdYdBm7NknT4iYuXn
         YUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693145765; x=1693750565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlWrC7UfFWG2JCIunWH3w3kpsU3Nr7X/K4LLgI+Iuc8=;
        b=EP/+PPLCNaKCy12zEpX99m6aayREGHDZI/TlA4LTGoIuTb2fa6c4g0zfj0WWeNKwf2
         5+YxVsmacWmdkBCxwR6CqAnlQGhdKINxshTtNZh20fG3oyg9kK3FHXoLuYrSLycbn7qJ
         0aAYEwKTY4XjoA5ZtCVWcOLaThcgMQdpABcH/RF1Cmnd4szNYSpsNxrLCIC3uDBNIQTr
         hBOWSFTFBpuyj+2xwhHU0URoV1tJlB7YPI5vG4ID8sbXxKFMgf1szvJ/RUOuFb3NVXUC
         yxLTOnWwqVFfD5dfBcpsAFEwJALCczi2CCmZ8moSV6plKWnTY4q+F4+ApPKj7FQ+dmuJ
         9oQA==
X-Gm-Message-State: AOJu0YyliTMOHlWEvVOfJmbDVJtjulH8ZWP8wvDddaEiB8QmcczfPaHg
        MKbj1xDJqYt5jMsqeiLHljQ=
X-Google-Smtp-Source: AGHT+IHa8WfG76rLU/5B3c9LrokM1yRQd26ZeIg10jSFxK4WSf3SaiERVMvnlDls7q8mTBbV5PCKgg==
X-Received: by 2002:a17:906:2214:b0:9a1:c659:7c56 with SMTP id s20-20020a170906221400b009a1c6597c56mr10213056ejs.22.1693145765026;
        Sun, 27 Aug 2023 07:16:05 -0700 (PDT)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id qc10-20020a170906d8aa00b0099ce188be7fsm3475106ejb.3.2023.08.27.07.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 07:16:04 -0700 (PDT)
Message-ID: <11c18425-a677-532c-1592-3182cad771e5@gmail.com>
Date:   Sun, 27 Aug 2023 16:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     savicaleksa83@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v6.1] hwmon: (aquacomputer_d5next) Add selective 200ms
 delay after sending ctrl report
To:     Greg KH <greg@kroah.com>
References: <2023081222-chummy-aqueduct-85c2@gregkh>
 <20230824141500.1813549-1-savicaleksa83@gmail.com>
 <c4197112-986d-81f2-53aa-7d53086d5eb2@gmail.com>
 <2023082708-jubilance-subtype-e111@gregkh>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <2023082708-jubilance-subtype-e111@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023-08-27 09:01:32 GMT+02:00, Greg KH wrote:
> On Thu, Aug 24, 2023 at 04:26:10PM +0200, Aleksa Savic wrote:
>> On 2023-08-24 16:15:00 GMT+02:00, Aleksa Savic wrote:
>>> commit 56b930dcd88c2adc261410501c402c790980bdb5 upstream.
>>>
>>> Add a 200ms delay after sending a ctrl report to Quadro,
>>> Octo, D5 Next and Aquaero to give them enough time to
>>> process the request and save the data to memory. Otherwise,
>>> under heavier userspace loads where multiple sysfs entries
>>> are usually set in quick succession, a new ctrl report could
>>> be requested from the device while it's still processing the
>>> previous one and fail with -EPIPE. The delay is only applied
>>> if two ctrl report operations are near each other in time.
>>>
>>> Reported by a user on Github [1] and tested by both of us.
>>>
>>> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82
>>>
>>> Fixes: 752b927951ea ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Octo")
>>> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
>>> ---
>>> This is a backport of the upstream commit to v6.1. No functional
>>> changes, except that Aquaero support first appeared in
>>> v6.3, so that part of the original is not included here.
>>> ---
>>
>> Just noticed that I left in the Aquaero mention in the commit
>> message, sorry for the omission... Do I need to resend?
> 
> Nah, that's fine, we want to keep the changelog identical, I left your
> note in the signed-off-by area explaining it.
> 
> thanks,
> 
> greg k-h

Ah, I see, thanks!

Aleksa
