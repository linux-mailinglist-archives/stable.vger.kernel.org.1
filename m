Return-Path: <stable+bounces-250027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFXjLLPpDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:04:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB75C592E4B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D17863076B8E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A195636403C;
	Wed, 20 May 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+rBgV8u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C6348C7B;
	Wed, 20 May 2026 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293946; cv=none; b=HjKISHSUJegHMFvrioaTXY07FV8NS9GgMb2zs/xSVyq4Q9K1DQe2CcL90d1zW7CLeEKFTHA/JDXiwS27FMBALLVjbI8aPj3c/QL5aJD5bCn5TErpVPUROgBu0reQ4g1z05WJ99d5UlSJYPZ/4/qvwr90sifuWqC/KDVvgcb+9L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293946; c=relaxed/simple;
	bh=Kr/DFL2+ExRUtQ3RU2oBfJ7rA1pWNmPUTKaySl12AtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/oNQcwpgt93+RQQ4eQLoFO0A9+HoVoIeHEvV7q8FrV/Oqws+NWm5186Jw4d7xxW01D2excgMFmwI1enEwXlZq1gKnpIk5A3J1pQP/RWavlPpL+Z5DsJ443USzXOKwkbLzHHutX4D7nh+Rn2HzaqSPKjMUow0IhRJhNL4dLk9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+rBgV8u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0AA1F000E9;
	Wed, 20 May 2026 16:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779293944;
	bh=ZnVTRos8ozafH6X7RFMHvK+Huyq3OGkoQqbj+82aZAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H+rBgV8umx4ZoRJkuhb6zZKG0wcZpl2wqLh13nJgNv0aQJFiDm0zgoSNcPNyc0+25
	 QW1IFDJlj63T3isnI4hS6yxZhFpOqtZDmjStTlaYYoZlnPH7d9t4iDk+K5BAfLChk8
	 XYgSgnblYMkTlR7s0yUfs5osHYff1c2d8x0jdyjCdQqlZG/kVd/34/Npoycnsp1+Bz
	 EQ60ooOAJbLAbsxdgtEoXXST5zpdeq3ZZz6vgHhd0M5xcimQASyBqFM07VfeqswZDj
	 dX9oaTEfOzCvWpfuWN3YeldZywhIdnazqMdE0mNF69psQPB0jinRvIL0OYWaZurwMM
	 LxoY8txJrYccw==
Date: Wed, 20 May 2026 17:19:00 +0100
From: Lee Jones <lee@kernel.org>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, broonie@kernel.org
Cc: Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mfd: max77620: Avoid regmap mutex deadlock in power-off
 handler
Message-ID: <20260520161900.GM2767592@google.com>
References: <20260520-max77620_poweroff-v1-1-9186a3bcbe9e@tecnico.ulisboa.pt>
 <c8d16352-63a3-4512-b90c-a79e7e96dd3c@gmail.com>
 <38f5201a-6b52-4f18-bbbe-775171a3f147@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38f5201a-6b52-4f18-bbbe-775171a3f147@tecnico.ulisboa.pt>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250027-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ulisboa.pt:email]
X-Rspamd-Queue-Id: BB75C592E4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mark,

On Wed, 20 May 2026, Diogo Ivo wrote:
> On 5/20/26 16:42, Dmitry Osipenko wrote:
> > 20.05.2026 17:28, Diogo Ivo пишет:
> > > max77620_pm_power_off() is called via the sys-off framework as a
> > > SYS_OFF_MODE_POWER_OFF handler, which runs in an atomic notifier chain
> > > with IRQs disabled after smp_send_stop(). regmap_update_bits() acquires
> > > the regmap mutex in this path; if another CPU held that mutex when it
> > > was stopped, the power-off sequence deadlocks.
> > > 
> > > Replace regmap_update_bits() with i2c_smbus_write_byte_data(), which
> > > bypasses the regmap lock entirely. The I2C core detects the atomic
> > > context via i2c_in_atomic_xfer_mode() and uses i2c_trylock_bus() rather
> > > than a blocking acquisition, avoiding the deadlock.
> > > 
> > > Tested on Pixel C, powers off correctly.
> > > 
> > > Assisted-by: Claude:claude-sonnet-4-6
> > > Fixes: 744b13107d0d ("mfd: max77620: Provide system power-off functionality")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> > > ---
> > > This patch was tested on a local branch that sets pm_power_off =
> > > max77620_pm_power_off() unconditionally so that the function runs.
> > > I haven't checked whether the other bits in ONOFFCNFG1 are safe to
> > > discard at power-off time as I don't have access to the datasheet.
> > > If someone with access to the datasheet confirms they're not I'll
> > > respin the patch taking that into account.
> > > ---
> > >   drivers/mfd/max77620.c | 10 +++++++---
> > >   1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
> > > index 3af2974b3023..8c768968a317 100644
> > > --- a/drivers/mfd/max77620.c
> > > +++ b/drivers/mfd/max77620.c
> > > @@ -487,10 +487,14 @@ static int max77620_read_es_version(struct max77620_chip *chip)
> > >   static void max77620_pm_power_off(void)
> > >   {
> > >   	struct max77620_chip *chip = max77620_scratch;
> > > +	struct i2c_client *client = to_i2c_client(chip->dev);
> > > -	regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG1,
> > > -			   MAX77620_ONOFFCNFG1_SFT_RST,
> > > -			   MAX77620_ONOFFCNFG1_SFT_RST);
> > > +	/*
> > > +	 * Atomic context: IRQs disabled. Use raw I2C write, bypassing
> > > +	 * regmap locking entirely.
> > > +	 */
> > > +	i2c_smbus_write_byte_data(client, MAX77620_REG_ONOFFCNFG1,
> > > +				  MAX77620_ONOFFCNFG1_SFT_RST);
> > >   }
> > >   static int max77620_probe(struct i2c_client *client)
> > > 
> > > ---
> > > base-commit: 27fa82620cbaa89a7fc11ac3057701d598813e87
> > > change-id: 20260520-max77620_poweroff-08e39429835f
> > > 
> > > Best regards,
> > > --
> > > Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> > 
> > Kernel parks secondary CPUs before powering off system, hence there
> > shouldn't be a locking contention.
> 
> This patch was motivated by the Sashiko review I got in [1]. Its point
> here is that there is a possibility for a deadlock scenario in which
> a secondary CPU obtains the mutex for the regmap and then smp_send_stop()
> is called before this secondary CPU gets a chance to release the mutex,
> making it so that when the primary CPU tries to acquire it to issue the
> write it hangs. Is there something that I am misunderstanding here?
> 
> > Have you checked whether regmap_write_bits() works?
> 
> Now, in case this is all true this problem is still not something that
> will usually happen, only when this specific situation holds so
> generally even regmap_update_bits() was working, and in [1] I sent it
> out exactly like that. Changing it to regmap_write_bits() would not make
> any difference.
> 
> [1]: https://lore.kernel.org/linux-tegra/20260514-smaug-poweroff-v1-0-30f9a4688966@tecnico.ulisboa.pt/

It's my understanding that using the Regmap wrappers _prevents_ locking
issues, rather than causes them.

I'm deferring to Mark.

-- 
Lee Jones

