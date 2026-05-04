Return-Path: <stable+bounces-243007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F0iFj2N+GkVwgIAu9opvQ
	(envelope-from <stable+bounces-243007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:12:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBF14BCC56
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C52B33016290
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DCF3CEB8D;
	Mon,  4 May 2026 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jZF95QcW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9905C212FAD
	for <stable@vger.kernel.org>; Mon,  4 May 2026 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896762; cv=none; b=SidM7EVyWtsTYy5Zk6HrTHZI1Vq3kzgrR9IEn9iz+UzJtwZJ1xd+Hgxpne9WfljBuSd2P1YbZADvxpelkoAxh8BprzZaBukhr5aE22Aq+rLV+uwt7g689avvlIHs7XfGh/FK52A+kqPJghISzm1CdVc+RozTKhm1Mp28z5KGstQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896762; c=relaxed/simple;
	bh=VqaVeOHzRy0JPP1gUNaGaX6szLAgHENMvLEgSoAO6b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8NtiFtZ+2HdP2dW8sHUs2auwKwRQD1FsfWXdNDv6tLm3gqsb22eKnEKdo/2EHTyPxJT9VJvsPDZrbwmZZQ0L/BCwcgZvbwTdM1Jt+MbiZj9w4MDoZwx1fwU6hNz/or3UUEkQd5lbyFlZ277evnJQ1aGhbam5Gwz9lBduVH9upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jZF95QcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1CBC2BCB8;
	Mon,  4 May 2026 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777896762;
	bh=VqaVeOHzRy0JPP1gUNaGaX6szLAgHENMvLEgSoAO6b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZF95QcWN98PCowr1j4eBJDhde6mJy2RiSZswfEtcUT7SP/QOxN1kOlmuFB1p6Vl0
	 xFp/w7HzH7c02jp2Tx3zJE6JxqUcFM6LiFnNfAax+GcBMMFD6zUpqRGcbQ6DMZHp5o
	 ladA7gJrkZ4FTCahGufDCAoubCwcaH7cEDd9TclI=
Date: Mon, 4 May 2026 14:12:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: Apply "crypto: authencesn - reject short ahash digests during
 instance creation"
Message-ID: <2026050428-service-doctrine-e340@gregkh>
References: <20260503174152.GA1036833@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503174152.GA1036833@google.com>
X-Rspamd-Queue-Id: BBBF14BCC56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-243007-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]

On Sun, May 03, 2026 at 05:41:52PM +0000, Eric Biggers wrote:
> Please cherry-pick 5db6ef9847717 ("crypto: authencesn - reject short
> ahash digests during instance creation") to all stable and LTS kernels.
> 
> This one does have 'Cc: stable@kernel.org' already.  But I thought I'd
> call it out specifically, given that it's in the same problematic file.

Now queued up, thanks.  Our backlog is huge...

greg k-h

