Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E74702C9C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbjEOMZw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbjEOMZt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:25:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FF910F0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EF7961E95
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A62C433EF;
        Mon, 15 May 2023 12:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684153546;
        bh=pHQdy6zJ5rWJ5go2LYKfiPh3jO5aCTM4UIoOLqMzXbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1SRgemg9TQ44/eFR7nQiMgnw32jal/KQDf0w23dhMLDR+1sqO26rdOpP33ldETyTd
         6GVu7yUJnlha+hU7JflmXaS2FY1/pyk9y9/hs1rV/iDSk5ZyooUmTFcvmtXGN/uGVC
         0xMP32A/KQAzW2DXNToMQeOJvjggdWBeKG0+X3/c=
Date:   Mon, 15 May 2023 14:25:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y and below 1/2] tty: Prevent writing chars during
 tcsetattr TCSADRAIN/FLUSH
Message-ID: <2023051528-cloak-hatchet-1839@gregkh>
References: <20230511123244.38514-1-ilpo.jarvinen@linux.intel.com>
 <2023051513-upward-playhouse-4e14@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023051513-upward-playhouse-4e14@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 15, 2023 at 02:24:32PM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 11, 2023 at 03:32:43PM +0300, Ilpo Järvinen wrote:
> > If userspace races tcsetattr() with a write, the drained condition
> > might not be guaranteed by the kernel. There is a race window after
> > checking Tx is empty before tty_set_termios() takes termios_rwsem for
> > write. During that race window, more characters can be queued by a
> > racing writer.
> > 
> > Any ongoing transmission might produce garbage during HW's
> > ->set_termios() call. The intent of TCSADRAIN/FLUSH seems to be
> > preventing such a character corruption. If those flags are set, take
> > tty's write lock to stop any writer before performing the lower layer
> > Tx empty check and wait for the pending characters to be sent (if any).
> > 
> > The initial wait for all-writers-done must be placed outside of tty's
> > write lock to avoid deadlock which makes it impossible to use
> > tty_wait_until_sent(). The write lock is retried if a racing write is
> > detected.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Link: https://lore.kernel.org/r/20230317113318.31327-2-ilpo.jarvinen@linux.intel.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > (cherry picked from commit 094fb49a2d0d6827c86d2e0840873e6db0c491d2)
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/tty/tty_io.c    |  4 ++--
> >  drivers/tty/tty_ioctl.c | 45 ++++++++++++++++++++++++++++++-----------
> >  include/linux/tty.h     |  2 ++
> >  3 files changed, 37 insertions(+), 14 deletions(-)
> 
> Didn't apply to 4.14.y :(
> 
> But all others it did, so I've queued it up now there, thanks!

Oh nevermind, I fixed it up, it wasn't hard, now queued up everywhere,
thanks!

greg k-h
