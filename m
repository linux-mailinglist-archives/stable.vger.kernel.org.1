Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C48745544
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 08:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGCGDp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 02:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjGCGDo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 02:03:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCE9B6
        for <stable@vger.kernel.org>; Sun,  2 Jul 2023 23:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A903660DC6
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 06:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B27C433C8;
        Mon,  3 Jul 2023 06:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688364222;
        bh=DeP/CUR36m3FKKFq4j54H+joqtB+5QADGOpCDpBifvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ydIQMRYVnhDkr4QB1W2vt5Ok9pMUFPmkGVbF1ozEHfaBrrEFMATrz+knze3wrBNVH
         JdGKP4KTgOtDWG9bR5a3AhfR6r9NJG5qYX4w8wwvYAQnmCNGPs3LADlOsDWMbSpZ5Q
         NAlC81PDNqfbnyjMNBPDgpvc31t7Y+XHeG3T5vAU=
Date:   Mon, 3 Jul 2023 08:03:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: Fix some issues due to missing _REG
Message-ID: <2023070329-registrar-ignition-f7c4@gregkh>
References: <880981db-06be-7594-28f4-2818300fc250@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <880981db-06be-7594-28f4-2818300fc250@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 03, 2023 at 12:40:10AM -0500, Mario Limonciello wrote:
> Hi,
> 
> There are two issues that have been identified recently where the lack of
> calling ACPI _REG when devices change D-states leads to functional problems.
> 
> The first one is a case where some PCIe devices are not functional after
> resuming from suspend (S3 or s0ix).
> 
> The second one is a case where as the kernel is initializing it gets stuck
> in a busy loop waiting for AML that never returns.
> 
> In both cases this is fixed by cherry-picking these two commits:
> 
> 5557b62634ab ("PCI/ACPI: Validate acpi_pci_set_power_state() parameter")
> 112a7f9c8edb ("PCI/ACPI: Call _REG when transitioning D-states")
> 
> Can you please backport these to 6.1.y and later?

Now queued up, thanks.

greg k-h
