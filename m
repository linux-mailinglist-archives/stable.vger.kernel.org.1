Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A827A2FBD
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 13:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjIPLkx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 07:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjIPLkk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 07:40:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B2CCC7
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 04:40:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764A0C433C8;
        Sat, 16 Sep 2023 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694864434;
        bh=bLEKLRqOdbhh1Uy6IGr02CJHXRpF1UtdzUK2OF9yZEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwQCh0NODsxckDXC8ZJsUVLw4bAAvGKLG4Wbcon4P+v3E+VJnujN4MbbVE1nuD61V
         Ukcn+noCwMBdJx5Yh7jbWZp51f+TS8vlNdMT9IYEbSif6omIGfLBVj50OUDv2pPlvu
         9zwo4rrE3oZjflIkpq84yU69ofWJLZz5jP65l5bA=
Date:   Sat, 16 Sep 2023 13:40:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: Re: Fix colorspace warning on MST displays
Message-ID: <2023091624-jiffy-venture-58ad@gregkh>
References: <42a47017-633a-4749-8215-2ff35913f578@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a47017-633a-4749-8215-2ff35913f578@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 15, 2023 at 02:50:43PM -0500, Mario Limonciello wrote:
> Hi,
> 
> There are some warning traces being reported in linux-6.5.y related to the
> relatively recent colorspace property.
> 
> A workaround is landed in 6.6-rc1 to avoid the traces.
> 
> Can you please backport this back to linux-6.5.y?
> 
> 69a959610229 ("drm/amd/display: Temporary Disable MST DP Colorspace
> Property")

Now queued up, thanks.

greg k-h
