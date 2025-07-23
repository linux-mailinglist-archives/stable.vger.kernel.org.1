Return-Path: <stable+bounces-164436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6FCB0F437
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DC0169406
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6602B2E7BC4;
	Wed, 23 Jul 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xCw5ycBA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF0E2E762A
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277892; cv=none; b=lCn/WKEFGF14XXk7ZTB4e1sXzthJqRKRHmcER7c7YgSG4HbeBOYDDyIhFwk+BzYiXjH+GOBFBO+H9TFDCEc028WMNBroLCHyU0rsjcqwp6OJc2Uwh1lR+xpKAm1+GYJJ1R9D+uheCTXD6ZIyHm3exu6q+D9GMUXxgYPbKEBEFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277892; c=relaxed/simple;
	bh=pjrEu/ZYnLRzeKLNkYuVmzbdoItD0h6Ztyl55j9UJ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQJh7t8VFVlnxTCwEfkO9lhyRJIfbQP4d6bBTh1GIYkvjB3hTk+hF/Wl6ro2yDTyFMSCalx+NCf+/cE3NZFpyY95CTHnURszwrFwlAtjkeUie8j4WOM+F2eqBafxTdqkyLh3LKrnLiWbnx66xejcYknPQFn3E3bq5FbCvJnfcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xCw5ycBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E005C4CEE7;
	Wed, 23 Jul 2025 13:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753277891;
	bh=pjrEu/ZYnLRzeKLNkYuVmzbdoItD0h6Ztyl55j9UJ88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xCw5ycBAwUcSaJdYIWrBLul+jQrB7dwkGTn2u5FjIRpwVuwhXNLMC4x5c0z+JNam8
	 i/uV1iyhSUR0o/r9E+RRUx3biiUHk2biae0Vb7GQlaZgtMle4zOhr97Q6nwZXzTmu4
	 pgwMlVjU8DTkD7sFKA/vSawi/TNplZYWQK53hbb4=
Date: Wed, 23 Jul 2025 15:38:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nicusor Huhulea <nicusor.huhulea@siemens.com>
Cc: cip-dev@lists.cip-project.org, Imre Deak <imre.deak@intel.com>,
	stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 6.1.y-cip 2/5] [PARTIAL BACKPORT]drm: Add an HPD poll
 helper to reschedule the poll work
Message-ID: <2025072342-handpick-geriatric-ce9a@gregkh>
References: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
 <20250723125427.59324-3-nicusor.huhulea@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723125427.59324-3-nicusor.huhulea@siemens.com>

On Wed, Jul 23, 2025 at 03:54:24PM +0300, Nicusor Huhulea wrote:
> From: Imre Deak <imre.deak@intel.com>
> 
> Add a helper to reschedule drm_mode_config::output_poll_work after
> polling has been enabled for a connector (and needing a reschedule,
> since previously polling was disabled for all connectors and hence
> output_poll_work was not running).
> 
> This is needed by the next patch fixing HPD polling on i915.
> 
> CC: stable@vger.kernel.org # 6.4+
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20230822113015.41224-1-imre.deak@intel.com
> (cherry picked from commit fe2352fd64029918174de4b460dfe6df0c6911cd)
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Partial-Backport-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>

What does "Partial-Backport-by:" mean?  I don't see that in the
documentation files as a valid tag to put in kernel commits :(

confused,

greg k-h

