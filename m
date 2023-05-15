Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940FF7022A5
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 05:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjEOD7M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 14 May 2023 23:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjEOD7L (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 14 May 2023 23:59:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4485AE5E
        for <stable@vger.kernel.org>; Sun, 14 May 2023 20:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8B8E6142C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 03:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C12C433D2;
        Mon, 15 May 2023 03:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684123149;
        bh=dVlg3dlwcijDwrEoN7oOI9+E5B/BcKv+jesAgVUM+bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RvvOjFU9ijG9Vfdi5ZU6eCYwy/wz8pYeu2laXSVOeS6Vlz39s7+gzPJRt1HvuK1hP
         Aw2qGgffW4CeMoFgJA2Mf9uo7ZxKAPAjp6oV/gplXCDesKmtn2fN6SyYnH6i3Fi3IP
         kdfqkGUcTmK9pls0sJdUBFIlTof1XslDELfwa8xU=
Date:   Mon, 15 May 2023 05:59:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, stable@vger.kernel.org
Subject: Re: [queue-6.3] Double "fs/ntfs3: Fix null-ptr-deref on inode->i_op
 in ntfs_lookup()"
Message-ID: <2023051558-crescent-urging-a428@gregkh>
References: <CA+icZUVq2eAb_hRLZjt5Uuf=Na3O5vPPHeca2oFay7ZeNQL8wA@mail.gmail.com>
 <ZGGn0IffMsXXE+lF@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGGn0IffMsXXE+lF@sashalap>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, May 14, 2023 at 11:32:32PM -0400, Sasha Levin wrote:
> On Sat, May 13, 2023 at 08:46:56PM +0200, Sedat Dilek wrote:
> > Hi,
> > 
> > while looking through 6.3-series patch-queue I noticed:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/6.3&id=5a5aea218d527e82c59d0164b4205a96399bda8e
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/6.3&id=a5085c4040ae421cc5d90bba2a1a1cecd6f800c0
> > 
> > Looks like the same patch:
> > 
> > fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()
> > commit 254e69f284d7270e0abdc023ee53b71401c3ba0c upstream.
> > 
> > fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()
> > [ Upstream commit 254e69f284d7270e0abdc023ee53b71401c3ba0c ]
> 
> Looks like Greg's patch somehow applied on top of mine, I've dropped it.

Thank you, this got confusing fast...
