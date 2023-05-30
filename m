Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFF2716D08
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 21:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjE3TDI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 15:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjE3TDG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 15:03:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E439410D
        for <stable@vger.kernel.org>; Tue, 30 May 2023 12:03:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 912C65C01E4;
        Tue, 30 May 2023 15:03:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 30 May 2023 15:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1685473380; x=1685559780; bh=UikHnh1RTee5laDvrulUh9XgV7AU84eex5L
        LLOjCKvY=; b=nU4bw0HwlIkEsPyBRvO2S4IYWjcy96fXBsAU/ouP+TEMgwIjEiJ
        ip7knsUk7FH/i42TkkhlJzOo5iN59c2Oir9w9qfmDMvfxDN9Bz7iuLde0+xq1WoJ
        rYp1ENNliFIUjyPXB8bD3JYM+7BcvffOX/nIvkpOfoTTs9ETAgRDJyIZsRZE2eok
        72TzXepoBiHzVjj6RSod59d+Lg3ivEinJ5f/vug35OJnuMhnup1hQOQ0j9R3bI2t
        eorTho5f/TnGytX+ik+EOAHqmLNn0WCrg/dFWagStzCGvHrjhWYTkNPF6QlMJdsI
        XlR4hNbcIo664hBS86eYopvYcMBUYF3apvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685473380; x=1685559780; bh=UikHnh1RTee5laDvrulUh9XgV7AU84eex5L
        LLOjCKvY=; b=jgeTElblSGEm8Ixedqe8fAuNedeND+jMWzBxUmBMgshVTUhK1Ca
        +fV7mPXfISHPQ3H1CMA0dehlBuljQqkXzNG8DTcfdctdxSHvGZgzJfbRA8lbd2DT
        09tBuiC4eSMuoZedR8QM1R9pR/qdcbZoT7szqWzATqwkaZSymSoEMjyfLti1hss2
        YzNZAXj3tr/bNdf1bRGI+NbRJjC3/J+mvTb45zrhlLaYZx1z/NdkRUhMLpIEGM8+
        Fm5DLd3Ed6N7dlJklduU/vNIFwrrpR+AZFHWuvP1NDyY8gSPgvvZK33khNZ8Fa5u
        N6mGV1Zx17yeX/Ez4HXRH1hCHWeNeNeAipA==
X-ME-Sender: <xms:ZEh2ZISTeTJCYQMgmWsY-52Q6tGYg6RazY2_5vB_ArcTCl_6MNo0gw>
    <xme:ZEh2ZFyD8nXUvgXLjXuHJ0qk1sFWpIgW1XqVfvhLydNexhesO8m4GyE502cdRyO7Y
    mywEPTVCpRzjg6E250>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeu
    feefieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ZEh2ZF3udvKPHYn9bY8sL4dAPQ5ulDZhmfekIoDrkBVI_Qilnu-M3w>
    <xmx:ZEh2ZMB3ar_7k03f5pGTG8HVWeKWC6B_cakJs791ZuBBg2VL3LathQ>
    <xmx:ZEh2ZBhBL0lxMnJu-_Wh9AxiaYZQODWLM1CPC2gF2hCMhUgurcxkdg>
    <xmx:ZEh2ZGtwqnCUmdwrhqyF2b1Ka7tdtEckKdbBq0tiidEJDd0TX5ZqCg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 21E5CB60089; Tue, 30 May 2023 15:03:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <2fce7746-6d63-4853-9b20-8fa0b24d6f32@app.fastmail.com>
In-Reply-To: <6b1a0ee6-c78b-4873-bfd5-89798fce9899@kili.mountain>
References: <b59d1bfe-15b1-4318-a12f-a38143ba35bd@kili.mountain>
 <4716f9fd-0e09-4e69-a802-09ddecff2733@app.fastmail.com>
 <6b1a0ee6-c78b-4873-bfd5-89798fce9899@kili.mountain>
Date:   Tue, 30 May 2023 21:02:38 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dan Carpenter" <dan.carpenter@linaro.org>
Cc:     stable@vger.kernel.org,
        "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>
Subject: Re: randconfig fixes for 5.10.y
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 30, 2023, at 17:38, Dan Carpenter wrote:
> On Tue, May 30, 2023 at 10:53:55AM +0200, Arnd Bergmann wrote:
>> On Tue, May 30, 2023, at 10:22, Dan Carpenter wrote:
>
> Ah, yeah.  Thanks.  Scripting to automatically bisect would be useful.
> Btw, I reported one that isn't fixed on randconfig-6.4.
>
> https://lore.kernel.org/all/1770d098-8dc7-4906-bed2-1addf8a6794d@kili.=
mountain/
>
>   CC [M]  crypto/twofish_common.o
> crypto/twofish_common.c: In function =E2=80=98__twofish_setkey=E2=80=99:
> crypto/twofish_common.c:683:1: warning: the frame size of 2064 bytes i=
s=20
> larger than 2048 bytes [-Wframe-larger-than=3D]
>   683 | }
>       | ^
>   CHECK   crypto/twofish_common.c

Thanks for the report, I forgot about this bit.

I have a small fragment that I pass to the randconfig generator
to avoid some common problems and also give me much faster
builds:

# maximize search space, disable options not worth testing
CONFIG_COMPILE_TEST=3Dy
# reduce compile-time dependencies
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy

CONFIG_COMPILE_TEST=3Dy forces a number of options to be
hidden from build tests, which is generally super useful.
The one that ended up hiding the stack growth above is
CONFIG_GCOV_PROFILE_ALL. I'll try enabling it for a few
builds to see what else shows up with it.

        Arnd
