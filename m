Return-Path: <stable+bounces-223594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EwXALuirmk9HAIAu9opvQ
	(envelope-from <stable+bounces-223594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:36:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A92237347
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE0773025106
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4D539185E;
	Mon,  9 Mar 2026 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RkLMQ2DX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5501E1C02;
	Mon,  9 Mar 2026 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052451; cv=none; b=I1VZJjVS96w4bmiuNp1gl9JbqeuIfIHie731jL0KiKncCs73X/RqAP/2xCTpP9SH5W4EYQ3poX72C3a1NkO1M69o7afakhpOoeGPrraqiPRIZFKFYhX+Yg8ORwhfltu7AwjI1kAwrGqVZPJaatYjddhHRTx7ae+fdX99zSBng3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052451; c=relaxed/simple;
	bh=TNlUigElmImpUSq5TN7YcHXgKOKuN7SKd3UBymVVzOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSIWwoVnT3Uxd4gP4ddsiSqZ3881v8Sqo7/fJo95KEqrZyn1dCcc72fwdHdZn76AWiKB3GBHzL87DNOkPVjzGtfNlU6ZYmBfKNdpmSENI/DmwOTGsOlVnoO0LdckZ+KxYXNDcf5VFPTpj82Dc2PV4Iesigfyi4FSTofb6lPXHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RkLMQ2DX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3C3C4CEF7;
	Mon,  9 Mar 2026 10:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773052451;
	bh=TNlUigElmImpUSq5TN7YcHXgKOKuN7SKd3UBymVVzOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkLMQ2DXMC8QGFNcLsrBEA4W+O+mQpceVrIpl1v2+ddg27eJBei7AV5Mua4krWgMR
	 5sW1JVeEj/rIqpVavK2pKHqhTLEbOswhbren+KptKlcWxq2Z5ttWnX456gyBn0OjcR
	 UHxm4U0REqnSmFU23IhRDUBZb29y7jLgunJx1gbA=
Date: Mon, 9 Mar 2026 11:34:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: stable@kernel.org, Sasha Levin <sashal@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Vlad Poenaru <thevlad@meta.com>,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH stable] ipmi: Fix use-after-free and list corruption on
 sender error
Message-ID: <2026030953-imaging-resize-ce85@gregkh>
References: <20260309-ipmi_stable-v1-1-be09c9686671@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-ipmi_stable-v1-1-be09c9686671@debian.org>
X-Rspamd-Queue-Id: 51A92237347
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223594-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.330];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,minyard.net:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 03:16:13AM -0700, Breno Leitao wrote:
> From: Corey Minyard <corey@minyard.net>
> 
> [ Upstream commit f9323a44994c2ccd5e0d582bac6f2b2a662e5603 ]

This is not a valid git id in Linus's tree :(

