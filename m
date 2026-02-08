Return-Path: <stable+bounces-214863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP7OIyuliGlRtQQAu9opvQ
	(envelope-from <stable+bounces-214863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 16:00:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB3109013
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 16:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 448FF3015724
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5917358D2C;
	Sun,  8 Feb 2026 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pKdPJ/3e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880091DE4CE;
	Sun,  8 Feb 2026 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770562849; cv=none; b=qEAkFl3IcqoCPqAR7kctCVQM7wJMdbGw2SEuTjn/QW0j43EZHXzpHFP1cHgJd4Ve58lh1pRMOuPwruT/kFSz212PNHkLr/Oyl2Gb/GhWjUqAh+nVzWvQ8lmFWe0uAe1j5uIVgOh3Aq2YwEdLBfUH4cbujW/n1rvvyQ0JhGNgI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770562849; c=relaxed/simple;
	bh=IhMPQApmWrc04vEawLhgrxYIChSC2Nc1f1e6F0lzOh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEv/jyOV9u15DnWt6wuCzi9nm4h4dQ80JgUFKXY1EXKCpTsY6Hi71btAJbTxgpPgVMA8Azb87XzqS8GpDWHQ1eW163nQCBO1AMXGEf1TYlxk14/hBwQDZgbxDQRxPoEBPNDBYgWkP4h5JGiH7gCzEMX8BeoPlQfvKzS/lbd//w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pKdPJ/3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A8AC4CEF7;
	Sun,  8 Feb 2026 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770562849;
	bh=IhMPQApmWrc04vEawLhgrxYIChSC2Nc1f1e6F0lzOh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKdPJ/3eqYZmw0uVFdBD59Ngi7+ABaDP1XKI2VVaERORIN11anlEnTtFFH6ZAsSfB
	 9YS18gYWuok/FAdVe8u/a64lGom4QUMP/xBeiJb+RvW1iBQdUt6eGdHqEpSc8mWwUY
	 PniXRmDBnH1SrOAooIrYPIOHrgEZxqMOKCliQvfs=
Date: Sun, 8 Feb 2026 16:00:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Cc: stable@vger.kernel.org, davem@davemloft.net, yoshfuji@linux-ipv6.org,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kafai@fb.com, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com,
	tapas.kundu@broadcom.com, Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: Re: [PATCH v5.10-v5.15 ] ipv6: use RCU in ip6_xmit()
Message-ID: <2026020822-stable-slogan-8452@gregkh>
References: <20260205074644.2091266-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205074644.2091266-1-keerthana.kalyanasundaram@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214863-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E9EB3109013
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 07:46:44AM +0000, Keerthana K wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 9085e56501d93af9f2d7bd16f7fcfacdde47b99c ]
> 
> Use RCU in ip6_xmit() in order to use dst_dev_rcu() to prevent
> possible UAF.
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Link: https://patch.msgid.link/20250828195823.3958522-4-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
> Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
> ---
>  net/ipv6/ip6_output.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)

We need working versions for newer kernels first.  Please resend this
when you have submitted patches for the newer releases.

thanks,

greg k-h

