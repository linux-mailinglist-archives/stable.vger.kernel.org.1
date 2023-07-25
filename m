Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2167610BD
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjGYK0R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjGYK0J (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48A1199C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5E686162F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF573C433C8;
        Tue, 25 Jul 2023 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690280757;
        bh=8AbLehGa6dSFt+GCAS44M3WU41lJMU7o6om4I9qtGRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDv9FQ6a0El/Ys/fvoKDGC3nswwnwAVdOnn963bTeYfRfG2kzzDeTs6VeLSt9xW9t
         G+JBwtpjEfv57NKxl0/Llmf8Q1HDNNSMTUJNDiWYxKxceGcdRAbY0bV9Zi5p8yQyvQ
         UdjQDJqnCbiTmQrauCypOousmBvHmBHiHRG3fJS8=
Date:   Tue, 25 Jul 2023 12:25:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 6.1 0/7] Backports for "drm/amd/display: Add polling
 method to handle MST reply packet"
Message-ID: <2023072541-cola-query-a4d3@gregkh>
References: <20230724222638.1477-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724222638.1477-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 24, 2023 at 05:26:31PM -0500, Mario Limonciello wrote:
> "drm/amd/display: Add polling method to handle MST reply packet"
> was intended to be backported to kernel 6.1 to solve usage of some
> non-spec compliant MST hubs.
> 
> This series has a variety of dependencies across amdgpu_dm though,
> so the backport requires several manual fixups to avoid hitting
> file and symbol renames.
> 
> Details of individual changes are in the commit message for each
> patch.
> 
> Hamza Mahfooz (1):
>   drm/amd/display: use max_dsc_bpp in amdgpu_dm
> 
> Hersen Wu (1):
>   drm/amd/display: fix linux dp link lost handled only one time
> 
> Qingqing Zhuo (1):
>   drm/amd/display: force connector state when bpc changes during
>     compliance
> 
> Srinivasan Shanmugam (2):
>   drm/amd/display: fix some coding style issues
>   drm/amd/display: Clean up errors & warnings in amdgpu_dm.c
> 
> Wayne Lin (2):
>   drm/dp_mst: Clear MSG_RDY flag before sending new message
>   drm/amd/display: Add polling method to handle MST reply packet

All now queued up, thanks.

greg k-h
