Return-Path: <stable+bounces-244299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PjXTHUen+mk/RAMAu9opvQ
	(envelope-from <stable+bounces-244299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 04:28:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF5C4D5AA4
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 04:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2471A301AD08
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 02:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662BA29AAFA;
	Wed,  6 May 2026 02:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5yeoWWv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638014B08A;
	Wed,  6 May 2026 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034498; cv=none; b=qGGbdzIYtDfp4uCKLeTZzTNGrgPImy5akHkNwk38pfY7rHAEbH4APJXnTv3KdF7u1WCdJLAuLoSjvmXTu2arD6WO3aVdVhabl4NdOpSEDCjwuYhw16ShMKOR3bBVwLBLX8R79xsPGF1OGZ//vuoE2qhz+ra1LIxV/8d/BeMkP3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034498; c=relaxed/simple;
	bh=DZ9nkG1RwN5rYhQ0DxOeLA1xUg02CRqZFiVnaR3tmZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nF9Oim0EUATv0eoFqxPVKsTou+mAm0ogLoW/Yh6Ehj0p43bfC4KXCkrU6yzUsvJSVg7WmyeuI+Jm4uCQouXgChGFqnmvLUPX6jlVJfsuD0FimA/8cF4tBjb3nJQU6LNaH9FEhZA5XgwxcmzriyeKx0gtbLgA5wqmVPFxUTyZjl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5yeoWWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D387C2BCB4;
	Wed,  6 May 2026 02:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778034497;
	bh=DZ9nkG1RwN5rYhQ0DxOeLA1xUg02CRqZFiVnaR3tmZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5yeoWWvgm2QXqprRhxmapmPQlqChtyE7ds1FBXUdAl4vCzDu/elWS2Am9sD6LWZ6
	 0wjlAQy1DuNYE5nIyCJY3ZfF1CUdSODcmnJMK5HnjYmW9vMjLeyZ3Eu/6pyTpH/Iug
	 FlY1gLXqUCOWmjSasH9Dy527UYxRi1RzIR4Up40Bsm8dMbuSlP8GUzX+9AmJpwSaZm
	 khq+crgXr1FJ7nNggNVge32oriYuLX/iKY6H+wXRFf0oiMmfAk46b0HKUl0JjVqIAc
	 /pBWvGexl6d/eStUua6bwmj0n/jDKCGM7X0UX7VNohDqxG5aMjAUosmeE3SZXJ8S0O
	 JzSXyYsR6xcXQ==
Date: Wed, 6 May 2026 02:28:14 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Init mutex in
 Thunderbolt registration
Message-ID: <afqnPhTMJkcWFRdL@google.com>
References: <20260505053403.3335740-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505053403.3335740-1-tzungbi@kernel.org>
X-Rspamd-Queue-Id: EDF5C4D5AA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244299-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzungbi@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 05:34:03AM +0000, Tzung-Bi Shih wrote:
> cros_typec_register_thunderbolt() missed initializing the `adata->lock`
> mutex.  This leads to a NULL dereference when the mutex is later
> acquired (e.g. in cros_typec_altmode_work()).
> 
> Initialize the mutex in cros_typec_register_thunderbolt() to fix the
> issue.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-7.1

[1/1] platform/chrome: cros_ec_typec: Init mutex in Thunderbolt registration
      commit: 525cb7ba6661074c1c5cc3772bccc6afab6791ef

Thanks!

