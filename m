Return-Path: <stable+bounces-214327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGOAKdJyg2mFmwMAu9opvQ
	(envelope-from <stable+bounces-214327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:24:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B911BEA2C4
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76A7D3018B90
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C8C421A0F;
	Wed,  4 Feb 2026 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsTPAZsi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC83AEF49;
	Wed,  4 Feb 2026 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220706; cv=none; b=Q1Fp2loNF+wiIUny6s4pUHG0QAPY8jtczxdql3606JRedE9dYndJdfyvXpGMRFHMj0D7/3irqwmY/UrpZ92AQKgVuetyBfLzOZL5McFi1xQlm87+5euTaWP6lcyADPG9a6OEihA0mxKWhjIThKcHzSeEQp6l7I8ALPR9mMpu7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220706; c=relaxed/simple;
	bh=Qvn7LhXHvLpz9p3S9/cddZZzHsxs6pA4On1GbrqXLcA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=d3t/AWnQiGxsnPXUcsZMeAK1GwOMwzivzfpNsn0zgwTx6gAzuogR/pbs9ZTHxVWyuNzsm0KUgndeu1PVUGijlUmbZfxeSNV6zRZ026+YXH672OPHiraJVILupKUoIODdVujc6zYY+Kz8aNHaKRAv5QmcjYbK9WZoj8ruJxlYY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsTPAZsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F94C19423;
	Wed,  4 Feb 2026 15:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770220705;
	bh=Qvn7LhXHvLpz9p3S9/cddZZzHsxs6pA4On1GbrqXLcA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SsTPAZsiTRKFKTgu7oC4LDQrhun9Jk74R0BVEaO+G6LyaDNP+3+uhvqx+l5Orz8E2
	 bnvNvArohIr3K97ql+8Ik3UH4WDWZOFMC+o+x1s/iucr3pZ3PESApD6YmbI1L16BmV
	 2T7+DfGBvkIqPPqjhDiYXZnjp0Gifv6QnTa3YEyLVT8hDzPwUdiOjdY78VGWIIf2ga
	 LwpfbflQV22TmoyYge+mu+m73j58bDDbdnsi6F+K3BW4SYkIIMyT3qUOsrYu1r69Pp
	 YT/FMGsA+MbcZlIgqHZ5ybRsfzRDyuVBeLBYHfy/SPSgzOAWG7WTG19/QMIPK/Nd3t
	 A8UDZVFbAcnog==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4D96DF4006A;
	Wed,  4 Feb 2026 10:58:24 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 04 Feb 2026 10:58:24 -0500
X-ME-Sender: <xms:oGyDaavG1EzvkWsCDk6idLv_gWkM8Gsx6LQs3TV6LJHdu8N6LSJpqQ>
    <xme:oGyDaaQMSSzqJZV1OjCAhqGYVDrLJxYvb3EDfOcQb8hQQ2c_VnfuiI9ChUUfWQK8W
    _7HfYWhxkvt2PXxhavdcV8qh1HjthqdsKyJFLq8wEFTPY0RuOfsFBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehthhhomhgrshdrlhgvnhgurg
    gtkhihsegrmhgurdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepuggrvh
    gvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehkvghv
    ihhnhhhuihesmhgvthgrrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oGyDaWug49v5mdtzDAR8EsiKHohh3-tfTg2HMIo5f1zlPfzzIFKhGQ>
    <xmx:oGyDaYBWe0aYznrH5PGF3M6_dayyVuBfNDfdP3DV_biUdbk-DPQclg>
    <xmx:oGyDaWMN4QPj4J7_v75Epa_eyHRf3J0fO3hqUk4tibzELBzQbHu27w>
    <xmx:oGyDaYCmkjqBTYEsMKftisdsMjt8pvS7vjv7BEiP1VCBDxOy__s3BQ>
    <xmx:oGyDaX68JYz0YExRRt5B9tf-31QcUQ6Ug-NmpI8fSidwKGI0xGqUc4fj>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 291F1700065; Wed,  4 Feb 2026 10:58:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Feb 2026 16:54:23 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Tom Lendacky" <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 "Kevin Hui" <kevinhui@meta.com>
Message-Id: <4dfe2339-7899-4469-8957-646d8195b4a4@app.fastmail.com>
In-Reply-To: 
 <5648b7de5b0a5d0dfef3785f9582b718678c6448.1770217260.git.thomas.lendacky@amd.com>
References: 
 <5648b7de5b0a5d0dfef3785f9582b718678c6448.1770217260.git.thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/boot/sev: Move SEV decompressor variables into the .data
 section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214327-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,meta.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B911BEA2C4
X-Rspamd-Action: no action



On Wed, 4 Feb 2026, at 16:01, Tom Lendacky wrote:
> As part of the work to remove the dependency on calling into the
> decompressor code (startup_64()) for a UEFI boot, a call to rmpadjust()
> was removed from sev_enable() in favor of checking the value of the
> snp_vmpl variable. When booting through a non-UEFI path and calling
> startup_64(), the call to sev_enable() is performed before the BSS section
> is zeroed. With the removal of the rmpadjust() call and the corresponding
> check of the return code, the snp_vmpl variable is checked. Since the
> kernel is running at VMPL0, the snp_vmpl variable will not have been set
> and should be the default value of 0. However, since the call occurs
> before the BSS is zeroed, the snp_vmpl variable may not actually be zero,
> which will cause the guest boot to fail.
>
> Since the decompressor relocates itself, the BSS would need to be cleared
> both before and after the relocation, but this would, in effect, cause all
> of the changes to BSS variables before relocation to be lost after
> relocation.
>
> Instead, move the snp_vmpl variable into the .data section so that it is
> initialized and the value made safe during relocation. As a pre-caution
> against future changes, move other SEV-related decompressor variables into
> the .data section, too.
>
> Fixes: 68a501d7fd82 ("x86/boot: Drop redundant RMPADJUST in SEV SVSM 
> presence check")
> Cc: stable@vger.kernel.org
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Tested-by: Kevin Hui <kevinhui@meta.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

