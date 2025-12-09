Return-Path: <stable+bounces-200471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED55CB093B
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 17:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D6C30E67D6
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DF8322B8C;
	Tue,  9 Dec 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlkyMtcF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24819CD06;
	Tue,  9 Dec 2025 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765297906; cv=none; b=DREdM4eOjJOY7aDvu36Jb9SjJmkTBDI8/H+YxU3p//1YFxSG5uYyumGiHAF3QSMboZWXnMJIycYdBJOMIWUPxBecH8scrVIA5E9QkJcHbje3KucNf9KQBqSvCkyTJABCEku4NEp2Zg3xIQ741yo7KZT1xNEb5p+30kaKmud3b3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765297906; c=relaxed/simple;
	bh=ljcYWKrFHBqaRjQK0bAeo8F9ZsC9pQ6T8szwyE8lz1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArQgnUqeBWvawuTfOU63eYZFIydyKAAelg+89i6CSQoFu/EXwNB8xfuQptHl3dE8s76x7Q8CKBWOGmJjwdDoQeTKHHntBgiisAvaAdoumLjizE2VMIMIp4jfXqjC4fkK/voqpF1tEt1HbbUHQ2MB0fIAUtTMnmUwF7TMA240+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlkyMtcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E212EC4CEF5;
	Tue,  9 Dec 2025 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765297906;
	bh=ljcYWKrFHBqaRjQK0bAeo8F9ZsC9pQ6T8szwyE8lz1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlkyMtcFiCHP5RONLdHkAYZLatDHDpjHDNg5YMcYcpsMn9WPxjkHYiiy4mAb21N/z
	 ytxcK+osbf464k3wXrLfrkw8Ylje3myx4lWfTbRXXR+kVdcQerzogkmW7Fy3uDFC6/
	 4H+xsuDSdaXyzvO9IWVS42Qfl47sbHDJHPgEodh+ZR9coqI7ZQoaJPls5auD01V8x/
	 BF43hjLrjsd+y8fOSQDlD8TP2EkwbzyZOSj0RgI6ExC7vsnN9juIgRRXAOmXn+JMnF
	 Wd7R6qOPPLoDouilhZpUYLiLG8/jhspctn4LRb7BtanFchutjBvr19lMuSHCUMcVN1
	 PbKs+mzUSIMLg==
Date: Tue, 9 Dec 2025 16:31:42 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Thalmeier <michael.thalmeier@hale.at>
Cc: Deepak Sharma <deepak.sharma.472935@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: nfc: nci: Fix parameter validation for packet data
Message-ID: <aThO7rm4MqONBurh@horms.kernel.org>
References: <20251209132103.3736761-1-michael.thalmeier@hale.at>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209132103.3736761-1-michael.thalmeier@hale.at>

On Tue, Dec 09, 2025 at 02:21:03PM +0100, Michael Thalmeier wrote:
> Since commit 8fcc7315a10a ("net: nfc: nci: Add parameter validation for
> packet data") communication with nci nfc chips is not working any more.
> 
> The mentioned commit tries to fix access of uninitialized data, but
> failed to understand that in some cases the data packet is of variable
> length and can therefore not be compared to the maximum packet length
> given by the sizeof(struct).
> 
> For these cases it is only possible to check for minimum packet length.
> 
> Fixes: 8fcc7315a10a ("net: nfc: nci: Add parameter validation for packet data")

Hi Michael,

I don't see that hash in net. Perhaps it should be:

Fixes: 9c328f54741b ("net: nfc: nci: Add parameter validation for packet data")

> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>

...

