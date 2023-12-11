Return-Path: <stable+bounces-5501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD0380CEA1
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78710281B06
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789E495CE;
	Mon, 11 Dec 2023 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KrrT7nAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NISFLn7d"
X-Original-To: stable@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D65DC2
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 06:47:29 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id CF90C5C03B5;
	Mon, 11 Dec 2023 09:47:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Dec 2023 09:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702306045; x=1702392445; bh=aD
	bCmLvi9t4wqPy0P3gYOPOM7ZNVoaRUqU5RYRCbjgs=; b=KrrT7nANfapS8cJ673
	poWaqPTcR54B66eOYZ9fsEYUXzlGGTTYlasYRYR+5c/7KFoh50XfbMiD9wpoNkU1
	BeBazc/2ZK88faUbb7/CE36Pil3ZTlFajGYxPC0jBvBopacfERfnGwknbuJTLkcz
	CvJ6QfGD9a5HwNVKaEmlHGipFI0jL5p7I6JBtGLkYUJkPPQKf/gzlgqpTz2NvA87
	q/zKzOfnH0gw2ANtxT27PIYbi5aPxlBt6VQa4cXE9xkURXvx5uyMitcrDwdyxAsn
	J6ticE2oaEnxrTe9qNBgWMvCio4Uvd4EcQMZPtVozUl/XpW3PSrMrFQSRlQmua2a
	KNwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702306045; x=1702392445; bh=aDbCmLvi9t4wq
	Py0P3gYOPOM7ZNVoaRUqU5RYRCbjgs=; b=NISFLn7dytRS20DU/CFP9hfKaTHO2
	GYdfNSckznnhXRTVMSSpuhPUPayiNvphojYacrXdMvEA4Kb20VXIXEVZHOiojByi
	PeyN/s+tkD0hMUasLugM+BfBCT+IKgtQDqkV/K8n2H0sy0Tugsz4f6vTwfGaEBnx
	YsHWZr+ENc7+1yCMNWyTr3pXjWwmArnk72mqAw/NqT7LLWN56D+jdA2rn6WAf2UL
	jEL9hpnjz2oehW+5B7s3steTfqcaeaqiZbzCB7jHHLIC4N+15t9UFXCrzFrKMCHf
	xcxRTvXbmqHfDc2SLBk2eRhQZx0lt3B2/3JuIYYMrObHBlMG/CUIx/ubQ==
X-ME-Sender: <xms:_SB3ZREu9kvVMBeSrXzmoxTRPNc6FbD93KsRCXNW4qDOfLyaQl1ENQ>
    <xme:_SB3ZWX_1gIIGhpR8UFJcYShFPwvjdMNQPqHpeOR1prVmvoaGDROuY3FQI2YONUYV
    2VNTkH_u34qJg>
X-ME-Received: <xmr:_SB3ZTLUe13RtamdYhVr9pfaalyBAy3TprAFGGQBjjWNz-TalfJjAvssEC4Kk36Hz96sWvaBiNdK7WX2zb2WPqR3rfLH53GcuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:_SB3ZXGxWU1673zbdChAnsGNFMgUHHf1kKiMeHdV6lPn2a8-PHX5RQ>
    <xmx:_SB3ZXXXC1PyKnjS98jiTdu_TBzhr1LfrYQUjbc2OHcCaJHCumrS1Q>
    <xmx:_SB3ZSN3YJajYOJq6BuYVZ6QdBlxLuRacopQPGsO2v1q0eO5w-NREQ>
    <xmx:_SB3ZUh-DJvOrb_VULeFzW2DENdxdDmOE9-Wnk5E7ta8EiO_tgzisA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 09:47:25 -0500 (EST)
Date: Mon, 11 Dec 2023 15:47:23 +0100
From: Greg KH <greg@kroah.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10] mmc: block: Be sure to wait while busy in CQE error
 recovery
Message-ID: <2023121116-unvented-stipend-df75@gregkh>
References: <2023120358-baking-anymore-b0c7@gregkh>
 <20231211144132.99257-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211144132.99257-1-adrian.hunter@intel.com>

On Mon, Dec 11, 2023 at 04:41:32PM +0200, Adrian Hunter wrote:
> STOP command does not guarantee to wait while busy, but subsequent command
> MMC_CMDQ_TASK_MGMT to discard the queue will fail if the card is busy, so
> be sure to wait by employing mmc_poll_for_busy().
> 
> Backport to 5.10: Add mmc_busy_cmd MMC_BUSY_IO
> 
> Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> Link: https://lore.kernel.org/r/20231103084720.6886-4-adrian.hunter@intel.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> (cherry picked from commit c616696a902987352426fdaeec1b0b3240949e6b)
> Tested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c    | 2 ++
>  drivers/mmc/core/mmc_ops.c | 3 ++-
>  drivers/mmc/core/mmc_ops.h | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)

Now queued up, thanks.

greg k-h

