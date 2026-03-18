Return-Path: <stable+bounces-227131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNNEIr/lummdcwIAu9opvQ
	(envelope-from <stable+bounces-227131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:49:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E50472C0A10
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A623232044D6
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808D93321BF;
	Wed, 18 Mar 2026 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qlTBW54C"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0923C3148DC
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853735; cv=none; b=NCbSDVUfRGKQXiOJNBdRg5MEXzEYP/yETp2qQlZb/lfQJHLqdxBYWve0PFRWs5TjlIYopGbP8URfCrDIGJy+PmGzHYlgn7IWAs2RMA+sdjdVARuh/RVTfl7m0Z4ZYb06jrk6pX0DejjCIIUEIFIoNTFjJ8dpmwlNc2sU+jErMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853735; c=relaxed/simple;
	bh=WnaO3r8kwiEPCzciuA7Hy5gEsFhz0fe6EAHj01qcMDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t2/Qk8UYetrqmA3l8daA1FdPPCMqaWaKgko+VCboplZFLUBp5jDYFo+IydtQMYtN50Iw7Pv0UyRK4wUTted3qa/ucYwF7YGyQNwp4sWKkUXC5/16VeOw7JYVhg5TTob0uztWggbxP/+VFxxH/lrQks7byMJG6yO0P5DjMhXt2vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qlTBW54C; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CB272C5506A;
	Wed, 18 Mar 2026 17:09:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D3056004F;
	Wed, 18 Mar 2026 17:08:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D8C110450502;
	Wed, 18 Mar 2026 18:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773853731; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6feiyHbCpZ3qfsMrs13AqEFm5/6rFI3LL/ii8kwxib0=;
	b=qlTBW54CM4ik+hMftNqR4sjML+3MRgCcUEBR5SZ52fzvhbuprh2w6FAHW9M81mUGNMDrFr
	2Vz1OmDX7EDCV4Cc0VMF7acfltmykwDSnVN2XOufu6dMZckG0giPNz9iGx89nX0LBBljLv
	7/+pl+veQWzMKlB/cX26R74v0HBm+irvuM8E0JbPAC9TjfFps/CQc602/RHbv82tnyUF+o
	NiX4b1cxeSJgNX2vrSQQBLOX2locmSMcGwqJ/Hc+gaTyjYo2O8lIIUxuseJcFAYDcwD0ui
	r6ucpHeXDJRo5g3FSZPeTmy/3e6JqLg02D3EHYzBr1qgvlxjUA5AlJjrKj39bw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>, 
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, stable@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
In-Reply-To: <20260317101842.319656-1-miquel.raynal@bootlin.com>
References: <20260317101842.319656-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Fix RDCR controller capability core
 check
Message-Id: <177385372622.729501.7256585617777481305.b4-ty@bootlin.com>
Date: Wed, 18 Mar 2026 18:08:46 +0100
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-227131-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: E50472C0A10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 11:18:42 +0100, Miquel Raynal wrote:
> Commit 5008c3ec3f89 ("mtd: spi-nor: core: Check read CR support") adds a
> controller check to make sure the core will not use CR reads on
> controllers not supporting them. The approach is valid but the fix is
> incorrect. Unfortunately, the author could not catch it, because the
> expected behavior was met. The patch indeed drops the RDCR capability,
> but it does it for all controllers!
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: spi-nor: Fix RDCR controller capability core check
      commit: ac512cd351f7e4ab4569f6a52c116f4ab3a239cc

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


