Return-Path: <stable+bounces-245143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGuhBtKHAWpscgEAu9opvQ
	(envelope-from <stable+bounces-245143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:40:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8AD509632
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CEE13004DD0
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8DE3939B4;
	Mon, 11 May 2026 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YAHZzvkF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F739185C
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485196; cv=none; b=BcRkihQ0dm768FwdrIk6QqkuWmwvv1N3WdTZCvKqeoNfKXe86OUKTmJqmNQ1OJ9+1LH0IzKdoWT24yvRXC88SW+kOE7nNivRwB4CQbNUkiRZ3LX4aGzWdvRo+7n/9qGqxvqyXMiVOxC7OqpnKRJpGqbcF3F07AnMa0AGHXvHcjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485196; c=relaxed/simple;
	bh=kpc43gJ0ocXdaXWtVMYszzKgD7eAwxaYXhut0HhNWwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AB7qXCudeCh1JHyVSnX+49e7tolb9YNw6Ytp5NW9iqPX5bIU6ItFdHoqI1ZKStM42b/0hVfqimFLyiLCO8ugarEhudlzg/VQKlfybIONkvb6SfKORQBJ5Hqum6Hs49O5nGucf5OUY55AEQXwMEZJSQpgCmdjSAUzZ0vWMd2sDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YAHZzvkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A67AC2BCB0;
	Mon, 11 May 2026 07:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778485195;
	bh=kpc43gJ0ocXdaXWtVMYszzKgD7eAwxaYXhut0HhNWwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAHZzvkFZxY/iDZFATFrqHd/NwHDZ8eBsxQpApzBPzuUaCs4P8GwHSRDSIAyRxqXA
	 g3m0PkqZtPZnGIYZeE8GHrGmeJDzi71nvjCv3szNvRxZYjnaBP89kpV1fx4y9y1AAe
	 pVqcTxr5qVia1TAyoMMVJ3gWfrXkEwH7sc4jiH6k=
Date: Mon, 11 May 2026 09:39:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: dhowells@redhat.com, imv4bel@gmail.com, jiayuan.chen@linux.dev,
	stable@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: Re: [PATCH 1/2] rxrpc: Fix conn-level packet handling to unshare
 RESPONSE packets
Message-ID: <2026051132-equity-umbrella-a786@gregkh>
References: <2026051119-family-spiritual-5b2c@gregkh>
 <20260511073351.55658-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511073351.55658-1-guanwentao@uniontech.com>
X-Rspamd-Queue-Id: AF8AD509632
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245143-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 03:33:51PM +0800, Wentao Guan wrote:
> Sorry, it is for 6.12.

What is?

> But miss fixes in https://lore.kernel.org/stable/20260508083142.1752208-1-guanwentao@uniontech.com/,
> will cause build failed with no rxrpc_skb_put_response_copy,
> which introduced in 1f2740150f904bfa60e4bad74d65add3ccb5e7f8.

I am sorry, but I do not understand what you are asking for here.

confused,

greg k-h

