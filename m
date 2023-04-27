Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299216F02B8
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbjD0IlN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 04:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbjD0Ik6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 04:40:58 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED1A4ED8
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 01:40:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E42C5C0225;
        Thu, 27 Apr 2023 04:40:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 27 Apr 2023 04:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682584856; x=1682671256; bh=bL
        /TnZJi6O3rmqL+8gm01PXeH4Tqnqf2D6c8CMpT/SM=; b=DHEOMPdkDyqoZNBOGO
        99bQckwcmHcBmc5Mspqh7Y36YKl6KPj/oEGcUZgD19O9BBeKkj8u1UnorFb4jXwV
        TDZI+DxuUscOLjh+XircyJgQ7jrxavmgYD+ZahqaHE8qgfCXL2DP7ATbjBtbwBq4
        KD/4HFBdxctXDfkq1SL5lljMt5jzC2sMPrT067r56rx4okKW48/4uFXLTNjv/iu4
        idJOsG/EO965DAQ2imrLuFIZxDsQDpDNT4B0IEBqkWV9Q9WLO0uwq7IZwApWV67c
        2jzKq0w0JYMD+uVwS3XgZksra0jkkxMOFAMm+2T0tTI/1UIrGveNjJlgFq7W3NG2
        URRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682584856; x=1682671256; bh=bL/TnZJi6O3rm
        qL+8gm01PXeH4Tqnqf2D6c8CMpT/SM=; b=Dje4XTg6O6LEClF76rxmSyIMWhCAj
        jsWWd6ksNByiU77km+kCe4ehApu4OXGlUxeUxs+13INFqCeTMf6eHDRor0iPh8t6
        QWu8iP48JeTBiVtEn+YjQza7J7/1uJMGLH3JsHkhjuKOu/DEN7JOJjXK7F6O2UcI
        wZDL60NM26BQK7QN64362IbE0ha2rQVZy04C42Q/DN6DtOX/7O2WmmkgH9pE6LTx
        KJK50cmBaANfLQgv/DxqgxIedsSL4Hn/OtEbHi1GveC+dsTvHox8IbI7GRIB6GHf
        WfSacR1Ese+UE9PEKnALX4EeA8n47v2SSCraXquVjZISAUo5Lwn0igoLQ==
X-ME-Sender: <xms:GDVKZI922ZaIJGYAeHksITB1Uac5xdfPHn4WKhDlUhP0ZCos5TUH1w>
    <xme:GDVKZAsR5jD-D9Vnm7c8psnCHlZC5LXODMJjnJ3iXGHvEqQRPc9z0xwIVzR-cGLM8
    r31u-LuKPVwVw>
X-ME-Received: <xmr:GDVKZOB7ybyanIpdN8ID4oCENL0Xk_AuG5CwmskEFi6-x6GOYqL012uZ39AGTFO7cFxzw7k8iKzSyhpYdfLJuPemnq_XSSt4L3SrNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:GDVKZIdqeB53hWylvxvG05QVQTpHPJTxAUNX0boZ9Uzrah0bMa3m8g>
    <xmx:GDVKZNNpsquDNJRxOyzUZ5uWjS4VXz0kjhQXOxCi0bnmIqQKwtfI6A>
    <xmx:GDVKZCk9dW9v8JW-lW4TNAzygriIItnwDJ8o8ratcnxMoDyuAoYx5Q>
    <xmx:GDVKZJCdXQQLAPbcfz_LnhIErxhuSBKzCshStAIzYH2BkmTv_uk5Aw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 04:40:55 -0400 (EDT)
Date:   Thu, 27 Apr 2023 10:40:53 +0200
From:   Greg KH <greg@kroah.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     stable@vger.kernel.org,
        syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.2.y] mm/mempolicy: fix use-after-free of VMA iterator
Message-ID: <2023042738-humorous-handprint-cd6c@gregkh>
References: <2023042253-speed-jolliness-682f@gregkh>
 <20230424153108.3354538-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424153108.3354538-1-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Apr 24, 2023 at 11:31:08AM -0400, Liam R. Howlett wrote:
> [ Upstream commit f4e9e0e69468583c2c6d9d5c7bfc975e292bf188 ]
> 
> set_mempolicy_home_node() iterates over a list of VMAs and calls
> mbind_range() on each VMA, which also iterates over the singular list of
> the VMA passed in and potentially splits the VMA.  Since the VMA iterator
> is not passed through, set_mempolicy_home_node() may now point to a stale
> node in the VMA tree.  This can result in a UAF as reported by syzbot.
> 
> Avoid the stale maple tree node by passing the VMA iterator through to the
> underlying call to split_vma().
> 
> mbind_range() is also overly complicated, since there are two calling
> functions and one already handles iterating over the VMAs.  Simplify
> mbind_range() to only handle merging and splitting of the VMAs.
> 
> Align the new loop in do_mbind() and existing loop in
> set_mempolicy_home_node() to use the reduced mbind_range() function.  This
> allows for a single location of the range calculation and avoids
> constantly looking up the previous VMA (since this is a loop over the
> VMAs).
> 
> Link: https://lore.kernel.org/linux-mm/000000000000c93feb05f87e24ad@google.com/
> Fixes: 66850be55e8e ("mm/mempolicy: use vma iterator & maple state instead of vma linked list")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reported-by: syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com
>   Link: https://lkml.kernel.org/r/20230410152205.2294819-1-Liam.Howlett@oracle.com
> Tested-by: syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit f4e9e0e69468583c2c6d9d5c7bfc975e292bf188)
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> (cherry picked from commit 905e8727c6aca577a8151105a6e0912591649690)

There is no such commit in Linus's tree.  Please be more careful in the
future...

