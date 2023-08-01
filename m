Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA076AA4F
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 09:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjHAHwe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 03:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHAHwd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 03:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13330E49
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 00:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DFAC614A7
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 07:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C255C433C8;
        Tue,  1 Aug 2023 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690876352;
        bh=2wg1u7fxyqVy1ZeIi4vlo8zdzTEytc0+KEO4AGgltrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=draCrfCj8Ht7cfgI3JVbB4O+AMtWvjptFIweZACrDlZm6HQa1cYRWSc+ernA9fbjd
         tyhyGI9lERewBoQtQwj/foNS/QzhgGFSivdRQ1KdaqR4BKsopv/daLIpzl7Cp1UuC7
         Ze9PQgtoW3ZbuRjH34EargRkfRob4gM8SmZtY4FM=
Date:   Tue, 1 Aug 2023 09:52:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Cc:     stable@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        clm@fb.com
Subject: Re: [PATCH 5.4 0/3] CVE-2023-1611 Kernel: race between quota disable
 and quota assign ioctls in fs/btrfs/ioctl.c
Message-ID: <2023080123-wronged-dowry-1363@gregkh>
References: <20230728073914.226947-1-harshvardhan.j.jha@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728073914.226947-1-harshvardhan.j.jha@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 28, 2023 at 12:39:11AM -0700, Harshvardhan Jha wrote:
> The following series is a backport the fix of CVE-2023-1611
> on stable 5.4. All pics were clean and no conflict resolution was
> needed.
> 
> Commits "btrfs: qgroup: remove one-time use variables for quota_root
> checks" and "btrfs: qgroup: return ENOTCONN instead of EINVAL when
> quotas are not enabled" were added to get a clean pick for the fix
> "btrfs: fix race between quota disable and quota assign ioctls"
> 
> These changes have been tested using the xfstests test-suite and no regressions
> were observed when compared to stable 5.4.
> 
> Filipe Manana (1):
>   btrfs: fix race between quota disable and quota assign ioctls
> 
> Marcos Paulo de Souza (2):
>   btrfs: qgroup: remove one-time use variables for quota_root checks
>   btrfs: qgroup: return ENOTCONN instead of EINVAL when quotas are not
>     enabled
> 
>  fs/btrfs/ioctl.c  |  2 ++
>  fs/btrfs/qgroup.c | 55 +++++++++++++++++++++--------------------------
>  2 files changed, 27 insertions(+), 30 deletions(-)
> 
> -- 
> 2.40.0
> 

All now queued up, thanks.

greg k-h
