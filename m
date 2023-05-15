Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1D702282
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 05:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjEODhG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 14 May 2023 23:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbjEODga (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 14 May 2023 23:36:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257794C25
        for <stable@vger.kernel.org>; Sun, 14 May 2023 20:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E6C561E6E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 03:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2EAC433D2;
        Mon, 15 May 2023 03:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121553;
        bh=eEK0SGA7D61tYNiGDtGRNAwsu+4R87t2bV38rBX6/rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGJ8Bkf+hfoV7EyiOIjQMkWMhyPuoolaR1s/TVr62FXDhGxYqX74CpYNsMnDe/l+2
         N5yBzP2CCpsgIxBRSS8LQ+b4qWU+sfI2ylZ7O4lTA6kmausU2vclVqPeova9Oudtq5
         pPRgIBlKFGhXt3zCnL6IktvgFWJ/ZUlqNVhdR4C7UE4IiClaklKMRGA6qjc8Al6wG+
         R9BTyMv//eLn3CdfsB/QedIXmM9QsWCqiJP72lG7unirpb5cvHKlnonqhUg1cS1I8p
         QXEPR0d8RkrzLbPDj3vXOytLbB7SlMUjR4tthuLOr5SWWhYvmpx3XNa6dMDjZ/UyOK
         Pt4eQP6zUGE2g==
Date:   Sun, 14 May 2023 23:32:32 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [queue-6.3] Double "fs/ntfs3: Fix null-ptr-deref on inode->i_op
 in ntfs_lookup()"
Message-ID: <ZGGn0IffMsXXE+lF@sashalap>
References: <CA+icZUVq2eAb_hRLZjt5Uuf=Na3O5vPPHeca2oFay7ZeNQL8wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+icZUVq2eAb_hRLZjt5Uuf=Na3O5vPPHeca2oFay7ZeNQL8wA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 13, 2023 at 08:46:56PM +0200, Sedat Dilek wrote:
>Hi,
>
>while looking through 6.3-series patch-queue I noticed:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/6.3&id=5a5aea218d527e82c59d0164b4205a96399bda8e
>
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/6.3&id=a5085c4040ae421cc5d90bba2a1a1cecd6f800c0
>
>Looks like the same patch:
>
>fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()
>commit 254e69f284d7270e0abdc023ee53b71401c3ba0c upstream.
>
>fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()
>[ Upstream commit 254e69f284d7270e0abdc023ee53b71401c3ba0c ]

Looks like Greg's patch somehow applied on top of mine, I've dropped it.

Thanks!

-- 
Thanks,
Sasha
