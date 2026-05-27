Return-Path: <stable+bounces-254520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oACsA3K2FmqGpwcAu9opvQ
	(envelope-from <stable+bounces-254520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:16:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 531C95E1A6C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E37B430071D2
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDE837AA74;
	Wed, 27 May 2026 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bpnTdk7n"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C52A1CF
	for <stable@vger.kernel.org>; Wed, 27 May 2026 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873052; cv=none; b=apfCBimBhLTqq6dACV3Y9AaYSYfuSdr0vjberOTPRuAAr7oVjdaf9IFpEmecG+m7RTQ3lATcuz+gnLNghe791wsWSRIBwm163mED6YtIH10vmjZ37HnLTQDpGELPZ5+ch2cb7Lpt9R4OJb5aGD9cnfpvpF3FSUYEsTGBZ8pFYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873052; c=relaxed/simple;
	bh=pMZKBvvH++v6qrSCOSG15NIT83FfdUUFp40npEmVe/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oQOaIakUF53CTQbfYf+fzB9o4Naz8NTgsPdFpBPDPtN5lUPJw/2T88e9c+dYH2WzMqBHEjVA8IB335HONsc/9uIkfbwJ2iMoaRjVrPh+QW5ZdJpToZGJcbncI8VqVJuO7oaDesAJuGHeJCNDhzx2ZMeiwb95IcQyKyZRRFd6+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bpnTdk7n; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CADE74E42D19;
	Wed, 27 May 2026 09:10:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 98DCA601A1;
	Wed, 27 May 2026 09:10:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACF1B1088845E;
	Wed, 27 May 2026 11:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779873046; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pGl2916JTVjLHrmDmkxr4i2x/78he1PST7i+Hzc+Ksw=;
	b=bpnTdk7nCnrQZk9Ix2sZqS95AT62zvsr6ey8NPDp0aNLK/UOGdxMRxcwCuW0S8bCm5Pntv
	Sdaw4hU62GtrfGdVA5oslq1pr9ml+OB+TXJqj9QiF5eOQuGyRMXp00Kqb/n+MUrtu8E0sU
	e1gsk9MfcTg5yrEoixmNXV+MQuq4eqlrrWgLEcFndQWzRYgTzaDb2OqCEL6ULzPovS6Kr3
	go1ZMTht83zW3flin0XInHSbj++BttxhQ9hixn74hKtcj3qR2bikFVAoyf4WJecCLzDZBd
	TMBf0mRwdhnBjyF76EqXp3bdzVq82Q+wA4zlRX5a7c6RvJv+ft3wzE3WynoVTQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>, 
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Andrea Scian <andrea.scian@dave.eu>, stable@vger.kernel.org
In-Reply-To: <20260522091739.2789664-1-miquel.raynal@bootlin.com>
References: <20260522091739.2789664-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: rawnand: Pause continuous reads at block
 boundaries
Message-Id: <177987304402.3986809.14594892371333987990.b4-ty@bootlin.com>
Date: Wed, 27 May 2026 11:10:44 +0200
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
	TAGGED_FROM(0.00)[bounces-254520-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 531C95E1A6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 11:17:39 +0200, Miquel Raynal wrote:
> Some chips do not support sequential cached reads past block
> boundaries, like Winbond. In practice when using UBI, this should very
> rarely happen, but let's make sure it never happens.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: rawnand: Pause continuous reads at block boundaries
      commit: 8e4531667d718e2e9b193928cf9b2497fa0d01ef

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


