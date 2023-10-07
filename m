Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCC67BC730
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 13:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjJGLe7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 07:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGLe5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 07:34:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212C710F
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 04:34:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BAAC433C8;
        Sat,  7 Oct 2023 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696678492;
        bh=g4kcmZuVlrnCvXePPMNhjMgpY5B61K7nqUyY3pN4I38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9AulF/PRKsHOGqc/4j3jiOID9eObmROQnmJlj5tRksAEg9P5m0j/edk0oupXWR1Y
         1+yooxejLPcA8l+AVJcRRNyN7pf6TBYhdcejz3wyK/GL2LOR5o/yP66cVo8MPfmYJ1
         V10/nVpF0nV7m2gAxk42NeJHjPISWVY+MsZb7fyg=
Date:   Sat, 7 Oct 2023 13:34:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     stable@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 4.19.y] ata: libata: disallow dev-initiated LPM
 transitions to unsupported states
Message-ID: <2023100739-captivity-earmark-0270@gregkh>
References: <2023092000-constrict-congested-cec9@gregkh>
 <20230928155426.9839-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230928155426.9839-1-niklas.cassel@wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 28, 2023 at 05:54:26PM +0200, Niklas Cassel wrote:
> In AHCI 1.3.1, the register description for CAP.SSC:
> "When cleared to ‘0’, software must not allow the HBA to initiate
> transitions to the Slumber state via agressive link power management nor
> the PxCMD.ICC field in each port, and the PxSCTL.IPM field in each port
> must be programmed to disallow device initiated Slumber requests."
> 
> In AHCI 1.3.1, the register description for CAP.PSC:
> "When cleared to ‘0’, software must not allow the HBA to initiate
> transitions to the Partial state via agressive link power management nor
> the PxCMD.ICC field in each port, and the PxSCTL.IPM field in each port
> must be programmed to disallow device initiated Partial requests."
> 
> Ensure that we always set the corresponding bits in PxSCTL.IPM, such that
> a device is not allowed to initiate transitions to power states which are
> unsupported by the HBA.
> 
> DevSleep is always initiated by the HBA, however, for completeness, set the
> corresponding bit in PxSCTL.IPM such that agressive link power management
> cannot transition to DevSleep if DevSleep is not supported.
> 
> sata_link_scr_lpm() is used by libahci, ata_piix and libata-pmp.
> However, only libahci has the ability to read the CAP/CAP2 register to see
> if these features are supported. Therefore, in order to not introduce any
> regressions on ata_piix or libata-pmp, create flags that indicate that the
> respective feature is NOT supported. This way, the behavior for ata_piix
> and libata-pmp should remain unchanged.
> 
> This change is based on a patch originally submitted by Runa Guo-oc.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Fixes: 1152b2617a6e ("libata: implement sata_link_scr_lpm() and make ata_dev_set_feature() global")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> (cherry picked from commit 24e0e61db3cb86a66824531989f1df80e0939f26)
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/ata/ahci.c        |  9 +++++++++
>  drivers/ata/libata-core.c | 19 ++++++++++++++++---
>  include/linux/libata.h    |  4 ++++
>  3 files changed, 29 insertions(+), 3 deletions(-)

Both now queued up, thanks.

greg k-h
