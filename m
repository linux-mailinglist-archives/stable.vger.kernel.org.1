Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7197566F6
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGQO7a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 10:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjGQO73 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 10:59:29 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C072FE7F
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 07:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689605968; x=1721141968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JeA+85lGymeBpxhPg7mm043dBovqc22VrgKsfkOn3GI=;
  b=hhL+6ZaWzrKyl4qbuVCLf6UKn1ckdzKhozD0aFu9TxDjEoibtkDu8l0d
   KacbtBoV4ITyuy2CTTkhPU9cOex774/hXORau8Rg/YjLqoQGYPBkM6s4X
   8QiUrXL4bVS77+8HwhKDKZwHsTjnoOKTdmajjoFjMX2PFn7i0aH2fkyyq
   o=;
X-IronPort-AV: E=Sophos;i="6.01,211,1684800000"; 
   d="scan'208";a="16703574"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 14:59:26 +0000
Received: from EX19MTAUEA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id 7E0D7469D9;
        Mon, 17 Jul 2023 14:59:24 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 14:59:22 +0000
Received: from [10.136.59.42] (10.136.59.42) by EX19D028UEC003.ant.amazon.com
 (10.252.137.159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 17 Jul
 2023 14:59:21 +0000
Message-ID: <9c7fc5ab-1c06-8452-2747-aa89e7a1dfb6@amazon.com>
Date:   Mon, 17 Jul 2023 10:59:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [5.10, 5.15] New bpf kselftest failure
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        <ast@kernel.org>, <gilad.reti@gmail.com>
References: <935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com>
 <76dfe02eea69141b662a3a399126dba9e00e5abe.camel@gmail.com>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <76dfe02eea69141b662a3a399126dba9e00e5abe.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.59.42]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023-07-17 10:55, Eduard Zingerman wrote:

> 
> 
> 
> On Mon, 2023-07-17 at 09:04 -0400, Luiz Capitulino wrote:
>> Hi,
>>
>> The upstream commit below is backported to 5.10.186, 5.15.120 and 6.1.36:
>>
>> """
>> commit ecdf985d7615356b78241fdb159c091830ed0380
>> Author: Eduard Zingerman <eddyz87@gmail.com>
>> Date:   Wed Feb 15 01:20:27 2023 +0200
>>
>>       bpf: track immediate values written to stack by BPF_ST instruction
>> """
>>
>> This commit is causing the following bpf:test_verifier kselftest to fail:
>>
>> """
>> # #760/p precise: ST insn causing spi > allocated_stack FAIL
>> """
>>
> 
> I can reproduce the error on 6.1.36 but don't understand what's causing it yet.
> The log is suspiciously different from master, will comment later today.

Thank you very much for the prompt reply, Eduard.

I'm available for further testing if needed.

- Luiz

> 
>> Since this test didn't fail before ecdf985d76 backport, the question is
>> if this is a test bug or if this commit introduced a regression.
>>
>> I haven't checked if this failure is present in latest Linus tree because
>> I was unable to build & run the bpf kselftests in an older distro.
>>
>> Also, there some important details about running the bpf kselftests
>> in 5.10 and 5.15:
>>
>> * On 5.10, bpf kselftest build is broken. The following upstream
>> commit needs to be cherry-picked for it to build & run:
>>
>> """
>> commit 4237e9f4a96228ccc8a7abe5e4b30834323cd353
>> Author: Gilad Reti <gilad.reti@gmail.com>
>> Date:   Wed Jan 13 07:38:08 2021 +0200
>>
>>       selftests/bpf: Add verifier test for PTR_TO_MEM spill
>> """
>>
>> * On 5.15.120 there's one additional test that's failing, but I didn't
>> debug this one:
>>
>> """
>> #150/p calls: trigger reg2btf_ids[reg→type] for reg→type > __BPF_REG_TYPE_MAX FAIL
>> FAIL
>> """
>>
>> * On 5.11 onwards, building and running bpf tests is disabled by
>> default by commit 7a6eb7c34a78498742b5f82543b7a68c1c443329, so I wonder
>> if we want to backport this to 5.10 as well?
>>
>> Thanks!
>>
>> - Luiz
>>
> 
