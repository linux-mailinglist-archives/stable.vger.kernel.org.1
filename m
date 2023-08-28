Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B566C78A973
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjH1J6v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjH1J6X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 05:58:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFCC91
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 02:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0099D6345B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 09:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C2DC433C7;
        Mon, 28 Aug 2023 09:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693216699;
        bh=9aKq3lfUlUbjMkZjzTY0bvtm1hQvqIbjb03zY1FtK5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTB7NRyzgWWYHPVcEItVBBkW2J7AZKd0lTEOtlbY6xprPAg7xwsqb8AdO5LmtdjtV
         1JcP6NWfwIO+xKzZMKBiEE2fqMCVGeZUyIkVTMhwuHgK6mqOcawXFIkFvny3trlMKT
         A2mMFxz076yRW4TtSzTRowoCyTdmMaLdTfPPxvOE=
Date:   Mon, 28 Aug 2023 11:58:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     riel@surriel.com, robh@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm,ima,kexec,of: use memblock_free_late
 from" failed to apply to 5.15-stable tree
Message-ID: <2023082805-radar-flavored-db63@gregkh>
References: <2023082642-catfight-gallantly-8b84@gregkh>
 <20230828073303.GA3223@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828073303.GA3223@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 28, 2023 at 10:33:03AM +0300, Mike Rapoport wrote:
> Hi Greg,
> 
> On Sat, Aug 26, 2023 at 07:43:42PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> This version applies to 5.15-stable:

Now queued up, thanks!

greg k-h
