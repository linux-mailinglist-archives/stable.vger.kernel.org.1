Return-Path: <stable+bounces-231008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHnMA08PymmL4gUAu9opvQ
	(envelope-from <stable+bounces-231008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:51:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAF2355B97
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 623D6303527E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490733822B7;
	Mon, 30 Mar 2026 05:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q5yoNUVM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069141C84A0;
	Mon, 30 Mar 2026 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774849777; cv=none; b=G76hCvLfzXSdJkSFAjlKL/j20HVNhh3CZgAgRatwszOFxNhhtzjvsfdU0mtOZqbFiKECCwyg01D4UNIQjskuUeijhMPLnHY3Dpv9vgRFeMNcCFNHDD9NxMyOXo+s84CIbI71Zvw3Hx7LJJk8B9/H4SIhuq9WWONqp7FaC3ywXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774849777; c=relaxed/simple;
	bh=EhAVrikuae8dBFQwRBouxw8+WcGAcl4RSohzI4XMGo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Afq2lwcpFWiYA0luKICpoLnqSSAJIVMzbwhhRquY1306rjMUDqgKuRoVnjc+4qZefKTunD6Z3mjKKgV//wBm6LVQMI+HL1DRBzgks24Ln8MPF1Svdy2l2lMNhl5bs0IP8S5JjfoTnHstPBU6nwndFEmRuR20qYbvm/mVbthjFJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q5yoNUVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2412CC4CEF7;
	Mon, 30 Mar 2026 05:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774849776;
	bh=EhAVrikuae8dBFQwRBouxw8+WcGAcl4RSohzI4XMGo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5yoNUVMwPlOMGjpq2YLyPPk+ym9v3eBuMbbgChWATbgVY7FHUKAqdWJT/+RGfVqS
	 2M3KBuzazOemUJkH7f3pbVs8cBQXTPaQcopb12YAZi0x5wj9l/Dqo7uWgH744VnMA/
	 w3SkZqK2/Nd36ekTvRO29WIUYtxIuED/g3ekFQuk=
Date: Mon, 30 Mar 2026 07:49:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Cc: marvin24@gmx.de, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] staging: nvec: validate battery response length
 before memcpy
Message-ID: <2026033007-echo-preschool-36a4@gregkh>
References: <20260329210800.597697-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260329210800.597697-1-sebasjosue84@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-231008-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmx.de,lists.launchpad.net,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 9EAF2355B97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 03:08:00PM -0600, Sebastian Josue Alba Vives wrote:
> From: Sebastián Alba Vives <sebasjosue84@gmail.com>
> 
> In nvec_power_notifier(), the response length from the embedded
> controller is used directly as the size argument to memcpy() when
> copying battery manufacturer, model, and type strings. The
> destination buffers (bat_manu, bat_model, bat_type) are fixed at
> 30 bytes, but res->length is a u8 that can be up to 255, allowing
> a heap buffer overflow.
> 
> Additionally, if res->length is less than 2, the subtraction
> res->length - 2 wraps around as an unsigned value, resulting in a
> large copy that corrupts kernel heap memory.
> 
> Introduce NVEC_BAT_STRING_SIZE to replace the hardcoded buffer
> size, store res->length - 2 in a local copy_len variable for
> clarity, and add bounds checks before each memcpy to ensure the
> copy length does not exceed the destination buffer and that
> res->length is at least 2 to prevent unsigned integer underflow.
> 
> Tested-by: Marc Dietrich <marvin24@gmx.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
> ---
> v2:
>   - Introduce NVEC_BAT_STRING_SIZE constant to replace hardcoded
>     buffer size (Marc Dietrich)
>   - Store res->length - 2 in local copy_len variable for clarity
>     (Marc Dietrich)
>   - Use NVEC_BAT_STRING_SIZE in strncmp call for consistency
>  drivers/staging/nvec/nvec_power.c | 41 +++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 13 deletions(-)

Is there a reason you are not sending these to the staging maintainer
and mailing list so that they can actually be applied?

thanks,

greg k-h

