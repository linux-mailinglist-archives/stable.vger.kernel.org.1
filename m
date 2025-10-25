Return-Path: <stable+bounces-189264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF7BC08C78
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 08:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11510350D82
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 06:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864132D9EF3;
	Sat, 25 Oct 2025 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="emJOExfo"
X-Original-To: stable@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F1ADDA9;
	Sat, 25 Oct 2025 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375352; cv=none; b=Nt2+E8Qov0O65TfTrEy7GcCFyDTpRCOyYYsxiD1oIxFH49zxRNl86auKaj7d5N7GDzyz04W8NrNPEZ8g/7uiWVwOT5fhwuYTL1kQhMZgT+lBrs1v377KwrIJ+xdIZjw7VhYd9yTlpBaY4ZBCHwTmSlTnhLYxJKqZr5pkdWrlUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375352; c=relaxed/simple;
	bh=3otcvR1gvzjNe+8Q/P9Blrw9ab/aFXjN69AOFDiMaOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZasPxlk/we2oY7jd/bCTTgXhWSMg7gtRYt8NFSeIAoD1k0bMgTen50YdJjIVqN+xZyIN2/yVKwd09tmJ+27DuDv0KJhsD3jKNrn7H97JBHJ0HmKjPdOUWfnjlFmCQ9r8mAJ3nHaZRXxD4bVu+4/jIb5EwLq0wDK/ilnx6dp0auM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=emJOExfo; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=2XwKzkS0PuEDgVKmnN/slJI+cbGfcqpoPw9ilvSTppI=;
	b=emJOExfoC0tdxiFGGN6i74ObhJeqTde+cxv0Fkq59zBNmVD7I0n61OIRHeUmCp
	9ccQR2tp2pYziSVXolN/4b1Vr49rL7/EfWTEcz0a7zsAgAGzuRUxEiZPeG8XtbEU
	aDFu1PlB1r3f9BRNUUbtIfixKoox2aZCcJ1VdJ3h5iB8c=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgC3v7RddPxo83eaAA--.3387S3;
	Sat, 25 Oct 2025 14:55:27 +0800 (CST)
Date: Sat, 25 Oct 2025 14:55:25 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Mark Brown <broonie@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] regmap: irq: Correct documentation of wake_invert flag
Message-ID: <aPx0XQTbFcD0kk9X@dragon>
References: <20251024082344.2188895-1-shawnguo2@yeah.net>
 <aPt6_lzhFYy5w0l0@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPt6_lzhFYy5w0l0@finisterre.sirena.org.uk>
X-CM-TRANSID:M88vCgC3v7RddPxo83eaAA--.3387S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWDAF1kuFWkZF4kuF1ftFb_yoWDCrgEgF
	1SkFs3Gws0vrs3C3Z8Zr1qvrn8K3W0gFWfGr18GrsFgrnrXFZ5ArWDZ39Iv3y8G3yFqrnx
	Ka45WrZxGrn3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUsqXJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNR+N8mj8dF8Q+AAA3C

On Fri, Oct 24, 2025 at 02:11:26PM +0100, Mark Brown wrote:
> On Fri, Oct 24, 2025 at 04:23:44PM +0800, Shawn Guo wrote:
> 
> > Per commit 9442490a0286 ("regmap: irq: Support wake IRQ mask inversion")
> > the wake_invert flag is to support enable register, so cleared bits are
> > wake disabled.
> 
> > - * @wake_invert: Inverted wake register: cleared bits are wake enabled.
> > + * @wake_invert: Inverted wake register: cleared bits are wake disabled.
> 
> That sounds like what I'd expect for a normal polarity wake register?
> I'd expect to set the bit to enable, so inverting that means that
> instead we clear the bit which is what the original text says.

Hmm, am I misreading the wake disable code in regmap_add_irq_chip()?

	/* Wake is disabled by default */
	if (d->wake_buf) {
			...

			if (chip->wake_invert)
				ret = regmap_update_bits(d->map, reg,
							 d->mask_buf_def[i],
							 0);
			else
				ret = regmap_update_bits(d->map, reg,
							 d->mask_buf_def[i],
							 d->wake_buf[i]);
			...
	}

Isn't it clearing bits to disable wake for wake_invert flag?

Shawn


