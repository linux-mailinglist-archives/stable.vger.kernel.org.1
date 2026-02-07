Return-Path: <stable+bounces-214811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKQ3HvR0h2lNYQQAu9opvQ
	(envelope-from <stable+bounces-214811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 18:23:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD96106AD3
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 18:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B6753015A5F
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D767B337BB3;
	Sat,  7 Feb 2026 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7jL2/rT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32C299AAB;
	Sat,  7 Feb 2026 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770484972; cv=none; b=C3grF1sbDxBMY5yJX9b+oRaEc8pc3kb5WDtBNrbGG0el1K8J7X3v2LTLx5wSyoN4jXuDYAWSvDZKnA0kDqx+FIF6cTvsS1XF5Ri7sKrZEi6E50G4zlrgolLkkWD2B+eJFxHBSpAgz7AY9tKBsl7gCAIVwpY9Fo9Ly4F7twdD2Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770484972; c=relaxed/simple;
	bh=5g6QLwI/lHcJw+6W5Hl91Aidb2kRIJX4DebN8IZ+QxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbOyaDmBivxcfaUgeQHTAMavt2Rpua5tLX5p97GiwFi3xLRkPjohAN0rBtAWJwyVGtk+oS/pJRh3BC8sBwzvRu+Au+IyB4MxI53cg6T+E/518oITM9ns3uDsfKogLcWzvNJkaZGxJtMbzfLyg7RswjAXmxnvvyuWUoSG6ioTyA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7jL2/rT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F85FC116D0;
	Sat,  7 Feb 2026 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770484972;
	bh=5g6QLwI/lHcJw+6W5Hl91Aidb2kRIJX4DebN8IZ+QxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7jL2/rT9TxWcigbs5V/yqWSP2BKCztARnhvN7LdOZhp/Te7hU+c/00E1bpKDFaaE
	 ZybG6rS+Cm5w/WRTzS9y8xWwLwxkmT8Gd3sokAjJDJBFm/HMX9toUaG7PQ6nJktOZH
	 gcyuQaMbULvAY3qU5W2HtGkoe77juMMZPSyBGzf46TPq/FXZ41cz3F/uvUGr9XkHlh
	 +YKZOQrlYZKpx8oh+IWPyocHh6Gct1NHo16tPBlH99GT37zLsSqJaAVkdBxrSLyH8B
	 /eaSkNmQSMBH2YnmjpfD1zIzJQzJX8Vj6FyuXIpOd9yd1tE1G0g5fl3AQJJ7qlC4nI
	 80oC9OvMmFDDw==
Received: by pali.im (Postfix)
	id D5F44A1B; Sat,  7 Feb 2026 18:22:42 +0100 (CET)
Date: Sat, 7 Feb 2026 18:22:42 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com, stable@vger.kernel.org,
	Olexa Bilaniuk <obilaniu@gmail.com>
Subject: Re: [PATCH v2] platform/x86: dell-wmi: Add audio/mic mute key codes
Message-ID: <20260207172242.r5dcdf5kxnihshpi@pali>
References: <20260207-mute-keys-v2-1-c55e5471c9c1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260207-mute-keys-v2-1-c55e5471c9c1@gmail.com>
User-Agent: NeoMutt/20180716
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214811-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[srcf.ucam.org,kernel.org,linux.intel.com,vger.kernel.org,dell.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pali@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFD96106AD3
X-Rspamd-Action: no action

On Saturday 07 February 2026 12:16:34 Kurt Borja wrote:
> Add audio/mic mute key codes found in Alienware m18 r1 AMD.
> 
> Cc: stable@vger.kernel.org
> Tested-by: Olexa Bilaniuk <obilaniu@gmail.com>
> Suggested-by: Olexa Bilaniuk <obilaniu@gmail.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Thank you, this looks good.

Acked-by: Pali Rohár <pali@kernel.org>

> ---
> v2:
>   - Put the codes in the correct order
>   - Add comment above keycodes
>   - Mention the specific model that uses these keycodes in commit
>     message
> 
> v1: https://lore.kernel.org/r/20260201-mute-keys-v1-1-825e786732fc@gmail.com
> ---
>  drivers/platform/x86/dell/dell-wmi-base.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> index 28076929d6af..907f1da01c8d 100644
> --- a/drivers/platform/x86/dell/dell-wmi-base.c
> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> @@ -80,6 +80,12 @@ static const struct dmi_system_id dell_wmi_smbios_list[] __initconst = {
>  static const struct key_entry dell_wmi_keymap_type_0000[] = {
>  	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
>  
> +	/* Audio mute toggle */
> +	{ KE_KEY,    0x0109, { KEY_MUTE } },
> +
> +	/* Mic mute toggle */
> +	{ KE_KEY,    0x0150, { KEY_MICMUTE } },
> +
>  	/* Meta key lock */
>  	{ KE_IGNORE, 0xe000, { KEY_RIGHTMETA } },
>  
> 
> ---
> base-commit: 008bec8ffe6e7746588d1e12c5b3865fa478fc91
> change-id: 20260126-mute-keys-7f8a27cd317f
> 
> -- 
> Thanks, 
>  ~ Kurt
> 

