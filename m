Return-Path: <stable+bounces-259493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBojIzBVHWqnYwkAu9opvQ
	(envelope-from <stable+bounces-259493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 11:47:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7433961CB85
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 11:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFA0A300D773
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6532F691D;
	Mon,  1 Jun 2026 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA5wPr46"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288118FC97
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306913; cv=none; b=qLpbzx3sVSsDWzZUcaqf2PlhXF0c74h+TVgN27B84DjtnwYeCiLVi1fnCvSZTCU+oxBy3ZSJHIp6Rl/HXrMnaHnn458mZqx2Ymti3p8oFrd3ncJC9+OEdAnJjDJVjwWC+B5VXtClFPORXiuONecpGV1Odog+mbjoFNlN5SClE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306913; c=relaxed/simple;
	bh=M0afn7yk3q3IP37rKqnNbVxopkaMvCGehO/GCuNGtbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcY5F9krrBiKD4jnWNR23ktD4Y/JsadOSRTNAGNZoDjoFYZUM3P5tzeXP+Yz/qpXgSd/QG3K5nvnaEHDNzFdJC1pj3TP4rBFepTUB3FO142V60bdqRNIPfuav1ys6e+qe4mASXEWn7rW+ZK7hza3SotvA4M1F6fbg9jJRyFjqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA5wPr46; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B3E1F00893;
	Mon,  1 Jun 2026 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780306912;
	bh=j2ClisWBsJN6oKxDvmkUZLOrb+GmAmbBsM5VjRJdbOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SA5wPr46OGRYVU+kDH9qwBFg/rH4gpCroiTWSeihbgTsuiEU4R0aTcKGgJb2UxR71
	 RRTZ96wWYy9zCNz0SMguYXIk0LmUcLFe1Am1SF4rLSyLgcRCbyAxod/GRglg/U/Ob7
	 W8CrpfR0jZbavsbOPYvjRMqWiDCdPbOgXntIsRDmF1fzGBX8ASon3dbvd7AEaf2P3i
	 X/b8IHYaMBfxN0cawKhFmOhOfdoFP8OdjO98cKzLuW6zU63M3UMyIyaGJurgctSlpR
	 R+pcucpFws+jFAOxlhV/3E0BTULsjQtSpaLW3GdTm1+uJ5CuI3Hudcsli3dzr5Et/g
	 J4OlVt091aVpg==
Date: Mon, 1 Jun 2026 10:41:49 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Gyokhan Kochmarla <gyokhan@amazon.de>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
	Sudeep Holla <sudeep.holla@kernel.org>, sebastianene@google.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: firmware: arm_ffa: Align RxTx buffer size before mapping
Message-ID: <20260601-spicy-weightless-chachalaca-a2aceb@sudeepholla>
References: <20260601092918.11031-1-gyokhan@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601092918.11031-1-gyokhan@amazon.de>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259493-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7433961CB85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 09:29:18AM +0000, Gyokhan Kochmarla wrote:
> From: Sudeep Holla <sudeep.holla@kernel.org>
> 
> commit 0399e3f872ca3d78044bb715a73ea645806d2c7b upstream.
> 
> Commit 83210251fd70 ("firmware: arm_ffa: Use the correct buffer size during
> RXTX_MAP") advertises PAGE_ALIGN(rxtx_bufsz) to firmware when mapping the
> buffers but the driver continues to stores the minimum FF-A buffer size
> in drv_info->rxtx_bufsz which is used elsewhere in the driver.
> 
> Align the size before storing it so that the allocation, validation and
> FFA_RXTX_MAP all use the same buffer size.
> 
> Fixes: 83210251fd70 ("firmware: arm_ffa: Use the correct buffer size during RXTX_MAP")

Because of the fixes tag, it was already backported/queued to v7.0, v6.18
and v6.12. May I ask what was the intention of posting ?

-- 
Regards,
Sudeep

