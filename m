Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C6C7DBCFE
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 16:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjJ3P4I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 11:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjJ3P4H (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 11:56:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0301CE4
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 08:56:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B1A051F7AB;
        Mon, 30 Oct 2023 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698681363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E3XSA6WYBW8wrapbDS0LhBDnP8RGWsuPkduvqjedEqs=;
        b=kR38w7x3BQ7gPL3vFPD9UWK/Ssfj/pyDTaDMbLv2qaWIQteL3Hwcf4Vbkrc9on90TpC1F4
        lr8Cbs1p4oNm14I8vNHRq7HSAU0ulEbAVm42YXxdQLgCb8cqyxqwxdry+JgM5ymFXtVjeq
        xgoLjsKgHtKY/Y9oK+NdacDzYqsOeOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698681363;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E3XSA6WYBW8wrapbDS0LhBDnP8RGWsuPkduvqjedEqs=;
        b=YmGYY48HATodz9rPRuIhG053z/Hc+GzKDncp3XcDsaOpjoqlYV+AVRowhJZE1aLiHA9Zwa
        gMionwcRsqOM67AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F9E8138EF;
        Mon, 30 Oct 2023 15:56:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lVjgJhPSP2XqegAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 30 Oct 2023 15:56:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 293D2A05BC; Mon, 30 Oct 2023 16:56:03 +0100 (CET)
Date:   Mon, 30 Oct 2023 16:56:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <20231030155603.k3kejytq2e4vnp7z@quack3>
References: <ZTiJ3CO8w0jauOzW@mail-itl>
 <a413efbf-7194-95ff-562b-f2eb766ca5c1@redhat.com>
 <89320668-67a2-2a41-e577-a2f561e3dfdd@suse.cz>
 <818a23f2-c242-1c51-232d-d479c3bcbb6@redhat.com>
 <18a38935-3031-1f35-bc36-40406e2e6fd2@suse.cz>
 <3514c87f-c87f-f91f-ca90-1616428f6317@redhat.com>
 <1a47fa28-3968-51df-5b0b-a19c675cc289@suse.cz>
 <20231030122513.6gds75hxd65gu747@quack3>
 <ZT+wDLwCBRB1O+vB@mail-itl>
 <a2a8dbf6-d22e-65d0-6fab-b9cdf9ec3320@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2a8dbf6-d22e-65d0-6fab-b9cdf9ec3320@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon 30-10-23 15:08:56, Mikulas Patocka wrote:
> On Mon, 30 Oct 2023, Marek Marczykowski-G�recki wrote:
> 
> > > Well, it would be possible that larger pages in a bio would trip e.g. bio
> > > splitting due to maximum segment size the disk supports (which can be e.g.
> > > 0xffff) and that upsets something somewhere. But this is pure
> > > speculation. We definitely need more debug data to be able to tell more.
> > 
> > I can collect more info, but I need some guidance how :) Some patch
> > adding extra debug messages?
> > Note I collect those via serial console (writing to disk doesn't work
> > when it freezes), and that has some limits in the amount of data I can
> > extract especially when printed quickly. For example sysrq-t is too much.
> > Or maybe there is some trick to it, like increasing log_bug_len?
> 
> If you can do more tests, I would suggest this:
> 
> We already know that it works with order 3 and doesn't work with order 4.
> 
> So, in the file include/linux/mmzone.h, change PAGE_ALLOC_COSTLY_ORDER 
> from 3 to 4 and in the file drivers/md/dm-crypt.c leave "unsigned int 
> order = PAGE_ALLOC_COSTLY_ORDER" there.
> 
> Does it deadlock or not?
> 
> So, that we can see whether the deadlock depends on 
> PAGE_ALLOC_COSTLY_ORDER or whether it is just a coincidence.

Good idea. Also if the kernel hangs, please find kcryptd processes. In what
state are they? If they are sleeping, please send what's in
/proc/<kcryptd-pid>/stack. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
