Return-Path: <stable+bounces-240064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CpbHdoo52kf4wEAu9opvQ
	(envelope-from <stable+bounces-240064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:35:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E19437AAB
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FCAB300B9D0
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A4E331A78;
	Tue, 21 Apr 2026 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uhy0t4T1"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08742BE05F;
	Tue, 21 Apr 2026 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756927; cv=none; b=pinWpyTVf6IwHw+X0sznqOS7MhiDYsAKHDwoe3PYHttpDJvmGCGMNB6nrWXebjGg5O6H9LlImkL+fHL7DMWd7xc+2M5luDvc/BGQeaf8c8PF7+9eXkxN3DSq5QQDum40YEaxYtWuUZ8Pj0PORYJ6RyH5h0MDM7PWz0hPpe8Yey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756927; c=relaxed/simple;
	bh=tjDRDh3IFRsUTJociGMi2a37LGpLwz5EHWQZhwlDXuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HyvaYD4RzllPM2IU12CN4QPhzyMbY71Ht8DCwSA4CRwUO+jBZ2gDRJc8KmNCIUHEN1ru+BRIzYAdCq+JVq97FVSGyOxNkRKNvaOVaclW54TxNahkoLAaC7Euxca1cWJl5TcwuM9GvAGqVTwoPqzHCx0yZ3d0MrWuSF7kunPwaaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uhy0t4T1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 91D78C5C9A6;
	Tue, 21 Apr 2026 07:36:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5938F600D2;
	Tue, 21 Apr 2026 07:35:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD0EA1046093A;
	Tue, 21 Apr 2026 09:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776756923; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tjDRDh3IFRsUTJociGMi2a37LGpLwz5EHWQZhwlDXuk=;
	b=uhy0t4T1BIHFXIp8/Zxc/fi1FZ/u4Uk/IJrJNO9pHGIXTBiC6RsEslNnnn+K2E/+na+vny
	O/pe0fZpZ0kFg7ff4OXC+4KLr0kB3aCxPrfrGmzPsT4Au2eCoezwdXZ+8Wthf1VHs2ItL2
	WttOFoh96fBJJncDn3rG14ak9b9D/KwjzlHkdhXK2MyNYvquGlC3/YWZHjj9iLUv4aGu+b
	5M4OSSEMpREAMjyOElrHunp9BScFmx7ZQTcusLvUQ6nLlT9kxNWZKYiU7Cy9vW6PW+P02+
	GayWVztPWZzdz2Fqnru0z+q7Y2A8MKxNPC6LN2Ag+gA5lLDABq5Ikqoy1OXlfQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Takahiro Kuwano <takahiro.kuwano@infineon.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Pratyush Yadav <p.yadav@ti.com>,  Michael Walle
 <michael@walle.cc>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: debugfs: fix out-of-bounds read in
 spi_nor_params_show()
In-Reply-To: <20260417-fix-oob-read-spi-nor-v1-1-2132e61a684a@linaro.org>
	(Tudor Ambarus's message of "Fri, 17 Apr 2026 15:24:39 +0000")
References: <20260417-fix-oob-read-spi-nor-v1-1-2132e61a684a@linaro.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 21 Apr 2026 09:35:20 +0200
Message-ID: <87jyu07olj.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-240064-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,bootlin.com:dkim,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 28E19437AAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tudor,

On 17/04/2026 at 15:24:39 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> Sashiko noticed an out-of-bounds read [1].

[...]

> Cc: stable@vger.kernel.org
> Fixes: 0257be79fc4a ("mtd: spi-nor: expose internal parameters via debugf=
s")
> Closes: https://sashiko.dev/#/patchset/20260417-die-erase-fix-v2-1-73bb70=
04ebad%40infineon.com [1]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> We shall assign a CVE to this. I'll look into how next week.

They are assigned automatically to every fix, no?

If spi-nor folks want to ack, I might take it through an mtd/fixes PR.

Thanks,
Miqu=C3=A8l

