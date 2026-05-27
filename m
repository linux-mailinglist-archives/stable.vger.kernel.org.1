Return-Path: <stable+bounces-254518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABgdOd2zFmokogcAu9opvQ
	(envelope-from <stable+bounces-254518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:05:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 643775E1800
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8F96305421F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D03E51E4;
	Wed, 27 May 2026 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XS5M6R+o"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB3A3E3C53;
	Wed, 27 May 2026 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872666; cv=none; b=B7qh6v05aFijl3xyczEUhMN3hEXbFKz9LqjraIxr//dl2xFdD8PO4zbzV/T78hSLtcOsbzQ2yAKu3AbwjqJqYCOe/iPY8i2CnSh58UCl/DvT+OTqD+fKaUdkN6BcqGKcBmP5PnANW1JHdGH8YnZfC10Q4c/BaBjVXh1cd8nojSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872666; c=relaxed/simple;
	bh=+4CpZEZZLKX0wG4Tl9DsVPUK2TtEsnzdkjdn1ar9IAY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fYC1sUmKdEBTRnEdBOjyB1GCbBFjoHR/F6k55EC6kUXPTvIOR4BoYZogMzDUO9DXM0/llzzXnCjK+s7p1pxbZ69yIWvSmQ+ICHjD4oMcfqrbtsbnF9RfuomDMml6uLCF6gUPYqEvyjdP9afiqGKD6FHWK22L5yK/anEG/hf9QgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XS5M6R+o; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EDE70C2C643;
	Wed, 27 May 2026 09:04:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1EF14601A1;
	Wed, 27 May 2026 09:04:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C1A710888BA2;
	Wed, 27 May 2026 11:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779872660; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ifOb7iMULcjYrNOS66E0s/3v80FG2yX3hNh+Zn/Vc0E=;
	b=XS5M6R+oP7ote1rDCOtgWcUq5Y44uCawE3UmGwd/tlUdk37Dt4EIxwUVfPPkpKtjngfv0y
	ZgRdD/UTF/Vtk9tnMOlWCit78b6FkbhCQvS+lrTlAP+Ee9MEoluyi6hdBVUkJfkVQ7x+0/
	cxjQu3BwPu+AfhFqeVsyWU4RxQan3so87xmPt0EFRPICjdCnB9CVQafRVWTmD2rQZcVQ6a
	9peYEcx922Gz1rhLR3B1ZG0PNUkK1N/5NHtZst0GbYyIGQBpouQO/ciDgSmVxM94l9z8Ph
	4fvcsRKBCwI5sptc5IUsD6FZ3ZqVl2RmxTk1Ks8SXwAAP7r8jLT9wWWM4BlNeg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 rulkc@linuxtesting.org, oxffffaa@gmail.com, stable@vger.kernel.org
In-Reply-To: <20260505083030.322528-1-avkrasnov@rulkc.org>
References: <20260505083030.322528-1-avkrasnov@rulkc.org>
Subject: Re: [PATCH v2] mtd: rawnand: fix condition in
 'nand_select_target()'
Message-Id: <177987265687.3976930.563196216201085206.b4-ty@bootlin.com>
Date: Wed, 27 May 2026 11:04:16 +0200
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,linuxtesting.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254518-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 643775E1800
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 05 May 2026 11:30:30 +0300, Arseniy Krasnov wrote:
> 'cs' here must be in range [0:nanddev_ntargets[.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: rawnand: fix condition in 'nand_select_target()'
      commit: 8507c2cc9e4fa402401819f44d1e8a5ef4d11d8b

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


