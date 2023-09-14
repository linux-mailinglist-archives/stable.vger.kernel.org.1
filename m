Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4164F7A08F0
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 17:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbjINPVK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 11:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240687AbjINPVJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 11:21:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AC3C1
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 08:21:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6972C433C7;
        Thu, 14 Sep 2023 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694704865;
        bh=QGHJ2MNASWncSpG/BYyl2uUv2mHWKg/N0FO6GxQIbhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IV6B23whsnV+DoLjsUOgS5+7KaxKB643M5/We8Sha1Dshz1aABavs6gQdzm7pfC7U
         SAwK/Y6ZBnaNTHiSA+CT2TEUgGChj/tVoTkUOvCud8ORvz7eksrBmUVv7GGi/cVAUD
         5m6No5RLICrBZ4egNPdSMMOFf9uxYSAq9EBoYm7YkrCIdfgSNxMtUVGbWKfNoYIUaw
         ov///X6EcBX5uT8EuzVdGyGRNIAFhj3MR/dgibx4c38Or73BuaC5IQ1u9nkSIBa7c1
         j/H2kOkghuFMkQ2PdDRN1QABJ/IMy7QBXwCuREuz1LRXTxnz2QRuFeOhwZ5UPjSeeS
         M1laz2o1+H4YQ==
Date:   Thu, 14 Sep 2023 08:21:03 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de,
        =?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        Sagi Grimberg <sagi@grimberg.me>, stable@vger.kernel.org
Subject: Re: [PATCHv2] nvme: avoid bogus CRTO values
Message-ID: <ZQMk38DogqopZLeo@kbusch-mbp>
References: <20230913202810.2631288-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913202810.2631288-1-kbusch@meta.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 01:28:10PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some devices are reporting Controller Ready Modes Supported, but return
> 0 for CRTO. These devices require a much higher time to ready than that,
> so they are failing to initialize after the driver started preferring
> that value over CAP.TO.
> 
> The spec requires CAP.TO match the appropritate CRTO value, or be set to
> 0xff if CRTO is larger than that. This means that CAP.TO can be used to
> validate if CRTO is reliable, and provides an appropriate fallback for
> setting the timeout value if not. Use whichever is larger.

I need to send a pull request out today since we're quite a bit behind
as it is. I've applied this for nvme-6.6 now since it fixes a regression
that apparently quite a few people are encountering. If there are any
objections, please let me know by EOD and I'll remove it from the queue.
