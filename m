Return-Path: <stable+bounces-247101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPodMAJQBWomUwIAu9opvQ
	(envelope-from <stable+bounces-247101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:30:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D22953DA97
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B7D5302D1BD
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A2F35E529;
	Thu, 14 May 2026 04:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkdJkhlM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869561A6808;
	Thu, 14 May 2026 04:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778733052; cv=none; b=SLKrZFTWiSfbaUycFA8LtsDcu8BLdVgNpc5edym+tuZoQz3fPQF5G76qqCLFj+asbsoIx45xQkrtKUqhCuwkXjqkMAsabHF/ORUczPfEE9bj1dfDpVzAGMO2rUjjMnA+IW6LAuWuk3Cu2NRsZem6GJaLHCRFe2rlNscwphVfusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778733052; c=relaxed/simple;
	bh=ixvoQlegkcO1L+9UtwK7CT8sYtpgRASkPGBszMTMo7I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YppRxqLuiFo57frQKykKEeUcUzPzpcdkVPDY/lw68Ltd3O/KWpa6cKLyfNmR5P95OF+6GrhVOedWXLand1boNGHTCNhx4H6W60rLEvWa4Uo4x4Ma4QJJCDvFztKsiYyH8i0JTkDnjxYEq7G4cUZ2bZdVZTuFj/VVdfsqJl+tnSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkdJkhlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF15EC2BCB7;
	Thu, 14 May 2026 04:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778733052;
	bh=ixvoQlegkcO1L+9UtwK7CT8sYtpgRASkPGBszMTMo7I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=AkdJkhlMp0kLrTIe8rwFvCjghzPLyk2+L2KHXtg+8pmpVG0KciPQyL8gnuP1D3xr1
	 B4iDW/FX2mN3VtJS7YszimvQl7w1+b0w6jHB1sVU2+AxvZHPyrybEboeYwoE1aCleq
	 /a6MhV6IWgbS8mo8FZZN25BlOoyVqcq1lJo1HV+VieLH/9fj4Lc/YftlsQdct0w54r
	 mXuNk75zaiwc55wIySIQhKlKto8cUyI897HuC3lDIuuLurFrf46ERsNo5/IUyoJV9S
	 LuE7qyjgFZrim1UmR/4f3wCDCyfEZJ7WPp2kuvnP1CqTy4aWeHIpEDpfR0rYUtJR6B
	 YTJJXB1iHvbWQ==
Date: Wed, 13 May 2026 22:30:50 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
cc: =?ISO-8859-15?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, 
    Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, 
    Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Songsong Zhang <U2FsdGVkX1@gmail.com>
Subject: Re: [PATCH v2] riscv: misaligned: Make enabling delegation depend
 on NONPORTABLE
In-Reply-To: <20260401-riscv-misaligned-dont-delegate-v2-1-5014a288c097@iscas.ac.cn>
Message-ID: <ed77660c-84d2-ce2f-3b21-01a3309ed997@kernel.org>
References: <20260401-riscv-misaligned-dont-delegate-v2-1-5014a288c097@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 3D22953DA97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[rivosinc.com,kernel.org,dabbelt.com,ghiti.fr,ventanamicro.com,lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-247101-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pjw@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 1 Apr 2026, Vivian Wang wrote:

> The unaligned access emulation code in Linux has various deficiencies.
> For example, it doesn't emulate vector instructions [1] [2], and doesn't
> emulate KVM guest accesses. Therefore, requesting misaligned exception
> delegation with SBI FWFT actually regresses vector instructions' and KVM
> guests' behavior.
> 
> Until Linux can handle it properly, guard these sbi_fwft_set() calls
> behind RISCV_SBI_FWFT_DELEGATE_MISALIGNED, which in turn depends on
> NONPORTABLE. Those who are sure that this wouldn't be a problem can
> enable this option, perhaps getting better performance.
> 
> The rest of the existing code proceeds as before, except as if
> SBI_FWFT_MISALIGNED_EXC_DELEG is not available, to handle any remaining
> address misaligned exceptions on a best-effort basis. The KVM SBI FWFT
> implementation is also not touched, but it is disabled if the firmware
> emulates unaligned accesses.
> 
> Cc: stable@vger.kernel.org
> Fixes: cf5a8abc6560 ("riscv: misaligned: request misaligned exception from SBI")
> Reported-by: Songsong Zhang <U2FsdGVkX1@gmail.com> # KVM
> Link: https://lore.kernel.org/linux-riscv/38ce44c1-08cf-4e3f-8ade-20da224f529c@iscas.ac.cn/ [1]
> Link: https://lore.kernel.org/linux-riscv/b3cfcdac-0337-4db0-a611-258f2868855f@iscas.ac.cn/ [2]
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Thanks, queued for v7.1-rc.


- Paul

