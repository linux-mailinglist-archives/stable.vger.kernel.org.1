Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E26FAD80
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbjEHLfO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbjEHLfB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933253DCB2;
        Mon,  8 May 2023 04:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 148B363223;
        Mon,  8 May 2023 11:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F37C4339B;
        Mon,  8 May 2023 11:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683545646;
        bh=ZILwEctvAK18Hu7PlI1bveD9toRdgnBJ+HsGTT+MR2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MnYZ8L4k2KG1HX52v5lWPCh69Y33RV3dEYpmXEuQ4LnfDqEayU0bhanLQ8PpxUGCD
         q/Br9plvVRcCRjfZwXCM9Cpm/keXJf2w/gMpQXz9x//hxkur6ZDU+g1s4f849rQNhB
         iRSalTnIxeWRZVbulB3xm/ueWXWqH6MryB3cKiuT3211/XS6gyGOUr+Kr0HBsEAlry
         w4Gejl3Oea3kzYNwxOufZgyDo3PXtguZyYPCJdB5v+etjdvAgjJe9dhspQ811lmFoK
         XFgbjLC0jEpGSQhhCqGkntcgCOCCKz8fNhlxZGcnzYxmHQiHglU2uYT4v3SGihXVk1
         ZkxzYctQHHbnQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pvz8I-0002MF-La; Mon, 08 May 2023 13:34:23 +0200
Date:   Mon, 8 May 2023 13:34:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Udipto Goswami <quic_ugoswami@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v9] usb: dwc3: debugfs: Prevent any register access when
 devices is runtime suspended
Message-ID: <ZFjePu8Wb6NUwCav@hovoldconsulting.com>
References: <20230505155103.30098-1-quic_ugoswami@quicinc.com>
 <20230506013036.j533xncixkky5uf6@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506013036.j533xncixkky5uf6@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 06, 2023 at 01:30:52AM +0000, Thinh Nguyen wrote:

Udipto, looks like you just ignored my comment about fixing up the patch
Subject.

> On Fri, May 05, 2023, Udipto Goswami wrote:
> > When the dwc3 device is runtime suspended, various required clocks would
> > get disabled and it is not guaranteed that access to any registers would
> > work. Depending on the SoC glue, a register read could be as benign as
> > returning 0 or be fatal enough to hang the system.
> > 
> > In order to prevent such scenarios of fatal errors, make sure to resume
> > dwc3 then allow the function to proceed.
> > 
> > Fixes: 62ba09d6bb63 ("usb: dwc3: debugfs: Dump internal LSP and ep registers")
> 
> This fix goes before the above change.

Yes, this clearly is not the commit that first introduced this issue.

Either add a Fixes tag for the oldest one or add one for each commit
that introduced debugfs attributes with this issues.

> This also touches on many places and is more than 100 lines. While this
> is a fix, I'm not sure if Cc stable is needed. Perhaps others can
> comment.

I believe this should be backported as it fixes a crash/hang.

The stable rules are flexible, but it may also be possible to break the
patch up in pieces and add a corresponding Fixes tag.

Johan
