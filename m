Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B68C7DCCED
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 13:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbjJaMTD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 08:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbjJaMTA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 08:19:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F30DB
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 05:18:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6625AC433C8;
        Tue, 31 Oct 2023 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698754736;
        bh=7OOS9qkcluavkTKnbWW/XeVuIPRwBkxj/gK/y1hH3Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x1gE+WGN2dYT17H9UJAxQt4droggylH86mfGSA1pfAXdWeUcVz8IfvJDEXEwFxn99
         tKqQpqiO6z+tCfwNPcFBy1HIFz5PxVzGaDtjkxX2rkzZONu+5fddU7oubaFjfPspYl
         uFIWBY13CvaGYqqkrL1cTkCrE7f0e6KckWJpb+6c=
Date:   Tue, 31 Oct 2023 13:18:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     dlazar@gmail.com, hdegoede@redhat.com, mario.limonciello@amd.com,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] x86/i8259: Skip probing when ACPI/MADT advertises
 PCAT
Message-ID: <2023103145-abacus-shorten-3092@gregkh>
References: <2023102936-encounter-impatient-894d@gregkh>
 <87il6pyt9w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il6pyt9w.ffs@tglx>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 29, 2023 at 11:10:19PM +0100, Thomas Gleixner wrote:
> 
> commit 128b0c9781c9f2651bea163cb85e52a6c7be0f9e upstream.
> 
> David and a few others reported that on certain newer systems some legacy
> interrupts fail to work correctly.

All now queued up, thanks.

greg k-h
