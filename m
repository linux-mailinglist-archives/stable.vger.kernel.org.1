Return-Path: <stable+bounces-225437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFmrI5artWkn3QAAu9opvQ
	(envelope-from <stable+bounces-225437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 19:40:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAFC28E81D
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 19:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA5173015D34
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 18:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAD0346ADA;
	Sat, 14 Mar 2026 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxivH/Ko"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96934214F;
	Sat, 14 Mar 2026 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773513619; cv=none; b=PZ1Df6ei6ywnQGmu2N8pCFNfDuqQk4Y5k3yknVZG3q713Ivp/dqOCdbmJjUsLCGkCnWTFuY7Q01RqJFRGlSm/E2epNe6p3hAUeAx9eE7DZ2YC6wvbTMgol/SLnHkKkIx+LexVrCeDUpA3UAZdWxQRdGGEfN8lHvMgvIURJw6Dws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773513619; c=relaxed/simple;
	bh=MeeEBlZe1+s9pl24DBcFReIEEYqdGrsL04hNwJmo9gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7NCvGR5pOU9CMeU7wp9TifVTJQVCgidYTzR66kFYDOMTbSDE2rZO+jKAiApBabloDMAj2BS0mT4A7fMfoN0Qak6Wxg2jZrUSCnwPyhJs2UCgHfgVG6Ir/vK28sfiGt43mC5mYZXJ28WtOxWcPHtmQNjYPogIFsCIIPmW43nmVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxivH/Ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6699EC116C6;
	Sat, 14 Mar 2026 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773513619;
	bh=MeeEBlZe1+s9pl24DBcFReIEEYqdGrsL04hNwJmo9gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxivH/KoWLaxIA2WqV9So+q2d7xYpVcU2fNoXareIHooz03X8AyqQ1wfJ1eCEDIfE
	 DjZow/6kbrNsbKFIqjn811JrQ/Iku1eTJqmTmmM7EHGqnTt2OhMbVEtfQ7SGzUHNLn
	 7/gC5mbBAOa3q7kNeCevNkuwXnIjp3zTHIjTvTRQBib5XaJwwq4X9nAOhovOJseqxO
	 LXtgcsLGm3o0qQKo2vibfaM5BaQXErHm1vmsJmGKBnkIqVtPioY0iSmbcOlb6eUugO
	 5Hi60HO+4dZhGGRmGPCPdv/OvcbyVfwKSXF6Kk7ftOUcCslpCoHVtYJECbyDWirSyz
	 IHwEUFRuARRTw==
Date: Sat, 14 Mar 2026 11:40:16 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: AlanSong-oc <AlanSong-oc@zhaoxin.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
	ardb@kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, CobeChen@zhaoxin.com,
	TonyWWang-oc@zhaoxin.com, YunShen@zhaoxin.com,
	GeorgeXue@zhaoxin.com, LeoLiu@zhaoxin.com, HansHu@zhaoxin.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] crypto: padlock-sha - Disable for Zhaoxin
 processor
Message-ID: <20260314184016.GB40504@quark>
References: <20260313080150.9393-1-AlanSong-oc@zhaoxin.com>
 <20260313080150.9393-2-AlanSong-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313080150.9393-2-AlanSong-oc@zhaoxin.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225437-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECAFC28E81D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 04:01:49PM +0800, AlanSong-oc wrote:
> For Zhaoxin processors, the XSHA1 instruction requires the total memory
> allocated at %rdi register must be 32 bytes, while the XSHA1 and
> XSHA256 instruction doesn't perform any operation when %ecx is zero.

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-fixes

I made a few tweaks to your commit message, as noted below:

> ------------[ cut here ]------------
> 
> alg: shash: sha256-padlock-nano test failed (wrong result) on test vector 0, cfg="init+update+final aligned buffer"
> alg: self-tests for sha256 using sha256-padlock-nano failed (rc=-22)
> ------------[ cut here ]------------

Removed the "cut here" lines because they caused checkpatch errors

> Disable the padlock-sha driver on Zhaoxin processors with the CPU family
> 0x07 and newer. Following the suggestion in [3], add support for the PHE
> extensions to lib/crypto. Only XSHA256 support for SHA-256 is included,
> since SHA-1 has been cryptographically broken, as recommended in [4].

Changed to clarify that the lib/crypto/ support is in a different patch:

    Disable the padlock-sha driver on Zhaoxin processors with the CPU
    family 0x07 and newer. Following the suggestion in [3], support for
    PHE will be added to lib/crypto/ instead.

> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1103397

Changed to correct link https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1113996

- Eric

