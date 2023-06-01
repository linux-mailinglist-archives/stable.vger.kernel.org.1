Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4818071A205
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjFAPFl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 11:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjFAPEw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 11:04:52 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E50E78
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685631818; x=1717167818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=LtgF94wf1BMCPPv4cb6zN2B4LoyO1uoIYo/l+Wb0reU=;
  b=WntIwnHUhzGkZeRNJ8B1B4TsSVWmRoaYsZMBN0+Xr62GD9rOtbMRfXWe
   ftfXHU9s7MXZEN5gROZhjEbBjoyZLyp4OHif1rBU3rAMA1cMP3fUc5V8L
   XgrHzbFrGfZxjCjpPKQZEfeNdTMrvf7CRYa2Y2IBgNLnPpiZQQOnb17jF
   E=;
X-Amazon-filename: paul.patch
X-IronPort-AV: E=Sophos;i="6.00,210,1681171200"; 
   d="scan'208";a="335835448"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 15:03:06 +0000
Received: from EX19MTAUEB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 626484619E;
        Thu,  1 Jun 2023 15:03:05 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 15:03:02 +0000
Received: from [192.168.209.155] (10.106.239.22) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 15:03:00 +0000
Content-Type: multipart/mixed;
        boundary="------------jPrayy37WFHIX2ldYhSs7hPV"
Message-ID: <bb1e18f8-9d31-1ec7-d69a-2d1f5af31310@amazon.com>
Date:   Thu, 1 Jun 2023 11:02:57 -0400
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
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <CAHC9VhTmKbQFx-7UtZgg8D+-vtFOar0dMqULYccWQ2x7zJqT-Q@mail.gmail.com>
X-Originating-IP: [10.106.239.22]
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
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

--------------jPrayy37WFHIX2ldYhSs7hPV
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2023-06-01 10:27, Paul Moore wrote:

> 
> 
> 
> On Wed, May 31, 2023 at 10:13 PM Luiz Capitulino <luizcap@amazon.com> wrote:
>>
>> Hi Paul,
>>
>> A number of stable kernels recently backported this upstream commit:
>>
>> """
>> commit 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5
>> Author: Paul Moore <paul@paul-moore.com>
>> Date:   Wed Apr 12 13:29:11 2023 -0400
>>
>>       selinux: ensure av_permissions.h is built when needed
>> """
>>
>> We're seeing a build issue with this commit where the "crash" tool will fail
>> to start, it complains that the vmlinux image and /proc/version don't match.
>>
>> A minimum reproducer would be having "make" version before 4.3 and building
>> the kernel with:
>>
>> $ make bzImages
>> $ make modules
> 
> ...
> 
>> This only happens with commit 4ce1f694eb5 applied and older "make", in my case I
>> have "make" version 3.82.
>>
>> If I revert 4ce1f694eb5 or use "make" version 4.3 I get identical strings (except
>> for the "Linux version" part):
> 
> Thanks Luiz, this is a fun one :/

It was a fun to debug TBH :-)

> Based on a quick search, it looks like the grouped target may be the
> cause, especially for older (pre-4.3) versions of make.  Looking
> through the rest of the kernel I don't see any other grouped targets,
> and in fact the top level Makefile even mentions holding off on using
> grouped targets until make v4.3 is common/required.

Exactly.
  
> I don't have an older userspace immediately available, would you mind
> trying the fix/patch below to see if it resolves the problem on your
> system?  It's a cut-n-paste so the patch may not apply directly, but
> it basically just removes the '&' from the make rule, turning it into
> an old-fashioned non-grouped target.

I tried the attached patch on top of latest Linus tree (ac2263b588dffd),
but unfortunately I got the same issue which is puzzling. Reverting
4ce1f694eb5d8ca607fed8542d32a33b4f1217a5 does solve the issue though.

I have no problem trying patches or helping debug, but if you want to
give it a try on reproducing you could try with make-3.82 from:

https://ftp.gnu.org/gnu/make/make-3.82.tar.bz2

- Luiz
--------------jPrayy37WFHIX2ldYhSs7hPV
Content-Type: text/x-patch; charset="UTF-8"; name="paul.patch"
Content-Disposition: attachment; filename="paul.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NlY3VyaXR5L3NlbGludXgvTWFrZWZpbGUgYi9zZWN1cml0eS9zZWxp
bnV4L01ha2VmaWxlCmluZGV4IDBhZWNmOTMzNGVjMy4uZGYzNWQ0ZWM0NmYwIDEwMDY0NAot
LS0gYS9zZWN1cml0eS9zZWxpbnV4L01ha2VmaWxlCisrKyBiL3NlY3VyaXR5L3NlbGludXgv
TWFrZWZpbGUKQEAgLTI2LDUgKzI2LDUgQEAgcXVpZXRfY21kX2ZsYXNrID0gR0VOICAgICAk
KG9iaikvZmxhc2suaCAkKG9iaikvYXZfcGVybWlzc2lvbnMuaAogICAgICAgY21kX2ZsYXNr
ID0gJDwgJChvYmopL2ZsYXNrLmggJChvYmopL2F2X3Blcm1pc3Npb25zLmgKIAogdGFyZ2V0
cyArPSBmbGFzay5oIGF2X3Blcm1pc3Npb25zLmgKLSQob2JqKS9mbGFzay5oICQob2JqKS9h
dl9wZXJtaXNzaW9ucy5oICY6IHNjcmlwdHMvc2VsaW51eC9nZW5oZWFkZXJzL2dlbmhlYWRl
cnMgRk9SQ0UKKyQob2JqKS9mbGFzay5oICQob2JqKS9hdl9wZXJtaXNzaW9ucy5oOiBzY3Jp
cHRzL3NlbGludXgvZ2VuaGVhZGVycy9nZW5oZWFkZXJzIEZPUkNFCiAJJChjYWxsIGlmX2No
YW5nZWQsZmxhc2spCg==

--------------jPrayy37WFHIX2ldYhSs7hPV--
