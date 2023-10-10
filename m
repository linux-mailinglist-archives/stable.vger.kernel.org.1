Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD07C0057
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 17:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjJJPZr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 11:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjJJPZq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 11:25:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0306C93
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 08:25:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01507C433C7;
        Tue, 10 Oct 2023 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696951543;
        bh=vKtskxD5vy2rxXyzj9tKoA6R9P3r2fJ+wYMXhru0kH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nD3bPXpQn1fsiOoCobW4IK/Cdj//zjRtcGjNG2EtKXbtorXgCzphQYiBunBv0jMrF
         WmZklek2JgJaLSXLo+G175fjCT63E7/0kk1neoEwoqYvRpRNjqMg2WJAhAqbG46sO+
         zkDwx/XtPxufOWD5LjuUyPMRfmkSsqBRR71tQ5NE=
Date:   Tue, 10 Oct 2023 17:25:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <wqu@suse.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 4.19 70/91] btrfs: reject unknown mount options early
Message-ID: <2023101030-macarena-pastor-87bb@gregkh>
References: <20231009130111.518916887@linuxfoundation.org>
 <20231009130113.943075052@linuxfoundation.org>
 <c55ba96b-9058-42ac-817b-2d42b45ddf3a@suse.com>
 <2023101008-percolate-sterile-1391@gregkh>
 <20231010125952.GA2211@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010125952.GA2211@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 02:59:52PM +0200, David Sterba wrote:
> On Tue, Oct 10, 2023 at 01:27:48PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 10, 2023 at 07:23:15PM +1030, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2023/10/9 23:36, Greg Kroah-Hartman wrote:
> > > > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > Please reject the patch from all stable branches (if that's not yet too
> > > late).
> > > 
> > > The rejection is too strict, especially the check is before the security
> > > mount options, thus it would reject all security mount options.
> > 
> > This is queued up in all stable -rc releases right now, is there a fix
> > in Linus's tree for this as well or is it broken there too?
> 
> Yes it's broken there too, I'll send a revert.

Ok, thanks, I'll go drop this from all stable queues right now.

greg k-h
