Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1307734D97
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFSI0Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 04:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjFSI0R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 04:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5BCE71
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 01:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7FD960A36
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 08:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F32C433C8;
        Mon, 19 Jun 2023 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687163171;
        bh=P4J8L1mqTzsn53sQpCvuJXcEe77142TD8LVY+aNqM0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkP4eCBBYvqOr9TNLcwkIWstm1wBjvUBtM362R+bKaMGgUoSTz6jNBugHaItYT0/P
         bP6Gi58guLp7OOQtXS7OGv9Qht0NCCf0KZrUJOyiXAbDPPemFJ9W8MevrnVOtUwRHs
         gmG6FnnM+SodtbZACD4iUQtNrtOGUsBe9basWMKw=
Date:   Mon, 19 Jun 2023 10:25:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     stable@vger.kernel.org, holger.philipps@siemens.com,
        wagner.dominik@siemens.com,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH 5.10 v2 0/2] backport i915 fixes to 5.10
Message-ID: <2023061951-elliptic-unglazed-c13c@gregkh>
References: <20230615113909.2109-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615113909.2109-1-henning.schild@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 15, 2023 at 01:39:07PM +0200, Henning Schild wrote:
> changes since v1:
> - added my Signed-Offs
> - removed additional "From"s
> - change cover letter to motivate need for patch1
> 
> This fixes the following problem which was seen on a Tigerlake running
> Debian 10 with a 5.10 kernel. The fix is in the second patch while the
> first patch just makes sure the latter one does apply.

Now queued up, thanks.

greg k-h
