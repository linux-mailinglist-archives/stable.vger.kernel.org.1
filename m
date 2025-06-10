Return-Path: <stable+bounces-152250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7666DAD2BAF
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 04:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1B11700C8
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 02:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626C19E82A;
	Tue, 10 Jun 2025 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z379nVpM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7CB29A0;
	Tue, 10 Jun 2025 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749520950; cv=none; b=Oo7zPzUBHBVzhqcLUHlbI7ITF/Mzp3qMZ9quUukI6BR3XYAg2ON6eO6Wqi0hzj6G/XHu7r3+XZFFbYHJmk9s55B+4wFMfnGQLw1eA8C6m0BuUghhbqKQa5mMlwpe2MNeOIff0/1IPEIl/Se5P7852mgux0FDqn6SYeHgapcmDIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749520950; c=relaxed/simple;
	bh=ttDJDhDpFtCMC0+vuZRTUO90BrueMuUcXX2mP6poPGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLXXdBE8H0w1lXFbAPRWTnnhjAWqhxDBwLQhhmwKdmab6L4rvxXKcCIOQL9k5fo+bCieaPsIWghsjTAvTSB4RdSXiM/LbnHspfN7AndbJ9qcolFXTV7FU/Q+SdrkFoyJ6BHCRxBTmDZrjbNGr/Pp4pFNo29sydI4qWTKDxehY3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z379nVpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC49AC4CEEB;
	Tue, 10 Jun 2025 02:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749520950;
	bh=ttDJDhDpFtCMC0+vuZRTUO90BrueMuUcXX2mP6poPGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z379nVpMBO8Y5FQsPdUEPYOAAWPUiJTIxY5Ee2F8SawSdOzBZhzOvuk+1MJzqNaU5
	 E6TLgmRBCssxuVkoGvRE2eF9encC2DnVZ2WMZQTLlWBuzRWC4kBqsN3wBGwBsFmO46
	 FaEw4xHNgorgu+GbpNUorxbnfmDFYppQ0ST299sX/dnTz0c50W7wgbwUtO/9URewwl
	 TN5H5puLg18W24XrW9ZmnHw18sro57ND6Go3xq83gyz8koGeL4AJQTPg6edfBF+FGN
	 vuxd4Z1uwwuFq95PWpn9UG6jeXgq1Gla6GwOow94aUwf32gbCtWml/jPOGad2u/LuX
	 uWXV9SURDxb1g==
Date: Tue, 10 Jun 2025 02:02:26 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Tom Vincent <linux@tlvince.com>
Subject: Re: [PATCH v2] mfd: cros_ec: Separate charge-control probing from
 USB-PD
Message-ID: <aEeSMgomf0FP-NX2@google.com>
References: <20250609-cros-ec-mfd-chctl-probe-v2-1-33b236a7b7bc@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-cros-ec-mfd-chctl-probe-v2-1-33b236a7b7bc@weissschuh.net>

On Mon, Jun 09, 2025 at 11:39:35AM +0200, Thomas Weiﬂschuh wrote:
> The charge-control subsystem in the ChromeOS EC is not strictly tied to
> its USB-PD subsystem.
> Since commit 7613bc0d116a ("mfd: cros_ec: Don't load charger with UCSI")
> the presence of EC_FEATURE_UCSI_PPM would inhibit the probing of the
> charge-control driver.
> Furthermore recent versions of the EC firmware in Framework laptops
> hard-disable EC_FEATURE_USB_PD to avoid probing cros-usbpd-charger,
> which then also breaks cros-charge-control.
> 
> Instead use the dedicated EC_FEATURE_CHARGER.
> 
> Link: https://github.com/FrameworkComputer/EmbeddedController/commit/1d7bcf1d50137c8c01969eb65880bc83e424597e
> Fixes: 555b5fcdb844 ("mfd: cros_ec: Register charge control subdevice")
> Cc: stable@vger.kernel.org
> Tested-by: Tom Vincent <linux@tlvince.com>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

