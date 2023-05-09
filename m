Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443666FC9D0
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 17:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbjEIPFb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbjEIPF2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 11:05:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB463A87;
        Tue,  9 May 2023 08:05:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9208E634A9;
        Tue,  9 May 2023 15:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7837C433A7;
        Tue,  9 May 2023 15:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683644725;
        bh=muCXZxs7biHloNS/IxippC0Pd+LQEmkED1bdYH6kwMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0n9xdjaR28f5huH2Mj2pGLm9k9K/q8EYv3L71xHH5demWbJLd6b09uXaCS+aLp3H
         CI+NF75Cwcht0US5VHRJLFjGL63ti2iWKStW9xjRxOUSrVdS/NxOh3au+wv4xQTLnq
         DDOawbiKIOrdiJdCtU9VXBYo7Y9okNiX7t7UnEe/9STSBxy7fnrs2gBXcOS+zlMiBr
         ZDH/g085HZppNFuvEezoqbY86iZC0kZaO4SaTYVZcvIJYee/ywKEXJqW8BWroInl0x
         Xnp/d9UBjhsklyRjrmVdtlRzxFbSN/EnE/iEHQb7gUTRLCa9YPyIoIW8lRa3sQDb43
         ikvc95Dvog+oA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pwOuP-0007pg-Qh; Tue, 09 May 2023 17:05:45 +0200
Date:   Tue, 9 May 2023 17:05:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Udipto Goswami <quic_ugoswami@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v10] usb: dwc3: debugfs: Resume dwc3 before accessing
 registers
Message-ID: <ZFphSUFrUT6dMsQN@hovoldconsulting.com>
References: <20230509144836.6803-1-quic_ugoswami@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509144836.6803-1-quic_ugoswami@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 09, 2023 at 08:18:36PM +0530, Udipto Goswami wrote:
> When the dwc3 device is runtime suspended, various required clocks are in
> disabled state and it is not guaranteed that access to any registers would
> work. Depending on the SoC glue, a register read could be as benign as
> returning 0 or be fatal enough to hang the system.
> 
> In order to prevent such scenarios of fatal errors, make sure to resume
> dwc3 then allow the function to proceed.
> 
> Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
> Cc: stable@vger.kernel.org #3.2: 30332eeefec8: debugfs: regset32: Add Runtime PM support
> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
> ---
> v10: Re-wrote the subject & the commit text along with the dependency.
> v9: Fixed function dwc3_rx_fifo_size_show & return values in function
> 	dwc3_link_state_write along with minor changes for code symmetry.
> v8: Replace pm_runtime_get_sync with pm_runtime_resume_and get.
> v7: Replaced pm_runtime_put with pm_runtime_put_sync & returned proper values.
> v6: Added changes to handle get_dync failure appropriately.
> v5: Reworked the patch to resume dwc3 while accessing the registers.
> v4: Introduced pm_runtime_get_if_in_use in order to make sure dwc3 isn't
> 	suspended while accessing the registers.
> v3: Replace pr_err to dev_err. 
> v2: Replaced return 0 with -EINVAL & seq_puts with pr_err.

I've verified that this prevents the system from hanging when accessing
the debugfs interface while the controller is runtime suspended on the
ThinkPad X13s (sc8280xp):

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
