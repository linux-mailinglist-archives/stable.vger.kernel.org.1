Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5661A7BA520
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 18:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbjJEQOA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 12:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240880AbjJEQNK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 12:13:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1175C27B39
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 06:44:20 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3953sXJk007135
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 23:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696478078; bh=hzB6MdeqZv3ajavUtULVc5NBhUId8bTwLyK5LgsA3tw=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=KIEfYnHbRSra228veLHwH76PZ/lzRd5prVf2XL5yZ1C7O3pw0lNYA1DxaHgl545eK
         qhAEd6Dcg/KiN7JAISZ8bliQd3ZB9sOZcN+Bv8r626nISfr2vTTQPgjMMF/diZaAYI
         cLzSjvAydLfZe59YW6rALrH6lY83NDVGfsZBReMeCYTCrvMBRB7NB3iVtPbfvc+dNg
         0j/sUkg446VwKmdIzO72/YhRcf7QhmNXA/StXetUuciURLtEasCGKaNT3g2bm0qvOG
         w0wSMvQX6tspye7wWH+hehUNuWOdQI7fd8nyeYSf57cHKNteDAqzTcJ3/LdsoDq0N+
         8MBQgri7lU2SQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7D2B515C0250; Wed,  4 Oct 2023 23:54:33 -0400 (EDT)
Date:   Wed, 4 Oct 2023 23:54:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Mathieu Othacehe <othacehe@gnu.org>, stable@vger.kernel.org,
        jack@suse.cz, Marcus Hoffmann <marcus.hoffmann@othermo.de>,
        famzah@icdsoft.com, gregkh@linuxfoundation.org,
        anton.reding@landisgyr.com
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Message-ID: <20231005035433.GA6358@mit.edu>
References: <871qeau3sd.fsf@gnu.org>
 <ZR06COwVo7bEfP/5@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR06COwVo7bEfP/5@sashalap>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 04, 2023 at 06:10:16AM -0400, Sasha Levin wrote:
> On Wed, Oct 04, 2023 at 11:37:22AM +0200, Mathieu Othacehe wrote:
> > 
> > bd159398a2d2 ("jdb2: Don't refuse invalidation of already invalidated buffers")
> > d84c9ebdac1e ("ext4: Mark pages with journalled data dirty")
> > 265e72efa99f ("ext4: Keep pages with journalled data dirty")
> > 5e1bdea6391d ("ext4: Clear dirty bit from pages without data to write")
> > 1f1a55f0bf06 ("ext4: Commit transaction before writing back pages in data=journal mode")
> > e360c6ed7274 ("ext4: Drop special handling of journalled data from ext4_sync_file()")
> > c000dfec7e88 ("ext4: Drop special handling of journalled data from extent shifting operations")
> > 783ae448b7a2 ("ext4: Fix special handling of journalled data from extent zeroing")
> > 56c2a0e3d90d ("ext4: Drop special handling of journalled data from ext4_evict_inode()")
> > 7c375870fdc5 ("ext4: Drop special handling of journalled data from ext4_quota_on()")
> > 951cafa6b80e ("ext4: Simplify handling of journalled data in ext4_bmap()")
> > ab382539adcb ("ext4: Update comment in mpage_prepare_extent_to_map()")
> > d0ab8368c175 ("Revert "ext4: Fix warnings when freezing filesystem with journaled data"")
> > 1077b2d53ef5 ("ext4: fix fsync for non-directories")
> > 
> > Or apply the proposed, attached patch. Do you think that would be an
> > option?
> 
> Backporting the series would be ideal. Is this only for the 5.15 kernel?

If we're going to backport all of these patches, I'd really would like
to see a full regression test run, using something like:

   gce-xfstests ltm -c ext4/all -g auto

before and after applying all of these patches, to make sure there are
no regression.

(or you can "kvm-xfstests -c ext4/all -g auto" but be prepared for it
to take over 24 hours of run time.  With gce-xfstesets we start a
dozen VM's in parallel so it finishes in about 2.5 hours.  See
https://thunk.org/gce-xfstests for more information.)

If you someone who does the backports can send me a pointer to a git
branch, I can run the tests for you, if that would be helpful.

Thanks!!

				       - Ted
