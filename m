Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A4577669A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 19:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjHIRli (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 13:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjHIRlh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 13:41:37 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61799E71;
        Wed,  9 Aug 2023 10:41:37 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1bbafe6fd8fso25355fac.3;
        Wed, 09 Aug 2023 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691602896; x=1692207696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ycbMab7q1HQ8UI9guXQ6JfRQeBQi+U/6NBqVjfVg4XI=;
        b=IvMSxJhOCtdwgRwkslaJNYSn+5JmQuxnezIL91pP4DSC4ISclVOZNLZ18+UOP1q17Y
         5ne3yJM58woh5mw0v7FA6HTV8bQ0sLHU5ALXWZR5efvuNFR2YaqQenmbdN4YXDVcd8//
         3WyddVTTFcIWIjdydjQktBbFaNWmr0hFx+dmvHCaZJ/P+kmp2aM/55EMJmKsnTtvgIQv
         FGEWafwD1HJWENmAWmgEytliTFEcU1fcHj7V0RS6fPb4bSXsfZ9k4i4SKGNw/tB6so4d
         Msegmw0jCNyWPP/8syEeoLVP3Y3/4q16b2mEOG1ybZu2W5P8Rc6ZYEl0zLMSvtxiA3UE
         qcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691602896; x=1692207696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ycbMab7q1HQ8UI9guXQ6JfRQeBQi+U/6NBqVjfVg4XI=;
        b=OtwVyClZx725FuYq4QZctFYO24kUesEEqIMVK8BUyLj8tOKGk4ft1ega3RvwJRpaRQ
         oUmbcecBXAXCz936giNCKXdh4FqnfDsQqdq+cTE02JPfqHDmsp0MBbsiZ2lqNjaW1BwG
         Rog1d2BZlfa8CHeq4Amq+qIRdsav911S9YErK5tre6N16k8L2PUk1DZoa9nETyaw7/j/
         IE3Z8QYXZY0Qy4os2ml30P3FN8QfOxXut5+eq72H6F0jd1cLReHUq/hIlCNhj5f3MU0G
         IUkqpzJV/6kKAXWvjHltSc21PXSPi+S83lejZD+OxcAff7XaVve7nWxJd7fgB4YLn5Vv
         Qd5A==
X-Gm-Message-State: AOJu0Yz2jyjen4SNG+7lXOL+ZFF8S6PEzmJ/uKgvRnaBhoLccq6wXCw5
        XXUOnz7CdsaElzI9dXKqk0M=
X-Google-Smtp-Source: AGHT+IFt2+p7mDezSGWcNMh+gx/zSJPM87d2ieMzJMky3a1LD4i6GdN08URcs54eVfbgy8epCJEp2A==
X-Received: by 2002:a05:6870:d799:b0:187:e563:77b9 with SMTP id bd25-20020a056870d79900b00187e56377b9mr3192034oab.45.1691602896653;
        Wed, 09 Aug 2023 10:41:36 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id g2-20020a9d6202000000b006b753685cc5sm7068299otj.79.2023.08.09.10.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 10:41:36 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <33cd4c70-fcf1-d148-8f8b-66b81cd48d72@lwfinger.net>
Date:   Wed, 9 Aug 2023 12:41:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] bluetooth: Add device 0bda:4853 to device tables
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        stable@vger.kernel.org
References: <20230809010403.24612-1-Larry.Finger@lwfinger.net>
 <ce62fee5-7f67-4cf9-b265-f6e6fdc2c59b@molgen.mpg.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <ce62fee5-7f67-4cf9-b265-f6e6fdc2c59b@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/9/23 00:58, Paul Menzel wrote:
> Dear Larry,
> 
> 
> Thank you for your patch.
> 
> Am 09.08.23 um 03:04 schrieb Larry Finger:
>> This device is part of a Realtek RTW8852BE chip. The device table
>> is as follows:
> 
> […]
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>> ---
>> v2 - fix too long line in description
> 
> You also need to start with a capital letter: Bluetooth.
> 
> Also, I’d be more specific in the commit message summary. Maybe:
> 
> Bluetooth: Flag RTL 0bda:4853 to support wide band speech

No, that one is not better. The intent is to let the device be driven by btrtl, 
not btusb. I changed it to "Bluetooth: Add device 0bda:4853 to blacklist/quirk 
table."

Larry

