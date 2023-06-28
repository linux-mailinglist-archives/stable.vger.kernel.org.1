Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE73E7417E4
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 20:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjF1SU5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 14:20:57 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:55640 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjF1SUr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 14:20:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FC356141D
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 18:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260BCC433C8;
        Wed, 28 Jun 2023 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687976446;
        bh=bJsJLEf+O0tPy+gL1RctMXdMQmyPG0v4a2Z9VNfyGBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHgGz6D9MzzvCdWZXA2psnmHHN3dF+txf+kHTjRAJTHImEigmv8rge2P306W9sA3n
         jEFQRIJsccymWtca9eVaA1JFYs+neVfgHCIRh846NtVquUWDSW5E3A+XAcxypVVyFS
         BuhkOvTAolRDd69RJdswA+QcPZPyNrKOOcpvw00Q=
Date:   Wed, 28 Jun 2023 20:20:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.15.y] mptcp: consolidate fallback and non fallback
 state machine
Message-ID: <2023062828-affiliate-overlook-8535@gregkh>
References: <2023062315-example-anger-442b@gregkh>
 <20230627132557.2266416-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627132557.2266416-1-matthieu.baerts@tessares.net>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 27, 2023 at 03:25:57PM +0200, Matthieu Baerts wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> commit 81c1d029016001f994ce1c46849c5e9900d8eab8 upstream.
> 
> An orphaned msk releases the used resources via the worker,
> when the latter first see the msk in CLOSED status.
> 
> If the msk status transitions to TCP_CLOSE in the release callback
> invoked by the worker's final release_sock(), such instance of the
> workqueue will not take any action.
> 
> Additionally the MPTCP code prevents scheduling the worker once the
> socket reaches the CLOSE status: such msk resources will be leaked.
> 
> The only code path that can trigger the above scenario is the
> __mptcp_check_send_data_fin() in fallback mode.
> 
> Address the issue removing the special handling of fallback socket
> in __mptcp_check_send_data_fin(), consolidating the state machine
> for fallback and non fallback socket.
> 
> Since non-fallback sockets do not send and do not receive data_fin,
> the mptcp code can update the msk internal status to match the next
> step in the SM every time data fin (ack) should be generated or
> received.
> 
> As a consequence we can remove a bunch of checks for fallback from
> the fastpath.
> 
> Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Conflicting with:
> - 0522b424c4c2 ("mptcp: add do_check_data_fin to replace copied")
> - 3e5014909b56 ("mptcp: cleanup MPJ subflow list handling")
> 
> I took the new modifications but leaving the old variable name for
> "copied" instead of "do_check_data_fin" and the calls to
> __mptcp_flush_join_list()
> 
> Applied on top of d2efde0d1c2e ("Linux 5.15.119-rc1").
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

All backports now queued up, thanks.

greg k-h
