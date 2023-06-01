Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0E971A21C
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 17:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjFAPM1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 11:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjFAPMY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 11:12:24 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643641B3
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 08:12:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77479a531abso8650539f.1
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685632323; x=1688224323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RsYXXGDyqBZCWJC5E3tRN6Rs8Hr9gCvKGJf7AlzG4dg=;
        b=KtqxDH80Vo9nP2JpaBA8/3Pj3xnFCfKCYvtyNWyNDXwPboQ2W/uCevlX0L3KUzMIEo
         AH7OgDTb39OSNjQBVv7FJKbAPcB3RTOSnw81mXJm2FJkZU12o7idtdCxQ/M/3Tj1S5MS
         RDdhKxqs/2ZVr+ELQyPEbcdALerYYgpGAuFdvstE9+s/C6Z5UxfkIrTCJNwXWy5bEpAR
         PFsO0ftSRXkWAOyaw2d6LBuaIlZBORmW1/wvnfYfjhFjUjmZ1JKqEWPZbevCz9x26ni/
         ENFcJhbFmeBSosbPgNqPT9jM2gjOk7b9DP+RbLEtuyn6XqvLhBw23EtHQPFEFhE+Aama
         mE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632323; x=1688224323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsYXXGDyqBZCWJC5E3tRN6Rs8Hr9gCvKGJf7AlzG4dg=;
        b=ZAA1n1i7HVrhn04mmBY51wT4rHMT8o5C2BOL3guFHp5vGItaHn8dui/jucUTQWvvbi
         eUdY+ZXa+ubsiAzzWcs7xB5bW7RSvLMRbOFDqOAlZ2/pFKXb4nyQDtwGyAGS/xTZgrT5
         VNkUNWgDM8nTbsYVEa6TDTwbGTLOA99yYVby5FKU53JLlMr3skGY+3SXBMaL9lqiXuaN
         9gz2Eyr2Du0htvCCHPrx8/mS+kBIX72mYCFjgfL4JmgoJYPl0kLUfRoMTuK+nZSr0Yy+
         9z1mWn0whgS+o5QFfK6EMjq1cA+QG2mDFFzv/YdcF22ytY89kFcv044x8LW8JL/21GsQ
         qaLA==
X-Gm-Message-State: AC+VfDx7wso5GZKQM0hleU4ojCWZ3q7PAk2xGaIiNUHZCg2pj/6Jcjx7
        2A2QGN3kXLpczvZzc4rHGl6Mk6Kvd3duOP6yevg=
X-Google-Smtp-Source: ACHHUZ7IJudNJSnQPcEXFrV29G89BOj3+hF+YiHXvwpSwDPdY7m5sOSeF9mcBC65tA7hf9Z2dGWyhg==
X-Received: by 2002:a6b:5a0a:0:b0:774:931e:c20c with SMTP id o10-20020a6b5a0a000000b00774931ec20cmr3917230iob.1.1685632323395;
        Thu, 01 Jun 2023 08:12:03 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n34-20020a027122000000b00411a1373aa5sm2172706jac.155.2023.06.01.08.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:11:56 -0700 (PDT)
Message-ID: <76598d1c-f1df-6d8f-dee9-83f2a0510b1c@kernel.dk>
Date:   Thu, 1 Jun 2023 09:11:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: 5.4-stable patches
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>
References: <6a5172c0-de90-d582-baae-37b8c4de1d91@kernel.dk>
 <2023060121-activity-phoniness-3113@gregkh>
 <20230601134453.GE449117@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230601134453.GE449117@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 6/1/23 7:44 AM, Lee Jones wrote:
> On Thu, 01 Jun 2023, Greg Kroah-Hartman wrote:
> 
>> On Wed, May 31, 2023 at 10:00:39AM -0600, Jens Axboe wrote:
>>> Hi,
>>>
>>> Greg, can you include these in the 5.4-stable batch for the next
>>> release? Lee reported and issue that really ended up being two
>>> separate bugs, I fixed these last week and Lee has tested them
>>> as good. No real upstream commits exists for these, as we fixed
>>> them separately with refactoring and cleanup of this code.
>>
>> All now queued up, thanks.
> 
> Super job!  Thanks for this Jens.

Thanks for reporting and testing!

-- 
Jens Axboe


