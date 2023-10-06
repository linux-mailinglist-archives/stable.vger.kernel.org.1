Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8817BB40B
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 11:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjJFJQR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 05:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjJFJQO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 05:16:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA1F95
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 02:15:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B68721877;
        Fri,  6 Oct 2023 09:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696583757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0HRENDiKHcVlBZ+XaaEaXrQ7A+wbnVb52ACfwKB+Aq4=;
        b=vwemwxhAKq8hnfX6MKkAnnbxhTevI8xYehAbL0W9m/T08IV3tMQbp6b3JeGivkC4cB3jzK
        7Tfn9cDbDn7ZM+bFHVxr086GxAt19YE+Bi9urHmTcbNjjj9/v2lKhMTIeAiU1yZiddU5xZ
        gApYlgxCmg46QKLWPUf1BJ4YrEqfOjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696583757;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0HRENDiKHcVlBZ+XaaEaXrQ7A+wbnVb52ACfwKB+Aq4=;
        b=WelkEy10VxpRShkm67Mw40iU0/YTtzzTxNKy3NtyYy72Rts5ws1dRc6JJVH93B/M4W2NI0
        pw8Wgq6B40CFEHAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DD2813586;
        Fri,  6 Oct 2023 09:15:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fa/bFk3QH2XmMAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 06 Oct 2023 09:15:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DDD98A07CC; Fri,  6 Oct 2023 11:15:56 +0200 (CEST)
Date:   Fri, 6 Oct 2023 11:15:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mathieu Othacehe <othacehe@gnu.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        jack@suse.cz, Marcus Hoffmann <marcus.hoffmann@othermo.de>,
        tytso@mit.edu, famzah@icdsoft.com, gregkh@linuxfoundation.org,
        anton.reding@landisgyr.com
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Message-ID: <20231006091556.c6qqlb5seusvzl7a@quack3>
References: <871qeau3sd.fsf@gnu.org>
 <ZR06COwVo7bEfP/5@sashalap>
 <87wmw1v94t.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmw1v94t.fsf@gnu.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

On Thu 05-10-23 09:08:50, Mathieu Othacehe wrote:
> > Backporting the series would be ideal. Is this only for the 5.15 kernel?
> 
> OK. I spotted it on a 5.15 but as far as I understand, this affects all
> stables with 5c48a7df9149, i.e all stables. Is that correct Jan?

Yes, that is correct. Also I have realized that before patches I've already
mentioned are applicable, you will also need to pick up:

9462f770eda8 ("ext4: Update stale comment about write constraints")
c8e8e16dbbf0 ("ext4: Use nr_to_write directly in mpage_prepare_extent_to_map()")
3f5d30636d2a ("ext4: Mark page for delayed dirtying only if it is pinned")
f1496362e9d7 ("ext4: Don't unlock page in ext4_bio_write_page()")
eaf2ca10ca4b ("ext4: Move page unlocking out of mpage_submit_page()")
d8be7607de03 ("ext4: Move mpage_page_done() calls after error handling")
3f079114bf52 ("ext4: Convert data=journal writeback to use ext4_writepages()")
e6c28a26b799 ("ext4: Fix warnings when freezing filesystem with journaled data")
  This commit actually gets reverted in the series of patches I have
already mentioned.

So sadly the backport is even larger than what I originally thought.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
