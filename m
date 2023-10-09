Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6B17BE8D5
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 20:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376857AbjJISCv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 14:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376900AbjJISCv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 14:02:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EE494
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 11:02:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10438C433C7;
        Mon,  9 Oct 2023 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696874569;
        bh=d3FdwvtvKr9tew728w6/Qmk2W9VF8MLOdgOEYYNobKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=otwr7iKqVZIro9wBtNpN9ENZ/Q7we2+OX+uVgIemzb4Y0yB2vFTGWx3oRC5J9RJVY
         cfd7Gxm+fi/UP+tkf/gdy8Hw1X+GzLLHUTctev1KzaVgUvc93PtDlABPLCSwR2Kl/G
         3lyLrjjfOAfnCKoreyt8J1WVtFKRF/F9m2FJeSmA=
Date:   Mon, 9 Oct 2023 20:02:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Marek Vasut <marex@denx.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: Drop from 5.15 and older -- clk: imx: pll14xx: dynamically
 configure PLL for 393216000/361267200Hz
Message-ID: <2023100926-smugly-juniper-70fc@gregkh>
References: <4e5fa5b2-66b8-8f0b-ccb9-c2b774054e4e@denx.de>
 <2023100738-shell-scant-cfb6@gregkh>
 <6092d57f-4688-aaf2-120d-0e10c40f89c6@pengutronix.de>
 <be223184-6849-3d0c-a3ab-5f34f0bcfe68@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be223184-6849-3d0c-a3ab-5f34f0bcfe68@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 09, 2023 at 04:33:32PM +0200, Ahmad Fatoum wrote:
> On 09.10.23 16:17, Ahmad Fatoum wrote:
> > On 07.10.23 13:44, Greg KH wrote:
> >   Cc: stable@vger.kernel.org # v5.18+
> > 
> > Which is the syntax described in Documentation/admin-guide/reporting-issues.rst.
> 
> This is wrong. The example in that file has "Cc: <stable@vger.kernel.org> # 5.4+"
> without the v. Still, looking at other commits, the syntax with leading v is common
> enough that it's worth handling.

We can handle it either way, it's me reading it, no script is parsing
this :)

thanks,

greg k-h


