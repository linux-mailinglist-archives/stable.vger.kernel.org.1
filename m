Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA7E754F34
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 17:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjGPPIZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 11:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGPPIY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 11:08:24 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44988C9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 08:08:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F7025C0100;
        Sun, 16 Jul 2023 11:08:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 16 Jul 2023 11:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1689520101; x=1689606501; bh=99nGwBb11BfUWxAyVEweG6Lu4OWAv0SVWGn
        P4aBiC0w=; b=mg7vxK0fdM2SWYhxKdTSp1ChgW69qqiRQo0whrfY3HidRgfWn0v
        ULGgerRYIXRgkZxsAMsfpKBcf7b+AyxGch2Arigp5pCONWOCVEjlw86QhLIwBGr4
        qZNnee8/9bDKtAiB8kQYkn4SOPESqMj/RjGoaF5trtdOCCQaLPn8W8fpwAmhlc0J
        8Spqw3xdCueiSzPCqBAyghTY2IhfJOWfRv7nhVXdszln8NHqtYI7GWPOtNS1jpJt
        qhgIYxNk8YJqt1Ajf9IxlWk80NyRVK2kzFqp4+yI3GPBwPJGQVF+KdkVV6zThvPf
        ey4XrydvpafuYil9TEq0gWM+2GzP5iCL71Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689520101; x=1689606501; bh=99nGwBb11BfUWxAyVEweG6Lu4OWAv0SVWGn
        P4aBiC0w=; b=xQoUfDCM9f985k0HlbIpsYM2DroOztA0aX1TA4SQzYQkduh88c6
        WgHS6lToH1xizCZ+XJD1LUuDx7s+Z3Qgaepbd57vfGfx8uwOfz8ezgQUJ1GYl8k5
        HtSaPrTziFPNknhQ/u1nsF0Zbi5Bbbev9Fb5HFodAmusKPr3AC0M1hKYQRZqSUZ4
        izV9Ej2Slg+maTFPQHljOz7o5INDHfAOaOpKwWch+EJBScgfOPobBzHPC6CU35Fy
        4sWGsREfUGM90JIUT/9kSXY1QD3bre9LPyFlu4lSbbpYzwN+2fnlYBmA7PXnOPeB
        qMVlMpbmhyTjTTwbxjsb61OtYeeaBOJaD7A==
X-ME-Sender: <xms:5Ae0ZA1zSJ4lEuWGjG8JGxq-IBa2OS8zCK4FvPKAZf49vLn6gST7aA>
    <xme:5Ae0ZLHGKBrXfVBrXKMZ5OubXpJa4WHzoTsF1nUXyfjPCh09m3XX7zpWaHTybRSK6
    gwksi8AG572RA>
X-ME-Received: <xmr:5Ae0ZI73a2ainzwprFYPohlfXcfQigoQ49UcgJt0ze0GYRnqjRLLSnqlrPP6cgUdr6p_WzOw75aMwovAhUtrKc-ij4y_-9vmLZfD0v_uGFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedtgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtke
    ertddttdejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpefgkeffieefieevkeelteejvdetvddtledugfdvhfetje
    ejieduledtfefffedvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:5Ae0ZJ1nLTw4gDG9_5OKxLJLYyzY4NP53hQw4v1XsKk4Yw8vYU8OQg>
    <xmx:5Ae0ZDHwa1H121NK6SHPioDv9vrVEnSCgXANlQS-jwXFqIsDedru4g>
    <xmx:5Ae0ZC_n0xAGmGB4YK6PLX_egldTiA06fVE4fptywR33RSWYAYiBVg>
    <xmx:5Qe0ZIRy-GtVuBv2EMczqIydojGn3Hs8xPRcrht7NaPJnwEprGnM4Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jul 2023 11:08:20 -0400 (EDT)
Date:   Sun, 16 Jul 2023 17:07:40 +0200
From:   Greg KH <greg@kroah.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Stable <stable@vger.kernel.org>
Subject: Re: linux-6.1.y: request for picking 085679b15b5a ("mtd: parsers:
 refer to ARCH_BCMBCA instead of ARCH_BCM4908")
Message-ID: <2023071635-anytime-clumsy-8c92@gregkh>
References: <CACna6rw7xEUEOgsXTC2GJmmG56kpTN07nnRJDDnNHAi7-9cabA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6rw7xEUEOgsXTC2GJmmG56kpTN07nnRJDDnNHAi7-9cabA@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 14, 2023 at 08:39:11AM +0200, Rafał Miłecki wrote:
> Hi,
> 
> In linux-6.1.y we don't have ARCH_BCM4908 symbol anymore (see commit
> dd5c672d7ca9 ("arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA") but
> drivers/mtd/parsers/Kconfig still references it.
> 
> Please kindly cherry-pick a fix for that: commit 085679b15b5a ("mtd:
> parsers: refer to ARCH_BCMBCA instead of ARCH_BCM4908") - it's part of
> v6.2.

Now queued up, thanks.

greg k-h
