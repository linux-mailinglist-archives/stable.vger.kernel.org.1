Return-Path: <stable+bounces-213264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NikDPwKgmmCOQMAu9opvQ
	(envelope-from <stable+bounces-213264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:49:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 914E9DAC9F
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E0F130A6762
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A813ACA7A;
	Tue,  3 Feb 2026 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Urpp8iZV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3631F3ACA76
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130138; cv=none; b=ub2l8EVs+SX89YIqOF10+PZcPug0Da+nQn4wv5wu11vdA5DQE4GeHTyonxoj4X4GRuxPxU5NSB4+xfDiUnrHambuz3H851dCZqJJ2ahQwZKPNCB+bKh5MEPalFYGtc9p1noKWpWwWvXHsApz/rvZaEYjnG6ZPty5jk712xorQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130138; c=relaxed/simple;
	bh=HYOqQlVgAQ3xiFvWl/3QFlVIznHme4yIoupHUSb1/0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlKVK46gQHfpKoghd97vYsSqC+p4OR3+B05ukKEpsdLb2F5uoNPUslM8rJDnMEoF+kBm8PYKolW3mZMLVBXyc02wfs+6H4noPPS4Yy6HUMJf5EmWlrUz2Nbt/+8xpiVMqg8hoESawsyua/2QZSStHYKXttxa+06el9qe+dKjHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Urpp8iZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DFDC116D0;
	Tue,  3 Feb 2026 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770130137;
	bh=HYOqQlVgAQ3xiFvWl/3QFlVIznHme4yIoupHUSb1/0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Urpp8iZVco28HHlSlicNU1Fc80TEajPJNE2TXginbw6WUud6POfRksXPrsnIr9pC/
	 4O9pQ/ZdTTBK+kJQNKS6FMVYR38yMBW2dMF3SLxWR4uFJboZYq+K87QFVtOAXgXLMs
	 LqF4Gg4RSz4tELoEHCEpr3VV7xmIqDoyYD6uKzbY=
Date: Tue, 3 Feb 2026 15:48:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: stable <stable@vger.kernel.org>, tiwai <tiwai@suse.de>,
	sashal <sashal@kernel.org>, pavel <pavel@denx.de>
Subject: Re: [PATCH 6.6] ALSA: usb-audio: Fix missing unlock at error path of
 maxpacksize check
Message-ID: <2026020339-tidy-appealing-44f1@gregkh>
References: <tencent_09063379481F265B19AC7AC7@qq.com>
 <tencent_42D789F563D3A21850DD27DE@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_42D789F563D3A21850DD27DE@qq.com>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213264-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[denx.de:email]
X-Rspamd-Queue-Id: 914E9DAC9F
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 06:04:44PM +0800, Wentao Guan wrote:
> I found that patch which in v6.12.60 should be applied in v6.6-stable tree.
> 
> From: Takashi Iwai <tiwai@suse.de>
> 
> The recent backport of the upstream commit 05a1fc5efdd8 ("ALSA:
> usb-audio: Fix potential overflow of PCM transfer buffer") on the
> older stable kernels like 6.12.y was broken since it doesn't consider
> the mutex unlock, where the upstream code manages with guard().
> In the older code, we still need an explicit unlock.
> 
> This is a fix that corrects the error path, applied only on old stable
> trees.
> 
> Reported-by: Pavel Machek <pavel@denx.de>
> Closes: https://lore.kernel.org/aSWtH0AZH5+aeb+a@duo.ucw.cz
> Fixes: 98e9d5e33bda ("ALSA: usb-audio: Fix potential overflow of PCM transfer buffer")
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> (cherry picked from commit fdf0dc82eb60091772ecea73cbc5a8fb7562fc45)
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>  sound/usb/endpoint.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This does not apply to the 6.6.y kernel tree :(

Please fix up and resend.

thanks,

greg k-h

