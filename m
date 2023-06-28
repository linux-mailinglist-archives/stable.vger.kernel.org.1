Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBCF74188C
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 21:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjF1TCq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 15:02:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45007 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232395AbjF1TB6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 15:01:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B915D5C0181;
        Wed, 28 Jun 2023 15:01:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 28 Jun 2023 15:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687978917; x=1688065317; bh=FQ3GT5OEOBkeRk2JrCGxVq+o/Be+eewK7Ly
        otSN6uDA=; b=mVNq9f7jYhPULSjA7hi8/1FU1+leCWBU2OVr/tvhi39llL0byE+
        +1n+tpwba39ERUx+8fpOHXq1wnb5BvOylm3uGqnOKo8MxSNXyPdqyDRtow74IaQy
        MAV+o99NWgol/uIYFeDUAkytyta9iSnqhigxGofgPuHGvcannXPYPATouofmSXlL
        dQ1RU9JSZcaTV+qW3F/x0qz6PL0aZIIMd0om4bD5Bg8P81QYkcfy6eL54R79dpME
        SmRMA7BW2/IqgM9/WiXlV59vav6Kd8n3noqh171wPTO9e0DLCavUumgg1J+Q9Sgi
        66xXbLUR79J/VStFwTffbnUhaaflWVvwskA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687978917; x=1688065317; bh=FQ3GT5OEOBkeRk2JrCGxVq+o/Be+eewK7Ly
        otSN6uDA=; b=jCUFHeIe/QZkAd2OZot6wCK3HVUdQWHP7wRoXX7p+OdCxYpI+AC
        8rpgzsdtJpelGMS7f3cbsNNteILAwXPdJ5VmitNXW2T6O1RSNTFkWHvTL3SKyf6l
        ZvQIkccaDsy4wsQ2nVJhYOBHws+0/5+U8txQ9kCIoGxYtZfQPGkitleNRNDcd2Kj
        AYRTjj3oCpfK/O7hESFbrSEiQBKP1oPvbLuGZY1fcScNvnTG7/T50fcsQg80CMTf
        za35Uhh70eyxNovPbuRDnedVE/k4smUkVAZqLjdKC/ecLryVE25aCOTzkfAm5AfS
        a9qnxjHXiT6lBSlR/oeco0fTxAm7lD6EaEg==
X-ME-Sender: <xms:pYOcZGYVdPIn3W_3TRJwJFRqExhjAo0w41DBcoA0E6RV0qd2RObkOQ>
    <xme:pYOcZJbcpPzKofD6bwibED1yI1DNATcO_kzyyB_ov8kfVPObTXXaWbUG2fnWsaowp
    0ygupOsK8IJUg>
X-ME-Received: <xmr:pYOcZA8ICRZFVLjpOKW1vCzV2tHsOvGCKImy5_1-CQ_BZcdJ4HCXpIVn6fpikq4A8tv4q7gakERr5vCBxAaGqHQpTpPABqWWLIWB0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelhe
    ehudduueeggeejgfehueduffehveeukefgkeeufeeltdejteeiuedtkeekleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:pYOcZIpUzTMY9QkozlFRd3YkSa4JX_KFGXmUtLOpQuA6g5h31iF0Cg>
    <xmx:pYOcZBq_3F_5NhW2vg-ivlfIY0ScnpRR8GAkVaDLIg7Z2JoLAOxcTg>
    <xmx:pYOcZGRWjV2A6DGjuaD4ssRwgPfTBuSzkaNWVHDyRic0sIi8Ibk34w>
    <xmx:pYOcZOhLufibJRo9ji58Z1cdpg5LjI0TKTd97sTIQtlelCBHmY9DJg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jun 2023 15:01:56 -0400 (EDT)
Date:   Wed, 28 Jun 2023 21:01:54 +0200
From:   Greg KH <greg@kroah.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, Philip Yang <Philip.Yang@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH 5.15.y] drm/amdgpu: Set vmbo destroy after pt bo is
 created
Message-ID: <2023062848-edginess-thirty-13b9@gregkh>
References: <20230628111636.23300-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628111636.23300-1-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 28, 2023 at 06:16:36AM -0500, Mario Limonciello wrote:
> From: Philip Yang <Philip.Yang@amd.com>
> 
> Under VRAM usage pression, map to GPU may fail to create pt bo and
> vmbo->shadow_list is not initialized, then ttm_bo_release calling
> amdgpu_bo_vm_destroy to access vmbo->shadow_list generates below
> dmesg and NULL pointer access backtrace:
> 
> Set vmbo destroy callback to amdgpu_bo_vm_destroy only after creating pt
> bo successfully, otherwise use default callback amdgpu_bo_destroy.
> 
> amdgpu: amdgpu_vm_bo_update failed
> amdgpu: update_gpuvm_pte() failed
> amdgpu: Failed to map bo to gpuvm
> amdgpu 0000:43:00.0: amdgpu: Failed to map peer:0000:43:00.0 mem_domain:2
> BUG: kernel NULL pointer dereference, address:
>  RIP: 0010:amdgpu_bo_vm_destroy+0x4d/0x80 [amdgpu]
>  Call Trace:
>   <TASK>
>   ttm_bo_release+0x207/0x320 [amdttm]
>   amdttm_bo_init_reserved+0x1d6/0x210 [amdttm]
>   amdgpu_bo_create+0x1ba/0x520 [amdgpu]
>   amdgpu_bo_create_vm+0x3a/0x80 [amdgpu]
>   amdgpu_vm_pt_create+0xde/0x270 [amdgpu]
>   amdgpu_vm_ptes_update+0x63b/0x710 [amdgpu]
>   amdgpu_vm_update_range+0x2e7/0x6e0 [amdgpu]
>   amdgpu_vm_bo_update+0x2bd/0x600 [amdgpu]
>   update_gpuvm_pte+0x160/0x420 [amdgpu]
>   amdgpu_amdkfd_gpuvm_map_memory_to_gpu+0x313/0x1130 [amdgpu]
>   kfd_ioctl_map_memory_to_gpu+0x115/0x390 [amdgpu]
>   kfd_ioctl+0x24a/0x5b0 [amdgpu]
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> (cherry picked from commit 9a3c6067bd2ee2ca2652fbb0679f422f3c9109f9)
> 
> This fixes a regression introduced by commit 1cc40dccad76 ("drm/amdgpu:
> fix Null pointer dereference error in amdgpu_device_recover_vram") in
> 5.15.118. It's a hand modified cherry-pick because that commit that
> introduced the regression touched nearby code and the context is now
> incorrect.

Now queued up, thanks.

greg k-h
