Return-Path: <stable+bounces-272139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yt9vDTRWS2qVPgEAu9opvQ
	(envelope-from <stable+bounces-272139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 09:16:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0124470D6AB
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 09:16:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=V0mw8dsr;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272139-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272139-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F41D7310BE7E
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD74B4C8FEA;
	Mon,  6 Jul 2026 06:24:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B43D88FA;
	Mon,  6 Jul 2026 06:24:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319077; cv=none; b=Mqte0b2IoA71AeRNi+Y66J4j/i1zPbl+7B2X1BcynWtLibK3uRvV3asEFHhcOMIdv71T5gZAevyBE5p2T1Eh9Q54Zou5HvDnfgOg18JQX7NdbDlZS6nv9LKeYTjmCgTyPhxiJyuKs9eBJfOZI6TNjBoixcGuq1WJHe+lftXre2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319077; c=relaxed/simple;
	bh=t8PK/i5kExzoyadMP4zeq/CxF6DiBBH3PN72t37cGdE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dMLfEg11R/P+OFW8nIUv/xh2z1Pf1aKxAeTJaCu0U49JzcmfjhxADM7POehPB3Rtxc/9hRFeLJyOu89xlHjw5D4oqXHHYwjiopru8mmelHeVfi4Q8ZB0HQU782Q8vapeRyc8+Q05yu32HpYNgEXbRxYHyESHUGYI81az8FDZPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V0mw8dsr; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 64C941A0E80;
	Mon,  6 Jul 2026 06:24:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 38FA7601A2;
	Mon,  6 Jul 2026 06:24:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6538E11BB98DA;
	Mon,  6 Jul 2026 08:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783319068; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oWy73pQkQkykoXtmTREjFgcQDsCw6POAoGsrElatGjo=;
	b=V0mw8dsrSBSByAJAKvS8O3OxgpTuNmyWSRvuUtyWFhVX5iCHK3DHymMXLzJ8rBCzVz6lPJ
	bBOdDprjSupXr8P9uXIeg0ZsAA8eHRMKfz5ypqIF4vZGvXO5zfhbHnKB7VcuvwcrmYMtdD
	4IO3OUYL7bpMwhNwYa8CD2ZVJZrrpEIyH/1kFwCd4vHL+6TSyLns45G88HpdF+mGIFE7aI
	0c9w2f9BE2sO94wAZ3vYGwOUucyDKACtrwxghroXxwgCV5zlyzynZ6/+SuUlnyfnI7vKFL
	tU09jA7BSVkjdnyN6SlTJ4H2GkpIXlMIKaCFGXyps+zdmo4XxTLsYt/gODqshQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Frank Li <Frank.Li@nxp.com>, 
 Kees Cook <kees@kernel.org>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260703074233.59967-1-pengpeng@iscas.ac.cn>
References: <20260703074233.59967-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH v2] mtd: rawnand: fsl_ifc: return errors for failed
 page reads
Message-Id: <178331906728.868671.5254954365609125128.b4-ty@bootlin.com>
Date: Mon, 06 Jul 2026 08:24:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272139-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:richard@nod.at,m:vigneshr@ti.com,m:Frank.Li@nxp.com,m:kees@kernel.org,m:linux-mtd@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0124470D6AB

On Fri, 03 Jul 2026 15:42:33 +0800, Pengpeng Hou wrote:
> fsl_ifc_run_command() logs controller timeout and other non-OPC
> completion states in ctrl->nand_stat. fsl_ifc_read_page() then only
> increments the ECC failure counter for non-OPC status and still returns
> max_bitflips, which can be zero.
> 
> Return -ETIMEDOUT when the command did not complete at all and -EIO for
> other non-OPC read completions so the NAND core does not treat a failed
> page read as a clean page.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: fsl_ifc: return errors for failed page reads
      commit: f9a13e05a327080c3a1c8165adf9e678fb68fef2

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


