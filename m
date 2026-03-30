Return-Path: <stable+bounces-231005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG60FNENymmL4gUAu9opvQ
	(envelope-from <stable+bounces-231005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:44:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB232355ACE
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C3CF3003996
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4140DFB4;
	Mon, 30 Mar 2026 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BLRHBseS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084878F3E
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774849487; cv=none; b=Ey8BsuHyaBshIW1hJxkm8vYj39Oj7jJdP2HPz/Ly53pHwSrSqar/WUpFYdVpl/FDbNwbXo8GjqB6cIz4Y7Y0KsCe9erx+5yXqmjtIiPp5pAccP90mxIws44n1GvhwbzmgsKRmJDkJEKNHB02XVkdn1oB1jC5mIxVaAT00QO2nzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774849487; c=relaxed/simple;
	bh=RRP5lHa8SycofvQEYmmVKXX6Q6Hn58STSjh9L9/I0Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL2thoR3kle1LvXRPgN3eeWE2dvIpgt87Porz6ov1RYrlCPlp0vyrVk8DvlnZcK2WngSqTAAoxtmpAl61DHV89Zs044xvEybSU3VqM6Uhpr35xxM6ye5QfDCgjzCMAmyxoifLoYxmbGDPwRQ4Alh+siw+HnpQ4oPeX5ocoaGfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BLRHBseS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369FEC4CEF7;
	Mon, 30 Mar 2026 05:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774849486;
	bh=RRP5lHa8SycofvQEYmmVKXX6Q6Hn58STSjh9L9/I0Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLRHBseSOsRtoZuh2ASphpxZBlyojJHRy75x6kq0Sl+QNC8ZEYcYXwrLqGB5Pb6dr
	 GRahT+Unv/kqrD35X/xK+UBz8mNGmyngrT0d7gOdpJF6S+hOy9QCzGRneNtZf9+9/t
	 UxfTWwQ9pGQXS34UNNWuKtoOnh5xTFO9VDcTnj2k=
Date: Mon, 30 Mar 2026 07:44:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: stable@vger.kernel.org, tuan.zhang@amlogic.com, jianxin.pan@amlogic.com
Subject: Re: erofs: add GFP_NOIO in the bio completion if needed
Message-ID: <2026033056-uncapped-molar-9052@gregkh>
References: <ac74cd6d-c695-4a47-b551-6ac65bccb57a@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac74cd6d-c695-4a47-b551-6ac65bccb57a@amlogic.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231005-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EB232355ACE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:08:32AM +0800, Jiucheng Xu wrote:
> Dear 5.15.y and 6.12.y maintainers,
> 
> An erofs patch should be backported from upstream mainline to the stable
> 5.15.y and 6.12.y branch. The patch's information is shown as below:
> 
> [Subject]
> erofs: add GFP_NOIO in the bio completion if needed
> 
> [Upstream commit ID]
> c23df30915f83e7257c8625b690a1cece94142a0
> 
> [Kernel version]
> 5.15.y
> 6.12.y

Why not earlier versions, and also the versions in between those
releases?  I've done so now :)

thanks,

greg k-h

