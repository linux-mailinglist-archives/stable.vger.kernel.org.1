Return-Path: <stable+bounces-120065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617F9A4C2DC
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 15:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135BE1720BB
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 14:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32E221324C;
	Mon,  3 Mar 2025 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sFL5J3qG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EA98489;
	Mon,  3 Mar 2025 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010879; cv=none; b=Xq+lLAKBFXDRXJZw+BBnvxK/+QYD/Z1MrpUKs8wQwyaNQoEhYJ5HMXGBuBIkoYHD0XuGfOjWYhIo5U5/KL4dJv9s/9bcYScXR3fBq9Tz4yIN3xUN/QMppxtVat1hGqvFl+TRMX/tEROCywX3KcexHmrRxAyA44w7TmdC5mCPqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010879; c=relaxed/simple;
	bh=lrlCsavUJz6KOvb58RsHd0PRwT4FfA6Nqrz+IF8RGVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly8uYygHIvPuM0kKzMFwpupnylCIJbDaPPYi6KakttaA98OCrlsD85hYTQnQlsGnoNc0+YmXvKWR75reliOurew+cyuRWceeRTUxv+qzoUu/zSzexNknK2tpq3F/H64omAoFO1oyQcrhvvcwD6kw5ZCrSL2ZYHu+9ntAYv13UiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sFL5J3qG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270AFC4CED6;
	Mon,  3 Mar 2025 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741010877;
	bh=lrlCsavUJz6KOvb58RsHd0PRwT4FfA6Nqrz+IF8RGVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFL5J3qGhSOTmKTqbjuLFlDmWsIydsLfhFPeoLzlZQ48ALrzWHduW9Qd6xfDUUx1S
	 byZzLv1g18d6A+svIo0LWuCylTMJKurfmTqXFilz4mZXQKT/aH+pjlFy0F2YEQB1Yx
	 bXoa9mCcwisDGtT+MHnbRzFt8Z+KrxXeynwXofwc=
Date: Mon, 3 Mar 2025 15:07:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2] drivers: core: fix device leak in
 __fw_devlink_relax_cycles()
Message-ID: <2025030332-tumble-seduce-7650@gregkh>
References: <20250303-fix__fw_devlink_relax_cycles_missing_device_put-v2-1-3854d249d54e@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-fix__fw_devlink_relax_cycles_missing_device_put-v2-1-3854d249d54e@bootlin.com>

On Mon, Mar 03, 2025 at 10:30:51AM +0100, Luca Ceresoli wrote:
> Commit bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize
> cycle detection logic") introduced a new struct device *con_dev and a
> get_dev_from_fwnode() call to get it, but without adding a corresponding
> put_device().
> 
> Closes: https://lore.kernel.org/all/20241204124826.2e055091@booty/
> Fixes: bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize cycle detection logic")
> Cc: stable@vger.kernel.org
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Changes in v2:
> - add 'Cc: stable@vger.kernel.org'
> - use Closes: tag, not Link:
> - Link to v1: https://lore.kernel.org/r/20250212-fix__fw_devlink_relax_cycles_missing_device_put-v1-1-41818c7d7722@bootlin.com
> ---
>  drivers/base/core.c | 1 +
>  1 file changed, 1 insertion(+)

This was applied to my tree on Feb 20, right?  Or is this a new version?
Why was it resent?

thanks,

greg k-h

