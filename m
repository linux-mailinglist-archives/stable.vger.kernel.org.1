Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA747BF9B0
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjJJL1y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 07:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJJL1y (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 07:27:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7502994
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 04:27:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C561C433CA;
        Tue, 10 Oct 2023 11:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696937271;
        bh=5sE5gUILKS6QhHBpP8Exty2NmNy9zwTSLu679olXZiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVufBcV3Mw/7ZVyzPyO2D+YniZukJwDNmGRoa6dyxloIU2Z8yGeStTV3tAi5LQHL9
         atlgy13UlB/oRXKmDuPfSdj3qpE5R5OCzcuW9uLUY2Z58rrYJmdoZ3501dOc54QhYO
         Ey/qHW9OiWcBtVGYwZ0cfGbMEG6DgPUim59XUD6o=
Date:   Tue, 10 Oct 2023 13:27:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 4.19 70/91] btrfs: reject unknown mount options early
Message-ID: <2023101008-percolate-sterile-1391@gregkh>
References: <20231009130111.518916887@linuxfoundation.org>
 <20231009130113.943075052@linuxfoundation.org>
 <c55ba96b-9058-42ac-817b-2d42b45ddf3a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c55ba96b-9058-42ac-817b-2d42b45ddf3a@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 07:23:15PM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/10/9 23:36, Greg Kroah-Hartman wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> 
> Please reject the patch from all stable branches (if that's not yet too
> late).
> 
> The rejection is too strict, especially the check is before the security
> mount options, thus it would reject all security mount options.

This is queued up in all stable -rc releases right now, is there a fix
in Linus's tree for this as well or is it broken there too?

thanks,

greg k-h
