Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2743571A339
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 17:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjFAPvV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 11:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjFAPvN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 11:51:13 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1602BE48
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685634653; x=1717170653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bDZ9oce+Y7C21ZtxhJrwkxF0pGer0nlxgu5Btpe15so=;
  b=n0+c5S+1xQSLwFrJxWDYFoJ1fv6daYCD/ROnyU7Vjb0HuflJE2JizMhW
   PBfw5l5Q054lNG7HSNIzoVvJzdpo74iWUunZ964KINrgQvLL04nBe8a21
   6IYMB/hSQ2zJKDqiwOlvqJMK2ojdXyORblghAqALobNAlQ2T+x0U36bG4
   s=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681171200"; 
   d="scan'208";a="218010189"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 15:50:22 +0000
Received: from EX19MTAUEC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com (Postfix) with ESMTPS id 51E4B413AF;
        Thu,  1 Jun 2023 15:50:21 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 15:50:20 +0000
Received: from [192.168.209.155] (10.106.239.22) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 15:50:19 +0000
Message-ID: <d2b14172-7aeb-be98-ded2-b4ce255dccaf@amazon.com>
Date:   Thu, 1 Jun 2023 11:50:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Possible build time regression affecting stable kernels
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
CC:     <sashal@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <CAHC9VhTmKbQFx-7UtZgg8D+-vtFOar0dMqULYccWQ2x7zJqT-Q@mail.gmail.com>
 <bb1e18f8-9d31-1ec7-d69a-2d1f5af31310@amazon.com>
 <CAHC9VhTFzN_Y_7HBroJnbTHL2NZEYjFy9BB3JJJBKnwv_k25dw@mail.gmail.com>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <CAHC9VhTFzN_Y_7HBroJnbTHL2NZEYjFy9BB3JJJBKnwv_k25dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.239.22]
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023-06-01 11:45, Paul Moore wrote:

> 
> 
> 
> On Thu, Jun 1, 2023 at 11:03 AM Luiz Capitulino <luizcap@amazon.com> wrote:
>> On 2023-06-01 10:27, Paul Moore wrote:
>>> On Wed, May 31, 2023 at 10:13 PM Luiz Capitulino <luizcap@amazon.com> wrote:
>>>>
>>>> Hi Paul,
>>>>
>>>> A number of stable kernels recently backported this upstream commit:
>>>>
>>>> """
>>>> commit 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5
>>>> Author: Paul Moore <paul@paul-moore.com>
>>>> Date:   Wed Apr 12 13:29:11 2023 -0400
>>>>
>>>>        selinux: ensure av_permissions.h is built when needed
>>>> """
>>>>
>>>> We're seeing a build issue with this commit where the "crash" tool will fail
>>>> to start, it complains that the vmlinux image and /proc/version don't match.
>>>>
>>>> A minimum reproducer would be having "make" version before 4.3 and building
>>>> the kernel with:
>>>>
>>>> $ make bzImages
>>>> $ make modules
>>>
>>> ...
>>>
>>>> This only happens with commit 4ce1f694eb5 applied and older "make", in my case I
>>>> have "make" version 3.82.
>>>>
>>>> If I revert 4ce1f694eb5 or use "make" version 4.3 I get identical strings (except
>>>> for the "Linux version" part):
>>>
>>> Thanks Luiz, this is a fun one :/
>>
>> It was a fun to debug TBH :-)
>>
>>> Based on a quick search, it looks like the grouped target may be the
>>> cause, especially for older (pre-4.3) versions of make.  Looking
>>> through the rest of the kernel I don't see any other grouped targets,
>>> and in fact the top level Makefile even mentions holding off on using
>>> grouped targets until make v4.3 is common/required.
>>
>> Exactly.
>>
>>> I don't have an older userspace immediately available, would you mind
>>> trying the fix/patch below to see if it resolves the problem on your
>>> system?  It's a cut-n-paste so the patch may not apply directly, but
>>> it basically just removes the '&' from the make rule, turning it into
>>> an old-fashioned non-grouped target.
>>
>> I tried the attached patch on top of latest Linus tree (ac2263b588dffd),
>> but unfortunately I got the same issue which is puzzling. Reverting
>> 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5 does solve the issue though.
> 
> I'm at a bit of a loss here ... the only thing that seems to jump out
> is that the genheaders tool is run twice without the grouped target
> approach, but with both runs happening at the same point in the build
> and the second run updating both header files, I'm a bit at a loss as
> to why this would be problematic.
> 
> I don't want to block on fixing the kernel build while I keep chasing
> some esoteric build behavior so I'm just going to revert the patch
> with a note to revisit this when we require make >= 4.3.
> 
> Regardless, thanks for the report and the help testing, expect a
> patch/revert shortly ...

Thank you Paul, I really appreciate your fast response. I'd also
appreciate if you CC me in the revert patch so that I don't loose
track of it.

- Luiz
