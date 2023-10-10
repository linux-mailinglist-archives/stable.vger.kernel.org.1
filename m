Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E427BFCE4
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjJJNGp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 09:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjJJNGp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 09:06:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA0B7
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 06:06:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ADCC01F38A;
        Tue, 10 Oct 2023 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696943202;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ziRaTCMQY9PPH36OpIu+2jE3RQyPlDAIyWRvT4Uv5Y=;
        b=T+jJg9YmMLcywOz0Wvgu2xlIBemz6ssVvwf6vd7WowkbPqxbFKTlrY63kLbCwsyyZjS0sG
        QqNAufdgF8erMk6LHF+vU8l71xmumhMftFq3BNC/go6+87vnd7BgHkIegigAxExdfhV4Ss
        /nsZl9As3ko1Oa3oXhtIy8z4N448wDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696943202;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ziRaTCMQY9PPH36OpIu+2jE3RQyPlDAIyWRvT4Uv5Y=;
        b=cf6ZEpv19Q2EFY1TlIcF+KGTCe/UQ9WVSvRLA4iF4Pv2umB9gThYYTuS8yXXUPDqW6+fzl
        KkYIxZ8XSWuCQGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89CCA1348E;
        Tue, 10 Oct 2023 13:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1CbVIGJMJWVeXwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 Oct 2023 13:06:42 +0000
Date:   Tue, 10 Oct 2023 14:59:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qu Wenruo <wqu@suse.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 4.19 70/91] btrfs: reject unknown mount options early
Message-ID: <20231010125952.GA2211@suse.cz>
Reply-To: dsterba@suse.cz
References: <20231009130111.518916887@linuxfoundation.org>
 <20231009130113.943075052@linuxfoundation.org>
 <c55ba96b-9058-42ac-817b-2d42b45ddf3a@suse.com>
 <2023101008-percolate-sterile-1391@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101008-percolate-sterile-1391@gregkh>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 01:27:48PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 10, 2023 at 07:23:15PM +1030, Qu Wenruo wrote:
> > 
> > 
> > On 2023/10/9 23:36, Greg Kroah-Hartman wrote:
> > > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > 
> > Please reject the patch from all stable branches (if that's not yet too
> > late).
> > 
> > The rejection is too strict, especially the check is before the security
> > mount options, thus it would reject all security mount options.
> 
> This is queued up in all stable -rc releases right now, is there a fix
> in Linus's tree for this as well or is it broken there too?

Yes it's broken there too, I'll send a revert.
