Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9D27A0E9C
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjINT6R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 15:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjINT6Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 15:58:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480A526BC
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 12:58:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2FAC433C7;
        Thu, 14 Sep 2023 19:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694721491;
        bh=vnKDFySNlhlKPH3BAirwdbJlTr4ajeTiH5Uwamjt5sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PizRjT492y/il0bT9OELXX0UH+GBnfpE72LcuxQKmztSQ0MzJt8Mm0t+3Hk2bW1Cx
         A8xIK6Rg5P2ecrSao6UD3dOImO4YkyyVfPFqdl4e/pTkryP/pQgcLzLL+XOhg0JPvy
         7NUPEZNXkBckchn0VjFIdbhuzsGiPHJhD1BUO6rq3WTlHRQjf4O/EUqRFPvWRrUzI+
         COeWH/io/bKrNYlgcfC8PH4Ex2ABSEbn+Q9e03oO06BTV05HxVpI2RqGGjbfW0426w
         B4b67vLrw3a5LzO2s+sRDNeV6X2C6TfJRMRd7Y6DtXTfhz/SCfRJ/peZXEwATb5eQU
         gE9G7cUqK7eYw==
Date:   Thu, 14 Sep 2023 12:58:09 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Felix Yan <felixonmars@archlinux.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        hch@lst.de, =?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>, stable@vger.kernel.org
Subject: Re: [PATCHv2] nvme: avoid bogus CRTO values
Message-ID: <ZQNl0WMd9E8obFcs@kbusch-mbp>
References: <20230913202810.2631288-1-kbusch@meta.com>
 <536c792d-984c-439b-8ee9-25b1bfc5c791@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536c792d-984c-439b-8ee9-25b1bfc5c791@archlinux.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 14, 2023 at 10:48:55PM +0300, Felix Yan wrote:
> 
> Thanks, verified that it works well here.

Thanks, okay if I append your Tested-by: in the patch?
 
> I noticed only one very small issue: dev_warn_once seems to only print once
> when multiple devices are affected. It may be more ideal if it prints once
> for each device, but I don't know how to really achieve that...

There's no good way to do that, unfortunately. We'd have to create a
custom "print once" based on some driver specific flag for this path,
but that's overkill for this issue, IMO. I feel it should be sufficient
just to know that the fallback is happening, and doesn't really matter
for an admin scanning the logs to see it appear for each device. My main
concern was printing it on every reset; that level of repitition would
definitely cause alarm for some people.
