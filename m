Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CE3739909
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 10:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFVIKS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 04:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFVIKR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 04:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBACB10DB
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 01:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7957361768
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 08:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90836C433C8;
        Thu, 22 Jun 2023 08:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687421415;
        bh=kL7+m7MeOQBTLJQ4Cvo92ufPhfvZll7meDei71+QyBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5Rtf8snA8gPvAbUYvhLfffEtrWexYAr02kjddBllQaFqfkOOVVB13XTQfex0dBQU
         nbBzI86yPWMnT2+/bcFd7E++gIEGDsMOMJ9xY+ZomTYVZaE/yX9QNXl6HKpngSKszU
         HFgBNK7jn+TkXBadCNBdmvX2KRasZEWuS8SkC+yg=
Date:   Thu, 22 Jun 2023 10:10:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hardik Garg <hargar@linux.microsoft.com>
Cc:     stable@vger.kernel.org, code@tyhicks.com
Subject: Re: backport d8e45bf1aed2 (selftests/mount_setattr: fix redefine
 struct mount_attr build error)
Message-ID: <2023062258-deviancy-estimate-e976@gregkh>
References: <5f49c8bc-1eb7-be99-a1a8-7d7e0e87ad1b@linux.microsoft.com>
 <2023061929-landfill-speculate-1885@gregkh>
 <1f8ce040-ce1e-f8f3-9a52-4f9c0f61e726@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f8ce040-ce1e-f8f3-9a52-4f9c0f61e726@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 10:53:02AM -0700, Hardik Garg wrote:
> I apologize for the mistake. I'm not getting this error with v6.3
> Please backport it to v6.1 and v5.15

Now queued up, thanks.

greg k-h
