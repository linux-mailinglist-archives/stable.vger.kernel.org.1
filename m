Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B34E7DB8F5
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 12:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjJ3La2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 07:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjJ3La2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 07:30:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02B7B3
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 04:30:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6982A1FF01;
        Mon, 30 Oct 2023 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698665424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svj5aXOYkyIrxyCMubwNQeGYS1aCFXNzjgS3/u3RebQ=;
        b=qccV33ZdHgl81XZ4Jjr7rgR08yYp2ZwsAd0YE5W3uvCkvjrN9wLecL+pDl03EOMT9BqbNp
        Cpp4ipdwPO2qOeR87VgEA5+1aBjbOTgfjHKVeW//rIR9VRDkkwr9/aYFChEI93HGohxNMs
        xpI6K7WtNP+gZ0IC2pAQtezEWyrnZcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698665424;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svj5aXOYkyIrxyCMubwNQeGYS1aCFXNzjgS3/u3RebQ=;
        b=ZOY0WcIdyF5OIgMvaerYn6Iit0Xf2WlqtFigfsR/3DQOGMES7oN01B/HfjjwIizJSf72ox
        tdS/blqrXI1SZCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 379B5138F8;
        Mon, 30 Oct 2023 11:30:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LGzPDNCTP2WQTwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 30 Oct 2023 11:30:24 +0000
Message-ID: <1a47fa28-3968-51df-5b0b-a19c675cc289@suse.cz>
Date:   Mon, 30 Oct 2023 12:30:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Content-Language: en-US
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org, Jan Kara <jack@suse.cz>
References: <ZTNH0qtmint/zLJZ@mail-itl>
 <e427823c-e869-86a2-3549-61b3fdf29537@redhat.com> <ZTiHQDY54E7WAld+@mail-itl>
 <ZTiJ3CO8w0jauOzW@mail-itl> <a413efbf-7194-95ff-562b-f2eb766ca5c1@redhat.com>
 <89320668-67a2-2a41-e577-a2f561e3dfdd@suse.cz>
 <818a23f2-c242-1c51-232d-d479c3bcbb6@redhat.com>
 <18a38935-3031-1f35-bc36-40406e2e6fd2@suse.cz>
 <3514c87f-c87f-f91f-ca90-1616428f6317@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <3514c87f-c87f-f91f-ca90-1616428f6317@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/30/23 12:22, Mikulas Patocka wrote:
> 
> 
> On Mon, 30 Oct 2023, Vlastimil Babka wrote:
> 
>> Ah, missed that. And the traces don't show that we would be waiting for
>> that. I'm starting to think the allocation itself is really not the issue
>> here. Also I don't think it deprives something else of large order pages, as
>> per the sysrq listing they still existed.
>> 
>> What I rather suspect is what happens next to the allocated bio such that it
>> works well with order-0 or up to costly_order pages, but there's some
>> problem causing a deadlock if the bio contains larger pages than that?
> 
> Yes. There are many "if (order > PAGE_ALLOC_COSTLY_ORDER)" branches in the 
> memory allocation code and I suppose that one of them does something bad 
> and triggers this bug. But I don't know which one.

It's not what I meant. All the interesting branches for costly order in page
allocator/compaction only apply with __GFP_DIRECT_RECLAIM, so we can't be
hitting those here.
The traces I've seen suggest the allocation of the bio suceeded, and
problems arised only after it was submitted.

I wouldn't even be surprised if the threshold for hitting the bug was not
exactly order > PAGE_ALLOC_COSTLY_ORDER but order > PAGE_ALLOC_COSTLY_ORDER
+ 1 or + 2 (has that been tested?) or rather that there's no exact
threshold, but probability increases with order.

>> Cc Honza. The thread starts here:
>> https://lore.kernel.org/all/ZTNH0qtmint%2FzLJZ@mail-itl/
>> 
>> The linked qubes reports has a number of blocked task listings that can be
>> expanded:
>> https://github.com/QubesOS/qubes-issues/issues/8575
> 
> Mikulas
> 

