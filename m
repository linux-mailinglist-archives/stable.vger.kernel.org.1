Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101077E5ADF
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 17:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjKHQMb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 11:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjKHQMa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 11:12:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD631BDD
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 08:12:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2038EC433C9;
        Wed,  8 Nov 2023 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699459948;
        bh=gb1qNw0Ii7MCjpbOgCoGg4Iun+7X7SqHTMt3LvFNhQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNj3aHzSdFCwyGCZyNQ27hywyQwoGB/31seJzJ0d7uqRXeoVQ+b4gO3pr4oslvCVm
         ive4sPxwT6i5kj9+Q5OlUw/nCezPwJWYzzRvoOoM5sTExyj1R8ZSC3qcirsV0WtlLQ
         T2byH5lH6zne0rKMEjcRzJ0e4DU0ET512vAEksSc=
Date:   Wed, 8 Nov 2023 17:12:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johnathan Mantey <johnathanx.mantey@intel.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 062/131] ncsi: Propagate carrier gain/loss events to
 the NCSI controller
Message-ID: <2023110837-maturity-clean-6e78@gregkh>
References: <20231009130116.329529591@linuxfoundation.org>
 <20231009130118.189922269@linuxfoundation.org>
 <8734xg2seb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734xg2seb.fsf@intel.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 08, 2023 at 07:08:21AM -0800, Johnathan Mantey wrote:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > 5.4-stable review patch.  If anyone has any objections, please let me
> > know.
> > 
> 
> I have discovered an undesirable side effect caused by this change. If it
> isn't too late, I'd like to see this change set dropped.

And what is that side effect?

This is already in the following released kernels:
	5.4.258 5.10.198 5.15.134 6.1.56 6.5.6 6.6
so please, fix this in Linus's tree and tag the fix for the stable
backports as well and all will be good.

thanks,

greg k-h
