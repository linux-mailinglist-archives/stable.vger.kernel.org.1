Return-Path: <stable+bounces-8337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE8781CB5A
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 15:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA4A284282
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610C718E17;
	Fri, 22 Dec 2023 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H5NA4c9I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881E1DFC3;
	Fri, 22 Dec 2023 14:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F038EC433C8;
	Fri, 22 Dec 2023 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703255471;
	bh=UfxXwhVnnC9MwOhStHNLMQSE8zh6K26Jmnr6uqXI5OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5NA4c9IdcUrILe9LijRtez+WTkILLwQ4/XhpZAwbySkGcNWW3YQ5mNG0qnIXKa5v
	 ckYDoqNbb8kdcAiEFqj6aTNr13ek5dCYAeYFDggz3uYx/GjTD1w6+e8aTeQ0WTbZX/
	 GIgFpHWpixI62RS6rT3qiq3qzBijcLspAPRVin0E=
Date: Fri, 22 Dec 2023 15:31:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Uli v. d. Ohe" <u-v@mailbox.org>
Cc: jkosina@suse.cz, me@khvoinitsky.org, patches@lists.linux.dev,
	sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.6 097/530] HID: lenovo: Detect quirk-free fw on cptkbd
 and stop applying workaround
Message-ID: <2023122231-curly-contour-9795@gregkh>
References: <20231124172031.066468399@linuxfoundation.org>
 <2feecc09-3310-4733-a65e-50b9f5dc7325@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2feecc09-3310-4733-a65e-50b9f5dc7325@mailbox.org>

On Fri, Dec 22, 2023 at 03:15:34PM +0100, Uli v. d. Ohe wrote:
> I have one of the affected keyboards with original, unmodified firmware, so
> it should use the old "workaround" to function properly.

<snip>

You should respond to the original patch submission on the mailing list
for the input system, not much we can do here on the stable list for a
commit that is already in all of the branches, sorry.

thanks,

greg k-h

