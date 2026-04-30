Return-Path: <stable+bounces-242132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAAABG5k82le2AEAu9opvQ
	(envelope-from <stable+bounces-242132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:17:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 114844A3E9C
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37C4E300C6F9
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD493A3E6C;
	Thu, 30 Apr 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLxPH0Sf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500DD1E834E;
	Thu, 30 Apr 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558626; cv=none; b=FoYoH1lOKA++M1aV0Ifq1i2KH1EGcU3jLZexmGXkhihl2YAiqzRpozxjOSGL9bibSd3WYgFeGM2nHP8JK1a3uDSe1iLBciPD1BeUZJyPYAY858Q9fCIY/58RCkloQ1/nadajlf+uNwSL7MMnJihxRI8qsC7hLFpL/JRvKxzZ3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558626; c=relaxed/simple;
	bh=1CA//UZz/lF442UL/KaqO4gWJWWn+H8PPJ40xHhLvHk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V4iFepLZD5rOBXVokSGQR4CieeQZ/spk5beiD1t8aYNEOr4n7dlo8QrJlRd1hHNdbzLsqaf1OlcVikEUJwnE0icJKTVaIUEdz7yXXklz6QjdZNc7WByxX6wFEMYoIhJTewX/owqim1mELk0+x/QAs/pkVJCJlBa7FslXB7rHdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLxPH0Sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C36C2BCB3;
	Thu, 30 Apr 2026 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777558625;
	bh=1CA//UZz/lF442UL/KaqO4gWJWWn+H8PPJ40xHhLvHk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PLxPH0SfoD7k6Mu3D+47aF5DFsuaC13Kqpuxcaguzp9vVbi9+Cl6RMzRtZCjoAIfa
	 vr5LoV8310/OYGDBBW1bGuwKtyX4iEWn0ledDQ3xBrruzs/ngBUadjlSSYVeZIB+vg
	 Kz2UvT3GOQUnR6SS3zBP0uBB7e/5KaRYdtXbBEWJHGE156l+rl0Xmak/KOQj4vOzlu
	 SrVO5WqbSTOC4mOy3CU1ZAmsGaQBI0E9GSxMX2RPZeYZ8WqNeFKj6jcB9GbH6YMG3G
	 qljp6FqYXN43w8sIMNmE5OvAKUGVjA/9gBhTNemNETmYf2RZNXeLmzoYZbkJEYhz8k
	 QAPue0YvmA7tw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Vincent Sanders <vince@arm.linux.org.uk>, 
 Ben Dooks <ben@fluff.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260415162627.3558789-1-lgs201920130244@gmail.com>
References: <20260415162627.3558789-1-lgs201920130244@gmail.com>
Subject: Re: (subset) [PATCH] mfd: sm501: fix reference leak on failed
 device registration
Message-Id: <177755862419.2623171.12042280860083766235.b4-ty@b4>
Date: Thu, 30 Apr 2026 15:17:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
X-Rspamd-Queue-Id: 114844A3E9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,arm.linux.org.uk,fluff.org.uk,linux-foundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-242132-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, 16 Apr 2026 00:26:27 +0800, Guangshuo Li wrote:
> When platform_device_register() fails in sm501_register_device(), the
> embedded struct device in pdev has already been initialized by
> device_initialize(), but the failure path only reports the error and
> returns without dropping the device reference for the current platform
> device:
> 
>   sm501_register_device()
>     -> platform_device_register(pdev)
>        -> device_initialize(&pdev->dev)
>        -> setup_pdev_dma_masks(pdev)
>        -> platform_device_add(pdev)
> 
> [...]

Applied, thanks!

[1/1] mfd: sm501: fix reference leak on failed device registration
      commit: f764c91c47046547bbe5b4f19cc5ad64132ee7d2

--
Lee Jones [李琼斯]


