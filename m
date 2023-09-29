Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD997B2C17
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 07:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjI2Fws (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 01:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjI2Fwr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 01:52:47 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3CC1B2
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 22:52:45 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E74235C0DBB;
        Fri, 29 Sep 2023 01:52:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 29 Sep 2023 01:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1695966761; x=1696053161; bh=XV
        vqIfHPHtEcbdr5LfkG8vjFGIU6rfeQaDgYBi2Jgi8=; b=A6eKm/T5fF7OJUBJu8
        uBDMUtuR2BXSND3tVu1sJ6ujOMZ/QOuK9blKH1wOsutFXX1KIk8S0Xb+lU4SQos8
        G83j2HNkgxsdTTfV/pV0TgGb/F9pKwPQSVjf92ABtmioFTlhc2XBhlepo7zfEq2v
        EzsqfnE8JzDgVvsDruH5HGDzTngOMLEF3NbZhayhHrBg2uCbaM7PwuUaiCCBVAR/
        OLe68irW5mgumWIXqq/sO4FkjzXByaAY9AkgdaxBc9zbYxIZ3IQFP+pfUEJNkPwn
        8A1ajkSsQj4893t5TVJCG68+DsSjRyXKI/S8kRD13c9YgsIiCcYKw0urwPQ5Xnxn
        KTpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695966761; x=1696053161; bh=XVvqIfHPHtEcb
        dr5LfkG8vjFGIU6rfeQaDgYBi2Jgi8=; b=QF7vgD4LMXp4C85ROdkiLktIjmG0w
        Os6Iw5kex4POEDPPM4OSU2UopA+Lnl+//6yfEzPbwTASRx8WAA0M0D8gcSPPsoOx
        4PVXvaFyqRDdF1XoJtwi9DKPae1srUnQICyEt1ps9bYQgx1eowlBmK6/1s2hMgA+
        3sPoT+mxVng3J80HH/qZI+Cw4/1GOigZfqA8Dps6h+q1HpBzJVUWTQa58ELJXnwh
        4RE8uAoPCblI2ZtfqYtWQn5Rb7J9nQq4SmdhK+Hh5WazRi5opOW8H/Ooyg/hUXQI
        LPT/NdtlLb6f5seicv9rcjQER1EkEHcUeLDHIvD7lYDrBuaDqNtE3PXxQ==
X-ME-Sender: <xms:KWYWZUylQppie6wVSZBpcbsaMFrmJruDdFkjNEsAgma62xhcWGql8Q>
    <xme:KWYWZYTF6CBRwyKnFDtM-4nFRnP7R-1uXlp4EA2uH3kEQggfnhXqeCw3vonvBDiCF
    haSyrACQpOLOA>
X-ME-Received: <xmr:KWYWZWUJoak3__zdaYqtU3WiHmQbSh9qjGCQZdZLARzTVv-b-PYs-SMl2lr-AG5OXDiFeJySYJ5ZDiZfQSyrRZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddugddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheefle
    ettdeihffhleeltdffffethedvffeglefgkeeiheeitdehheduveehheehnecuffhomhgr
    ihhnpehurhhluggvfhgvnhhsvgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghh
    rdgtohhm
X-ME-Proxy: <xmx:KWYWZSgqAWx3nWAGG7NcgBRYjnO0eG2nQE--blOzPL0hnS_Crd7IHw>
    <xmx:KWYWZWCngtEekFYLlRm2ZGkmXRVgy9o3-6J85RTtMzJhyP_UViKx-w>
    <xmx:KWYWZTIgaKRkABYp9eDi0i8R-3raV_Lhqpckq4fRyV_YnEWs9WI19A>
    <xmx:KWYWZY31E8JHjaWUU1APyxeqbqc-D8ljyKHIR9aHt6gfTQXlDFFsHg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Sep 2023 01:52:40 -0400 (EDT)
Date:   Fri, 29 Sep 2023 07:52:38 +0200
From:   Greg KH <greg@kroah.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 3/3] mmap: Add clarifying comment to vma_merge() code
Message-ID: <2023092922-erupt-pope-aaa5@gregkh>
References: <20230928171634.2245042-4-Liam.Howlett@oracle.com>
 <ZRW1MBvWCCFevIg1@f61ccfac960a>
 <20230928172639.hmnzdsk3y4snjkwe@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928172639.hmnzdsk3y4snjkwe@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 28, 2023 at 01:26:39PM -0400, Liam R. Howlett wrote:
> * kernel test robot <lkp@intel.com> [230928 13:18]:
> > Hi,
> > 
> > Thanks for your patch.
> > 
> > FYI: kernel test robot notices the stable kernel rule is not satisfied.
> > 
> > The check is based on https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html/*option-1__;Iw!!ACWV5N9M2RV99hQ!Oav0h0ZRmSJZ5mOjG5-prYR3nJYyas32Z8AfSgTboijdcVMSWzmyOVzI-s1RuIdzGakIiSzdg1vB$ 
> > 
> > Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> > Subject: [PATCH v2 3/3] mmap: Add clarifying comment to vma_merge() code
> > Link: https://urldefense.com/v3/__https://lore.kernel.org/stable/20230928171634.2245042-4-Liam.Howlett*40oracle.com__;JQ!!ACWV5N9M2RV99hQ!Oav0h0ZRmSJZ5mOjG5-prYR3nJYyas32Z8AfSgTboijdcVMSWzmyOVzI-s1RuIdzGakIiRhQUpN6$ 
> 
> Right, thanks.  This is part of the series but stable does not need to
> backport this one.
> 
> Sorry for Cc'ing stable on the last patch of the series.
> 

It's not an issue, I think the kernel test robot is a bit pedantic here,
so no worries :)
