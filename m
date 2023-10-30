Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D708C7DB90F
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 12:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjJ3Lgh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 07:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjJ3Lgf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 07:36:35 -0400
X-Greylist: delayed 130 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 04:36:33 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BEEC5
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 04:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698665789; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=b4fOF/V8BCG4ZHLsO3LVYfFqY33xA3/aEpQMAQTjUjc9URgwQ7ZOixfFqks5X9wc0j
    igfRbec3kbfAJzASn53YONd62BD1mcoNOWeAx2Q0EGU/BMya/OEpQAyagLGzQHtCAuhM
    2Wxt1FFTMyYFDuGpigBT1t6vD9vq7RpLWFgI3NtYF7AJ+BxCl0Rya7IlGztjjQyUOnLf
    BHhbW+gE6hiuwW6SP/X8722ogu/o3UV9Pkl6dZ6pCImDsXjxKvVuiZ4ojzpuGavNvhRF
    hrqCS74p+Top9OHmiln4ikjjJkixb+ei3EMsCdXhKAZO102dETxPw1WH7q3G11fw4cry
    sn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698665789;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dvAMxS1s9xzlzdndQjZ4tD7LC8vju2tU5Fs8EiEQpwo=;
    b=LN4JFEbstgt/JUgYf2AgWlIWAU5cmSbVJmIh0ia1Kcfrae7bH3deMSq2cv58z6zccS
    4vNBe8GUyLb29jzap6b+cAyOX87JDv/P8iThtMVpvg85F+zNInYATyfn99N9RhWJ34vP
    QzZOdUedtkTDBgmfECXHCggJ9mNXzpfMZ1L2Ry2xO5nLrpFHhvwB347QNxC63NVnlU+E
    7u7Vzja0xyZMReF38rlZL2qLgjQ6XKSnWF3lrSgdRUvw18xdeCwcZEC+1dcKPRGfHC0n
    kdlQYB2Mw3JH9zP+jRE6f3CO5gltqR3tALBVMnaIkBJ+D35TnJg/WiJPnqMvu6pPzTtW
    iPlA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698665789;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dvAMxS1s9xzlzdndQjZ4tD7LC8vju2tU5Fs8EiEQpwo=;
    b=q4VbbNYsxjvUhr2a5Tb6FPuZp5nalwDKoXmQQvPtHH98BhZXCO/Z0MpmDMwpNcjir8
    qYmMObHfjva0B/lMNSDIOmnfJzdnB3sbSLYlaSVCq2fSte+pSWjeiB7sDyPTNU57tOJO
    GoQjJ30wRJE6EAIcbVikLzH+bTQHIHP3IlSVtVvqp/fd/a7A3cOi/Z3JWk+fm1jEbnbU
    /PwDgGKq8J4BHiwxkgsqXMAxWlVi0+IbI4a+qcUOK6QeFJSPxHYf09cHsyxumPz+uX/I
    VCUQvM+p/ydKvHdAdNRggjzdmogeGhOncjOdfcZZkyxZ84K8ppZ2Yxdkmurv9ReoXY0k
    wjZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698665789;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dvAMxS1s9xzlzdndQjZ4tD7LC8vju2tU5Fs8EiEQpwo=;
    b=dSna4ZawCcU0ycQCl1w4dSj450k/MZbHM5jHT+4MZsaIWbn8F+xdFNR9fGazc0L/ka
    SSxzskDU+IeyVBF57/CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVJiOM9vpw=="
Received: from [192.168.60.115]
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9UBaSDKw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 30 Oct 2023 12:36:28 +0100 (CET)
Message-ID: <a1ae9eee-9da6-4ceb-8873-dc5ddb1e8e88@hartkopp.net>
Date:   Mon, 30 Oct 2023 12:36:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 043/131] can: isotp: isotp_sendmsg(): fix TX state
 detection and wait behavior
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Magel <lukas.magel@posteo.net>, patches@lists.linux.dev,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        Michal Sojka <michal.sojka@cvut.cz>
References: <20231016084000.050926073@linuxfoundation.org>
 <20231016084001.142952122@linuxfoundation.org>
 <b4a1bdc2-54f8-428a-a82a-0308a4bc7f92@hartkopp.net>
 <2023102721-voltage-thyself-e881@gregkh>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <2023102721-voltage-thyself-e881@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello Greg,

On 27.10.23 14:16, Greg Kroah-Hartman wrote:
> On Tue, Oct 24, 2023 at 08:34:30PM +0200, Oliver Hartkopp wrote:

>> @Greg: I double checked the changes and fixes from the latest 6.6 kernel
>> compared to the 5.10 when isotp.c was introduced in the mainline kernel.
>> Would it be ok, to "backport" the latest 6.6 code to the 5.x LTS trees?
>> It really is the same isotp code but only some kernel API functions and
>> names have been changed.
> 
> Sure, if you think it is ok, please send the backported and tested patch
> series and we will be glad to review them.

I posted to patches to upgrade the 5.10.y and 5.15.y kernels to the 
latest 6.6 mainline code base.

https://lore.kernel.org/linux-can/20231030113027.3387-1-socketcan@hartkopp.net/T/#u

https://lore.kernel.org/linux-can/20231030113110.3404-1-socketcan@hartkopp.net/T/#u

The patch description contains the list of patches that have been 
reverted to meet the older kernel APIs and a list of improvements.

Thanks for the review and the consideration to upgrade the LTS code base.

Best regards,
Oliver

