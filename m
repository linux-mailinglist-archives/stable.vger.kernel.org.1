Return-Path: <stable+bounces-254521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGgYB3+2Fmo6pwcAu9opvQ
	(envelope-from <stable+bounces-254521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:16:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF3A5E1A83
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B74733012E90
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36E03E7157;
	Wed, 27 May 2026 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="t7IkMvMO"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47B3E5EF4
	for <stable@vger.kernel.org>; Wed, 27 May 2026 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873054; cv=none; b=QSrc+gq5UWAunJQyoR2HTWBYULToWE5UdSq5BnQvPXA2moz5Jg/HQRk4sdwqZ26klhEUX8ezq3JkgX1I9WgwzzIglhF14fmxY6b5uFWNDl3Vm4fa54U9CT/i2fZFTtInhQkwc6ncf/I5E27a3YFJRGa1UHyXVm8URDz3vNeHoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873054; c=relaxed/simple;
	bh=zeWjnV+QQS9mGGww64PRoBStOZNzDLLq9xxaSY3ZX2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UMmNTFl5iUEVup8RYxHTTkX9LMbgzW5OMpmxq5AuBznm4Xyv6xisuYSB6dR+nuLZv6sL0XQCswKva6Fi4caH2y/+3S/aCYBPS0Tf+A54mNHMl3EkM+Gkt9vNmEGfJLM5ADJkOU3xgOkuLT3loXHFTPo9KZFKtNzxgRntt/QhQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=t7IkMvMO; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EA139C2C65F;
	Wed, 27 May 2026 09:10:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3AF1E601A1;
	Wed, 27 May 2026 09:10:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABFAF10888BDC;
	Wed, 27 May 2026 11:10:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779873048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0VFSCjnRlda22B1SRgGJJdCZhhm3V9AMj+EJNXVn1u0=;
	b=t7IkMvMOZwTkFNbQamA6Je6jR7RCS/TtMi0rE7Oh+IrV+j78eAtGnQium5U7de1FWj6gYf
	MbWfLyf6IsyhZ5kgfy5wt1Onfb3g+ixaQSezlVDx0VgUM/AnG8Yrog2gWPdM0KkK7GvX0c
	bw0D1qB3h3Qm+M0/GAy/dik8f2UG3XRQkACVM+/z5NChEgvdqDrm2JhH3Vnp3v6kXAFbLA
	IkzMtXzjhs/iyRVnh9sU38cfQ2rwOrfB0YzOiin5+qocb6kyRps0zIJxO/+yzle2pWACnk
	8Y0CmOaH4y36zbKAlp+GmpZiAEwXM4WDS5jx7dPVVoTb3W9YUCgLfWNd1zUsEw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michal Simek <michal.simek@amd.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260526-fix-pl35x-probe-v1-1-3baad4f527f2@bootlin.com>
References: <20260526-fix-pl35x-probe-v1-1-3baad4f527f2@bootlin.com>
Subject: Re: [PATCH] mtd: rawnand: pl353: fix probe resource allocation
Message-Id: <177987304762.3986809.7897694507848304230.b4-ty@bootlin.com>
Date: Wed, 27 May 2026 11:10:47 +0200
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-254521-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 9FF3A5E1A83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 09:10:00 +0200, Bastien Curutchet wrote:
> During probe(), the devm_ioremap() is called with the parent device
> instead of the current one. So when the module is unloaded, the register
> area isn't released.
> 
> Target the pl35x device in the devm_ioremap() instead of its parent.
> 
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: pl353: fix probe resource allocation
      commit: 19ed11aee966d91beebdef9d32ce926474872f79

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


