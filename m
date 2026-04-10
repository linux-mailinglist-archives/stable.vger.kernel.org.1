Return-Path: <stable+bounces-235649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDpuHPcv2WkOnQgAu9opvQ
	(envelope-from <stable+bounces-235649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:14:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA32D3DAF1E
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4B0300E3BC
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7943DDDB1;
	Fri, 10 Apr 2026 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jaEMXPB3"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727E3DA7F4
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841190; cv=none; b=EuBOQjkeDWvCH8MBD2gXNMI3TaOe88F/Kid3mkoTkmkUUOeodh1f1v81K42v7ycjx0ubZadUiiFfqY6JULYdxxkWXvUN3EzxIEp/pEoLsnIjxrPuibRe7ejKl4Lo8Qnau/KOXZB/wfeZ3cvRuRaH/VJ/+0JQzozHooEAL+JJyoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841190; c=relaxed/simple;
	bh=uenRIJZ892Auxkr+lcKC92XeoxvPpO+crCqUEfzQszU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ESE1fgSrh8FbbtrI9mn92ryIIOpl1tofizqG/s1DRFUQqBhk9SM8lzD4J989S+KEZ2xx4U+tyQ7dO8q3xHkZAUbExTUUYcCWyHPRHDZXs39kitwIJ9uFFdSLvv0Hjdnh2mG/ac6LX038huD3yiChL+QcmdvquHTUjIiHL6Sxrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jaEMXPB3; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D1952C5C1A5;
	Fri, 10 Apr 2026 17:13:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F8A8603F0;
	Fri, 10 Apr 2026 17:13:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20DD210450081;
	Fri, 10 Apr 2026 19:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775841186; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zDFS+saDI2MMDl7CZmYSKhT4lg/rWw8LZU0LtITesdY=;
	b=jaEMXPB3DWGVVX8Z9H7A+/0V7PMKsbB6hzRc3BN/tAN6kSFLtvFnOxKIKTvbiNh46cGG3i
	EJMX+iSWMEN9pilimOtVMLlH415SWqFovxGUABamF6ts1nlkBd/ZgdxtnCiZKePDazQ6so
	euCekRzf/KdWsuEjr4bi7onhHOVthkehF6zNRexzhg70aPC3FdHD+rpiJ7r4IVPdcAOcBi
	uhq/ibBe+KHj97G+SD7WaFxibSQPY8e+kI9DWdQFtQPGpsut1UfOruu9hAsgv7dqylN0Su
	D7wwr1zByuxlPCe3ByVdaiRda766h4M0JeVqIfTgGSY9eosBCnw93YpRF/CwRw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>, 
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Steam Lin <stlin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
In-Reply-To: <20260325170450.1118324-1-miquel.raynal@bootlin.com>
References: <20260325170450.1118324-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: spinand: winbond: Declare the QE bit on W25NxxJW
Message-Id: <177584118236.3008797.12886304380823058130.b4-ty@bootlin.com>
Date: Fri, 10 Apr 2026 19:13:02 +0200
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-235649-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA32D3DAF1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 18:04:50 +0100, Miquel Raynal wrote:
> Factory default for this bit is "set" (at least on the chips I have),
> but we must make sure it is actually set by Linux explicitly, as the
> bit is writable by an earlier stage.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: spinand: winbond: Declare the QE bit on W25NxxJW
      commit: 7866ce992cf0d3c3b50fe8bf4acb1dbb173a2304

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


