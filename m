Return-Path: <stable+bounces-60803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC2193A4FC
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 19:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8EA1C21CB3
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A84E158207;
	Tue, 23 Jul 2024 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xdOO8/UA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398F156F36;
	Tue, 23 Jul 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756004; cv=none; b=TbLNbLeceHn0UhcF7JWC2Juwp9JiIwiMYCYAr8kJGCdqM1T9u3nOTYTXZEazsI67dcSDozubIhE4WmDy1wW+Ku2MT1uG1auPMl9gUPbxstJI/ynjW54LWi2HFHpsC9RqhnNM/TGmU8xpFx8s/pXxivHg6GBNk23gzavWXpPRNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756004; c=relaxed/simple;
	bh=VJo3rBx5SbqiAp8AHWFBZitfGYaW0B4USiP11Vyc8eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4hqTEN6oe+Go1MZSLORl6I7sjKO0kNrWaLhU6KSoVo5JaqaXaEXHfsIPvmsTG6pGAfd4eKwDLyBjKSd+UbRk1EXkGYBrfGYc5nNJQO4enAUIbJbt5G2f71VNyl/zKNGDahhxIDHbG1tJepObcHRT8wEDysK8Km+QehscfTKqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xdOO8/UA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F88C4AF09;
	Tue, 23 Jul 2024 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721756003;
	bh=VJo3rBx5SbqiAp8AHWFBZitfGYaW0B4USiP11Vyc8eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xdOO8/UA/cbZD7MNX642R3uZesNqUUXkTB0Q9NN8nRDdi/4uk+jTt5O3UWR9eaufF
	 XNlq9vpH9G+w2WSpm7acbpeNrXpYa2iFXkzAg30yShkJqtKHRFYHlaTvz8uEqRLVOd
	 9OfHF9Q9yVNQKvx2x1t/I+c/ITDLfWlPYlmdQuTg=
Date: Tue, 23 Jul 2024 19:33:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: heikki.krogerus@linux.intel.com, utkarsh.h.patel@intel.com,
	abhishekpandit@chromium.org, andriy.shevchenko@linux.intel.com,
	kyletso@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: Fix NULL pointer dereference in
 ucsi_displayport_vdm()
Message-ID: <2024072350-talisman-elongated-0e3d@gregkh>
References: <20240723141344.1331641-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723141344.1331641-1-make24@iscas.ac.cn>

On Tue, Jul 23, 2024 at 10:13:44PM +0800, Ma Ke wrote:
> When dp->con->partner is an error, a NULL pointer dereference may occur.
> Add a check for dp->con->partner to avoid dereferencing a NULL pointer.
> 
> Cc: stable@vger.kernel.org
> Fixes: 372adf075a43 ("usb: typec: ucsi: Determine common SVDM Version")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

How was this found?  How was it tested?  Given that the first version
didn't even build, it seems like this was never tested at all...

thanks,

greg k-h

