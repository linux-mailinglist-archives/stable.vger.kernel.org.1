Return-Path: <stable+bounces-247386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFIAFxW0BmqKnAIAu9opvQ
	(envelope-from <stable+bounces-247386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:50:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC5549BDC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36A8C3050241
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD8F36BCC0;
	Fri, 15 May 2026 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LMw4h996"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891EA357A40;
	Fri, 15 May 2026 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824104; cv=none; b=VEoXm5mRAcE2efykYt0CbpXqmrX0u5aqow95lBgl8NUt+11z01un52WBWeVkxPa069h5HmfTa7XGI8VicF9tuG7Qw9A9oMxkNy9yvNbZKFKtgZvMikp8MPLoCNfAh90DiPOk/8Pku3rA9O3M9P3/Xz1WCQm2GR+nCYoB+GMLJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824104; c=relaxed/simple;
	bh=YTvt4nkMmH2mjg/l1x5d01iCRahYVbi97XiWVbeW8ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDgAN5PzABzpkTI+Y4czuQvCxGdDp7BpQ0GOo9Sx+QrSY1ZGdHjq2CJQ+oSsWFnShSoYQeP4nJux45hRo8pEoDYpry2JY0QFWGtn5YoM0c1x9+LKwWFIbiteGGnOeF66VyY096xRatZSgqL9V6GmOO/3tUiElw1/s6zAo6g+YS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LMw4h996; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236FCC2BCB0;
	Fri, 15 May 2026 05:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778824104;
	bh=YTvt4nkMmH2mjg/l1x5d01iCRahYVbi97XiWVbeW8ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMw4h996eF2r2EHTYswbma1NhxNCZ74A0gza3gPziU7wNJZf4UIGNu3dZJDZDSU1E
	 5byW1XKewmfGOSm30OAm/plm9X2xGWiZ1SWk24YPq03Yu4y9QgrzdfaDReJZiPbhYS
	 pzfbEGBNaozhGDp00ldUQ3R9JG7QnDBvDPWP5Icc=
Date: Fri, 15 May 2026 07:48:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Krishna Chomal <krishna.chomal108@gmail.com>
Cc: stable@vger.kernel.org, ilpo.jarvinen@linux.intel.com, aros@gmx.com,
	platform-driver-x86@vger.kernel.org
Subject: Re: Please backport e8c597368b85 (platform/x86: hp-wmi: Ignore
 backlight and FnLock events) to 7.0.y and LTS
Message-ID: <2026051522-calculus-halt-1506@gregkh>
References: <agaiW9AmqFwsT7pZ@archlinux>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agaiW9AmqFwsT7pZ@archlinux>
X-Rspamd-Queue-Id: E6FC5549BDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247386-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,gmx.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 10:16:40AM +0530, Krishna Chomal wrote:
> Hi all,
> 
> I would like to request a backport of commit e8c597368b85 [1] to Linux
> 7.0.y, and LTS versions.
> 
> On new HP OmniBook 7 (Panther Lake) hardware, the keyboard backlight
> and FnLock keys are handled by firmware but still trigger WMI events.
> This results in "Unknown key code" warnings spamming dmesg [2].
> 
> The mainline commit e8c597368b85 ("platform/x86: hp-wmi: Ignore backlight
> and FnLock events") silences these warnings by adding the key codes to
> the keymap with KE_IGNORE.
> 
> The patch was merged in v7.1-rc1 but missed the stable tag during
> initial submission.

Now applied, thanks.

greg k-h

