Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF30726016
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 14:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbjFGMww (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 08:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjFGMwt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 08:52:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE6F1FCD
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 05:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E1C360EA1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 12:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61356C433EF;
        Wed,  7 Jun 2023 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686142345;
        bh=JcdfspB6t4CZg4Ro9h1TSFR+2gHNieZiEpssyeWDHY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4zEkAF0YQ2ciaqZTmYPpXJdYiwwGU9JZYbPNN1M/uhj/uZagYO/bOzLG88HgjZQE
         5xlBqarJjErHJ3JEPquYL7GmtXufVDrNtLZWdT6HeYalMYrffRR8VQM1hhvce9TY1Z
         bOUoPSp8s5rQr+qWegu6of0l48Ror57rT4LDIyNM=
Date:   Wed, 7 Jun 2023 14:52:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Wylder <jwylder@google.com>
Cc:     stable@vger.kernel.org
Subject: Re: regmap: Account for register length when chunking
Message-ID: <2023060707-bovine-ahoy-1196@gregkh>
References: <CAEP57O8D-73=CS_6=s=2pvVjt=sQEv_60TpuppxwnxyN6v4pQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEP57O8D-73=CS_6=s=2pvVjt=sQEv_60TpuppxwnxyN6v4pQg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 02, 2023 at 01:03:24PM -0500, Jim Wylder wrote:
> Requesting that this regmap fix be cherry picked into the active
> stable releases 5.15 and later (5.15 being the earliest I was able
> to test).
> 
> Commit 3981514180c987a79ea98f0ae06a7cbf58a9ac0f fixes a error in
> _regmap_raw_write() when chunking a transmission larger than the
> maximum write size for the bus and when bus writes the address
> and any padding along with the data.
> 
> Jim
> 
> The original commit message is:
> 
> ------
> commit 3981514180c987a79ea98f0ae06a7cbf58a9ac0f
> Author: Jim Wylder <jwylder@google.com>
> Date:   Wed May 17 10:20:11 2023 -0500
> 
>     regmap: Account for register length when chunking
> 
>     Currently, when regmap_raw_write() splits the data, it uses the
>     max_raw_write value defined for the bus.  For any bus that includes
>     the target register address in the max_raw_write value, the chunked
>     transmission will always exceed the maximum transmission length.
>     To avoid this problem, subtract the length of the register and the
>     padding from the maximum transmission.
> 
>     Signed-off-by: Jim Wylder <jwylder@google.com
>     Link: https://lore.kernel.org/r/20230517152444.3690870-2-jwylder@google.com
>     Signed-off-by: Mark Brown <broonie@kernel.org
> ------

Now queued up, thanks.

greg k-h
