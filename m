Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622E87ABECD
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjIWIRY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 04:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjIWIRX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 04:17:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787F1180
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 01:17:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D2AC433C7;
        Sat, 23 Sep 2023 08:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695457037;
        bh=lUrqarf5J/wNG3skXdLJr09ehc0tAMmI/R3wOn0LZUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtjlFyPFGldr9hWy6p8i/8u5Enjr/9tXZQ7qOlyoyhycQ383ULchc7Z4K3BNSSEVt
         XBb5aUkHwQ0LPF6MQPNnGMUM4dH4DaN7THbEH04P1+R9Lw+FbTw6YBrMlRdjn+D851
         f4QeIiabtoONTn9J7vOezPTxwUj3wybIaSQbkDGw=
Date:   Sat, 23 Sep 2023 10:17:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5 158/211] ata: libata: remove references to
 non-existing error_handler()
Message-ID: <2023092355-shadow-halves-8c2a@gregkh>
References: <20230920112845.859868994@linuxfoundation.org>
 <20230920112850.780030234@linuxfoundation.org>
 <ZQrn1rae3Y55/1DG@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQrn1rae3Y55/1DG@x1-carbon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 20, 2023 at 12:38:50PM +0000, Niklas Cassel wrote:
> On Wed, Sep 20, 2023 at 01:30:02PM +0200, Greg Kroah-Hartman wrote:
> > 6.5-stable review patch.  If anyone has any objections, please let me know.
> 
> Hello Greg,
> 
> I don't think that we should backport this commit.
> 
> While the patch did apply without conflicts, it was part of a series that
> did a bunch of other cleanups as well.
> 
> I think that it is best to either have that whole series (and we don't want
> to backport the whole series), or none of the patches in that series.
> 
> (So that at least we know that we have one or the other, not some half-way
> cleanup that will only live in v6.5 stable.)

Thanks, now dropped.  It was added for a later patch as a dependancy,
but I fixed that up by hand so all should be good now.

greg k-h
