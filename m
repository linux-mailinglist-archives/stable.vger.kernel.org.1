Return-Path: <stable+bounces-72719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD71968757
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 14:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF886B26E05
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B324819E960;
	Mon,  2 Sep 2024 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0vI5ZCxP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D2919E96B;
	Mon,  2 Sep 2024 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279293; cv=none; b=YpgD2BvvGtUMFpfDuiKtArsFZxYK/hENggNfqyfW7t6zA4L6KRnpwVtHUh9Ak2X7PfGdwWAZ8doLPpQbf+3V8FAJ0q73HU86Um+IBkZSlVGCXxZtwxxjnRZouZoGqDsH/7+QlNgaWTFidd49DfNJFhuGe8m5PXP2dXeFJUipduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279293; c=relaxed/simple;
	bh=n601jGxcwbLz5zKu9HSp5uYcLAZIHKllavn+kEnf+Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGSCnbGvsn+P4NvUl8XiFVtj/QBcWfi1oXs34Uh8hBbcjaqA2m6M4I7sD+GSIqbmRc3WfDExS2oh4nnNI/RdNL4b4uJsN/yDhv+6bVYF/56KRk0oitOcoAFFfnG922DF9QjNcP5bdKq7eEarIkqsaESAxVVVtDaiMHXEzZ62gZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0vI5ZCxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683BAC4CEC2;
	Mon,  2 Sep 2024 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725279293;
	bh=n601jGxcwbLz5zKu9HSp5uYcLAZIHKllavn+kEnf+Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0vI5ZCxPvJUx2Ek04kWkcq0ibB0vYrvouMQLskDZLCdq7+ai12ozER/Znc5bkWrwb
	 vHureAhzvx8OjG79jN+NSm5vBTJ2al9PtnK8Azgjnst9QM8Gjw7PxnRM+JBoRjZw+R
	 KGwLwz33qAxXRj3TeLgPqd6fo9BJ35sgQDp9munA=
Date: Mon, 2 Sep 2024 14:14:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: linux-usb@vger.kernel.org, peter.chen@kernel.org, sashal@kernel.org,
	stable@vger.kernel.org, hui.pu@gehealthcare.com
Subject: Re: [GIT PULL] USB chipidea patches for linux-5.15.y and linux-6.1.y
Message-ID: <2024090208-throat-sponge-79cc@gregkh>
References: <20240902092711.jwuf4kxbbmqsn7xk@hippo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902092711.jwuf4kxbbmqsn7xk@hippo>

On Mon, Sep 02, 2024 at 05:27:11PM +0800, Xu Yang wrote:
> Hi Greg,
> 
> The below two patches are needed on linux-5.15.y and linux-6.1.y, please
> help to add them to the stable tree. 
> 
> b7a62611fab7 usb: chipidea: add USB PHY event
> 87ed257acb09 usb: phy: mxs: disconnect line when USB charger is attached
> 
> They are available in the Git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git branch usb-testing

Also, wait, this wouldn't work anyway, you are asking me to pull a
random testing branch into the stable tree?

confused,

greg k-h

