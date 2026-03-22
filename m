Return-Path: <stable+bounces-227843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB4BNqEVwGnMDQQAu9opvQ
	(envelope-from <stable+bounces-227843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:15:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 463042E9F57
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3C66300B98E
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28261A682A;
	Sun, 22 Mar 2026 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RR7w2fnT"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589F1E49F;
	Sun, 22 Mar 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774196122; cv=none; b=WiZKHmJueL3VAldM1GEvYkvphPiMGhieYTeW7sCAD/NSkyCEZdJ/0YxBXmsoBAgaHp4YYLN8WQmOG+H1SDkDaTcnUAoKI8gvRgsrpbLo6DpVJoszuGk3fRFazWEmVjYcHEW1STHn94P/WGThDsvC9VvvcDlbxgwaTH19UvUuEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774196122; c=relaxed/simple;
	bh=V/vWTaJCpXakGe39KWaGEGCkk+F95Fqxb5spvgx3Tdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdGXOnDiR38d63jeM36I5CCbo5IQTT66lnLTs3K1TBZKzXnfH30ems1PZvi6+bkoOM06i5My0jJk1z2A3AsJqh1Kg5i4x1su5oyxw1XXAktfscLZt58WORdH3QJavcoFqqOHz9gJkcr9iTiZWYVAALDW26+hqmO+BznTd3LsvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RR7w2fnT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D934940E0163;
	Sun, 22 Mar 2026 16:15:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id f8o9yzRBOPU1; Sun, 22 Mar 2026 16:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774196113; bh=E0xC9iuncRCEDg2/ntU6JAxl0SLVJB0pCmZt/v2cnQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RR7w2fnTS55PPTT0ZuU1qXxVzJd+bEeAqKXmSi+tYxlrj5Pd4elnhaExXzWrAgzSc
	 8LXYJ1DZ3WkuCAZNhdtDIN7nqErZheMqpPwkS/L8suiEQYDWwMUt/6rHTQyCJ9oYFx
	 YTjQ84otw+Gqy8RQDS+RVUzYYtFsz4Ubc46DOvBM4RgI6wZJDteGn46s7EhGPsL1Xr
	 P+fA4/ft3/AEiCZLRl0gPhFshCK+2Fkh/F/4n3wBK2Bo3rbPZynQFB6GJOJaLYQcG5
	 gVlWhsMeuqWSxhgO8wrCNC2IOB4gpBz1Zdjn4+8OKOZjLzZ34Pdo8CFnUawJT9V69q
	 7ouaRu3QAc5rruB4rN5Jnx2lbl6MfcuGMH03OZf/+jI4PGasUpkX8dfospTHysrmPQ
	 2fjaBpqkn87oXX8+VeQLLeFGT9NPSArVCmcD6amVGo4ZfNh5cOnzAkZ+2u44p5CdJg
	 bPdCHa2zz20sKADbS6HNQLwQAp6YXg3nkf7kG4d3KHEVMWsVqQ0BAVA1hzThOtsa0X
	 6U0Ggkps0R0fyrvoHMEW5jYgKEZwS/bzT0LIOjRPRwGs+Hw4lih8dIMYUYD5b7wgte
	 2ObbwKJjadn2OBpvyHiOY7+HQKo2aRKKp0Dc2C1rNkKXkMmuhfKXgf+aLLJ5X68w9F
	 HJGpPP6ndiiyRFccjlxL4oXc=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0F08A40E0031;
	Sun, 22 Mar 2026 16:15:07 +0000 (UTC)
Date: Sun, 22 Mar 2026 17:15:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Cc: shubhrajyoti.datta@amd.com, tony.luck@intel.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] EDAC/versalnet: Fix device name memory leak
Message-ID: <20260322161506.GBacAViv5G6Ul-0WUX@fat_crate.local>
References: <20260322131107.1684647-1-ptsm@linux.microsoft.com>
 <20260322131149.1684771-1-ptsm@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260322131149.1684771-1-ptsm@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227843-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 463042E9F57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 06:11:49AM -0700, Prasanna Kumar T S M wrote:
> The device name allocated via kzalloc() in init_one_mc() is assigned to
> dev->init_name but never freed on the normal removal path.
> device_register() copies init_name and then sets dev->init_name to NULL,
> so the name pointer becomes unreachable from the device. Thus leaking
> memory.
> 
> Track the name pointer in mc_priv and free it in remove_one_mc().

No, get rid of the name allocation and allocate a char name[MC_NAME_LEN] on the
stack in init_one_mc() which you pass into device_register(), it copies it and
we forget about it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

