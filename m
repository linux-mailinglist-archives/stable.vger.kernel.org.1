Return-Path: <stable+bounces-202842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D16FDCC7FCD
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1A6B302B750
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16037D550;
	Wed, 17 Dec 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2H9++2cG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166736C0B1;
	Wed, 17 Dec 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979587; cv=none; b=jSi+v36W+sZCH2QCKvigLnGDr0q5vfJR76HuRofVbtlAxzcJ+rkJ0+QeAwckds+XCRlzKrqsQRejzalS2JPagJ4Na6ZOpDPyET4LVeaB5nI5BeZubHADq55mtgzpm3twsqIRvHHRkDZZb0JlwvgCU9prNYNj//FMbS9Cs9yY+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979587; c=relaxed/simple;
	bh=ZHAB+uND+LmBmXwrnBEwu6F1EI8DH36ey+sYzyQr+8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAYpNMgYtfi9tyQHgD3+5vc1fnJu7F0pYATSfhINRY8TZjCQSvNLiIJ9/r4dzV29aWFhmw7U8gYI3/WVGfinURyPwuonpAI2tqMQ8FMwCnPdrO5NT7BW/z3JHLVsmI4PGhH7V0RCK69hRXhaMYqv56OZUbvi0hwV4AP6zBW0QdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2H9++2cG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27232C113D0;
	Wed, 17 Dec 2025 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765979583;
	bh=ZHAB+uND+LmBmXwrnBEwu6F1EI8DH36ey+sYzyQr+8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2H9++2cG2Vj8EmFk1Jf92QLlJXq8IEobMsH1w0MRqxUPPMZxW3TXM/TWkRNJKNECI
	 RryABSa1H1f93hAH9zHRb3gK1zDYCMNf07AuQM4/jof+zvpUG5gwGh+PQqV2xEv2/A
	 MJtWju/C4kB3XrMUxFbf2NvTi0Bsdizjm+hPus1M=
Date: Wed, 17 Dec 2025 14:53:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] usb: typec: ucsi: Get connector status after enable
 notifications
Message-ID: <2025121743-arise-epilepsy-a4b0@gregkh>
References: <20251205-ucsi-v6-1-e2ad16550242@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205-ucsi-v6-1-e2ad16550242@chromium.org>

On Fri, Dec 05, 2025 at 03:07:46PM +0800, Hsin-Te Yuan wrote:
> Originally, the notification for connector change will be enabled after
> the first read of the connector status. Therefore, if the event happens
> during this window, it will be missing and make the status unsynced.
> 
> Get the connector status only after enabling the notification for
> connector change to ensure the status is synced.
> 
> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
> Cc: stable@vger.kernel.org # v4.13+
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Changes in v6:
> - Free the locks in error path.
> - Link to v5: https://lore.kernel.org/r/20251205-ucsi-v5-1-488eb89bc9b8@chromium.org

This does not apply to 6.19-rc1 at all, please rebase and resend.

thanks,

greg k-h

