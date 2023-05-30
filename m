Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D59716D6A
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 21:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjE3TVO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 15:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjE3TVN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 15:21:13 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA138E
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:21:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B18A5C003B;
        Tue, 30 May 2023 15:21:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 30 May 2023 15:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685474472; x=1685560872; bh=bk
        WqTFXfoxo0CMTNILmC/itJshJF4NrwWdWP3pLHhpY=; b=j4BiYOkWn58OjIyCEY
        Vaxnh6RPyV4/ubJ3AzUO/5mnApwAbl4W3HU5N+dzAMzgMLE6qN0jQ3QHgVDi5jjS
        Tuo7zYihJbw4xABhesrJnu1sdC09aOyNZCUJxq9hx2L2hjlIo/wOlHRNlIHmoF52
        OcSIKy+ZbZcSdZEgP1p/VxaJy2O/MDW3DyiT7dQ/+8NMZiYuinj1wNhSZWfCPxGB
        ua6eJyW9gNT14LDnckSxUInh1cj26TTBqjedxnN8R+hKFSQdejEV/MNtKUbgDcoc
        9H3OpfGvaPUjScsCBixS4E6VLcpDFFe4YdaBkKgD7tCor18kDhp94tkpU6qflvDN
        2Qqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685474472; x=1685560872; bh=bkWqTFXfoxo0C
        MTNILmC/itJshJF4NrwWdWP3pLHhpY=; b=IGf8e71Nx4au4qsohIm4UPDWjbuzK
        pwTRcTvM8FwhiSDBt8yXr5VUf5nkOoQSQ+sVxef817cjgGLCHhY0qvSznRPZpnxV
        qz8aAhhtnWdP+7scFIwK9sWZ2fnerbpzGq8dO9Jp0bzwkF/na2SWz2kwWaCwFvl0
        56XqiGW7AP5eZT9AmkStJkT/blPMoCISVEuPUvlF2i/EX/e/MWqd+KlucveFf7eH
        xXkHYJQoH7f8ofWWUJGsQM622EKXWhllmW53W+zkoEpAnyQP9qdMKef7uFhrft9W
        JkmBhXw7l+KF+lXiGmnGQolbdYuLO6YrpFjQ/xIW+mTNWJP7+Cd/qj/jg==
X-ME-Sender: <xms:qEx2ZGk4Gy7MDy75gooB23RaiJ1mw32DJzcoJbvr-XCipcT-1Frxlw>
    <xme:qEx2ZN12B2278TXZ8-SgvY-kI3MD036nOhejWEJ-0EapKOo-0gjFMSPxHKUOd19r3
    P0Ctg0MgloTUK9rnyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qEx2ZEqCFFJKtHxq9TWDBscwrpDyiEcRT0pe1vVIsEOnSrkGQu0bhg>
    <xmx:qEx2ZKlh5ewcAhmlKfoLKPoGi3FkM-_MhByojrBraRq4Hn2yHczmZw>
    <xmx:qEx2ZE0veMWXFE1hdqGpSQZ35RHsUKD3VP30R3IhKfOTzsU1FEkh8w>
    <xmx:qEx2ZBzcvT2jv4L69qenpPNc3k47gOGk7WhvZFHFK_9xlp16wYIpAA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3512BB60086; Tue, 30 May 2023 15:21:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <41c61895-59f4-449c-9e2e-d127d7f95be5@app.fastmail.com>
In-Reply-To: <2fce7746-6d63-4853-9b20-8fa0b24d6f32@app.fastmail.com>
References: <b59d1bfe-15b1-4318-a12f-a38143ba35bd@kili.mountain>
 <4716f9fd-0e09-4e69-a802-09ddecff2733@app.fastmail.com>
 <6b1a0ee6-c78b-4873-bfd5-89798fce9899@kili.mountain>
 <2fce7746-6d63-4853-9b20-8fa0b24d6f32@app.fastmail.com>
Date:   Tue, 30 May 2023 21:20:52 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dan Carpenter" <dan.carpenter@linaro.org>
Cc:     stable@vger.kernel.org,
        "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>
Subject: Re: randconfig fixes for 5.10.y
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 30, 2023, at 21:02, Arnd Bergmann wrote:
>
> CONFIG_COMPILE_TEST=y forces a number of options to be
> hidden from build tests, which is generally super useful.
> The one that ended up hiding the stack growth above is
> CONFIG_GCOV_PROFILE_ALL. I'll try enabling it for a few
> builds to see what else shows up with it.

Update: you already pointed to UBSAN_SANITIZE_ALL causing
this, I can confirm that this is also the case. With your
config, the combination of CONFIG_GCOV_PROFILE_ALL and
CONFIG_UBSAN_SANITIZE_ALL causes the compiler to completely
mess up register allocation in this code, disabling either
of the two gets it below the boundary.

     Arnd
