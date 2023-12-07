Return-Path: <stable+bounces-4957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2411809255
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 21:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D362B1C20C76
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 20:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FF851026;
	Thu,  7 Dec 2023 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW81JGLc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703F563A8;
	Thu,  7 Dec 2023 20:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB37C433C7;
	Thu,  7 Dec 2023 20:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701981177;
	bh=Czicd5N/eXaMLjTilbeZ1WUkn0YbvQTJzzOKqY7RemA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kW81JGLc1cjb9TaxSmqDV2nxeQjeYaPVfVhNAtH2tZ81Y3GWgXgHZAY0rOWblhVYv
	 YOql0kFfBUFjj9v9eZ4MHZtx/Osz2FBORYVcLOC5JphinYn/42k064IrOAFY9vQyYY
	 eCkTadcdQephXqlSuGRJ/wp4L7QHOd7/Mnp5giuMWCyP4GIUUw5PDwcdFenWq/gxpn
	 282pHAsjgL2blUaHo6nbYDaq97UHuM6O8oP8brwLiA3qQM+d4JjPiJeqwotrtkI5Fz
	 toOtfsjaGqAt52VztbWiIENZW034Ckx3N1Sz0KNDUgo2ITm9Cs+kwIcQ0yWv+7vhWh
	 bfM0GKuCXcCeA==
Date: Thu, 7 Dec 2023 12:32:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, davem@davemloft.net,
 edumazet@google.com, greg@kroah.com, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, oneukum@suse.com,
 pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v6] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
Message-ID: <20231207123256.337753f9@kernel.org>
In-Reply-To: <d8c331dd-deb1-4f12-8e66-295bfac8b1d7@rowland.harvard.edu>
References: <0bd3204e-19f4-48de-b42e-a75640a1b1da@rowland.harvard.edu>
	<20231207175007.263907-1-jtornosm@redhat.com>
	<d8c331dd-deb1-4f12-8e66-295bfac8b1d7@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 15:23:23 -0500 Alan Stern wrote:
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

FWIW I'm expecting Greg to pick this up for usb.

