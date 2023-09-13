Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84B079E0FE
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbjIMHlK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 03:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjIMHlJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 03:41:09 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913B91729
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 00:41:05 -0700 (PDT)
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 99A6E61E5FE01;
        Wed, 13 Sep 2023 09:40:34 +0200 (CEST)
Subject: Re: [PATCH 5.15 052/107] Remove DECnet support from kernel
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        David Ahern <dsahern@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <20230619102141.541044823@linuxfoundation.org>
 <20230619102143.987013167@linuxfoundation.org>
 <6084b5fc-577c-468a-a28e-e0ccc530ed9e@molgen.mpg.de>
 <2023091117-unripe-ceremony-c29a@gregkh>
 <1be4b005-edfe-5faa-4907-f1e9738cc43a@molgen.mpg.de>
 <2023091210-irritably-bottle-84cd@gregkh>
From:   Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <b5a6233e-be87-0872-9ff9-bba3b9108314@molgen.mpg.de>
Date:   Wed, 13 Sep 2023 09:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <2023091210-irritably-bottle-84cd@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/12/23 10:15 AM, Greg Kroah-Hartman wrote:
> On Tue, Sep 12, 2023 at 09:47:40AM +0200, Donald Buczek wrote:
>> On 9/11/23 15:54, Greg Kroah-Hartman wrote:
>>> We have never guaranteed that Kconfig options will never change in
>>> stable kernel releases, sorry.
>>
>> I didn't want to imply that and I don't expect it.
>>
>> It's just _if_ stable really gradually opens up to anything (like code
>> removals, backports of new features, heuristically or AI selected
>> patches, performance patches) it IMO loses its function and we could
>> as well follow mainline, which, I think, is what you are recommending
>> anyway.
> 
> When code is removed from stable kernel versions, it is usually for very
> good reasons, like what happened here.  Sorry I can't go into details,
> but you really wanted this out of your kernel, this was a bugfix :)

Thanks. I understand that this topic can not be discussed and take your word.

>> We've had bad surprises with more or less every mainline releases
>> while updates in a stable series could be trusted to go 99% without
>> thinking. Keeping productions systems on some latest stable gave us
>> the time to identifying and fix problems with newer series before
>> making it the designated series for all systems. This worked well.
>>
>> If the policy of stable gradually changes, that's tough luck for us. I
>> wouldn't complain but it would be good to know. And maybe
>> Documentation/process/stable-kernel-rules.rs should be reviewed.
> 
> If the policy changes, we will change that document, but for now, we are
> backporting only bugfixes that are found through explicit tagging,
> developer requests, manual patch review, and "compare this commit to
> past commits that were accepted" matching which then gets manual review.

Hmmmm, okay. For an apparent counter-example, just yesterday we had to learn about 4921792e04f2125b ("drm/amdgpu: install stub fence into potential unused fence pointers") [1] the hard way [2].

[1]: https://lore.kernel.org/stable/20230724012419.2317649-13-sashal@kernel.org/t/#u
[2]: https://gitlab.freedesktop.org/drm/amd/-/issues/2820#note_2080918

Does "compare this commit to past commits that were accepted" include anything AUTOSELected?

Best

  Donald

> 
> thanks,
> 
> greg k-h
> 


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
