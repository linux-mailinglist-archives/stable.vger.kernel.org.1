Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A526B719FBD
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 16:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjFAOW3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 10:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjFAOWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 10:22:16 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B5518C
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685629333; x=1717165333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mlto/nhRnFArgtR/xc+9SU0nbndJcIGFxh/IhSr7LuM=;
  b=QFIYpiiph8CiLJSiEcHKfu8yzaYDnk6gg1Qq4guINzN2cXKobc5WDeRr
   uy8M80cbksJQNIdhfEHjqgtzEF26i9/psqKDpK5+2KUH0qdXF6lFSg0m+
   wB7P+XIW1CblqdY7/FMI8xkdx5ui21ZFVEihYMWIfSmMTJTKmd35HudpA
   E=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681171200"; 
   d="scan'208";a="335817699"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:22:07 +0000
Received: from EX19MTAUEA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id EFDB48563D;
        Thu,  1 Jun 2023 14:22:05 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 14:22:05 +0000
Received: from [192.168.209.155] (10.106.239.22) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 14:22:04 +0000
Message-ID: <5ddde717-9026-db02-c870-a5a4db304ac4@amazon.com>
Date:   Thu, 1 Jun 2023 10:22:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Possible build time regression affecting stable kernels
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <paul@paul-moore.com>, <sashal@kernel.org>,
        <stable@vger.kernel.org>
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <2023060156-precision-prorate-ce46@gregkh>
 <20259cf7-d50d-4eca-482b-3a89cc94df7b@amazon.com>
 <2023060148-levers-freight-5b11@gregkh>
 <71ab9b4b-ef82-10d0-e97b-b870c3bd85f1@amazon.com>
 <2023060106-malformed-unwoven-3106@gregkh>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <2023060106-malformed-unwoven-3106@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.106.239.22]
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
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



On 2023-06-01 10:13, Greg KH wrote:

> 
> 
> 
> On Thu, Jun 01, 2023 at 09:26:30AM -0400, Luiz Capitulino wrote:
>>
>>
>> On 2023-06-01 09:20, Greg KH wrote:
>>
>>>
>>>
>>>
>>> On Thu, Jun 01, 2023 at 09:13:21AM -0400, Luiz Capitulino wrote:
>>>>
>>>>
>>>> On 2023-06-01 02:06, Greg KH wrote:
>>>>
>>>>>
>>>>>
>>>>>
>>>>> On Wed, May 31, 2023 at 10:12:40PM -0400, Luiz Capitulino wrote:
>>>>>> Hi Paul,
>>>>>>
>>>>>> A number of stable kernels recently backported this upstream commit:
>>>>>>
>>>>>> """
>>>>>> commit 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5
>>>>>> Author: Paul Moore <paul@paul-moore.com>
>>>>>> Date:   Wed Apr 12 13:29:11 2023 -0400
>>>>>>
>>>>>>        selinux: ensure av_permissions.h is built when needed
>>>>>> """
>>>>>>
>>>>>> We're seeing a build issue with this commit where the "crash" tool will fail
>>>>>> to start, it complains that the vmlinux image and /proc/version don't match.
>>>>>>
>>>>>> A minimum reproducer would be having "make" version before 4.3 and building
>>>>>> the kernel with:
>>>>>>
>>>>>> $ make bzImages
>>>>>> $ make modules
>>>>>>
>>>>>> Then compare the version strings in the bzImage and vmlinux images,
>>>>>> we can use "strings" for this. For example, in the 5.10.181 kernel I get:
>>>>>>
>>>>>> $ strings vmlinux | egrep '^Linux version'
>>>>>> Linux version 5.10.181 (ec2-user@ip-172-31-79-134.ec2.internal) (gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15), GNU ld version 2.29.1-31.amzn2) #2 SMP Thu Jun 1 01:26:38 UTC 2023
>>>>>>
>>>>>> $ strings ./arch/x86_64/boot/bzImage | egrep 'ld version'
>>>>>> 5.10.181 (ec2-user@ip-172-31-79-134.ec2.internal) (gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15), GNU ld version 2.29.1-31.amzn2) #1 SMP Thu Jun 1 01:23:59 UTC 2023
>>>>>>
>>>>>> The version string in the bzImage doesn't have the "Linux version" part, but
>>>>>> I think this is added by the kernel when printing. If you compare the strings,
>>>>>> you'll see that they have a different build date and the "#1" and "#2" are
>>>>>> different.
>>>>>>
>>>>>> This only happens with commit 4ce1f694eb5 applied and older "make", in my case I
>>>>>> have "make" version 3.82.
>>>>>>
>>>>>> If I revert 4ce1f694eb5 or use "make" version 4.3 I get identical strings (except
>>>>>> for the "Linux version" part):
>>>>>>
>>>>>> $ strings vmlinux | egrep '^Linux version'
>>>>>> Linux version 5.10.181+ (ec2-user@ip-172-31-79-134.ec2.internal) (gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15), GNU ld version 2.29.1-31.amzn2) #1 SMP Thu Jun 1 01:29:11 UTC 2023
>>>>>>
>>>>>> $ strings ./arch/x86_64/boot/bzImage | egrep 'ld version'
>>>>>> 5.10.181+ (ec2-user@ip-172-31-79-134.ec2.internal) (gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15), GNU ld version 2.29.1-31.amzn2) #1 SMP Thu Jun 1 01:29:11 UTC 2023
>>>>>>
>>>>>> Maybe the grouped target usage in 4ce1f694eb5 with older "make" is causing a
>>>>>> rebuild of the vmlinux image in "make modules"? If yes, is this expected?
>>>>>>
>>>>>> I'm afraid this issue could be high impact for distros with older user-space.
>>>>>
>>>>> Is this issue also in 6.4-rc1 where this change came from?
>>>>
>>>> Yes. I'm reporting this here because I'm more concerned with -stable kernels since
>>>> they're more likely to be running on older user-space.
>>>
>>> Yeah, we are bug-compatible!  :)
>>>
>>> When this gets fixed in Linus's tree, I'll be glad to backport the
>>> changes to the other kernels.  Please work with the developers to get
>>> that fixed there.
>>
>> OK, I'll report it there, but shouldn't we avoid regressing -stable kernels?
> 
> We should avoid regressing Linus's kernel tree just as much.  It's
> always been this way, I don't want to revert patches unless they are
> really bad if the fix is not in Linus's tree already.  Gives people
> "encouragement" to resolve the issue quicker.

Fair enough. Paul is in this thread, let's see if he picks it up from here. If not, I'll
report it on lkml.

- Luiz
