Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACE57188A6
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 19:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjEaRmB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 13:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEaRlv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 13:41:51 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580961B6
        for <stable@vger.kernel.org>; Wed, 31 May 2023 10:41:21 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E8D45320024A;
        Wed, 31 May 2023 13:41:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 31 May 2023 13:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1685554875; x=1685641275; bh=Z27KUhqn8HR8f/r0qD5mXmzbwOrJsrhhMRW
        X0m4do3s=; b=fZEojO3FsIZz7YDoFRqxXh/Oaj8F1uHOB2VEH/63jFvQnlaqFrZ
        RPz/1RNkRpfhhqUelyBu1d977dKpP0vDBtZ6okmFbpl4QHQBIjsnbMNjnUepqGz4
        Cmc0BSPrHWRbqom5NQLx3Vl+zefnWUoKtvU50Ewx/gm8matWQu9S0Hcl0YI/z3io
        Fwod5i+xQz1JPIIpzeOL1EKKrXpcVqyxxyKTlsFN9hcrSn9vLZVlIfqp66rokAqr
        JiHvSFHntG9UZrefJs5cJrSc/uuRDLiaXvxhrKUqicGpHi3HEAY2pWv8KKOoUM6j
        jPSiVnnMWuQNFiHfJaXULsVkCOj3SIjneFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685554875; x=1685641275; bh=Z27KUhqn8HR8f/r0qD5mXmzbwOrJsrhhMRW
        X0m4do3s=; b=gtCpiAKxOJzmkRzD8E12D5NqlUAjVyh2iEdXWxSRfIc9tfpnpfL
        ople+zAjw9IV6xiQTxXj+pGOW8MoSLvZDWyrkDMHso7AC04+LG9Ccmtabom3nsrx
        XNVSKkGdMrcOnWV5x5c7PFThEsgLrC7NMmlTOLS35VrMD2ePB7pGp4xqUVT5d4QC
        i1fuNWT1/LgUsTqJnSzTshaWSIZkYDv0jOOTB5LpGy5WwE8W18+IYKlmSEEa4Nvv
        2nLchz5xEdCFik1kseI0ll+xMNrhkcPbxb33YHE4vPhtEOzbeR6me5VNc4PaekWm
        AfsUmPEsgQ3qW6T7GLtFwTYzJ93G3lN81Ag==
X-ME-Sender: <xms:u4Z3ZLDU4Mxq-8SZ614Y-XAWGyU3aqP9DU1DQPeWAZvZWzcl3yuHkA>
    <xme:u4Z3ZBjLBjWWGHF7TnUul3KFmvLgedAMS1pHxCJ9-p1asa7FPVYNhCvXiDnsBRgiS
    YM0gyd2qZ3Csw>
X-ME-Received: <xmr:u4Z3ZGlh3K9HDB8yOC3m4MH33tV5IponHAQKUPrQpJa2qr41Q-JtonKTeiMyt2TRoluPiVVTFAPlWkGoFNi9d6hs_Ydr0LhWO8zu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgf
    ekffeifeeiveekleetjedvtedvtdeludfgvdfhteejjeeiudeltdefffefvdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrh
    horghhrdgtohhm
X-ME-Proxy: <xmx:u4Z3ZNw7CQCLp2V4u_1CFr6U5jmXGL0AnDKOAJB60w8E41w6BNwA1w>
    <xmx:u4Z3ZATpyYKItdJRk8VjrNtWFh9AV1DZpNunm8t_ZwYo8xnh3h3yNA>
    <xmx:u4Z3ZAZr6N9sUKSlXwIIV2sx_5icdK-RCs285izbdrRpK_dp6iqGTQ>
    <xmx:u4Z3ZLeSHypESh7gGwYyWTRfrYVUAg0zZKwM9vZu1_teriKNtNOoFQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 13:41:14 -0400 (EDT)
Date:   Wed, 31 May 2023 18:41:13 +0100
From:   Greg KH <greg@kroah.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: S0ix guard rails for amdgpu in 6.1
Message-ID: <2023053107-petty-racoon-4f9b@gregkh>
References: <14df2f2b-21cf-5204-9826-698be6ccab90@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14df2f2b-21cf-5204-9826-698be6ccab90@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 31, 2023 at 12:27:03PM -0500, Limonciello, Mario wrote:
> Hi,
> 
> There is a commit in 6.3 that adds some guard rails to ensure amdgpu doesn’t
> run s2idle flows unless the hardware really supports it.  Can you please
> take this into 6.1.y?
> 
> ca4751866397 ("drm/amd: Don't allow s0ix on APUs older than Raven")
> 
> It is not necessary to take the commit it marks “a fix” in it’s commit
> message, as a problem was found in that commit and it will be reverted in
> the near future.

Now queued up, thanks.

greg k-h
