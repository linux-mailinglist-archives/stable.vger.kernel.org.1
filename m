Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3C739CE4
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjFVJ1V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 05:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjFVJ1D (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 05:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F12C268A
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 02:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BFF4617D7
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 09:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CA8C433C0;
        Thu, 22 Jun 2023 09:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687425422;
        bh=A7AQXtt/KFDxudkuK9bKcbPkzr4ajpUNaDSMmZQ/e/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mw6nr0/0fo9KlFwtUK1tI18XMNfAcMjUWSU1Eo0VZaSTUt6LmFb4ACU6qm7ihu47D
         ENrj0ypO7/3YO1cxR9Q9UHFVJ3B3CXJhY+Mhk00lijVS2mdanBwa+4dNuvsQFpYn9N
         1fZFxME+Rwb+MEnb06WOdGmzcHc4+2mnWNa45p8s=
Date:   Thu, 22 Jun 2023 11:16:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     conor@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] scripts/quilt-mail: add email address for Conor Dooley
Message-ID: <2023062248-waggle-earful-fe7f@gregkh>
References: <20230622083443.930823-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622083443.930823-1-conor.dooley@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 22, 2023 at 09:34:44AM +0100, Conor Dooley wrote:
> Sometimes I miss the stable announcements cos of the delights of our
> corporate email setup, so add me to the 0th mail CC list.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I dunno how to test this, but touch wood I've not made a hames of
> something trivial...

Looks good to me, now applied, thanks.

greg k-h
