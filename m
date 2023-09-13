Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFB179E545
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 12:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjIMKuf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbjIMKuY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 06:50:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006471BC8
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 03:50:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C954967373; Wed, 13 Sep 2023 12:50:15 +0200 (CEST)
Date:   Wed, 13 Sep 2023 12:50:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        Keith Busch <kbusch@kernel.org>,
        =?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Message-ID: <20230913105015.GA30644@lst.de>
References: <20230912214733.3178956-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912214733.3178956-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 12, 2023 at 02:47:33PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some devices are reporting controller ready mode support, but return 0
> for CRTO. These devices require a much higher time to ready than that,
> so they are failing to initialize after the driver starter preferring
> that value over CAP.TO.
> 
> The spec requires that CAP.TO match the appropritate CRTO value, or be
> set to 0xff if CRTO is larger than that. This means that CAP.TO can be
> used to validate if CRTO is reliable, and provides an appropriate
> fallback for setting the timeout value if not. Use whichever is larger.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217863
> Reported-by: Cláudio Sampaio <patola@gmail.com>
> Reported-by: Felix Yan <felixonmars@archlinux.org>
> Based-on-a-patch-by: Felix Yan <felixonmars@archlinux.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 48 ++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c

> +	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)

I don't think the NVME_CAP_CRMS_CRWMS check here makes sense, this
should only need the NVME_CAP_CRMS_CRIMS one.

> +	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
> +	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
> +		u32 crto;
> +
> +		ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
> +		if (ret) {
> +			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		/*
> +		 * CRTO should always be greater or equal to CAP.TO, but some
> +		 * devices are known to get this wrong. Use the larger of the
> +		 * two values.
> +		 */
> +		if (ctrl->ctrl_config & NVME_CC_CRIME)
> +			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
> +		else
> +			timeout = max(timeout, NVME_CRTO_CRWMT(crto));

Should we at least log a harmless one-liner warning if the new timeouts
are too small?
