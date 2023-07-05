Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F15B748E61
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 21:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjGETxb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 15:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjGETx0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 15:53:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20101BC0
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 12:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45B9B616E4
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 19:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFB9C433C7;
        Wed,  5 Jul 2023 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688586800;
        bh=UnR/qYPHVY8Bq2CLm7vPnxpBuHlGkTjAEWaeGQxpbU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SvCk7Jp8V+aRC5fiK6Se6HKj/ehO6NTRtt73zZDtEwXe3CPOPBIICTUIaLN9BcRig
         vQd1k8uZSkKGzn+otIYdUEWyHRQAYQWaELF30tF7bQi7je+mdQdFA9jhrelON/csDR
         qCvzNHOpX2GyO4zff17UJMWB7qTp2NyzgNx1soZs=
Date:   Wed, 5 Jul 2023 20:53:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: NULL pointer fixes
Message-ID: <2023070509-dyslexia-character-ae00@gregkh>
References: <1c04a328-10e2-606a-c1ab-370d785d3534@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c04a328-10e2-606a-c1ab-370d785d3534@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 05, 2023 at 02:44:16PM -0500, Limonciello, Mario wrote:
> Hi,
> 
> The following commit landed in 6.4 that helps some occasional NULL pointer
> dereferences when setting up MST devices, particularly on suspend/resume
> cycles.
> 
> 54d217406afe ("drm: use mgr->dev in drm_dbg_kms in
> drm_dp_add_payload_part2")
> 
> Can you please take this to 6.1.y and 6.3.y as well?  The NULL pointer
> de-reference has been reported on both.

Now queued up, thanks.

greg k-h
