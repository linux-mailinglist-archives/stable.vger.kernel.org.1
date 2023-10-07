Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6062B7BC68F
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 11:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjJGJwI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGJwH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 05:52:07 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2FFB9
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 02:52:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2864B32009BC;
        Sat,  7 Oct 2023 05:52:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 07 Oct 2023 05:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696672321; x=1696758721; bh=PI
        /FYbXP4tamTEEOaZ71Eser6r+FAUef7sdQARGl9f4=; b=ZArjl1HUy8VDHPRgqO
        gQ+SSOeRuvdkOi/QUukXTJJ5P107t/x/dA7/7/hZuB2xhZ5rBoVQB+O/+Sapf1+u
        tZI99jkRj8fWKSFHwzg6NOuWAB/jzBC0af+Z3bu+LmeGftME+2HiKtvdvjboJJlm
        mTUizZzVx6tSPeb+piW1Nt6Q/d2BxyTmlVnEGsghv+MsoAWWJ0qCDv/OEQVYSGVW
        0/c9jgmLE0OnuqwCkx6GW30qsVT2fb3aIW+04BR9MP5JV6gcXBKTY4V1eIElqZSp
        70stptTxWYImNDBGhCIXFDbdkynRYX1VENsX98b+BUWCBo8Rr/fQG8UW+dEiubqb
        h+lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696672321; x=1696758721; bh=PI/FYbXP4tamT
        EEOaZ71Eser6r+FAUef7sdQARGl9f4=; b=i+BJ/L9Zvs3U5/NBG/9rumVrYWNPf
        X/qYqMo5MNy5X9CxZEebg1blBv3dQrKHpCfg/f+c/oOhmAB01xTxcgTRJIR9484C
        /Nsw7URRc/aDKhs28bdCH0Wlj48t1Op6mgaTxc/dyjkOL8r03tm6E510ILKJrA2M
        s+tVBWGmhUlQxQCyC5KY8flEy+HnXvwWvT0tTGr5adE9mBSCIVcDEPr6EAaeR0gL
        a6GKDbaAnA6EsCYYKtAj2pOTSCNVju5KdkwB7myY1ChWf3LMcTWbi4lJXmjwK8Zl
        o+k7e8Y8gM+f7C4If54acY4xRjR7boC8SGZvBuHd6MBpGtYiaLmg0sLTw==
X-ME-Sender: <xms:QSohZZVhaQgJD7zNYLbyho-Ruy_jms1Sa7HK48TIu1GirhpyA_GpEw>
    <xme:QSohZZmG3LXJ6MZ1bIhypZu4L3_Nd0GRdYQyi-E2o6FHKsfo5_35BpJi3Zb4-e2Dn
    bwCHsJ8jvOndQ>
X-ME-Received: <xmr:QSohZVYdP0r-98iQEgxOB3_hL4zP6Ys63Gl5npp3bB-8g0o13kYbHFlApLkq2pAxrgGQbu3YFfNAZW8s0eh8rN9_6uPWGHvx_clqLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeelgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:QSohZcUtZjU_fBztM3WbpDtxtlnjekHKlHFpjLuP-ZKXS4kfUBPJJg>
    <xmx:QSohZTk_gM3TsitEtrFsb-GNRcrajWVIxDvK4qBTXNq2KCuo_hT6bA>
    <xmx:QSohZZe92u-OOZH3S8_N6SK3I2QVhkxBgU8OBM1qcKAEOG34kPDh7Q>
    <xmx:QSohZccRScROFuLNodNOs4eC5zh5W4_HPmU-SvR_adsl3GwORD062w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Oct 2023 05:52:00 -0400 (EDT)
Date:   Sat, 7 Oct 2023 11:51:57 +0200
From:   Greg KH <greg@kroah.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, Wayne Lin <wayne.lin@amd.com>,
        Chao-kai Wang <stylon.wang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: Re: [PATCH 6.1] drm/amd/display: Adjust the MST resume flow
Message-ID: <2023100751-vastly-crust-d17c@gregkh>
References: <20230920153331.73662-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920153331.73662-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 20, 2023 at 10:33:31AM -0500, Mario Limonciello wrote:
> From: Wayne Lin <wayne.lin@amd.com>
> 
> [Why]
> In drm_dp_mst_topology_mgr_resume() today, it will resume the
> mst branch to be ready handling mst mode and also consecutively do
> the mst topology probing. Which will cause the dirver have chance
> to fire hotplug event before restoring the old state. Then Userspace
> will react to the hotplug event based on a wrong state.
> 
> [How]
> Adjust the mst resume flow as:
> 1. set dpcd to resume mst branch status
> 2. restore source old state
> 3. Do mst resume topology probing
> 
> For drm_dp_mst_topology_mgr_resume(), it's better to adjust it to
> pull out topology probing work into a 2nd part procedure of the mst
> resume. Will have a follow up patch in drm.
> 
> Reviewed-by: Chao-kai Wang <stylon.wang@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Acked-by: Stylon Wang <stylon.wang@amd.com>
> Signed-off-by: Wayne Lin <wayne.lin@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a)
> Adjust for missing variable rename in
> f0127cb11299 ("drm/amdgpu/display/mst: adjust the naming of mst_port and port of aconnector")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> This is a follow up for https://lore.kernel.org/stable/2023092029-banter-truth-cf72@gregkh/
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 ++++++++++++++++---
>  1 file changed, 80 insertions(+), 13 deletions(-)

Now queued up, thanks.

greg k-h
