Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DE17C93AE
	for <lists+stable@lfdr.de>; Sat, 14 Oct 2023 11:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjJNJLI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 14 Oct 2023 05:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjJNJLH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 14 Oct 2023 05:11:07 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95397AD
        for <stable@vger.kernel.org>; Sat, 14 Oct 2023 02:11:04 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8DE7532009C4;
        Sat, 14 Oct 2023 05:10:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 14 Oct 2023 05:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1697274659; x=1697361059; bh=g4
        SMTb693pxutFd1rZmtdpkvzw7HxP/4Iwdp4VvcK2E=; b=a02Nj30JQimAFgcwCb
        muVUYQKSNq2/JIdErFTo6DT1NI4rZITa0vw7cUfCVv8sPp5NBRNxoZY3kvRZE2yD
        HES7CwAaMmZOj6Wsn+jamlyqZUzctF4axsTcq6eUZSxF3AVAiiHthAXc6myGu/yF
        h+dT29LA0IWy7WOCYITwAftE12iVUps8IrbiV9qicvGvFk2VcXWwqhoYd/dNQ9Ic
        oC7JgeWv6IE72mNef7wU+XWIz6AvUAeSMfFIInE9VkmS6e8FbKR+GgW09zDFoqOJ
        CY2f0cOoF2KbBHftktLtWYXm3tWhOUTt8GvB+3dUzEFHy6OYG+qfyMI0xotV0GgS
        CyTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697274659; x=1697361059; bh=g4SMTb693pxut
        Fd1rZmtdpkvzw7HxP/4Iwdp4VvcK2E=; b=MO3Cj6pY7uUHeDvlpuVp1R4uGRZaO
        amnRcaaLEI27h/ES/3oT4MBySUGqgV4ewxFvZOn4t3L0LikQtmMM6DW9mMszBTlt
        1DNyYRNt/JtVFXcq6ujwIqKNhHfelx9y7qh+OHb27eVnd4yHpdeidivpLX4R028p
        xydsP4J5dsfh7X+bvPRamug/kPoVM+1NUYVbx0ZPEN8DJCoM2tc9LXrzHFfHFfZH
        Te23sSQ1EfiN7oanMNTI1d9hFa1AGZLWudkSwosh5pcSfnomUYuHTm00MfxSY078
        hgTbD4con7FfLv8bN8HFCNpAlUsmPGcz9rZGj2L2EFNj4cN2w6uNZX6fA==
X-ME-Sender: <xms:IlsqZVN7kUVV9sIbn9_vwGA5DAyIduecOjzheQTPDuQZnjF6cPwWqQ>
    <xme:IlsqZX8wOEbjAv3qizbxugjIyGaYLEDRHylSHCkSO35J93vLa5pvN8xf76Z0jdA7A
    EGwQbrAs4Z_sg>
X-ME-Received: <xmr:IlsqZUQY8y8Z8avkMko--egK1f6gnlOwJ0GyveMh79Asemgm9W1X89IpxvQRC-v7frqPIbuClmlBOZ8L8D1sVoBa9pI4kaU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieehgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:IlsqZRvZ4W1NieaDaq3k4Ry1BdqRZMQjeA5yN7uuXNlEtXpE3czk1A>
    <xmx:IlsqZdd2X31z0I0u2Uxg9t2_NVMFGE3WZ_a7ASyIaxDjPkAoF1K3lw>
    <xmx:IlsqZd1fhadJLaEfVRMKcvJq_AYZI6OpEZb0uNTAStb-8pLv8hL-0g>
    <xmx:I1sqZQU2Kx3FrxPJwjkl1OnEVi2DV8dUtP-eVjCwS4tltpa3O7orDA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 05:10:58 -0400 (EDT)
Date:   Sat, 14 Oct 2023 11:10:56 +0200
From:   Greg KH <greg@kroah.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] nvme: remove unprivileged passthrough support
Message-ID: <2023101437-external-paddling-8786@gregkh>
References: <CGME20231014090724epcas5p443807b5d724c97645a8a85fc627bf1ad@epcas5p4.samsung.com>
 <20231014090108.128809-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014090108.128809-1-joshi.k@samsung.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Oct 14, 2023 at 02:31:08PM +0530, Kanchan Joshi wrote:
> Passthrough has got a hole that can be exploited to cause kernel memory
> corruption. This is about making the device do larger DMA into
> short meta/data buffer owned by kernel [1].
> 
> As a stopgap measure, disable the support of unprivileged passthrough.
> 
> This patch brings back coarse-granular CAP_SYS_ADMIN checks by reverting
> following patches:
> 
> - 7d9d7d59d44 ("nvme: replace the fmode_t argument to the nvme ioctl handlers with a simple bool")
> - 313c08c72ee ("nvme: don't allow unprivileged passthrough on partitions")
> - 6f99ac04c46 ("nvme: consult the CSE log page for unprivileged passthrough")
> - ea43fceea41 ("nvme: allow unprivileged passthrough of Identify Controller")
> - e4fbcf32c86 ("nvme: identify-namespace without CAP_SYS_ADMIN")
> - 855b7717f44 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
> 
> [1] https://lore.kernel.org/linux-nvme/20231013051458.39987-1-joshi.k@samsung.com/
> 
> CC: stable@vger.kernel.org # 6.2
> Fixes <855b7717f44b1> ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")

Nit, this should be:
Fixes: 855b7717f44b1 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")

