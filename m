Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696367C8200
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 11:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjJMJ0p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 05:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjJMJ0o (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 05:26:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A331E95
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 02:26:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFDAC433C8;
        Fri, 13 Oct 2023 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697189202;
        bh=8iLd7VlcI7wXbTB+5Lhowsuei0/aADcJ/3z8eZEJZtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEaijQVQVjX5LLJb1E5qsND213nlr/XpCeTNsFYwpaR1S9Dq6dnzPSYhyVBPgyOIL
         r96Q/SO2M/YyGq/ZoFg+XFhI812JHa2+vdfQiyoPQxVjG35JzCJzpxhmPdihv4v5qp
         6Ge0mO1WuJCVrDTrh1DiRhNIAQrUM5vCwojWRTKZ4sW8dI/0wwkTD99VTQUZ2SOfYJ
         G33OFXQEQ+dK9hkU7Gz8MW4CaLyehSXcuhx328+g1ss4qmXct/hDHNHY38NX+tM+mw
         K7NdoljOk3SQ38lDdc1O/TS95QcEdsDfU/Co85D8iTIXNCwKkOad1F4dnhvKtICvfj
         oID0x3BVctMgw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qrERu-0004N0-02;
        Fri, 13 Oct 2023 11:27:14 +0200
Date:   Fri, 13 Oct 2023 11:27:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Daniele Palmas <dnlplm@gmail.com>
Cc:     Fabio Porcedda <fabio.porcedda@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Telit LE910C4-WWX 0x1035
 composition
Message-ID: <ZSkNctWGrKZ6Jb54@hovoldconsulting.com>
References: <20230905073724.52272-1-fabio.porcedda@gmail.com>
 <CAGRyCJEzKn13gbBYfoF9H5XKJ_OSXJh0+h3U6SMa6c5S6kAVtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRyCJEzKn13gbBYfoF9H5XKJ_OSXJh0+h3U6SMa6c5S6kAVtQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 06, 2023 at 11:02:22AM +0200, Daniele Palmas wrote:
> Il giorno mar 5 set 2023 alle ore 09:37 Fabio Porcedda
> <fabio.porcedda@gmail.com> ha scritto:
> >
> > Add support for the following Telit LE910C4-WWX composition:
> >
> > 0x1035: TTY, TTY, ECM
> >
> > Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> > Cc: stable@vger.kernel.org
> 
> Reviewed-by: Daniele Palmas <dnlplm@gmail.com>

Thanks for the patch and for the review.

I included the usb-devices output directly in the commit message when
applying.

Johan
