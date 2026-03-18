Return-Path: <stable+bounces-227132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCBsLczruml0dAIAu9opvQ
	(envelope-from <stable+bounces-227132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:15:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B900E2C1174
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B167F31B2080
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F9E33D6DD;
	Wed, 18 Mar 2026 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g1FYuwNX"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E333A039;
	Wed, 18 Mar 2026 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853738; cv=none; b=WFyrEOT/DGh3vtC1I41i9r/VrlJbz6wgbtKcMteFdclWIkns2kYSHRnmxK9orqSpuL/EdrazrlgQBYTYIspNbELFBqN54AH62dwjiVIR66jvsckHsHoJYaIUOczE06KAUIasZBlzSag8LRnV5CCrefOoSGB43wRbmqIJBOAvnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853738; c=relaxed/simple;
	bh=oaP1OzfN5zepmjf+fAdrQmseqqHLW4qo7nfL5nXAeB0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b1D46zsbSPaR10wUHU1onXSIr6lD+4ZtGeaeNB2MNwf3q4bvAodf393i7zONZhZ+9UQuzjht4aUylQeGU4CfTuUDccDOy4UhMZrLEOcSPhYK6O3mrWNKCJgxGw6HGB8Gsz2X5XiRyR+ALOmA1BrbS4Shj6kgR/2DNzxzYIEsxRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g1FYuwNX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 020574E426F8;
	Wed, 18 Mar 2026 17:08:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBB106004F;
	Wed, 18 Mar 2026 17:08:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A981810450567;
	Wed, 18 Mar 2026 18:08:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773853733; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zax5XZm81akV6xkhhXpN4ysizTkpEPk/kpg6u3k2zJQ=;
	b=g1FYuwNXAXXlz6R+TMq0HeBOuHaX1JJdcuTevM666CxJoxYGrR4zK878M5ngZts/RuS39U
	Rf2DBviZQF3t3dzncq+ydm16RtlLDHS40uFA3jBvYDMnu/OdsIOZ8YCcppCTjcELho3NKw
	OGEWyPHO1RKgtGefr+692TLF7Kr+raR88ZpvzXzkp0GzLUN0YJRGfU3ssnozXyG7uWIaau
	RaolKNGMs8e0EGtKQXahLgvrWrJUVeWbXFetwjnO/aPzPrrv3I/ycXuOsvR6RzHcXkNMV+
	PlItq18JizzHDMzBnk12jRNkPakXIfjhEf93NyrTTDzn0+HsqfQpfIaNWGMIUw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: Michal Simek <michal.simek@amd.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andrea Scian <andrea.scian@dave.eu>, stable@vger.kernel.org
In-Reply-To: <20260317171807.652642-1-olivier@sobrie.be>
References: <20260317171807.652642-1-olivier@sobrie.be>
Subject: Re: [PATCH v2] mtd: rawnand: pl353: make sure optimal timings are
 applied
Message-Id: <177385373262.729501.6970700040556749897.b4-ty@bootlin.com>
Date: Wed, 18 Mar 2026 18:08:52 +0100
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-227132-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: B900E2C1174
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 18:18:07 +0100, Olivier Sobrie wrote:
> Timings of the nand are adjusted by pl35x_nfc_setup_interface() but
> actually applied by the pl35x_nand_select_target() function.
> If there is only one nand chip, the pl35x_nand_select_target() will only
> apply the timings once since the test at its beginning will always be true
> after the first call to this function. As a result, the hardware will
> keep using the default timings set at boot to detect the nand chip, not
> the optimal ones.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: pl353: make sure optimal timings are applied
      commit: b9465b04de4b90228de03db9a1e0d56b00814366

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


