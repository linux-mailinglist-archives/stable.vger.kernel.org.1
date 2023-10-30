Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8B7DB9D6
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 13:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJ3MZV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 08:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjJ3MZU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 08:25:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4377C9
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 05:25:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9295E1F45B;
        Mon, 30 Oct 2023 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698668713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6H2Hz968qnsjGDRsAw1Bd6MzPZMRvBR69VRmb0NiViQ=;
        b=E7xFlMYRHK+TvNgf9G3Ne9Q6LHDlZypFI+F0kfmjDzDQOwW95T9gkyjFMV/3w+zDKmyVs9
        6ZpxXjmjCHVNEWQ5zXM4sGKheKdTdVG9CCqAtJNB1RP4W7meg+BIiRV0lJWP2v+XlIKyK8
        giKkX+U8Z2PHKyqVofWOBWR24ZDocfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698668713;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6H2Hz968qnsjGDRsAw1Bd6MzPZMRvBR69VRmb0NiViQ=;
        b=7XKA7iztfpQJPbuPLuTcHsSlVNnoDltQtLe0T0dYCMf/nCeuWNGF+lhJLUjRqZeKfY7vTl
        sH14VXrVWs+JvxDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 847C3138F8;
        Mon, 30 Oct 2023 12:25:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X2BOIKmgP2WHcAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 30 Oct 2023 12:25:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 13322A05BC; Mon, 30 Oct 2023 13:25:13 +0100 (CET)
Date:   Mon, 30 Oct 2023 13:25:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org, Jan Kara <jack@suse.cz>
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <20231030122513.6gds75hxd65gu747@quack3>
References: <ZTNH0qtmint/zLJZ@mail-itl>
 <e427823c-e869-86a2-3549-61b3fdf29537@redhat.com>
 <ZTiHQDY54E7WAld+@mail-itl>
 <ZTiJ3CO8w0jauOzW@mail-itl>
 <a413efbf-7194-95ff-562b-f2eb766ca5c1@redhat.com>
 <89320668-67a2-2a41-e577-a2f561e3dfdd@suse.cz>
 <818a23f2-c242-1c51-232d-d479c3bcbb6@redhat.com>
 <18a38935-3031-1f35-bc36-40406e2e6fd2@suse.cz>
 <3514c87f-c87f-f91f-ca90-1616428f6317@redhat.com>
 <1a47fa28-3968-51df-5b0b-a19c675cc289@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a47fa28-3968-51df-5b0b-a19c675cc289@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon 30-10-23 12:30:23, Vlastimil Babka wrote:
> On 10/30/23 12:22, Mikulas Patocka wrote:
> > On Mon, 30 Oct 2023, Vlastimil Babka wrote:
> > 
> >> Ah, missed that. And the traces don't show that we would be waiting for
> >> that. I'm starting to think the allocation itself is really not the issue
> >> here. Also I don't think it deprives something else of large order pages, as
> >> per the sysrq listing they still existed.
> >> 
> >> What I rather suspect is what happens next to the allocated bio such that it
> >> works well with order-0 or up to costly_order pages, but there's some
> >> problem causing a deadlock if the bio contains larger pages than that?
> > 
> > Yes. There are many "if (order > PAGE_ALLOC_COSTLY_ORDER)" branches in the 
> > memory allocation code and I suppose that one of them does something bad 
> > and triggers this bug. But I don't know which one.
> 
> It's not what I meant. All the interesting branches for costly order in page
> allocator/compaction only apply with __GFP_DIRECT_RECLAIM, so we can't be
> hitting those here.
> The traces I've seen suggest the allocation of the bio suceeded, and
> problems arised only after it was submitted.
> 
> I wouldn't even be surprised if the threshold for hitting the bug was not
> exactly order > PAGE_ALLOC_COSTLY_ORDER but order > PAGE_ALLOC_COSTLY_ORDER
> + 1 or + 2 (has that been tested?) or rather that there's no exact
> threshold, but probability increases with order.

Well, it would be possible that larger pages in a bio would trip e.g. bio
splitting due to maximum segment size the disk supports (which can be e.g.
0xffff) and that upsets something somewhere. But this is pure
speculation. We definitely need more debug data to be able to tell more.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
