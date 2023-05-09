Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD566FBF3B
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 08:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjEIG3y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 02:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjEIG3x (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 02:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F84A65A4;
        Mon,  8 May 2023 23:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D00861683;
        Tue,  9 May 2023 06:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771BFC433D2;
        Tue,  9 May 2023 06:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683613791;
        bh=EWKmzmpmpIPk+tYsSQfEsNi+FvW3K1hTnV5qm+E9KKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVgirDeM/TOBShMWhAS+cU40d4jVIskEqHM8d5CurWK62swipZHL/6lIpnN4cLj6g
         Mz8PczXzf8QDPDcvc26jO5YWEe1bsVlclARetdRywIQ75p1i/M9N+5ft6FNd0UF7u3
         L+QgTa/8Tx9NKhV6X6qLz5kjpg7t18EGA55ajR9PxdKRiwJKJBcCd+k3+2bYSUG713
         yDsL1gadY+5na7qGbXD9HH3Bl1xacva4wj4KwMLoPkDGq1U6+wzQgnqH9wyVtZT3wM
         V4hdDvirNpLq0j3DLeVQV7Il9FsnMlwVR7eVTLU4yOVtSIJ2W0n0AgeOu5qoLekQXk
         dK+bqrFUzKG8w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pwGrS-0007EC-Mt; Tue, 09 May 2023 08:30:10 +0200
Date:   Tue, 9 May 2023 08:30:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Udipto Goswami <quic_ugoswami@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v9] usb: dwc3: debugfs: Prevent any register access when
 devices is runtime suspended
Message-ID: <ZFnoctKuC2i2T8qV@hovoldconsulting.com>
References: <20230505155103.30098-1-quic_ugoswami@quicinc.com>
 <20230506013036.j533xncixkky5uf6@synopsys.com>
 <ZFjePu8Wb6NUwCav@hovoldconsulting.com>
 <34a33b09-20aa-13e3-e4bd-c8b5854450a4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34a33b09-20aa-13e3-e4bd-c8b5854450a4@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 08, 2023 at 09:18:17PM +0530, Udipto Goswami wrote:

> > I believe this should be backported as it fixes a crash/hang.
> > 
> > The stable rules are flexible, but it may also be possible to break the
> > patch up in pieces and add a corresponding Fixes tag.
> 
> Agree, I will add a fixes tag for the oldest change that introduced the 
> debugfs attributes instead of breaking it to multiple patches and adding 
> fixes for each one. (I think the present code changes can stay in one 
> patch as we are fixing the same issue in all the functions).
> 
> Let me know if you think otherwise?

Sounds good to me. Note that the fix depends on 

	30332eeefec8 ("debugfs: regset32: Add Runtime PM support")

which went into 5.7.

This can be documented as

	Cc: stable@vger.kernel.org	# 3.2: 30332eeefec8: debugfs: regset32: Add Runtime PM support

(see Documentation/process/stable-kernel-rules.rst).

Note that this issue appears to have been there since the driver was
first merged in 3.2.

Johan
