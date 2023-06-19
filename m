Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5A734BBA
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 08:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjFSGY4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 02:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFSGYz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 02:24:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518699B
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 23:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEBED611D9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 06:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE193C433C9;
        Mon, 19 Jun 2023 06:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687155893;
        bh=R4eNmMq5eD1LVA/vS/IN/2bNouTX22+yNxgBmtfFOcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3peL6m6SyrMAEGOjrrd7FZl98ArKVoda/B5RXvoCUIBBefGELZVIKqMrcy/6ExiW
         wo7DvgssoLXiciLX/WrZ/2nQO+OTyEIvyXWiCmd/ZqNTEdpmllcHeMYL0ww3fP3o0v
         Ygf/mOhIq6/k33bLkbxgbIc7eQ/SvxDeCeZC735U=
Date:   Mon, 19 Jun 2023 08:24:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hardik Garg <hargar@linux.microsoft.com>
Cc:     stable@vger.kernel.org, code@tyhicks.com
Subject: Re: backport d8e45bf1aed2 (selftests/mount_setattr: fix redefine
 struct mount_attr build error)
Message-ID: <2023061929-landfill-speculate-1885@gregkh>
References: <5f49c8bc-1eb7-be99-a1a8-7d7e0e87ad1b@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f49c8bc-1eb7-be99-a1a8-7d7e0e87ad1b@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 14, 2023 at 01:28:25PM -0700, Hardik Garg wrote:
> commit d8e45bf1aed2 upstream.
> (selftests/mount_setattr: fix redefine struct mount_attr build error)
> Backport this commit from v6.2.0-rc5 to v6.3, v6.1, and v5.15 to resolve
> the struct redefinition error:

6.3 obviously already has this commit in it, so how are you seeing an
error there?

confused,

greg k-h
