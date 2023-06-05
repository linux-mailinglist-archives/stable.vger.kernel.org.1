Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD568723045
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 21:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjFETt6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 15:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbjFETtY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 15:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00600123
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 12:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C76F629E9
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 19:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D670C433D2;
        Mon,  5 Jun 2023 19:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685994511;
        bh=HF4SvIJsbwlda0Sb64fA20GYLcAQev/LfnXDvCgy9UU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOBhlH+fXLlQVtHRVVWg3E0ctC1M/MQ9u506IjyfJCmP+ndHDFvWKC5/EHbAWeNEA
         T5rp4v7purbnx9HCSEqURjENeUMmUBo+rwOG1+05OF4LyFbpK33nC03O2w1DiogebY
         wEEWuYDmhybgrtsM7aNOxOr4yRMOOxKdJzLD2bIE=
Date:   Mon, 5 Jun 2023 21:48:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Borislav Petkov <bp@alien8.de>,
        Christian Kujau <lists@nerdbynature.de>
Subject: Re: Request: x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix
 pat_x_mtrr_type() for MTRR disabled case")
Message-ID: <2023060513-self-ditch-57f5@gregkh>
References: <CAKf6xptzGSq5xUhbFDVB-vR0WfhDWnqXRY3UYYG4DvUakNR1AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKf6xptzGSq5xUhbFDVB-vR0WfhDWnqXRY3UYYG4DvUakNR1AQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 05, 2023 at 09:56:24AM -0400, Jason Andryuk wrote:
> x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for
> MTRR disabled case")
> 
> commit f9f57da2c2d119dbf109e3f6e1ceab7659294046 upstream
> 
> The requested patch fixes ioremap for certain devices when running as
> a Xen Dom0.  Without the patch, one example is TPM device probing
> failing with:
> tpm_tis IFX:00: ioremap failed for resource
> 
> The requested patch did not include a Fixes tag, but it was intended
> as a fix to upstream 90b926e68f500844dff16b5bcea178dc55cf580a, which
> was subsequently backported to 6.1 as
> c1c59538337ab6d45700cb4a1c9725e67f59bc6e.  The requested patch being a
> fix can be seen in the thread here:
> https://lore.kernel.org/lkml/167636735608.4906.4788207020350311572.tip-bot2@tip-bot2/
> 
> I think it's only applicable to 6.1

Now queued up, thanks.

greg k-h
