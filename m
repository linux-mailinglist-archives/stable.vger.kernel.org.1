Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579837CA0F2
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 09:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjJPHpD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 03:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjJPHpD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 03:45:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60DA83
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 00:45:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4EAC433C8;
        Mon, 16 Oct 2023 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697442301;
        bh=XvdO5ChCScFYGqf6PTOTmAg7nlRj+kYzG4KYxrRgVGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1sU0Votop53yTObasUrpz6yncH1yLlDKVFx3f2YV212rghEpgddBkTtCtl7Rgr0K
         ecBZppLPTroUZMwdk633rDP6pY74v7XamcVoFuZErLGXvtFDuCFm/gFikc7aSRHWrC
         b17bvR0HnqbtQp5UyS7datQxVU+hoFhK9/RrhOgY=
Date:   Mon, 16 Oct 2023 09:44:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     rene@exactcode.de, stable@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/cpu: Fix AMD erratum #1485 on
 Zen4-based CPUs" failed to apply to 5.4-stable tree
Message-ID: <2023101648-pout-deeply-0af5@gregkh>
References: <2023101526-mumbling-theft-3113@gregkh>
 <20231015202207.GCZSxJ75lVvnJKNj/M@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015202207.GCZSxJ75lVvnJKNj/M@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 15, 2023 at 10:22:07PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Sat, 7 Oct 2023 12:57:02 +0200
> Subject: [PATCH] x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Upstream commit f454b18e07f518bcd0c05af17a2239138bff52de.
> 

Both backports now queued up, thanks.

greg k-h
