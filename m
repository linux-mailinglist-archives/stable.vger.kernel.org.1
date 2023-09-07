Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A4E79775C
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 18:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjIGQYd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 12:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245096AbjIGQXp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 12:23:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EEC9036
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 09:20:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CB4C116A2;
        Thu,  7 Sep 2023 10:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694081596;
        bh=ggt85MkVm5n/VVtzdg9a/WsdfVNY9sXa/fHTsqlpB6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkKm3QhxDEuD42TctXPpi8WL57hNdxZ/RQhVkBljvD5Ufxes0Oj/7rbWal1Ex2evh
         nidHMr1PAah0GTdz6zEzZwzt1GQm6N7BTtye8Ty0AFllW9GwfNrxmjMAtVW9+kaNuM
         GMFHAqnsuHxX4Ugm5SCMe0GlYHRMwvGhzuDQVdT8=
Date:   Thu, 7 Sep 2023 11:13:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org,
        Michael Larabel <Michael@michaellarabel.com>
Subject: Re: Kernel 6.5 black screen regression
Message-ID: <2023090729-struggle-poison-4ebc@gregkh>
References: <074d84cd-e802-4900-ad70-b9402de43e64@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <074d84cd-e802-4900-ad70-b9402de43e64@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 06, 2023 at 12:55:29PM -0500, Mario Limonciello wrote:
> Hi,
> 
> The following patch fixes a regression reported by Michael Larabel on an
> Acer Phoenix laptop where there is a black screen in GNOME with kernel 6.5.
> 
> It's marked CC to stable, but I checked the stable queue and didn't see it
> so I wanted to make sure it wasn't missed.

The fixes tag in that commit is odd, it says it fixes something that is
NOT in 6.5, so are you sure about this?

> a7c0cad0dc06 ("drm/amd/display: ensure async flips are only accepted for
> fast updates")
> 
> Reported-by: Michael Larabel <Michael@MichaelLarabel.com>

Ok, now queued up, thanks.

greg k-h
