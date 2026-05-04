Return-Path: <stable+bounces-243889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePAIL97b+GnG2QIAu9opvQ
	(envelope-from <stable+bounces-243889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:48:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF814C21F9
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58A03022054
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE48C3E4C85;
	Mon,  4 May 2026 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbnXedo3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC713959D;
	Mon,  4 May 2026 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916887; cv=none; b=ftfyLERegjE7lckvet5t9ERNIe8GkMb6ynh+1S9N3oFe3IQVu1v6qGGyD8bZtvVdXxzeBGqllGqBxTo0SiZvIExOmoXhIy2UmCWjwBKDhr3skpshLmB5+jdNwOpy8PpzneB/l5cjnIbuJ5cxdz0OYQXNpubafHEEPJwbC5TUE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916887; c=relaxed/simple;
	bh=/3g7lvlSwRiq70E1vvvgAFrlVJw6GAXpNdIwVjWsoCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QnbZozbqtDfUhs6KMBG3VGwIDYTNKalB/dSJVr02fbHDzov+boXnG2i9S8NolmsU/pfBrHgsY0NYfr/QvoZdMHSXvBrgBMbp44I79OEKtjeHDykPOJbNDHV6A73A70DLuH/BCqxNUpPA5Z/rcDyCr1p49KNIwbJc8+oqf2UFpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbnXedo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AB1C2BCB8;
	Mon,  4 May 2026 17:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777916886;
	bh=/3g7lvlSwRiq70E1vvvgAFrlVJw6GAXpNdIwVjWsoCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JbnXedo3AK7ZISss5kOZ3g5EbeApjZuXQG5TjqviDvYOVWcFEITaivXCPdUcJXUuP
	 MgINhIUGbSJRnZ1C6N3og8G2fLhnSrGKa1l580WoVid1YF8CzsB1TtJwpJq0r7+xZP
	 rkJrfNbcRnKFFja0Brj2p/+K+7aTHg0tFaSehxorBvxDoKl1neEA5RHb+msEDV5wHa
	 3EFuDAEcIHJpjkjj8/V2DtNz788Xqn1JOVcZ7EJo4sYL6cfwhx5vcpCt6brSxCw1EZ
	 m7ytF6Lf/0V7+BWZ5C1EaVkz+cNXdiMoCqWdupFtqFYzO5bKztSZp0vlv8z/l6iusr
	 CMkbENVomJRkg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Alexander Dahl <ada@thorsis.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 linux-mtd@lists.infradead.org, stable@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 "Rob Herring (Arm)" <robh@kernel.org>, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260429125930.844790-1-ada@thorsis.com>
References: <20260429125930.844790-1-ada@thorsis.com>
Subject: Re: [PATCH] memory: atmel-ebi: Allow deferred probing
Message-Id: <177791688430.723206.2269403194221624148.b4-ty@b4>
Date: Mon, 04 May 2026 19:48:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 1FF814C21F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243889-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]


On Wed, 29 Apr 2026 14:59:30 +0200, Alexander Dahl wrote:
> After removing of_platform_default_populate() calls the atmel-ebi driver
> was affected by deferred probing.  platform_driver_probe() is
> incompatible with deferred probing.  This led to atmel-ebi driver
> eventually not being probed on at91 sam9x60-curiosity and other sam9x60
> based boards.  Subsequently the nand-controller driver (nand-controller
> being a child node of ebi) on that platform was not probed and thus raw
> NAND flash was inaccessible, preventing devices to boot with rootfs on
> raw NAND flash (e.g. with UBI/UBIFS).
> 
> [...]

Applied, thanks!

[1/1] memory: atmel-ebi: Allow deferred probing
      https://git.kernel.org/krzk/linux-mem-ctrl/c/754d60ad1c91895be0bc7d771fbf9fb3c9448640

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>


