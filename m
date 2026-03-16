Return-Path: <stable+bounces-225545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM0RGR8OuGkWYQEAu9opvQ
	(envelope-from <stable+bounces-225545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:05:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF7929AF86
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1ECC300879A
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE37239B49E;
	Mon, 16 Mar 2026 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P6/9M3Ll"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233834F275
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669863; cv=none; b=cIC3bCrR2A4Ly3UGZV0+B9/AmyCuj8QfZcXKLfPNUviuU8vI3nWmrBZA3fwdD8682vXjd05kcLICezdskSPmWrr2vVNxocVCZToLsJz6CM7qFn8iJp/DyoJr+Axdi5rTOgWXVYtR55p8uIV50VS2UlpilUl6D2tjnU4DmnszHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669863; c=relaxed/simple;
	bh=KvUASMu7CidRO1RJlSxq5DHtwfSW4qW352+DTUQi5gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OywSu6fDE25UqWpAkaq5mVYCXzm4hpkTQQeP0mYVDofrm3O4BBdFXIZKUZ2pv01QyzSqZ/sXq5VZ0t38Mm+1osx+WUTbC0r+F+9n9RfO191Y/E9w3SFXVyf6o8UikOJ8updSuqTRlgK8Cj//wIoeMMrCavygQPT+ejfcTWLZZEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P6/9M3Ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194A9C19421;
	Mon, 16 Mar 2026 14:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773669863;
	bh=KvUASMu7CidRO1RJlSxq5DHtwfSW4qW352+DTUQi5gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6/9M3Lltxp9HQXlRTUzORBzV2yHflNOGrtXj6ehtVTHuIeokomyqHwSs0MXD85SZ
	 bDpGPQNNdJe7T9z6VByK3kovOUIstCUa3nr4TS6YCb9Ynonkojnt5xHjMZxE/pR2EQ
	 oD0WFRin9YhlyvYKEr5XwX4IF7APA7DqgYEG9Y/0=
Date: Mon, 16 Mar 2026 15:04:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Simon Liebold <simonlie@amazon.de>
Cc: stable@vger.kernel.org
Subject: Re: 6.18.y: Please backport commit 31b153315b87
Message-ID: <2026031601-uncorrupt-saucy-36b4@gregkh>
References: <h6dsx7brbucyy.fsf@dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h6dsx7brbucyy.fsf@dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com>
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
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-225545-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: EDF7929AF86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 01:21:25PM +0000, Simon Liebold wrote:
> Hi,
> 
> could you please backport the following commit to 6.18.y stable:
> 
> 31b153315b87 ("drm/amdgpu: ensure no_hw_access is visible before MMIO")
> 
> It is a follow-up fix for commit cd7ff7fd3e4b ("drm/amd/pm: Disable MMIO
> access during SMU Mode 1 reset") which was backported to v6.18.10.
> 
> It's a clean cherry-pick.

Also queued up to 6.19.y, as you do not want a regression there.

thanks,

greg k-h

