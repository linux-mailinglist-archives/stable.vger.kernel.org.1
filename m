Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B74C71F191
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjFASP6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 14:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjFASPs (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 14:15:48 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6071B9
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685643336; x=1717179336;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2+IV6Mjwt4cUkUNXTp4X2L/nb2cjsLaOV7K1fNjm+tE=;
  b=X3k8ETtCENZ4j0sPnQFfyS1zvWaXdBtEUhBu2D2SY0ftEVhxNzAGhTtN
   0D2t039nKTD2LERQ3SiIWgJbUJzVOWUEXGmOLREVZOHYTd9ob+Ltf+GbQ
   IHULKJLbXNKy/bW8nq9Dr6XdBr8cn0jC4eTdut7OdWi2NRq2zhPT7zTZC
   s=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681171200"; 
   d="scan'208";a="289040701"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 18:15:30 +0000
Received: from EX19MTAUEC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id A13C2A8A59;
        Thu,  1 Jun 2023 18:15:28 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 18:15:27 +0000
Received: from [192.168.209.155] (10.106.239.22) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 18:15:26 +0000
Message-ID: <94516854-c5b6-e626-9f8e-d6600011dcf5@amazon.com>
Date:   Thu, 1 Jun 2023 14:15:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Possible build time regression affecting stable kernels
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <sashal@kernel.org>, <stable@vger.kernel.org>
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <CAHC9VhTmKbQFx-7UtZgg8D+-vtFOar0dMqULYccWQ2x7zJqT-Q@mail.gmail.com>
 <bb1e18f8-9d31-1ec7-d69a-2d1f5af31310@amazon.com>
 <CAHC9VhTFzN_Y_7HBroJnbTHL2NZEYjFy9BB3JJJBKnwv_k25dw@mail.gmail.com>
 <d2b14172-7aeb-be98-ded2-b4ce255dccaf@amazon.com>
 <2023060120-monopoly-math-3bc5@gregkh>
 <CAHC9VhTdZ=-Tmi=nPzKFHRoiE+oWNFWrXr=oG70fti9HNCgrWQ@mail.gmail.com>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <CAHC9VhTdZ=-Tmi=nPzKFHRoiE+oWNFWrXr=oG70fti9HNCgrWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.239.22]
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
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



On 2023-06-01 14:10, Paul Moore wrote:

> 
> 
> 
> On Thu, Jun 1, 2023 at 1:05 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Thu, Jun 01, 2023 at 11:50:16AM -0400, Luiz Capitulino wrote:
>>> On 2023-06-01 11:45, Paul Moore wrote:
> 
> ...
> 
>>>> I don't want to block on fixing the kernel build while I keep chasing
>>>> some esoteric build behavior so I'm just going to revert the patch
>>>> with a note to revisit this when we require make >= 4.3.
>>>>
>>>> Regardless, thanks for the report and the help testing, expect a
>>>> patch/revert shortly ...
>>>
>>> Thank you Paul, I really appreciate your fast response. I'd also
>>> appreciate if you CC me in the revert patch so that I don't loose
>>> track of it.
>>
>> And please add a cc: stable@ to it too :)
> 
> Done, and done.  I just sent the patch so give it a few minutes if you
> haven't seen it yet.  I'll leave it for a few hours in case anyone can
> give it a test build before I send it up to Linus.

Thanks Paul, I can test it but it may take more than a few hours for me.

- Luiz
