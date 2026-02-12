Return-Path: <stable+bounces-215956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCecOePNjWn87AAAu9opvQ
	(envelope-from <stable+bounces-215956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:56:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966712DA19
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 879BF3048889
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9026D356A0D;
	Thu, 12 Feb 2026 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mKqoZNU+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768B296BD2
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900751; cv=none; b=cf9eywZQaMhQ5asa4zhOWIBJwf64jnho42VB8lgQ0IX5xIedYm2JWs+oBi+wtcCOjo51HLj7x7T4n3nmNycuNvf8xyjWBhrOuYLgNvznrn6Q+8oq0uI/pIhtoKYVy0YcJMY1a55LgSjCfF+Zdk7Rj/DWSJS0hWgSH0sYJhB+5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900751; c=relaxed/simple;
	bh=kAK5Pe1R55mQWBTm0vefHxh9FAlrEg6zu6pOoLeFq8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQZkwfMbrFRql3NIkzt68sdBzjyvtkK/pb53NxIntBbGoak9I6dnr94wzuz7OMX+WgrMvmgll9PPxqjoz2vfjKb0RFq5GedP/4YiLPyms5a+t1aq0dNadbvHysDpncChhah7iakzNDoOomEbeO1afmUmvMSNt32debfIWCaMtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mKqoZNU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B878C4CEF7;
	Thu, 12 Feb 2026 12:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770900750;
	bh=kAK5Pe1R55mQWBTm0vefHxh9FAlrEg6zu6pOoLeFq8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKqoZNU+P9CS4cCFguoLrCM8CB5ZsHdU+1Ms8YCg6Rx1Z2MpboIBemHF1gNuy4NZU
	 CP7pVKK01J2kAVYlksW+2fDKbnFsPiH0NN/W2+modqtUmzPlndigJ8alXDTnMSw0VG
	 JcX9G6IfXbomMOeZBMbAaRdDGA+ufTtjHvmZhziM=
Date: Thu, 12 Feb 2026 13:52:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>
Subject: Re: 6.18-stable inclusion request
Message-ID: <2026021222-bunkhouse-surfacing-ae48@gregkh>
References: <7923dc60-dbf5-44aa-9aab-1c474cea0039@kernel.dk>
 <faa3e25a-ab8e-4589-aa4f-6f58bd93a636@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa3e25a-ab8e-4589-aa4f-6f58bd93a636@kernel.dk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-215956-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9966712DA19
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 05:21:35AM -0700, Jens Axboe wrote:
> On 2/11/26 4:49 AM, Jens Axboe wrote:
> > Hi Greg/stable,
> > 
> > Can you add these two patches to the 6.18-stable queue? You can also
> > just cherry pick these in order:
> > 
> > 38aa434ab9335ce2d178b7538cdf01d60b2014c3
> > 91214661489467f8452d34edbf257488d85176e4
> > 
> > It's in the nice-to-have category just to be consistent with the
> > older/current stable release.
> 
> Oh and since 6.19 is out as well, 6.19-stable queue as well, please.

Now done, thanks!

greg k-h

