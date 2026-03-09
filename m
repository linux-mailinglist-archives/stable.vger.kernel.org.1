Return-Path: <stable+bounces-223492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAVbMsxXrmm0CQIAu9opvQ
	(envelope-from <stable+bounces-223492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 06:17:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CE4233E0A
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 06:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA7C9300D36E
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 05:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCD92E718B;
	Mon,  9 Mar 2026 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gcxvjKcg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E412E6CCD
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773033417; cv=none; b=k4QaWxDWDvQf7KnSGc4KP1rE3TJ5a6Tz/aGvtQ3qqRmhMo699F9LWisNI7LVuV7qXxF4e6PywYgg0AIgkTwe+N251XHOCCuAKBVUjAFxXtCLSnt35+IZRPet3GydTV0knV2ODQpH6LXsTrtebO6hx0PzPVm6E9aw0EI2WXq/LbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773033417; c=relaxed/simple;
	bh=fetCZripp28zuJvvlVo7P4VQn5OYq5UPw1qXrLKpocw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4qsdK0LnXbAlySE0Qeq6C9lweO5FcghY2yUujfZwQ2TOWKAY2n2c9zbqXIcpjJxIuP0Qkt+XKcJJkOWs72S3aZqTiTxb0vhTH7BhgVB51F/5DsVluhvSLl1D6IKG2h/q7Z8gr65gYOaXnSig6PnGwANqkJYnKGjz8oyXj/nwm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gcxvjKcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E706DC4CEF7;
	Mon,  9 Mar 2026 05:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773033416;
	bh=fetCZripp28zuJvvlVo7P4VQn5OYq5UPw1qXrLKpocw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcxvjKcg0HkmUqva1f46AbSwq0vSIdHemdd0pX7yhLxkz3juoCNr8moBiUCIGUTwb
	 fzczGDcm/YoPQ5sCvXTW4xwkuQnjoqTHCzmIBpoEXyIyQuQog2ccicSJutECfdhpAZ
	 2Lx3uhDSVxo2/JlxAt8jGlequFh4K6GA71Cdph2w=
Date: Mon, 9 Mar 2026 06:16:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: GONG Ruiqi <gongruiqi1@huawei.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	"Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Subject: Re: Inquiry for linux-rolling-stable: move to 6.19.y?
Message-ID: <2026030917-series-surviving-7680@gregkh>
References: <e80b5e71-ad6b-4fbd-83a5-d6bbe4774f6b@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e80b5e71-ad6b-4fbd-83a5-d6bbe4774f6b@huawei.com>
X-Rspamd-Queue-Id: 73CE4233E0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223492-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.166];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:37:37AM +0800, GONG Ruiqi wrote:
> Hi Greg, hi Sasha,
> 
> I notice that linux-rolling-stable is still on branch linux-6.18.y,
> which has been assigned as longterm. Shall we switch the tag to
> linux-6.19.y, the current stable?

Yes, we will move it "soon", probably in another release or so.

thanks,

greg k-h

