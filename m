Return-Path: <stable+bounces-223654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHy9EgnOrmnEIwIAu9opvQ
	(envelope-from <stable+bounces-223654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:41:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF1239E4F
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 566BB302BDD9
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13B83B8D5F;
	Mon,  9 Mar 2026 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RNRVmgl2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RC/mK6Xo"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7E3BD623
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063625; cv=none; b=dhELtv9yJSwwm53Q4H7E7/2qdh69l9zaeXe1hcxTuqVyrPel8gyqzLlSk3YvpwKaspsgIgED4X3tfu3jkM+Y9KKC+A7DkYb/fBPbflji8wCJrNAiIog8TLct8rBQZ97Yi2lgjz1J60SVaCstIUqI9ft2pvJJGJF7287Msm0ReII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063625; c=relaxed/simple;
	bh=xNVQxAsmn4tbu5qowZHIgfOuqm75eIXhw6Mk7CYLJCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nx+CZOMjLPmgeZfG+MjIU3vR/qmMTnaMAdOZj6oAvZVO0pV5dW2ZBCA0A3mLIM1pZLaDFiDFU+1vmNu6ZRbj7kiOZGUnLUgwoTjHkc3OXFg8yZGg5ApaiSqr1hvFgq6Mn/JBNZU9LO2uDK3s8EXHpEJUibz+ChVggEVfNBWyOrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RNRVmgl2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RC/mK6Xo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 9 Mar 2026 14:40:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773063620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNVQxAsmn4tbu5qowZHIgfOuqm75eIXhw6Mk7CYLJCA=;
	b=RNRVmgl2Vc8tB2Y+QrFzMeRYPVLDq5iXFdw/Mhba4ignSboxkYiHBOoKZbR3YfxTusWhYI
	e38xQ14FTlljEmN68HHgTB83lfZVn4L8otMVBNQgkjMH2O7uNBAuvntrvj0JoJ7OCJZhy0
	yvN+YV07sehc1RaCn8XwVwg4clrUVCdltOIO5dqYQ7A7wVkkyPJT8JMzpsnwn1raNYpEW8
	Tbg4XKegkZBbS864LqMXCZP9pjtOPcJ9J1rgqs+eIC9kMf0CLJnQ46sjkpMWsPehlv84j7
	yEtLY4/rQmI2Qibev/u4BbOGSIs6hsLf8bMv8g117bGOkt+iTdRVFy2MacT3BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773063620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNVQxAsmn4tbu5qowZHIgfOuqm75eIXhw6Mk7CYLJCA=;
	b=RC/mK6XovFK/SMJX/vQBJtWoSPmJcU3+8a07a/3Iv/rgyml8rEUYQ+eu6QAhGu/izaPEui
	YG/TCwMJXNvTu3CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pshete@nvidia.com,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Patch "soc/tegra: pmc: Fix unsafe generic_handle_irq() call" has
 been added to the 6.19-stable tree
Message-ID: <20260309134018.kstGuW4s@linutronix.de>
References: <20260227025419.2745361-1-sashal@kernel.org>
 <20260227071216.6dYMGnMj@linutronix.de>
 <2026030910-strength-relapse-8dee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2026030910-strength-relapse-8dee@gregkh>
X-Rspamd-Queue-Id: BCCF1239E4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,goodmis.org];
	TAGGED_FROM(0.00)[bounces-223654-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026-03-09 14:38:28 [+0100], Greg KH wrote:
> > sorry for not noticing this earlier: Instead of irq_work() and all this,
> > I would suggest to revert this and simply switch to
> > generic_handle_irq_safe() instead.
>=20
> Can you send a patch upstream for this and tag it for stable?

This was meant for the developer and maintainer of the patch, not for
the stable team.
I will follow up if they don't respond=E2=80=A6

> thanks,
>=20
> greg k-h

Sebastian

