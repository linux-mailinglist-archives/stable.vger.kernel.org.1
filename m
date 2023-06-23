Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3A673B426
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjFWJxB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjFWJw5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:52:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4EF184
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6331619D0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD003C433C0;
        Fri, 23 Jun 2023 09:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687513976;
        bh=pGamjcIe+8ovwyOvPBVtIx0PXFJ60YVVTdwGMF+RyRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBIT3gydqRtFxDfzaV2TrpVPZ8tjZX1GmC3tIsVLXNPcSO78r9QN0/OkhhcLoHOix
         0d2oKsD0N3gOlKEEyp+fjWZs381uwgwXjAKhN3U1RiMraxtm9cK/xiGwK+8tiTM1lu
         awT5XKF5gm/Ej471uqCJel42r+wNPXV050dq2OqM=
Date:   Fri, 23 Jun 2023 11:52:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     stable <stable@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Subject: Re: Request for "ip_tunnels: allow VXLAN/GENEVE to inherit TOS/TTL
 from VLAN" in v5.4 / v5.15
Message-ID: <2023062335-slogan-requisite-c8db@gregkh>
References: <f220c0e0-446c-58bd-eabb-0dee9819dd53@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f220c0e0-446c-58bd-eabb-0dee9819dd53@6wind.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 23, 2023 at 11:43:24AM +0200, Nicolas Dichtel wrote:
> Hi,
> 
> I would like to request for cherry-picking commit 7074732c8fae ("ip_tunnels:
> allow VXLAN/GENEVE to inherit TOS/TTL from VLAN") in linux-5.15.y and
> linux-5.4.y branches.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7074732c8fae
> 
> This commit has lived since a long time in upstream (11 months), the potential
> regressions seems low. The cherry-pick is straightforward.
> It fixes the vxlan tos inherit option when vlan frames are encapsulated in vxlan.
> 
> The kernel 5.4 and 5.15 are used by a lot of vendors, having this patch will fix
> this bug.

You forgot about 5.10.y :)

Now queued up for all 3, thanks.

greg k-h
