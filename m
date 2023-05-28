Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49A713870
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjE1Hjf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjE1Hje (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B65B4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 00:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8924460F82
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14AAC433EF;
        Sun, 28 May 2023 07:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685259573;
        bh=RomlE0ncdTqBVb/ExtKs95ZbISMxV8bJdd8w80tKlpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1NlUSk0PYs6RvQx/hNGcOH0QEOsVN8WGJRwI1B96/EiLfrxCdQV0DINy+4jrUCFK
         w0u25Tk+neD6/mt8ou0XqBCugH+gfEUb1CNoQpE17kfCYlEW6h53/EuM/6ZLevC44+
         U+CpnPFifUwF7VaNcxnxv3iRbCs65zFVlpX0/dRE=
Date:   Sun, 28 May 2023 08:39:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc:     stable@vger.kernel.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de
Subject: Re: [PATCH 5.15.y] x86/mm: Avoid incomplete Global INVLPG flushes
Message-ID: <2023052820-lilac-email-41e1@gregkh>
References: <2023052612-reproach-snowbird-d3a2@gregkh>
 <20230527001834.1208927-1-daniel.sneddon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527001834.1208927-1-daniel.sneddon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, May 26, 2023 at 05:18:34PM -0700, Daniel Sneddon wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The INVLPG instruction is used to invalidate TLB entries for a
> specified virtual address.  When PCIDs are enabled, INVLPG is supposed
> to invalidate TLB entries for the specified address for both the
> current PCID *and* Global entries.  (Note: Only kernel mappings set
> Global=1.)
> 
> Unfortunately, some INVLPG implementations can leave Global
> translations unflushed when PCIDs are enabled.
> 
> As a workaround, never enable PCIDs on affected processors.
> 
> I expect there to eventually be microcode mitigations to replace this
> software workaround.  However, the exact version numbers where that
> will happen are not known today.  Once the version numbers are set in
> stone, the processor list can be tweaked to only disable PCIDs on
> affected processors with affected microcode.
> 
> Note: if anyone wants a quick fix that doesn't require patching, just
> stick 'nopcid' on your kernel command-line.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> (cherry picked from commit ce0b15d11ad837fbacc5356941712218e38a0a83)
> Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
> ---
>  arch/x86/include/asm/intel-family.h |  5 +++++
>  arch/x86/mm/init.c                  | 25 +++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)

All now queued up, thanks.

greg k-h
