Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A318789BA2
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 09:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjH0HCG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 03:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjH0HBm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 03:01:42 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B85120
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 00:01:40 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 88F543200035;
        Sun, 27 Aug 2023 03:01:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 27 Aug 2023 03:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1693119697; x=1693206097; bh=hU
        TulXEn40KE/FPOcm7vGTInBrRUs5e+fYMtYJaOfP8=; b=jsh1yCLjM9xxyox4iW
        on8rcOaoa2jq4yc5eR0ha3bvl52trNhFVsL8uA9pboQBP1j9XZ+h9cVyc1dEswAM
        ha7ZCHRdtX8T8/Lg1myXRxVI3BUP3QE6z4xwTSDoIHsfK3WXNEz9aoC7dTWE7RlR
        +Y5//wCIbZTMn545ufeCpoCCnDKjIadMZY6O1o1ioDkbIwjVURyoFo7wBEtYMc/L
        /6sf48Y+4tO5RIXl75gX/WVB8aDgt/0VjKcEBNv7UwvST47LUgOTF18iZHbwBa+0
        EKeNhfTuxFR9uYIj5CAPOKlyUAUBL/X846VrnrrHh9B7muprMHilDKfKPDtlAIfL
        Ip9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693119697; x=1693206097; bh=hUTulXEn40KE/
        FPOcm7vGTInBrRUs5e+fYMtYJaOfP8=; b=nP03o8zRqh4Feae12vOg1vtPBimE5
        m5LOqn+E+3QTNc6Ao2P7K0rzYDzDYpVgwTM4YZFhgiYXnN1xADidvdXWm5L7ogOe
        Suj5Ivld/RE5rP26DJy7hNhSXOmSvvSwHqoMkDm8pmWrOtk/pAQLmWZQimwqcHhZ
        TMSkzKO+7XFWzZq1QcGXHTgoKTY33xlS8LJ1svIrxGTUWarqnlb97wV2a8EN77bv
        Ueu12X0Rt+VQwQaJhNx9QCNdj6zLj1xNDT7Q7H6DBeXNrVM3PBAztK4Oc6mh8s6m
        4t3zhOzsMVVV3+ImbzufkcPuqMmG1EzHreFKZ9SL1bZX9tobxmsTzZ8bg==
X-ME-Sender: <xms:0PTqZKcNgI4Igo3QztSUhhEDhPu0ir_NLs8MzO-QyIk5Vl1MOT9GCA>
    <xme:0PTqZEP2s2gEn694fXWX6DWsroNA87neZs-NX-J52xxlBTxMAVGnJPx7X4pKpAzku
    EAso2I5SEWkew>
X-ME-Received: <xmr:0PTqZLhkBFt3Ww-S3VGL5Oaduq7RhxHP40xxN5OBBPOS0xuwHgFJqIi5VprtQZp-CzkIkl_3zun_-nUjeGXhlqSEmu-8cJBgdCj3xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpedvje
    fhvefhjeejfeefleejteegtedvgeeghfeuveevgfffueelhffhhedugffhkeenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:0PTqZH-e32GxLW-1AEzMICrkFUkD20PstkxONjD2g41yA9z9755YoA>
    <xmx:0PTqZGta9A_pXtqJpbCRQbi-f2vsiNZYQ8jJX7b6qrxA9ARdyouZBA>
    <xmx:0PTqZOE90fl5r-qDHhxKqu_AECjhw6VR61Ba3WaX8vbfEvN77ctzlg>
    <xmx:0fTqZP4p6hUga5tBbjk7ADuwJnF8-dmdGfr0iiwLLwx0-jgEx3T9mg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Aug 2023 03:01:36 -0400 (EDT)
Date:   Sun, 27 Aug 2023 09:01:32 +0200
From:   Greg KH <greg@kroah.com>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH v6.1] hwmon: (aquacomputer_d5next) Add selective 200ms
 delay after sending ctrl report
Message-ID: <2023082708-jubilance-subtype-e111@gregkh>
References: <2023081222-chummy-aqueduct-85c2@gregkh>
 <20230824141500.1813549-1-savicaleksa83@gmail.com>
 <c4197112-986d-81f2-53aa-7d53086d5eb2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4197112-986d-81f2-53aa-7d53086d5eb2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 24, 2023 at 04:26:10PM +0200, Aleksa Savic wrote:
> On 2023-08-24 16:15:00 GMT+02:00, Aleksa Savic wrote:
> > commit 56b930dcd88c2adc261410501c402c790980bdb5 upstream.
> > 
> > Add a 200ms delay after sending a ctrl report to Quadro,
> > Octo, D5 Next and Aquaero to give them enough time to
> > process the request and save the data to memory. Otherwise,
> > under heavier userspace loads where multiple sysfs entries
> > are usually set in quick succession, a new ctrl report could
> > be requested from the device while it's still processing the
> > previous one and fail with -EPIPE. The delay is only applied
> > if two ctrl report operations are near each other in time.
> > 
> > Reported by a user on Github [1] and tested by both of us.
> > 
> > [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82
> > 
> > Fixes: 752b927951ea ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Octo")
> > Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> > ---
> > This is a backport of the upstream commit to v6.1. No functional
> > changes, except that Aquaero support first appeared in
> > v6.3, so that part of the original is not included here.
> > ---
> 
> Just noticed that I left in the Aquaero mention in the commit
> message, sorry for the omission... Do I need to resend?

Nah, that's fine, we want to keep the changelog identical, I left your
note in the signed-off-by area explaining it.

thanks,

greg k-h
