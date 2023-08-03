Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936E376EDB6
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 17:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbjHCPNI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 11:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjHCPNH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 11:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC5F30D5
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691075537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=alsHbM1v/nfjzdcfXP8ctyTsH1REwc9fdwebIn1r7Ck=;
        b=Y8FZaIebb/IVbLMakFIH5dmhtr81LWbufXfLv7TG/mzjnaKbhemr42OzWfgitni/tvg8qE
        TjWeq4p8y77ip+lycyc6G9uvRzo4jsUlreKkn9oJkESzTBueiTJlTfFFWv7Y6djIIhoEs8
        uk5S06pm2PszJvGjBQgSwHjLC84W/vA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-5n-Ww0paN_SzChQeK9voKQ-1; Thu, 03 Aug 2023 11:12:15 -0400
X-MC-Unique: 5n-Ww0paN_SzChQeK9voKQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52291e49dbcso740404a12.2
        for <stable@vger.kernel.org>; Thu, 03 Aug 2023 08:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691075534; x=1691680334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alsHbM1v/nfjzdcfXP8ctyTsH1REwc9fdwebIn1r7Ck=;
        b=aBTlw0eSgB461w9uD3hzpnGxn8c06iZiZRQ94rzn6FDAAkUQnxt1XIoX8EnXpp+FuP
         7JqYeWSiMBMWaTM40JDk/qqik9hKxtlP8W2MeNKJGHQhp4VUrwC9qtEnO5FhHe/9ql6W
         azXzdqZcHkQvK3vLKVr3AKMk3m/V6hxDSHsokc3CvnyfB2qTueHKIntvgkOer9jFVQvq
         yJd7v/2OhOCXjbq8bLGyoN/wrFZQlGQDC4Zo+rVPucqyYsKQIdku9wQ3zV58VIv8j1l7
         Bv00IsMzMtS9CHPdFCpUyDHeJUY+u13WDvEyIO9PuC/SoCpRaEL8iNakE/9HXKeAswqQ
         /P0Q==
X-Gm-Message-State: ABy/qLaXvq3BSeXKmLhPly9JJZbjaZtEOcQksg6uP1K8E0QXKMSrzWye
        APwsHCYqX59bpB3v693YolPCSxYYgQguZNRUBDQPbpHs2M0aMnfXXUiZOS/60aiYQS0njUH2GAf
        Huko1bBvcbulcXTQs
X-Received: by 2002:aa7:d382:0:b0:522:56d8:49c0 with SMTP id x2-20020aa7d382000000b0052256d849c0mr8093415edq.37.1691075534424;
        Thu, 03 Aug 2023 08:12:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFIMKKLxzUcAdGlurEifhhbkaXBhtuMzh7ZujHmOmhYOygd1xi7DZoVwWCISdNd6zi4b2EPMg==
X-Received: by 2002:aa7:d382:0:b0:522:56d8:49c0 with SMTP id x2-20020aa7d382000000b0052256d849c0mr8093399edq.37.1691075534052;
        Thu, 03 Aug 2023 08:12:14 -0700 (PDT)
Received: from redhat.com ([2.52.12.104])
        by smtp.gmail.com with ESMTPSA id bf19-20020a0564021a5300b0051ded17b30bsm10280982edb.40.2023.08.03.08.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:12:13 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:12:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "ruyang@redhat.com" <ruyang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Message-ID: <20230803111154-mutt-send-email-mst@kernel.org>
References: <20230726152258-mutt-send-email-mst@kernel.org>
 <3ae9e8919a9316d06d7bb507698c820ac6194f45.camel@nvidia.com>
 <20230727122633-mutt-send-email-mst@kernel.org>
 <b97484f15824c86f5cee4fe673794f17419bcb1b.camel@nvidia.com>
 <20230731050200-mutt-send-email-mst@kernel.org>
 <CACGkMEtiwNjq4pMVY-Yvgo3+DihMP5zO+q+HH-xAF+Xu_=gbHg@mail.gmail.com>
 <39c3be5dd59e67e7b5dd301100e96aa9428bc332.camel@nvidia.com>
 <CACGkMEueOXgjbr9Q0Tw5Bv-=YH9+5UR9jxttrf6hN-VRK9KtMg@mail.gmail.com>
 <4375036868b636fa9c5a03e7fa9c4d7cdefefc5f.camel@nvidia.com>
 <5eba7bc2d3f253be4b0b998dc8a7a3efc7fe08d9.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5eba7bc2d3f253be4b0b998dc8a7a3efc7fe08d9.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 03, 2023 at 03:02:59PM +0000, Dragos Tatulea wrote:
> On Wed, 2023-08-02 at 09:56 +0200, Dragos Tatulea wrote:
> > On Wed, 2023-08-02 at 10:51 +0800, Jason Wang wrote:
> > > On Tue, Aug 1, 2023 at 4:17 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > > > 
> > > > On Tue, 2023-08-01 at 11:59 +0800, Jason Wang wrote:
> > > > > On Mon, Jul 31, 2023 at 5:08 PM Michael S. Tsirkin <mst@redhat.com>
> > > > > wrote:
> > > > > > 
> > > > > > On Mon, Jul 31, 2023 at 07:15:31AM +0000, Dragos Tatulea wrote:
> > > > > > > On Thu, 2023-07-27 at 12:28 -0400, Michael S. Tsirkin wrote:
> > > > > > > > On Thu, Jul 27, 2023 at 04:02:16PM +0000, Dragos Tatulea wrote:
> > > > > > > > > On Wed, 2023-07-26 at 15:26 -0400, Michael S. Tsirkin wrote:
> > > > > > > > > > On Wed, Jul 26, 2023 at 10:07:38PM +0300, Dragos Tatulea
> > > > > > > > > > wrote:
> > > > > > > > > > > The ndev was accessed on shutdown without a check if it
> > > > > > > > > > > actually
> > > > > > > > > > > exists.
> > > > > > > > > > > This triggered the crash pasted below. This patch simply
> > > > > > > > > > > adds
> > > > > > > > > > > a
> > > > > > > > > > > check
> > > > > > > > > > > before using ndev.
> > > > > > > > > > > 
> > > > > > > > > > >  BUG: kernel NULL pointer dereference, address:
> > > > > > > > > > > 0000000000000300
> > > > > > > > > > >  #PF: supervisor read access in kernel mode
> > > > > > > > > > >  #PF: error_code(0x0000) - not-present page
> > > > > > > > > > >  PGD 0 P4D 0
> > > > > > > > > > >  Oops: 0000 [#1] SMP
> > > > > > > > > > >  CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 6.5.0-
> > > > > > > > > > > rc2_for_upstream_min_debug_2023_07_17_15_05 #1
> > > > > > > > > > >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > > > > > > > > > > rel-
> > > > > > > > > > > 1.13.0-0-
> > > > > > > > > > > gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > > > > > > > >  RIP: 0010:mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
> > > > > > > > > > >  RSP: 0018:ffff8881003bfdc0 EFLAGS: 00010286
> > > > > > > > > > >  RAX: ffff888103befba0 RBX: ffff888109d28008 RCX:
> > > > > > > > > > > 0000000000000017
> > > > > > > > > > >  RDX: 0000000000000001 RSI: 0000000000000212 RDI:
> > > > > > > > > > > ffff888109d28000
> > > > > > > > > > >  RBP: 0000000000000000 R08: 0000000d3a3a3882 R09:
> > > > > > > > > > > 0000000000000001
> > > > > > > > > > >  R10: 0000000000000000 R11: 0000000000000000 R12:
> > > > > > > > > > > ffff888109d28000
> > > > > > > > > > >  R13: ffff888109d28080 R14: 00000000fee1dead R15:
> > > > > > > > > > > 0000000000000000
> > > > > > > > > > >  FS:  00007f4969e0be40(0000) GS:ffff88852c800000(0000)
> > > > > > > > > > > knlGS:0000000000000000
> > > > > > > > > > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > > > >  CR2: 0000000000000300 CR3: 00000001051cd006 CR4:
> > > > > > > > > > > 0000000000370eb0
> > > > > > > > > > >  DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > > > > > > > > > > 0000000000000000
> > > > > > > > > > >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > > > > > > > > > > 0000000000000400
> > > > > > > > > > >  Call Trace:
> > > > > > > > > > >   <TASK>
> > > > > > > > > > >   ? __die+0x20/0x60
> > > > > > > > > > >   ? page_fault_oops+0x14c/0x3c0
> > > > > > > > > > >   ? exc_page_fault+0x75/0x140
> > > > > > > > > > >   ? asm_exc_page_fault+0x22/0x30
> > > > > > > > > > >   ? mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
> > > > > > > > > > >   device_shutdown+0x13e/0x1e0
> > > > > > > > > > >   kernel_restart+0x36/0x90
> > > > > > > > > > >   __do_sys_reboot+0x141/0x210
> > > > > > > > > > >   ? vfs_writev+0xcd/0x140
> > > > > > > > > > >   ? handle_mm_fault+0x161/0x260
> > > > > > > > > > >   ? do_writev+0x6b/0x110
> > > > > > > > > > >   do_syscall_64+0x3d/0x90
> > > > > > > > > > >   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > > > > > > > > >  RIP: 0033:0x7f496990fb56
> > > > > > > > > > >  RSP: 002b:00007fffc7bdde88 EFLAGS: 00000206 ORIG_RAX:
> > > > > > > > > > > 00000000000000a9
> > > > > > > > > > >  RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> > > > > > > > > > > 00007f496990fb56
> > > > > > > > > > >  RDX: 0000000001234567 RSI: 0000000028121969 RDI:
> > > > > > > > > > > fffffffffee1dead
> > > > > > > > > > >  RBP: 00007fffc7bde1d0 R08: 0000000000000000 R09:
> > > > > > > > > > > 0000000000000000
> > > > > > > > > > >  R10: 0000000000000000 R11: 0000000000000206 R12:
> > > > > > > > > > > 0000000000000000
> > > > > > > > > > >  R13: 00007fffc7bddf10 R14: 0000000000000000 R15:
> > > > > > > > > > > 00007fffc7bde2b8
> > > > > > > > > > >   </TASK>
> > > > > > > > > > >  CR2: 0000000000000300
> > > > > > > > > > >  ---[ end trace 0000000000000000 ]---
> > > > > > > > > > > 
> > > > > > > > > > > Fixes: bc9a2b3e686e ("vdpa/mlx5: Support interrupt
> > > > > > > > > > > bypassing")
> > > > > > > > > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
> > > > > > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > > > > 
> > > > > > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > > index 9138ef2fb2c8..e2e7ebd71798 100644
> > > > > > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > > > > @@ -3556,7 +3556,8 @@ static void mlx5v_shutdown(struct
> > > > > > > > > > > auxiliary_device
> > > > > > > > > > > *auxdev)
> > > > > > > > > > >         mgtdev = auxiliary_get_drvdata(auxdev);
> > > > > > > > > > >         ndev = mgtdev->ndev;
> > > > > > > > > > > 
> > > > > > > > > > > -       free_irqs(ndev);
> > > > > > > > > > > +       if (ndev)
> > > > > > > > > > > +               free_irqs(ndev);
> > > > > > > > > > >  }
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > something I don't get:
> > > > > > > > > > irqs are allocated in mlx5_vdpa_dev_add
> > > > > > > > > > why are they not freed in mlx5_vdpa_dev_del?
> > > > > > > > > > 
> > > > > > > > > That is a good point. I will try to find out. I also don't get
> > > > > > > > > why
> > > > > > > > > free_irq
> > > > > > > > > is
> > > > > > > > > called in the vdpa dev .free op instead of mlx5_vdpa_dev_del.
> > > > > > > > > Maybe I
> > > > > > > > > can
> > > > > > > > > change
> > > > > > > > > that in a different refactoring.
> > > > > > > > 
> > > > > > > > as it is I have no idea whether e.g. ndev can change
> > > > > > > > between these two call sites. that would make the check
> > > > > > > > pointless.
> > > > > > > > 
> > > > > > > > > > this is what's creating all this mess.
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > Not quite: mlx5_vdpa_dev_del (which is a .dev_del of for struct
> > > > > > > > > vdpa_mgmtdev_ops) doesn't get called on shutdown. At least
> > > > > > > > > that's
> > > > > > > > > what
> > > > > > > > > I
> > > > > > > > > see. Or
> > > > > > > > > am I missing something?
> > > > > > > > 
> > > > > > > > and why do we care whether irqs are freed on shutdown?
> > > > > > > > 
> > > > > > > Had to ask around a bit to find out the answer: there can be issues
> > > > > > > with
> > > > > > > kexec
> > > > > > > IRQ allocation on some platforms. It is documented here [0] for
> > > > > > > mlx5_core.
> > > > > > > 
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/main.c#n2129
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Dragos
> > > > > > 
> > > > > > It's quite weird.
> > > > > >          * Some platforms requiring freeing the IRQ's in the shutdown
> > > > > >          * flow. If they aren't freed they can't be allocated after
> > > > > >          * kexec. There is no need to cleanup the mlx5_core software
> > > > > >          * contexts.
> > > > > > 
> > > > > > but most drivers don't have a shutdown callback how do they work then?
> > > > > > do you know which platforms these are?
> > > > > 
> > > > I don't. x86_64 is not one of them though. I will do some more digging ...
> > > > 
> > Turns out that this fix (releasing the irqs on .shutdown on mlx5_core) was
> > required for PPC arch but only for certain mainframe systems. That's all the
> > info I could find.
> > 
> I will send a v2 for this patch that removes the shutdown op. The irqs will be
> released by the mlx5_core shutdown handler which is responsible for the VF.
> 
> Thanks,
> Dragos

Certainly seems cleaner. Thanks!

> > > > > There used to be bzs that requires virtio drivers to add a shutdown to
> > > > > fix kexec:
> > > > > 
> > > > > https://bugzilla.redhat.com/show_bug.cgi?id=2108406
> > > > > 
> > > > I don't have access to this. What is it about?
> > > 
> > > This bug might be more accurate:
> > > 
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1820521
> > > 
> > > It's about the kexec guys (cced relevant people) wanting to add a
> > > shutdown method for virito to fix potential kexec issues.
> > > 
> > > Thanks
> > > 
> > > > 
> > > > Thanks,
> > > > Dragos
> > > > > Thanks
> > > > > 
> > > > > > 
> > > > > > I don't really know much about why shutdown callback is even
> > > > > > necessary.
> > > > > > I guess this is to detect shutdown and do a faster cleanup than
> > > > > > the slow, graceful removal, just cleaning hardware resources?
> > > > > > 
> > .shutdown could be removed in mlx5_vdpa. But I notice that mlx5_core's
> > .shutdown
> > kicks in from pci_device_shutdown to clean the irqs. So the irqs will still be
> > freed but as a side effect. Which is not good.
> > 
> > Thanks,
> > Dragos
> 

