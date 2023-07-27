Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA237651BD
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 12:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjG0K5d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 06:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjG0K5c (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 06:57:32 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152AC2125
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 03:57:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 765D132005CA;
        Thu, 27 Jul 2023 06:57:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 27 Jul 2023 06:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1690455447; x=1690541847; bh=yd
        i4nEGQXYuZeNBDPC4NAi5EeVYOVRTFgfcahvBIPyU=; b=qTd4dAuxiOIPvfe/Dh
        4bIBL3S57FCZe0vYcsNIUZETNNv4F4AFeokeJR1SK9IWYHLFtOYXNTmTsstlRD5I
        ESaXYeY0zo0GBmXC6kA6TOQnYjhpnmKYxClk/Pg8uuuWNs0KeptUd3zunngNsy9d
        bCfKgT2YZpQbBVC4BHNviHkT5C9q1lnx/AmTac5VE21jrr4Q3kmqrCv+uUvtrmfi
        hfpXGnYQLQpuVjFsysrBy+NKpnW2Sw58KKgjQsY3iYg04vQLQCxaNf10aefNWhUg
        DL4L6pFdCASWAqhlJHs9jSXrZQUbvUE474e/Vtd0Qi7Z45JX8CW1i7ZEBi6zC2TQ
        DKLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690455447; x=1690541847; bh=ydi4nEGQXYuZe
        NBDPC4NAi5EeVYOVRTFgfcahvBIPyU=; b=KJLKpcx7kL5MrmlF34cjcH0BUs045
        eImsx9S5N/PwvSY5rSTnYt9/iYKJPqwSpHLorlbIcgK+wwiLIuyzwgkEPtRnkEFg
        EdlsCSKGHeTYrDF8Fu087NZwYaIg9AzKJlilxSQX/S+1EvS5JWQkfth8UlNr5A2o
        3Z7kRF6g7wFbe/qa6SLbckLN/ToRLIqhm42/XqCFNBKl4pi0H77V/kKGut5njRVc
        VAgGdsF83WW0DLyALuE49rK4PtpcUY9Ikk7QNQlQDlypuoj3swJw3bjhx504B2EE
        kA0uxUbyzrjDOZk7cSTZzEBX3xrGL23uXSgmpaRktgjaiXZ1tZa9kxaeA==
X-ME-Sender: <xms:l03CZEb6DkmX-uBfud5VeXbYUOuqwcYZ5snp5hR-qCObb_IsDixQ5Q>
    <xme:l03CZPaPuURiqNvSh34hPrHOQ-BKV1aSSsDvgtH8y3lHPYJyiVZ98oclnNF5yhAsZ
    KcV-yhy0fHKlQ>
X-ME-Received: <xmr:l03CZO-ngfwIRqsD39rEptaPWLhkaCFuIOeWpnB5jgre2uypEaB91ZrHtlwe9e3Pg_8URFAJ400bTat8YlWaToDh115mNZDL-QkRBsYXg6UJtd2D5GqIAZCKTP9Em4sNmHcwWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeggddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:l03CZOqmTFfo8CC0IlF09tT0slV9rgXn81whnDBdbvTGBcX5OBpimA>
    <xmx:l03CZPoRlRG7m0OrmNnkxGjsfMoQynKB5QBxcfCtwM68BSXrlFhc6Q>
    <xmx:l03CZMTf_Uk3fpl1dYcChzpeT_nVJD1YS8q8YxqxSZbJJQsOy-9JSw>
    <xmx:l03CZG2kTnZlwasPlA3ZpGURzuZF--iqH0SzAzfaImhFLptHijxk5w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 06:57:27 -0400 (EDT)
Date:   Thu, 27 Jul 2023 12:57:24 +0200
From:   Greg KH <greg@kroah.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [6.1] Fix phoenix PHY hang
Message-ID: <2023072717-subpar-postnasal-63ff@gregkh>
References: <a7e443d5-e818-f205-a12d-73a2f88bb085@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7e443d5-e818-f205-a12d-73a2f88bb085@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 26, 2023 at 09:33:40AM -0500, Mario Limonciello wrote:
> Hi,
> 
> This commit fixes a PHY hang that happens on AMD Phoenix when DPMS is
> toggled on/off.  Can you please take to 6.1.y?
> 
> 2b02d746c181 ("drm/amd/display: Keep PHY active for dp config")

Now queued up, thanks.

greg k-h
