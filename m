Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AC5756C43
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjGQSjX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 14:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGQSjT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 14:39:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB921E5
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 11:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71567611C6
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 18:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64576C433C9;
        Mon, 17 Jul 2023 18:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689619157;
        bh=QjyVra+wNSOEmVtHIjsvvLP5dKGU3qD8OuVE5SVAYc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8lsSd3/2sNXCXiyG9K7kDr8XHCBLg12mv/kcZc4YBjKNzmHT6wcGk5R4bbJQuykN
         UAGlAAwRM+TMb4EbBpWv+TFb3YNgrB9HpoZv9CrNPl4w9ilj6G7lid1+/tG3PJAZli
         CHZjH/45sezVvOAwRLtKAulRD2DbDbevn4vKHoC4=
Date:   Mon, 17 Jul 2023 20:39:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH 6.1 587/591] netfilter: nf_tables: do not ignore genmask
 when looking up chain by id
Message-ID: <2023071707-pull-guts-3357@gregkh>
References: <20230716194923.861634455@linuxfoundation.org>
 <20230716194939.039111086@linuxfoundation.org>
 <ZLURnzHumJDX5N0F@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLURnzHumJDX5N0F@calendula>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 17, 2023 at 12:02:07PM +0200, Pablo Neira Ayuso wrote:
> Hi Greg,
> 
> On Sun, Jul 16, 2023 at 09:52:06PM +0200, Greg Kroah-Hartman wrote:
> > From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > 
> > commit 515ad530795c118f012539ed76d02bacfd426d89 upstream.
> 
> You can cherry-pick this commit to:
> 
> - 5.15.y
> - 5.10.y
> 
> Just tested here and it is good, no hunks are reported.

Already queued up there, thanks!

greg k-h
