Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE9D7584C1
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 20:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGRS07 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGRS06 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 14:26:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0955AB6
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2/Ijw2bmoECq4MixcK35xA5bhR217CcbP+OhD7HCyz8=; b=bSSacvMtha+kn4WHSS1HdFlL72
        tIoX1uxzL580h3L4qyTXYRYCbJ77kjc3eDNiuMhVvI0joDKhcqcSehaHk/s9/GZXSUVLHjuLTKfAB
        G4fgRWH5CpKOYWdtwLEKbPgibQIla4CCj1E+/qUrTIxZFH9QWB4pirr6uRlmxisQWtinKIYT+IBre
        iV0p/N8dGvZhYFvXaFjScrpZEjXU0SudSKteNNDQf1aBQwHllvZFhLQZZRr0lXETEPWf/DjBqWmIF
        tS7MOEksO/v0EHnzUvV8YXo5Z/SQEnyde+vrAl9+A5LG4H7XebTRmfE/r+8q9ovR9s+aBBwAVPI3R
        4GbK3oWA==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qLpPQ-005VtP-07;
        Tue, 18 Jul 2023 18:26:52 +0000
Date:   Tue, 18 Jul 2023 11:26:48 -0700
From:   Joel Becker <jlbec@evilplan.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        David Howells <dhowells@redhat.com>,
        Mark Fasheh <mark@fasheh.com>,
        Kurt Hackel <kurt.hackel@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 133/591] ocfs2: Fix use of slab data with sendpage
Message-ID: <ZLbZaNtXL0VMDePW@google.com>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        David Howells <dhowells@redhat.com>, Mark Fasheh <mark@fasheh.com>,
        Kurt Hackel <kurt.hackel@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@oss.oracle.com,
        Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20230716194923.861634455@linuxfoundation.org>
 <20230716194927.316678989@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716194927.316678989@linuxfoundation.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Noticing this patch only here rather than the original post, sorry.

On Sun, Jul 16, 2023 at 09:44:32PM +0200, Greg Kroah-Hartman wrote:
> From: David Howells <dhowells@redhat.com>
> 

 ...

> [ Upstream commit 86d7bd6e66e9925f0f04a7bcf3c92c05fdfefb5a ]
> -	o2net_hand = kzalloc(sizeof(struct o2net_handshake), GFP_KERNEL);
> -	o2net_keep_req = kzalloc(sizeof(struct o2net_msg), GFP_KERNEL);
> -	o2net_keep_resp = kzalloc(sizeof(struct o2net_msg), GFP_KERNEL);
> -	if (!o2net_hand || !o2net_keep_req || !o2net_keep_resp)
> +	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 0);
> +	if (!folio)
>  		goto out;
>  
> +	p = folio_address(folio);
> +	o2net_hand = p;
> +	p += sizeof(struct o2net_handshake);
> +	o2net_keep_req = p;
> +	p += sizeof(struct o2net_msg);
> +	o2net_keep_resp = p;

Do we care that we aren't validating sizes here?  The original code
allocates the structures by size.  This code grabs an order 0 folio and
assumes the total size of these structures is smaller than a page.  But
while we "know" today that the handshake messages have no payload,
`o2net_msg.buf` could theoretically be filled by more data.  What if
someone decided to change the code to put some payload in
`o2net_keep_resp.buf`?  Yes, we would hope they would think to add the
appropriate allocation.  But should we be validating this with some kind
of safety check?

Thanks,
Joel

-- 

"I almost ran over an angel
 He had a nice big fat cigar.
 'In a sense,' he said, 'You're alone here
 So if you jump, you'd best jump far.'"

			http://www.jlbec.org/
			jlbec@evilplan.org
