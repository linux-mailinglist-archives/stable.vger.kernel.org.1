Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6718F701639
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 12:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjEMKvw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 06:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjEMKvv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 06:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA31991
        for <stable@vger.kernel.org>; Sat, 13 May 2023 03:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A26260E9E
        for <stable@vger.kernel.org>; Sat, 13 May 2023 10:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAF8C433EF;
        Sat, 13 May 2023 10:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683975108;
        bh=9X+6SO1vINjGlkookJdOXRSY6ed3zD0gsiHoB5TDP4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0/I+S+UV19j51NPtjvI0mqHBH2m4wD+u/Xyq8QwieERtqt6ZuuC56ZznaD5IsshDH
         ouFF3JZ3FZ/pto6btD+XloCsKF0j1VCFGdWdjEHlEh9c7XP5gMQGcPV9Y+FjRNwoeJ
         lOogI4fqJ72Zo+wtcV5nRvVYDq3ZiLHnZ4id8usg=
Date:   Sat, 13 May 2023 19:48:43 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     stable@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/retbleed: Fix return thunk alignment"
 failed to apply to 5.10-stable tree
Message-ID: <2023051335-version-prelude-0767@gregkh>
References: <2023051308-reflected-pessimism-42d1@gregkh>
 <20230513103432.GDZF9nuPNuUn8hxKNX@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513103432.GDZF9nuPNuUn8hxKNX@fat_crate.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 13, 2023 at 12:34:32PM +0200, Borislav Petkov wrote:
> On Sat, May 13, 2023 at 05:17:08PM +0900, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.10-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Same situation as 5.15 - see my reply there.

Great, thanks for checking.

greg k-h
