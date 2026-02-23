Return-Path: <stable+bounces-217806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ngkPKpeRnGnvJQQAu9opvQ
	(envelope-from <stable+bounces-217806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:42:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5051D17AFEF
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF855312AA00
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A893D331223;
	Mon, 23 Feb 2026 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxu/8cLi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C5332EB4;
	Mon, 23 Feb 2026 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868350; cv=none; b=U2kvYgQ0Uh1scgjXDqz72IBzsAvfnJkAHXEKyVgHTKxXAkrjX99+KkhzjFYKMtisVQyRnlPBzq+0M/mLJObAzp9naypwoN7SyDxBEzypuoQrYwZSZIbHVAGwlh9yraI/z+mRM7C2b+cSwAV2Lt4B/QZWha+tQ0mnsQr3tIYumPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868350; c=relaxed/simple;
	bh=qW9i6zN1CY6w+IeHjsOXHWptGUB6blB9XwWVVi+sh1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXPE7UELajyeIkkSCMMSa5U45zmH4OUnn80XUCgH+Q8WanTx104rCbLQKmYo0EpaE7PY4XdFuyeYjjEB1qfuS0f/mUBOxLSiOtV/m4AECsehelmmlaVezRB647IlMYpzHdlspAJR58kdogi23q6Y6qsppBFegrXmQPL+OjpE/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxu/8cLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C1EC116C6;
	Mon, 23 Feb 2026 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771868349;
	bh=qW9i6zN1CY6w+IeHjsOXHWptGUB6blB9XwWVVi+sh1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wxu/8cLigHMnzGFEcQNnYenuwJd9vXt+eU8fmhzNlvcNnWrR33idDVrz8YJ8qZ8gt
	 sit1aDhavzpGKZqmNzq7HrFUWgnp//z5HMvlNmHq8AAmtREXxi/elr3TceAnwnrcFF
	 /VevfSQhsH97GE1xcZsAEsNDV3hU/XGigy72iojdrO6PZE0hz2XRYC6EPcqziISq0b
	 WoNh1FD+F1e4PMqDpcJH25ffCZfGGLuIdULPOL5bv9eKCVJYY1onKNieis/qq02d7O
	 EirCDVRx0nMQ95In+KE2frbAoqPyNyw1fg3rxYnsgH+xItEIIHvriReHMjGt7chd2S
	 DsV6MQiziaDmA==
Date: Mon, 23 Feb 2026 17:39:03 +0000
From: Simon Horman <horms@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	rogerq@kernel.org, mwalle@kernel.org, nm@ti.com, v-singh1@ti.com,
	vadim.fedorenko@linux.dev, matthias.schiffer@ew.tq-group.com,
	vigneshr@ti.com, m-malladi@ti.com, jacob.e.keller@intel.com,
	stable@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH net 0/3] Fix Unbalanced IRQ Enable for CPSW and ICSSG
Message-ID: <aZyQt_K7z6OdjP-K@horms.kernel.org>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220041431.372610-1-s-vadapalli@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217806-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 5051D17AFEF
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 09:41:56AM +0530, Siddharth Vadapalli wrote:
> Hello,
> 
> This series fixes the warning:
>     Unbalanced enable for IRQ ...
> for the CPSW and ICSSG drivers.
> 
> Under heavy traffic and in an SMP environment the warning shows up after
> a relatively long time. The issue occurs due to the order in which the
> variable 'irq_disabled' is set and the function disable_irq_nosync() is
> invoked.
> 
> I have examined other drivers and they follow the right order which is
> to invoke disable_irq_nosync() before setting 'irq_disabled' (or its
> equivalent variable).
> 
> The first patch is for the CPSW driver and it has two Fixes tags since
> the code change associated with the fix is for a recent commit while
> the incorrect order was first introduced by a much older commit.
> 
> The second and third patches are for the ICSSG driver. Although they
> are both for the same driver and could be squashed, I chose to split
> them since they fix different commits and need to be backported as
> Fixes for the respective commits.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>

...


