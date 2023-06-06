Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C995724706
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbjFFO5O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbjFFO5E (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 10:57:04 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B14B1738
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686063407; x=1717599407;
  h=message-id:date:mime-version:subject:from:to:references:
   cc:in-reply-to:content-transfer-encoding;
  bh=NlNCaJsU0cTaSkSLt0hxuZxelnm/Bm1dnl3h3SpP5v0=;
  b=cscmt6XFibQ3BrkmIZhiP8eJX+/yLzEg1uf3z3QtItU8JCSNlsIGO09/
   NE/wlmOflA3HlSThqtsnMB3MEVQVr0vH4XYcVl1xa7r0FgKHD2ZfSQp9G
   AIINbrv3T3i0KcYh3QVZ7bkO7W2bCOR905ro+Y1qHw4I3hE0Y8BdPmqaH
   4=;
X-IronPort-AV: E=Sophos;i="6.00,221,1681171200"; 
   d="scan'208";a="219010605"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 14:56:43 +0000
Received: from EX19MTAUEC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id AEBEBA08F9;
        Tue,  6 Jun 2023 14:56:41 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Jun 2023 14:56:40 +0000
Received: from [10.136.46.198] (10.136.46.198) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Jun 2023 14:56:37 +0000
Message-ID: <61f6d16a-cf0b-9c25-a148-ccf99b6bd77f@amazon.com>
Date:   Tue, 6 Jun 2023 10:56:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [6.1.y] Please apply 98bea253aa28ad8be2ce565a9ca21beb4a9419e5
Content-Language: en-US
From:   Luiz Capitulino <luizcap@amazon.com>
To:     <stable@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
References: <23bb697e-c965-8321-f648-03f804853cdb@amazon.com>
CC:     <edward.lo@ambergroup.io>,
        <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <23bb697e-c965-8321-f648-03f804853cdb@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.46.198]
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023-06-01 17:17, Luiz Capitulino wrote:
> 
> It fixes CVE-2022-48425 and is applied to 5.15.y and 6.3.y. I quickly tested
> the commit by mounting an NTFS partition and building a kernel in it.

Humble ping?

> 
> """
> commit 98bea253aa28ad8be2ce565a9ca21beb4a9419e5
> Author: Edward Lo <edward.lo@ambergroup.io>
> Date:   Sat Nov 5 23:39:44 2022 +0800
> 
>      fs/ntfs3: Validate MFT flags before replaying logs
> """
> 
> Thanks,
> 
> - Luiz
