Return-Path: <stable+bounces-215985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFtkIFESjmll/AAAu9opvQ
	(envelope-from <stable+bounces-215985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 18:48:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C304130109
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 18:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE1DE308BDA3
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D4B13A258;
	Thu, 12 Feb 2026 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKe3Ln0U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C361F5EA;
	Thu, 12 Feb 2026 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770918474; cv=none; b=QZVtmm+GzQ58weCFjwdVwsR6mOjVMuTdiqrx28epkNnlqi/vUYWDsukRr0LJ0Kc9krVIl3Xu2VdEB9rcf3uXyymYM8dE9VNJi7+T9st7VTj5kKfJJ3DUwikOF47nAo5y3cvpoSkg9xoj6IpnV69naNnL+qzqCmqnV7Lla72Djmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770918474; c=relaxed/simple;
	bh=63eALC78UAbwjHtNgvnNd25XAYb18N5UP5293tvCClU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfVIgGrL3AY2eumaq2PIztR6lST28Jb/AMLNN/gaee0RMeO1Vu+KHSWX/ANc+p9Q/QmG/0XxraXdcLZnowH19zoONfEGoFh0n8560EarHkL+5YZxYFnUY9dUpwfwd2cni/Ld71f0P+JhlveEB+nifO8RWf+Cp+krVbR7gO4rbTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKe3Ln0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4019AC4CEF7;
	Thu, 12 Feb 2026 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770918473;
	bh=63eALC78UAbwjHtNgvnNd25XAYb18N5UP5293tvCClU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKe3Ln0UIr4Hxfec1A3/xVtsDdcLvg80s4LuHq1oza0sSlEywXxtMmg9UkccIajiV
	 GxfS4/9ajVZrpziQlUerIPURVBOKjk03L2nh09x9SHmKBol0EYiYQNqX1/+Tp9Prrq
	 wrqtV8SXeFL/ZdrVYA9SY5b+PItDZ2oVz1z8bEXEuGSl9eRAR+GiOuJmUoyssTF0Kc
	 5UAGTesxrS/qMcqfvsgAr9a1YNRgZQl/cbcN76KRfRZGnq3y9kyT1V1KcxJLBOqYN0
	 oosjmhRXrsuwBl42QzUqfp8vQ2rmixIlsW18hhWrUnFXIqWDByOxslfjEm/swawxKk
	 Trn4Ey5jLcMoQ==
Date: Thu, 12 Feb 2026 09:47:09 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Jerry Shih <jerry.shih@sifive.com>,
	"David S . Miller" <davem@davemloft.net>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Han Gao <gaohan@iscas.ac.cn>, linux-riscv@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] lib/crypto: riscv: Depend on
 RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS
Message-ID: <20260212174709.GB2269@sol>
References: <20251206213750.81474-1-ebiggers@kernel.org>
 <mvm1piq9ron.fsf@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvm1piq9ron.fsf@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215985-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C304130109
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 11:34:00AM +0100, Andreas Schwab wrote:
> On Dez 06 2025, Eric Biggers wrote:
> 
> > Replace the RISCV_ISA_V dependency of the RISC-V crypto code with
> > RISCV_EFFICIENT_VECTOR_UNALIGNED_ACCESS, which implies RISCV_ISA_V as
> > well as vector unaligned accesses being efficient.
> 
> That should be a runtime dependency.
> 

Currently there's no easy way to make it a runtime dependency,
especially given RISC-V's support for systems where the
"vector unaligned accesses are supported and efficient" property can
vary across CPUs on the same system and thus also vary at runtime as
CPUs go online and offline.  See
https://lore.kernel.org/linux-riscv/20251206195655.GA4665@quark/ where I
described these challenges in more detail.

I'd certainly *like* to make it a runtime dependency.  But the RISC-V
folks will need to provide a way to do that.  Part of that will likely
involve dropping support for systems where some CPUs don't have the same
feature set as the boot CPU, aligning with the other architectures.

For now, this patch was the only real option.

- Eric

