Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0689873CCAB
	for <lists+stable@lfdr.de>; Sat, 24 Jun 2023 22:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjFXU1q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 24 Jun 2023 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFXU1p (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Jun 2023 16:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1F5B5
        for <stable@vger.kernel.org>; Sat, 24 Jun 2023 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687638416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbXyyk/yBqQILU1gFxN7ECCFAbqxFWuc5FXiBKUeh9M=;
        b=V6vHlaH5dDOUs6RXaYOvE9w7R6Jxdlrzyz8lHhjolKAeWyz2WLDhCUH389NO5Jjdxvu+bP
        I2ZBN6BHIH96LRh6FYQvg1jqOqTZxZAfPGIWIM7Kp6MtwjvHgWcmKHrrYtgcBBoZRhwwv+
        4sHOLox1B05i9SrYHksQCdtTv1m2HG8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-ZV-FxS1HOkCVWB2n-IIWVA-1; Sat, 24 Jun 2023 16:26:54 -0400
X-MC-Unique: ZV-FxS1HOkCVWB2n-IIWVA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635984f84a9so2578206d6.0
        for <stable@vger.kernel.org>; Sat, 24 Jun 2023 13:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687638414; x=1690230414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbXyyk/yBqQILU1gFxN7ECCFAbqxFWuc5FXiBKUeh9M=;
        b=dSz33IvwF2NyNxeiFpP9u3ngrMu5S1npers7ZnuI0SRbBIEi86YvBRlB6+VN5qwKHI
         mfZrSElb6SrMNBjSyelHQknlphfs/nXnPcFGufxS8fSze4+mg6XPkSfkY0I7gfYivvGE
         QewBb6Sufbar8YtS5BILg/dZfC2X59eZvpCjPhiqRsny6j74vii9L3PFzBr3Y5jEM4uo
         cbUc/s55nJqN/7Nd0FN+0O9IVElLeHYc3d8snYNFK6aTO+KjBmKKdP9mQ2Fpm3yrdMSM
         FPnD/AyThTLR1Ykzcx5BA0HsnO9GsE2D1jDuXEHPp5/bUYuwnrllzAQlBohS/eHHPjE6
         7mXg==
X-Gm-Message-State: AC+VfDxHwSeyioBnZG3ErqTynl8ndhA8KF2vm6OyJZ+9gIfbXPJDLWx2
        dq7hp/2IB9NOVyq3HJcsqpVE9TG74MVzTdj6hgctmR4oRUZpl4UcEo/3wN1iD885SwjIfNqJXuk
        dP4o53iYk1YttDblB
X-Received: by 2002:a05:6214:4111:b0:62d:eb54:5f4d with SMTP id kc17-20020a056214411100b0062deb545f4dmr26915167qvb.38.1687638414173;
        Sat, 24 Jun 2023 13:26:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45SP7ygLE1GGGlF5/xUwSYzln5vf/n6k9iO0KJrYeVc94xkPjROkjdPgcmnmnI/31cP4nUeQ==
X-Received: by 2002:a05:6214:4111:b0:62d:eb54:5f4d with SMTP id kc17-20020a056214411100b0062deb545f4dmr26915161qvb.38.1687638413936;
        Sat, 24 Jun 2023 13:26:53 -0700 (PDT)
Received: from x1-fbsd (c-73-249-122-233.hsd1.nh.comcast.net. [73.249.122.233])
        by smtp.gmail.com with ESMTPSA id l4-20020ad44444000000b00625808d44cfsm1289268qvt.29.2023.06.24.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 13:26:53 -0700 (PDT)
Date:   Sat, 24 Jun 2023 16:26:51 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Greg KH <greg@kroah.com>
Cc:     stable@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.4.y] writeback: fix dereferencing NULL mapping->host on
 writeback_page_template
Message-ID: <ZJdRi6irmaebWDmg@x1-fbsd>
References: <2023062336-squall-impotence-3b78@gregkh>
 <20230623134601.1564846-1-aquini@redhat.com>
 <2023062427-glare-clutter-6dcc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062427-glare-clutter-6dcc@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jun 24, 2023 at 04:04:38PM +0200, Greg KH wrote:
> On Fri, Jun 23, 2023 at 09:46:01AM -0400, Rafael Aquini wrote:
> > commit 54abe19e00cfcc5a72773d15cd00ed19ab763439 upstream.
> > 
> > When commit 19343b5bdd16 ("mm/page-writeback: introduce tracepoint for
> > wait_on_page_writeback()") repurposed the writeback_dirty_page trace event
> > as a template to create its new wait_on_page_writeback trace event, it
> > ended up opening a window to NULL pointer dereference crashes due to the
> > (infrequent) occurrence of a race where an access to a page in the
> > swap-cache happens concurrently with the moment this page is being written
> > to disk and the tracepoint is enabled:
> > 
> >     BUG: kernel NULL pointer dereference, address: 0000000000000040
> >     #PF: supervisor read access in kernel mode
> >     #PF: error_code(0x0000) - not-present page
> >     PGD 800000010ec0a067 P4D 800000010ec0a067 PUD 102353067 PMD 0
> >     Oops: 0000 [#1] PREEMPT SMP PTI
> >     CPU: 1 PID: 1320 Comm: shmem-worker Kdump: loaded Not tainted 6.4.0-rc5+ #13
> >     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230301gitf80f052277c8-1.fc37 03/01/2023
> >     RIP: 0010:trace_event_raw_event_writeback_folio_template+0x76/0xf0
> >     Code: 4d 85 e4 74 5c 49 8b 3c 24 e8 06 98 ee ff 48 89 c7 e8 9e 8b ee ff ba 20 00 00 00 48 89 ef 48 89 c6 e8 fe d4 1a 00 49 8b 04 24 <48> 8b 40 40 48 89 43 28 49 8b 45 20 48 89 e7 48 89 43 30 e8 a2 4d
> >     RSP: 0000:ffffaad580b6fb60 EFLAGS: 00010246
> >     RAX: 0000000000000000 RBX: ffff90e38035c01c RCX: 0000000000000000
> >     RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90e38035c044
> >     RBP: ffff90e38035c024 R08: 0000000000000002 R09: 0000000000000006
> >     R10: ffff90e38035c02e R11: 0000000000000020 R12: ffff90e380bac000
> >     R13: ffffe3a7456d9200 R14: 0000000000001b81 R15: ffffe3a7456d9200
> >     FS:  00007f2e4e8a15c0(0000) GS:ffff90e3fbc80000(0000) knlGS:0000000000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: 0000000000000040 CR3: 00000001150c6003 CR4: 0000000000170ee0
> >     Call Trace:
> >      <TASK>
> >      ? __die+0x20/0x70
> >      ? page_fault_oops+0x76/0x170
> >      ? kernelmode_fixup_or_oops+0x84/0x110
> >      ? exc_page_fault+0x65/0x150
> >      ? asm_exc_page_fault+0x22/0x30
> >      ? trace_event_raw_event_writeback_folio_template+0x76/0xf0
> >      folio_wait_writeback+0x6b/0x80
> >      shmem_swapin_folio+0x24a/0x500
> >      ? filemap_get_entry+0xe3/0x140
> >      shmem_get_folio_gfp+0x36e/0x7c0
> >      ? find_busiest_group+0x43/0x1a0
> >      shmem_fault+0x76/0x2a0
> >      ? __update_load_avg_cfs_rq+0x281/0x2f0
> >      __do_fault+0x33/0x130
> >      do_read_fault+0x118/0x160
> >      do_pte_missing+0x1ed/0x2a0
> >      __handle_mm_fault+0x566/0x630
> >      handle_mm_fault+0x91/0x210
> >      do_user_addr_fault+0x22c/0x740
> >      exc_page_fault+0x65/0x150
> >      asm_exc_page_fault+0x22/0x30
> > 
> > This problem arises from the fact that the repurposed writeback_dirty_page
> > trace event code was written assuming that every pointer to mapping
> > (struct address_space) would come from a file-mapped page-cache object,
> > thus mapping->host would always be populated, and that was a valid case
> > before commit 19343b5bdd16.  The swap-cache address space
> > (swapper_spaces), however, doesn't populate its ->host (struct inode)
> > pointer, thus leading to the crashes in the corner-case aforementioned.
> > 
> > commit 19343b5bdd16 ended up breaking the assignment of __entry->name and
> > __entry->ino for the wait_on_page_writeback tracepoint -- both dependent
> > on mapping->host carrying a pointer to a valid inode.  The assignment of
> > __entry->name was fixed by commit 68f23b89067f ("memcg: fix a crash in
> > wb_workfn when a device disappears"), and this commit fixes the remaining
> > case, for __entry->ino.
> > 
> > Link: https://lkml.kernel.org/r/20230606233613.1290819-1-aquini@redhat.com
> > Fixes: 19343b5bdd16 ("mm/page-writeback: introduce tracepoint for wait_on_page_writeback()")
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > Reviewed-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Aristeu Rozanski <aris@redhat.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > ---
> >  include/trace/events/writeback.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> All now queued up, thanks.
>

Thank you, Greg.

-- Rafael

