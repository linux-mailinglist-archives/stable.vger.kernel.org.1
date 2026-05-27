Return-Path: <stable+bounces-254461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLlbERlLFmrZkQcAu9opvQ
	(envelope-from <stable+bounces-254461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:38:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E35DE472
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52989300621A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 01:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380203254A2;
	Wed, 27 May 2026 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlvUCH1q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD5732470E;
	Wed, 27 May 2026 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845903; cv=none; b=htv+gzadkolPP01ubB3PD8Pw4dhF+cepiEDosLbG6bHx0sAW2VHGP3Fd3GrUUtPwWu044JbhUd5+MSBBJ/jyvxMtdqLtxTrK6YEmWCtqKzIahHmljP2mbaa8lIfPHZ+yHk7HUsasQDFWo74HzQhZz89SN1/2FmdgB5tvCQroGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845903; c=relaxed/simple;
	bh=SkNI8P/58d3v6Ay2bk/nWH218JnJwz5keuZGest2BMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7TP7UpszPhAtlG6Pv6o0gePbmCavygIbkF8EXN22Px28AHzzq61Yt1+NHlciMj0XIEdrc9HDZTCTRmp+EASN8vrvF55H/2uzTmaC27lp7LhY5yef8YEbdSaes5avLz8ylrvbYQBm8vR7oSveXtXAAQYNiHQx+rGAxdWhOuwOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlvUCH1q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7271F00A3A;
	Wed, 27 May 2026 01:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779845901;
	bh=SkNI8P/58d3v6Ay2bk/nWH218JnJwz5keuZGest2BMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BlvUCH1qabVdZy2AQhNHqSJkIOsH36RV+R6pXmWeQRczg6Hn/Uwl67r8Be7piTd0Z
	 A+8D0NLWpsBP0VqD8GcP7W5MDtSEBRIqGHo//PQ3ZWI0V985gAxPGzLc36g3fXCUHF
	 M2/pCpc5IGphGepXrqBY+QeM7hwrSgz+Cb0XSkuTBgXRNzN9bEhXeTmKBlL7hF1FJf
	 A79W4snEC5dK+3Kc1zL2c1QmiBXUxMUjLNLXEKvAkoaABk4v8GLckcoPeq5m3vAxpG
	 Kghx4EtP4M6756+cMZhDNFBZOGdN6xCGntecOHGN50NC17PT47fcFKPivUDOgkhdU9
	 uUagJoQCyfSuQ==
Date: Tue, 26 May 2026 18:38:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: carl.lee@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, krzk@kernel.org, peter.shen@amd.com,
 colin.huang2@amd.com, david@ixit.cz, luca.stefani.ge1@gmail.com,
 mpearson@squebb.ca, Mark Pearson <mpearson-lenovo@squebb.ca>, Bartosz
 Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5] nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI
 systems
Message-ID: <20260526183820.42cd7b6a@kernel.org>
In-Reply-To: <CAMRc=McK-AArPcrRc8rmotfoM8tSxyogGVVA3K9AcB0uG1szdQ@mail.gmail.com>
References: <20260519-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v5-1-1a826cfbc128@amd.com>
	<CAMRc=McK-AArPcrRc8rmotfoM8tSxyogGVVA3K9AcB0uG1szdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254461-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,kernel.org,ixit.cz,gmail.com,squebb.ca,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9D6E35DE472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 10:58:39 +0200 Bartosz Golaszewski wrote:
> Can this be queued yet? The problem is still present in stable branches.

Sorry about the delays, teething issues.
It's in net now and will be in Linus's tree on Thu.

