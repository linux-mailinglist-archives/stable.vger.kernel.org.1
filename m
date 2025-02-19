Return-Path: <stable+bounces-116974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3382FA3B2BF
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93CC3B11C4
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 07:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6821C3C1F;
	Wed, 19 Feb 2025 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nt4n4ND+"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC11BEF71;
	Wed, 19 Feb 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950942; cv=none; b=D292e8cPhTAiOAouH3tBGf8YgkoO2EEULoTXUIYMTzVNNl/ItdFRZFwTfSj8PdzdAuk0FwvouS7wsH888BRNlxthPQX4HpDrV3p2TEOF5BJm9fNCRV4rughUezBWpVb7/tZnJb54glBOEsihjKx2mhWyzNohrd/xqxX839YSmuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950942; c=relaxed/simple;
	bh=IYZV4DKyRp83gdcIJ59Kj8qWqMhJv05T8ZY9PYuaYMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDhmfIO3/kKxkCz53aH/2eh66jgm+LY6fOhR/IAx8tgIvEOgKL+QGdH2Q5GlAyUj054pjrArMZElGmq1Vpgx81DYes1ym53/KkKjEHrycAbxL1t3h3jXmdWxduFPhnd5rJ3c4UK04sJHfyOdloh9BdmuPUYj+cNFUbANRnkohYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nt4n4ND+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IYZV4DKyRp83gdcIJ59Kj8qWqMhJv05T8ZY9PYuaYMU=;
	t=1739950940; x=1741160540; b=nt4n4ND+hTK+Wh8MxowQLAyQhH2bFT50tAv2l1G3/vZBHY4
	Rs18KCiZN8YkhnzWzWIdLtkGgqpd2oAUiAqfRWJjPCW4mwMkzbXdA2taAVw5wrD5xQB6sR7vmAKFy
	V/f6eO1jKLvTg+ila9b0nA8BZKL1ylrTkAPSaAEXYbXvuHsO14VtGLF3RkOhHqimebVISrYgWcuGm
	9DYaxTIYFxBJFC/RvHknn4LLkgttKfZmJRIJnbGmeB87sd0xjQCC+3TeL4EpAHeB8ZDXJ9iCMY4ma
	h2Wym2HJY0DArWqj6oHAqBJ+1ttatubfY3tRNDdIzKj5iMd+Wo7fwbA8j03cpsHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tkeiZ-00000002TFX-0bSF;
	Wed, 19 Feb 2025 08:42:03 +0100
Message-ID: <c993aa3a8e86e429d2135974929283a33d0f34ca.camel@sipsolutions.net>
Subject: Re: [PATCH AUTOSEL 6.6 14/17] um: virt-pci: don't use kmalloc()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, 
	mst@redhat.com, jiri@resnulli.us, tglx@linutronix.de,
 viro@zeniv.linux.org.uk, 	krzysztof.kozlowski@linaro.org,
 herve.codina@bootlin.com, 	linux-um@lists.infradead.org
Date: Wed, 19 Feb 2025 08:42:01 +0100
In-Reply-To: <20250218202743.3593296-14-sashal@kernel.org>
References: <20250218202743.3593296-1-sashal@kernel.org>
	 <20250218202743.3593296-14-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-02-18 at 15:27 -0500, Sasha Levin wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> [ Upstream commit 5b166b782d327f4b66190cc43afd3be36f2b3b7a ]
>=20
> This code can be called deep in the IRQ handling, for
> example, and then cannot normally use kmalloc(). Have
> its own pre-allocated memory and use from there instead
> so this doesn't occur. Only in the (very rare) case of
> memcpy_toio() we'd still need to allocate memory.

I don't believe this patch, "um: convert irq_lock to raw spinlock" and
"um: virtio_uml: use raw spinlock", are relevant to anything older than
6.12. I don't see how applying them would _hurt_, but I didn't have them
before 6.12 and had no lockdep complaints about it; I believe some other
internal IRQ rework caused the issues to pop up.

Never mind that we (Intel WiFi stuff) are probably the only ones ever
running this virtio_uml/virt-pci with lockdep :)

johannes

