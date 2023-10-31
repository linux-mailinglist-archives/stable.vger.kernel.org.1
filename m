Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1D57DCC1F
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344067AbjJaLts (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbjJaLts (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:49:48 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19961DA
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:49:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0871132009DC;
        Tue, 31 Oct 2023 07:49:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 31 Oct 2023 07:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1698752980; x=1698839380; bh=hb
        YOa22447mRttnGntWhHFRlRn2lORGwh8Zsj6YyhzU=; b=Bc7w8HUmNtoW4BMGNA
        mBGv+JAlpk4rGmFdyB1CPeF6gqv+flLr9ifzvVE5TpF6A5bCdvkwFVoz7fsUfRap
        GLiMMzGFMQZkNY2bLhr42Yhqq8yfKNycgyLMXRGCsnBZnGeQ+dioaM6SOEhFXIeu
        n0l3ZPPPYUk/kLeBpqOin0XI4gIfYowGpiZedL9Gh4+Vsy9xfn39n+VUEsJkK4ap
        dZTl/DeyueURY5AkTMizkXIsTkyUrseGr4Geqi8NjVX+eY3x92LPh66wX3Oo9gM4
        WutBxL3vpMkxyqQbDaazSdCyVchQtwMIsfPcGONagXOx81RkfGEMmYJJijXGLCSE
        RsHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698752980; x=1698839380; bh=hbYOa22447mRt
        tnGntWhHFRlRn2lORGwh8Zsj6YyhzU=; b=n6rgdGRZz5UGs+S8nu8JqVGoxLLN1
        H048p+7Xv9D284iDOjWT8Rm/oOiBGil3xVVgskXN1wCcysluTDjKJef64UL805An
        CFCARixU3h8gb/KOcnASMFYan/5lPXgO+1G8bN11Gn/6Ua6yrEKxYs56f72gft4G
        0QCSMzUcjzEkoPttG9EXhS5HoYS7/DIIoi7sADHSZzM/AjnnQBXil215YdhjsfDM
        M60rb0dmGmcvt0WAhizowijgs4mTNV6SaNGVK+4PZR3Lyy9jkSof1XcGRnG1O5If
        JFN/0p2zaBNTnFkgKmmKRiGwMiudP9i83ona5Mj4V1I0TgJ6pOr7GUSWg==
X-ME-Sender: <xms:1OlAZaTeb4DBsPVH_eWMuAIQ_kXm4nFpY0ShtoEzvUR5B4fm1buNjw>
    <xme:1OlAZfw_z_Ac7VlZF_y6UOuSDtXqDs-ALKT-tswkeFE68K1vlGSIz6bKgsUNd9yb4
    hUBvl4x9KDUzw>
X-ME-Received: <xmr:1OlAZX3-ajeSkLa11NSFJ3lyu-MmRA4gzDXxeYwjxJMJk9_zLakpmCfDF1-sOltCZZcdkO8NSmlLZEzODc4wa4OEuKsguJAJDQqalQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:1OlAZWAVUv9af9118sVXX39QrrAJ585y_dKJboeUBz3_2wOYvl9EQQ>
    <xmx:1OlAZTge66UZF03920885ETTi_IJVxGw18WeENphwWXoalhUiEWuJQ>
    <xmx:1OlAZSrKyM7vR-GOGLEPXkgJbwOXeUcaEmNqdcR5lLP6EIeDuHRC5Q>
    <xmx:1OlAZYautTiWkAwTwYBf76FVPKiCzZhAxM0neXQ1dxI9rd1QlLAcyQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 07:49:39 -0400 (EDT)
Date:   Tue, 31 Oct 2023 12:49:38 +0100
From:   Greg KH <greg@kroah.com>
To:     Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        hiraku.toyooka@miraclelinux.com, Chao Yu <chao@kernel.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 4.19] f2fs: fix to do sanity check on inode type during
 garbage collection
Message-ID: <2023103123-purchase-criteria-8b54@gregkh>
References: <20231025085432.11639-1-kazunori.kobayashi@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025085432.11639-1-kazunori.kobayashi@miraclelinux.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 25, 2023 at 08:54:32AM +0000, Kazunori Kobayashi wrote:
> From: Chao Yu <chao@kernel.org>
> 
> commit 9056d6489f5a41cfbb67f719d2c0ce61ead72d9f upstream.
> 
> As report by Wenqing Liu in bugzilla:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=215231
> 
> - Overview
> kernel NULL pointer dereference triggered  in folio_mark_dirty() when mount and operate on a crafted f2fs image
> 
> - Reproduce
> tested on kernel 5.16-rc3, 5.15.X under root
> 
> 1. mkdir mnt
> 2. mount -t f2fs tmp1.img mnt
> 3. touch tmp
> 4. cp tmp mnt
> 
> F2FS-fs (loop0): sanity_check_inode: inode (ino=49) extent info [5942, 4294180864, 4] is incorrect, run fsck to fix
> F2FS-fs (loop0): f2fs_check_nid_range: out-of-range nid=31340049, run fsck to fix.
> BUG: kernel NULL pointer dereference, address: 0000000000000000
>  folio_mark_dirty+0x33/0x50
>  move_data_page+0x2dd/0x460 [f2fs]
>  do_garbage_collect+0xc18/0x16a0 [f2fs]
>  f2fs_gc+0x1d3/0xd90 [f2fs]
>  f2fs_balance_fs+0x13a/0x570 [f2fs]
>  f2fs_create+0x285/0x840 [f2fs]
>  path_openat+0xe6d/0x1040
>  do_filp_open+0xc5/0x140
>  do_sys_openat2+0x23a/0x310
>  do_sys_open+0x57/0x80
> 
> The root cause is for special file: e.g. character, block, fifo or socket file,
> f2fs doesn't assign address space operations pointer array for mapping->a_ops field,
> so, in a fuzzed image, SSA table indicates a data block belong to special file, when
> f2fs tries to migrate that block, it causes NULL pointer access once move_data_page()
> calls a_ops->set_dirty_page().
> 
> Cc: stable@vger.kernel.org
> Reported-by: Wenqing Liu <wenqingliu0120@gmail.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
> ---
>  fs/f2fs/gc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c

Also applied to 5.4.y and 4.14.y, you can't forget those :)

thanks,

greg k-h
