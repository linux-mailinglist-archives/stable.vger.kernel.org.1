Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62A87805B2
	for <lists+stable@lfdr.de>; Fri, 18 Aug 2023 07:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357238AbjHRFdi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 18 Aug 2023 01:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357903AbjHRFdY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 Aug 2023 01:33:24 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4DD1706;
        Thu, 17 Aug 2023 22:33:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2308B5C00D1;
        Fri, 18 Aug 2023 01:33:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 18 Aug 2023 01:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692336799; x=1692423199; bh=Gc15qWvK649Gi
        on2Drq5HT+hHTu1NHG5OYl6MDmkzx8=; b=1WjoWEpIiIi59tu822LZZkMN5IJTH
        xCgRaQ9uamnnsxuS8DqOUK81oFgP1c4Spe/Q8o2QaF2/79kIaTUxoWLmy3xu8i5S
        vaVM+/8nO2//Kzd0lPL7j3/mn9aUiUZB3O8rifUUYgsmW+2tF28OGby/oob+NW3w
        q2i9HYmhOYhIdTKp/cZA+uesaMA0VkPtDYG0Juej+fJAMOX4KUIKSFSft585GaKD
        cnBqPq3fkjhj5Nqj29HhzYYzSNlzmK2kVSKVmCH8D/43pQqNtg/shtt5Hfci+rHp
        eJHoT3VRzy6IxP28ddIFHtUd+GYIaR7iMgQ259HzSlufS4LScHg5Nockw==
X-ME-Sender: <xms:ngLfZCBoHPYvtZG7Wxc7YL2dtH-NPygbjWoZdaQUinVh7g2KTFm6Kw>
    <xme:ngLfZMgxG1X7cHIwpSbW1GnysRvWIPl6q5TSFpX_qUlY76wFzJjdf-QhN_fKcLlHp
    nooaQA4kULNrghgWB8>
X-ME-Received: <xmr:ngLfZFk6DvdFj5F4n5jmx1YdW0aeHyYf8e4IvYhfjCNIXdrFmq1P5sGG7_LWXRkXUJGzg3aakI2Ob1DqHQ3j0QtAdzzF9u0-bLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduvddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeefieehjedvtefgiedtudethfekieelhfevhefgvddtkeekvdekhefftdek
    vedvueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieek
    khdrohhrgh
X-ME-Proxy: <xmx:ngLfZAw6ajbDA8fh9OOLKMFhMdNfNDMur9BwPV4Nc8cbQOhYoiH-wg>
    <xmx:ngLfZHRDtcKYaB0zppdEMgbJsLbKAQduu2KwKsVPvM7SszCV1kLtug>
    <xmx:ngLfZLaMngko4vNM2g7H2MRG6ELIA8t5K-6D1VEvUkPPvzDcdF72Pg>
    <xmx:nwLfZGEV9I-6suDbJVywE8_d352Y_50RfF63QN74pDiD5u4dT0kxyw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Aug 2023 01:33:15 -0400 (EDT)
Date:   Fri, 18 Aug 2023 15:33:29 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Damien Le Moal <dlemoal@kernel.org>, s.shtylyov@omp.ru,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] m68k/q40: fix IO base selection for Q40 in
 pata_falcon.c
In-Reply-To: <a75c21bc-c776-cf19-a5b2-9163af035d65@gmail.com>
Message-ID: <ef903aa8-25aa-779b-cf88-33840b498282@linux-m68k.org>
References: <20230817221232.22035-1-schmitzmic@gmail.com> <20230817221232.22035-2-schmitzmic@gmail.com> <ca753d89-ad51-d901-4058-d974fea7e658@kernel.org> <a75c21bc-c776-cf19-a5b2-9163af035d65@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 18 Aug 2023, Michael Schmitz wrote:

> >> Cc: <stable@vger.kernel.org> # 5.14
> >
> > 5.14+ ? But I do not think you need to specify anything anyway since 
> > you have the Fixes tag.
> 
> 5.14+ perhaps. I'll check the docs again to see whether Fixes: obsoletes 
> the stable backport tag. I've so far used both together...
> 

You'd specify a "# x.y+" limit along with a "Fixes" tag if you don't want 
to backport as far back as the buggy commit (because some other 
pre-requisite isn't present on the older branches). But that does not 
apply in this case.

Writing "# 5.14" is surprising because (according to www.kernel.org 
landing page) that branch was abandoned, and no live branch was named. 
But in "git log" you can see that people write this anyway.

Writing "# 5.14+" or "# 5.15+" is clear enough but is normally omitted 
when it can be inferred from the Fixes tag. That's been my experience, at 
least.
