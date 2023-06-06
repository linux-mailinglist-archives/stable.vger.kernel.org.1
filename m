Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC71C724912
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 18:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjFFQ2H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 12:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjFFQ2G (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 12:28:06 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DCAFB
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686068886; x=1717604886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q8r0nU+kYInfduMod6AId2mxn9ASghIzucCLAtJJnYg=;
  b=PIZZMWzkf64q/bf7tAQ9LW6yGmvwkZnKaSd1gQ77hRQTePYqUYJYE8dh
   SPEHmjhNdCpwbrsUsbZ8zyN205g4Es3ZCxbws/vyb5TSvy5tPepdyEr2b
   fqYeVDUWoMmitpGTl/Ch7wkWZprZ1TZuJPoUT0mCrl5kgO6FrSTlkvAwU
   I=;
X-IronPort-AV: E=Sophos;i="6.00,221,1681171200"; 
   d="scan'208";a="339458778"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 16:28:03 +0000
Received: from EX19MTAUEA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com (Postfix) with ESMTPS id B3A2B80E54;
        Tue,  6 Jun 2023 16:28:02 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Jun 2023 16:28:02 +0000
Received: from [10.136.46.198] (10.136.46.198) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Jun 2023 16:28:00 +0000
Message-ID: <010e7cb2-f51f-c316-cd76-e457bcb257e4@amazon.com>
Date:   Tue, 6 Jun 2023 12:27:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [6.1.y] Please apply 98bea253aa28ad8be2ce565a9ca21beb4a9419e5
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <edward.lo@ambergroup.io>,
        <almaz.alexandrovich@paragon-software.com>
References: <23bb697e-c965-8321-f648-03f804853cdb@amazon.com>
 <61f6d16a-cf0b-9c25-a148-ccf99b6bd77f@amazon.com>
 <2023060624-repave-audience-bfd5@gregkh>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <2023060624-repave-audience-bfd5@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.46.198]
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023-06-06 12:22, Greg KH wrote:

> 
> 
> 
> On Tue, Jun 06, 2023 at 10:56:34AM -0400, Luiz Capitulino wrote:
>>
>>
>> On 2023-06-01 17:17, Luiz Capitulino wrote:
>>>
>>> It fixes CVE-2022-48425 and is applied to 5.15.y and 6.3.y. I quickly tested
>>> the commit by mounting an NTFS partition and building a kernel in it.
>>
>> Humble ping?
> 
> 5 days later?  Please give us a chance to catch up...

Sorry Greg, I know you're all very busy. I saw you replying to other requests
and thought you might have missed this one.

> 
>>> """
>>> commit 98bea253aa28ad8be2ce565a9ca21beb4a9419e5
>>> Author: Edward Lo <edward.lo@ambergroup.io>
>>> Date:   Sat Nov 5 23:39:44 2022 +0800
>>>
>>>       fs/ntfs3: Validate MFT flags before replaying logs
> 
> And really, ntfs?  For an issue that was fixed last year?  What's the
> rush?  :)

No rush, I just thought this one was missed.

Thanks for replying and sorry again for the nudge.

- Luiz

> 
> thanks,
> 
> greg k-h
