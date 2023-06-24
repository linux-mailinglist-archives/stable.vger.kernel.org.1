Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F5B73CB3B
	for <lists+stable@lfdr.de>; Sat, 24 Jun 2023 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjFXOEz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 24 Jun 2023 10:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjFXOEv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Jun 2023 10:04:51 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EB9E4F
        for <stable@vger.kernel.org>; Sat, 24 Jun 2023 07:04:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2FF6A3200951;
        Sat, 24 Jun 2023 10:04:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 24 Jun 2023 10:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687615482; x=1687701882; bh=CA
        GBpHzGhBQLbDfC6Hop4DzJOJU7lXmEqqkgMWsGZvA=; b=AuiJX642+d4opIViDO
        G88K968JKf9Jp5lfKUPkyBXh9AN5P06N612Th0//wkziWwuldCpoz7OxzCajWX+o
        32KrEF65LPQkwJsvI8SwrCBeI+3olV7n69yIWYgzXbcA6YBx5tHy1zr0/Zr9rouc
        RphOu0r71iLH6oRo9WqEBkpuFUWFGkz40YZ1BtliWoOiY9GVEx9VpJWM8MANTsuA
        g92Z0KOtJfFsG4YHJEVljwFdgoemlUorgJWVxe8XNNYbKfWRbaaE5zqy+MM6LkY4
        Fk+D9CDfg4HExoFiyaOP6fD++keAD0cjBwjE429HwCXy1ga8Y2FJ7EyUXrip+rIb
        drSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687615482; x=1687701882; bh=CAGBpHzGhBQLb
        DfC6Hop4DzJOJU7lXmEqqkgMWsGZvA=; b=NhALvJn3+vpppI9M/KpcHG7rjHiET
        zz7P6M9Wrm11E5xK1ka/XaKt0NRdJo/KmxkvtW4Iye0N9l0A4h1SEeyVrEOSpOU8
        FIqWndgqGWpCjmjYrj/FQdvZ7owiL+/YH3Isj/EPKNbmDOKxiPnwk/m4ZPZeLc4h
        7VkaWFWLSLld33WTTkc7AecmXUKis7VSYJsVud1tsSRF6boa0C4TnR0QK9kBqgLu
        vamkD5r/3TpQTVLmPH9YYhHuSpB0u2UQy3csDPBvZEuWxddXq3Za5L8VRP6chAnu
        PpyTK5J4STR8GAJllfNPAoZt05z4oadgzPKe4efWLcobpY4zc0hE6kKxw==
X-ME-Sender: <xms:-veWZM5mry7BpCnpFWVDA4a6qNW4Wzy37OwQU35NyjqzdDXuJQ9flw>
    <xme:-veWZN716Sg8Nzi4qWfMIt2bh8PN-0t10piJm6_GOtXMHhULWtlshKw9PwfP4lwNM
    QRQcVmR3FZqtQ>
X-ME-Received: <xmr:-veWZLd7i8KMeVg1ClsCKHqEuzOoJuat3XygIcwBoi6xWuhSuyBOt6BnsR0PI3ooPrG8luWXS1z61ufKcwWTbOWcu4vTYanhBowmyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegjedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:-veWZBKDISrOY8aHql6IAuBnnFAL3ImfD10GGOvPcP5uEZ7bb6uFcw>
    <xmx:-veWZAK_4rjJxlrpalXM2VH_NpcESp59scaPcVmLEuqPG7x701NJhA>
    <xmx:-veWZCy85cKbjVeCEdf3AvXtKeU9W2GT6AAEo2mXajDQxtskip8goA>
    <xmx:-veWZP-__GIwtfuh2W4v-tJNOZib4SV8CUwyMWz52ZmvDzBuJ9yg5w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jun 2023 10:04:42 -0400 (EDT)
Date:   Sat, 24 Jun 2023 16:04:38 +0200
From:   Greg KH <greg@kroah.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     stable@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.4.y] writeback: fix dereferencing NULL mapping->host on
 writeback_page_template
Message-ID: <2023062427-glare-clutter-6dcc@gregkh>
References: <2023062336-squall-impotence-3b78@gregkh>
 <20230623134601.1564846-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623134601.1564846-1-aquini@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 23, 2023 at 09:46:01AM -0400, Rafael Aquini wrote:
> commit 54abe19e00cfcc5a72773d15cd00ed19ab763439 upstream.
> 
> When commit 19343b5bdd16 ("mm/page-writeback: introduce tracepoint for
> wait_on_page_writeback()") repurposed the writeback_dirty_page trace event
> as a template to create its new wait_on_page_writeback trace event, it
> ended up opening a window to NULL pointer dereference crashes due to the
> (infrequent) occurrence of a race where an access to a page in the
> swap-cache happens concurrently with the moment this page is being written
> to disk and the tracepoint is enabled:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000040
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 800000010ec0a067 P4D 800000010ec0a067 PUD 102353067 PMD 0
>     Oops: 0000 [#1] PREEMPT SMP PTI
>     CPU: 1 PID: 1320 Comm: shmem-worker Kdump: loaded Not tainted 6.4.0-rc5+ #13
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230301gitf80f052277c8-1.fc37 03/01/2023
>     RIP: 0010:trace_event_raw_event_writeback_folio_template+0x76/0xf0
>     Code: 4d 85 e4 74 5c 49 8b 3c 24 e8 06 98 ee ff 48 89 c7 e8 9e 8b ee ff ba 20 00 00 00 48 89 ef 48 89 c6 e8 fe d4 1a 00 49 8b 04 24 <48> 8b 40 40 48 89 43 28 49 8b 45 20 48 89 e7 48 89 43 30 e8 a2 4d
>     RSP: 0000:ffffaad580b6fb60 EFLAGS: 00010246
>     RAX: 0000000000000000 RBX: ffff90e38035c01c RCX: 0000000000000000
>     RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90e38035c044
>     RBP: ffff90e38035c024 R08: 0000000000000002 R09: 0000000000000006
>     R10: ffff90e38035c02e R11: 0000000000000020 R12: ffff90e380bac000
>     R13: ffffe3a7456d9200 R14: 0000000000001b81 R15: ffffe3a7456d9200
>     FS:  00007f2e4e8a15c0(0000) GS:ffff90e3fbc80000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 0000000000000040 CR3: 00000001150c6003 CR4: 0000000000170ee0
>     Call Trace:
>      <TASK>
>      ? __die+0x20/0x70
>      ? page_fault_oops+0x76/0x170
>      ? kernelmode_fixup_or_oops+0x84/0x110
>      ? exc_page_fault+0x65/0x150
>      ? asm_exc_page_fault+0x22/0x30
>      ? trace_event_raw_event_writeback_folio_template+0x76/0xf0
>      folio_wait_writeback+0x6b/0x80
>      shmem_swapin_folio+0x24a/0x500
>      ? filemap_get_entry+0xe3/0x140
>      shmem_get_folio_gfp+0x36e/0x7c0
>      ? find_busiest_group+0x43/0x1a0
>      shmem_fault+0x76/0x2a0
>      ? __update_load_avg_cfs_rq+0x281/0x2f0
>      __do_fault+0x33/0x130
>      do_read_fault+0x118/0x160
>      do_pte_missing+0x1ed/0x2a0
>      __handle_mm_fault+0x566/0x630
>      handle_mm_fault+0x91/0x210
>      do_user_addr_fault+0x22c/0x740
>      exc_page_fault+0x65/0x150
>      asm_exc_page_fault+0x22/0x30
> 
> This problem arises from the fact that the repurposed writeback_dirty_page
> trace event code was written assuming that every pointer to mapping
> (struct address_space) would come from a file-mapped page-cache object,
> thus mapping->host would always be populated, and that was a valid case
> before commit 19343b5bdd16.  The swap-cache address space
> (swapper_spaces), however, doesn't populate its ->host (struct inode)
> pointer, thus leading to the crashes in the corner-case aforementioned.
> 
> commit 19343b5bdd16 ended up breaking the assignment of __entry->name and
> __entry->ino for the wait_on_page_writeback tracepoint -- both dependent
> on mapping->host carrying a pointer to a valid inode.  The assignment of
> __entry->name was fixed by commit 68f23b89067f ("memcg: fix a crash in
> wb_workfn when a device disappears"), and this commit fixes the remaining
> case, for __entry->ino.
> 
> Link: https://lkml.kernel.org/r/20230606233613.1290819-1-aquini@redhat.com
> Fixes: 19343b5bdd16 ("mm/page-writeback: introduce tracepoint for wait_on_page_writeback()")
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> Reviewed-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Aristeu Rozanski <aris@redhat.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> ---
>  include/trace/events/writeback.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All now queued up, thanks.

greg k-h
