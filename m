Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30384702C98
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjEOMYi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEOMYh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:24:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA6EE5A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 202FF61E8D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137DDC433EF;
        Mon, 15 May 2023 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684153475;
        bh=/f01qIlX+38wcA72V5utm+N77I5YUwN5pH4US2P6XIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuDaIeuKbqNs40vbaPc2Ammcvw4sRYVQWLJPm8MmfBhJHTRrIAySj4Dzvup8MYJin
         b3SjV46V6HKus47173cccBl7fqxvV3IH0OLFEkjTlXuQAl6qS4gjUPcDaI9xnljSYV
         ca8pvTWikwIlwuNaugze1pJZ/QceowFhizNdc1FI=
Date:   Mon, 15 May 2023 14:24:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y and below 1/2] tty: Prevent writing chars during
 tcsetattr TCSADRAIN/FLUSH
Message-ID: <2023051513-upward-playhouse-4e14@gregkh>
References: <20230511123244.38514-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511123244.38514-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 11, 2023 at 03:32:43PM +0300, Ilpo Järvinen wrote:
> If userspace races tcsetattr() with a write, the drained condition
> might not be guaranteed by the kernel. There is a race window after
> checking Tx is empty before tty_set_termios() takes termios_rwsem for
> write. During that race window, more characters can be queued by a
> racing writer.
> 
> Any ongoing transmission might produce garbage during HW's
> ->set_termios() call. The intent of TCSADRAIN/FLUSH seems to be
> preventing such a character corruption. If those flags are set, take
> tty's write lock to stop any writer before performing the lower layer
> Tx empty check and wait for the pending characters to be sent (if any).
> 
> The initial wait for all-writers-done must be placed outside of tty's
> write lock to avoid deadlock which makes it impossible to use
> tty_wait_until_sent(). The write lock is retried if a racing write is
> detected.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Link: https://lore.kernel.org/r/20230317113318.31327-2-ilpo.jarvinen@linux.intel.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit 094fb49a2d0d6827c86d2e0840873e6db0c491d2)
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/tty_io.c    |  4 ++--
>  drivers/tty/tty_ioctl.c | 45 ++++++++++++++++++++++++++++++-----------
>  include/linux/tty.h     |  2 ++
>  3 files changed, 37 insertions(+), 14 deletions(-)

Didn't apply to 4.14.y :(

But all others it did, so I've queued it up now there, thanks!

greg k-h
