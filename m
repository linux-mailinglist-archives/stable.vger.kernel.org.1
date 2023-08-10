Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E951B777A54
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjHJOTZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 10:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjHJOTY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 10:19:24 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663971B4
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 07:19:23 -0700 (PDT)
Received: from quatroqueijos.cascardo.eti.br (1.general.cascardo.us.vpn [10.172.70.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AA8CF3F161;
        Thu, 10 Aug 2023 14:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691677161;
        bh=D/f99ff8mZI1F+TT0snp+nO0gccOJa2odqJW4qt6J3s=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=IRfpsKUBkFWaHCqb9DBZPyV9VwmP8VWC9p7JD+iuak6cR0DR0ETdrZpYP2jv7CJ5x
         pRpyDemyWyGVAN20Jz0p8eIrQcpjCaTyKVNzHbNgxD/2ONXDx7HTrVoUPvhkw/BPBE
         5iLIeYJJQXt74JLOWlbVWRcK5W9IEBl2+BKSsJkmcdnQlaPcHsNHJt1KRmNnCzZHwD
         R4ajba/le+2aOeZaf65FvXwiEhG+YCbBy3y8Ff53Q1vm1fdvkjAQKwsH4EYkaEo2ok
         tXZhhnUgKeia/1NFZrSBdcYLBLW2PkKNX0stTpQhWLFfo+aJdddYUZXkgI5ms/N7GI
         C555Cn979aBrg==
Date:   Thu, 10 Aug 2023 11:19:17 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     RAJESH DASARI <raajeshdasari@gmail.com>
Cc:     stable@vger.kernel.org, tglx@linutronix.de
Subject: Re: WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c in
 5.4.252 kernel
Message-ID: <ZNTx5TXekM/szrmR@quatroqueijos.cascardo.eti.br>
References: <CAPXMrf9Q7JGCwEnCKM8i0wi3oY9VH2V0fDYX_+6U9jfjzPeZ8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPXMrf9Q7JGCwEnCKM8i0wi3oY9VH2V0fDYX_+6U9jfjzPeZ8Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 10, 2023 at 12:58:53PM +0300, RAJESH DASARI wrote:
> Hi ,
> 
> We are noticing the below warning in the latest 5.4.252 kernel bootup logs.
> 
> WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c:878
> get_xsave_addr+0x83/0x90
> 
> and relevant call trace in the logs , after updating to kernel 5.4.252.
> 
> I see that issue is due to this commit
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.4.252&id=6e60443668978131a442df485db3deccb31d5651
> 
> This is seen in the qemu instance  which  is emulating the host cpu
> and was deployed on Intel(R) Xeon(R) Gold 5218 processor.
> 
> I revert the commit and there is no WARNING and call trace in the logs
> , Is this issue already reported and a fix is available? Could you
> please provide your inputs.
> 
> Regards,
> Rajesh.

Does applying b3607269ff57 ("x86/pkeys: Revert a5eff7259790 ("x86/pkeys:
Add PKRU value to init_fpstate")") fixes it for you?

Cascardo.
