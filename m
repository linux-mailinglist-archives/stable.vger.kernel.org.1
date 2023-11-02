Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78277DEBB5
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 05:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348514AbjKBEM2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 00:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348515AbjKBEL7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 00:11:59 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9671736
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 21:11:25 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SLVmk1wmwz9sjT;
        Thu,  2 Nov 2023 05:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owenh.net; s=MBO0001;
        t=1698898278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WN5fmOdVvci8BiTSNTkQ11/6+0Vp0IU6VwTOPcaqcaQ=;
        b=rrGbY2xW1+rXEaQIHig+TA8Z9R5mZ/w4e0xwsXUEFojPDzbZ7sKhEhVYzH4xpRTZ5H2X48
        T6h7IdM00xkClDJDZ/H+03qZJouT0nZsDaEAW5h08dbXKz0qnv3dn1IOlacW3CzfbIAUgM
        LJ4GU4G9hQo5ihfIGvHxYZ5B6uoH9TC+FDTgO1EEEH4qSyrbMwEUHZcTmH9wHyohUhP95Z
        raj36ltUy+sBcX7xMgoch2fn5ihKDCD3yIqZbMLXYVTjaKmo1NHanvnKxElj34B6U+pWEK
        crFALFWXUoXJLH9eTsYjEYg5zzQL86vvSp5iZwQdxyRh50wzB+3D2JdeD5zjHw==
Message-ID: <f98d5544-34f8-4b35-9466-80fa9671686d@owenh.net>
Date:   Wed, 1 Nov 2023 23:11:08 -0500
MIME-Version: 1.0
Subject: Re: [REGRESSION]: nouveau: Asynchronous wait on fence
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
Cc:     nouveau@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
References: <6f027566-c841-4415-bc85-ce11a5832b14@owenh.net>
 <5ecf0eac-a089-4da9-b76e-b45272c98393@leemhuis.info>
From:   "Owen T. Heisler" <writer@owenh.net>
In-Reply-To: <5ecf0eac-a089-4da9-b76e-b45272c98393@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/31/23 04:18, Linux regression tracking (Thorsten Leemhuis) wrote:
> Thanks for your report. With a bit of luck someone will look into this,
> But I doubt it, as this report has some aspects why it might be ignored.
> Mainly: (a) the report was about a stable/longterm kernel and (b)it's
> afaics unclear if the problem even happens with the latest mainline
> kernel.

> You thus might want to check if the problem occurs with 6.6 -- and
> ideally also check if reverting the culprit there fixes things for you.

Thorsten,

Thank you for your reply and suggestions. I will try (a) testing on 
mainline (when I tried before I was interrupted by another, unrelated 
regression) and (b) reverting the culprit commit there if I am able to 
reproduce the problem.

Thanks,
Owen

--
Owen T. Heisler
https://owenh.net
