Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F4279CE84
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjILKiQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 06:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjILKiQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 06:38:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A422ACC3
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 03:38:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED305C433C7;
        Tue, 12 Sep 2023 10:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694515092;
        bh=dIQVlyP42PolZznaFbAugpHLN9YBTqBzjJDxsh5OtkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqYNCVznT0v0Az3+noQuUAtDd4QEztxZrwh6XGd4u9MrjfTLN1tOd9iQIKGcK1S3B
         CrwgW0FthmtCVqBdzX/jZ+454Xacv3F26zuLpsklEh5q/acYnTrjno7C3FeV5WjEId
         eUF8C8ld+PBpPfqO5MPOGpZds2kOcCW+Kctb7OVU=
Date:   Tue, 12 Sep 2023 12:38:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Alexander Danilenko <al.b.danilenko@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5 134/739] spi: tegra114: Remove unnecessary
 NULL-pointer checks
Message-ID: <2023091212-dispose-oboe-ba98@gregkh>
References: <20230911134650.921299741@linuxfoundation.org>
 <20230911134654.832694547@linuxfoundation.org>
 <ZP8lHSmZVOvbI3wN@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP8lHSmZVOvbI3wN@finisterre.sirena.org.uk>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 11, 2023 at 03:33:01PM +0100, Mark Brown wrote:
> On Mon, Sep 11, 2023 at 03:38:53PM +0200, Greg Kroah-Hartman wrote:
> > 6.5-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Alexander Danilenko <al.b.danilenko@gmail.com>
> > 
> > [ Upstream commit 373c36bf7914e3198ac2654dede499f340c52950 ]
> > 
> > cs_setup, cs_hold and cs_inactive points to fields of spi_device struct,
> > so there is no sense in checking them for NULL.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> This is a code cleanup, why is it a stable candidate?  It's not a
> warning fix or anything.

{sigh}  This is due to the crazy people using SVACE marking stuff as a
"fix" when it really isn't to try to boost the chance that their patches
will be accepted :(

I'm all but refusing to take their patches now due to all of the
problems they have caused in the past.  I'll go drop this from all
stable queues as well, thanks for catching this.

greg k-h
