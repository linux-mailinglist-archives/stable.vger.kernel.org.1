Return-Path: <stable+bounces-227671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AZDhDnE4vmlQJwMAu9opvQ
	(envelope-from <stable+bounces-227671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:19:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 069E52E391C
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 101C8303A8E9
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7711236E46E;
	Sat, 21 Mar 2026 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZzghiyVi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38615362149
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774073950; cv=none; b=ce+2eclFHqDJ2UywSpSisKmWEEjCRPrIGM6O7fKKOQFw0XZCfV1bsNkrKf60HWnoDMA4TdcL5lLfFMZuzthFaF+SrZr/huaxkAcv7wCYAb0ZQDF7Rvk/bOwJ/qdLEthrZjXwag66rmBAp9hahdSdKSdGzh9cEaW1u3Kf/qR3SqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774073950; c=relaxed/simple;
	bh=4CZwcsNBMK561lizDhxzRP2Gf/ggRNaaRoBI3K5dM0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBEP2AedU1A/TA4TQcyFukXzWAkvDSa8WMpAzRd1hWrindrPNyh0fI9HEhLMa/HWNbxwo/Dx8jX2GDpSVJCVRoK2Kc+Av04G2+0GLGGt6hBng+pRQ9d+eBdUJJ9fEUpOBRsnCtaGSq15Nhn78Ze6x8qwOja26+JB/2BleaoFMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZzghiyVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6881C2BCB3;
	Sat, 21 Mar 2026 06:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774073950;
	bh=4CZwcsNBMK561lizDhxzRP2Gf/ggRNaaRoBI3K5dM0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzghiyVik0hK0UkO9zCoYm5TJHh3Qlj9p11uQsQcsGToj27PYpTANfnxKZjgdI3HH
	 OY2PZAJUNtFCUv2A4V9XzNRpceKLlqhhOVc5b8jhi8IfQh9eAvtHz8kpcYpfZkN2Ga
	 wnI4gUgILUqoV6Wybkcgbfo0uxqgteJmM6MprxlU=
Date: Sat, 21 Mar 2026 07:11:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: code@mgjm.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: propagate BUF_MORE through
 early buffer commit" failed to apply to 6.12-stable tree
Message-ID: <2026032123-slug-anthology-f473@gregkh>
References: <2026032021-amused-playable-2e81@gregkh>
 <c6099d0e-3f0b-4b25-9366-f258445a8e99@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6099d0e-3f0b-4b25-9366-f258445a8e99@kernel.dk>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227671-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 069E52E391C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:28:58PM -0600, Jens Axboe wrote:
> On 3/20/26 11:34 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's a tested version for 6.12-stable.

Now queued up, thanks.

greg k-h

