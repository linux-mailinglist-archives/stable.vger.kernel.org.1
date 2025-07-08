Return-Path: <stable+bounces-161034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB89BAFD302
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24FF3BB1D0
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AED2E0B4B;
	Tue,  8 Jul 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LD0ijrSZ"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3BF2DEA94
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993406; cv=none; b=tiQDUMyardK2KRRjZTPffVKKshQvoTy8rXmlf++uw0aGyRTUSu+wgkPLnb9VOjff760hGtOYdXZwIavhXn/vxfyN/oWGl9JvQjTCQGyhUzLeVGfUu9oFyIFElUhFGqgvBWnCnBqUv7xmBAoGZpiaC+ni8RvhI3Evhsz/jNJudW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993406; c=relaxed/simple;
	bh=vb6xa72EAnybF57lXVrUACPpI41DGNA1KzK813kv3gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTSK782IDkAVs3VFuXQxWGHadZYiutlsOY+U2ydnafiRabc2zllX88pmyUqJdHv+8q2TtE/R9kVQZ4ClEH9FMU3HY1BPRMyAa62iBbcqsAn14KrXtrz24xGSy8wE20NmTVq14FywodtMNvyRCqMLOPEIogcYh3A1Q46GlaUDpho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LD0ijrSZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 12F3240E021F;
	Tue,  8 Jul 2025 16:50:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id b2Eb-en64xAO; Tue,  8 Jul 2025 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751993398; bh=35SFA4vdbpN+EBpu812cljDoimPbKxLGwRw5L1vFqO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LD0ijrSZ3fbGVPsPVjshFprC8ICrgM3RZOSjja1Y/3ooBEpeCc0+Syx9SI3q3oXxW
	 OFrN1jAaGn8Vx2VuW8f7e0yxygfOtUiNZ/GVyQumQ+jzknudwVyxjAC09Xwrb/t0fC
	 vNrRjdlCYqHZktHRBZlVCmgNomeqrCsO3VOuCi4Kp5GyqDtiTKN1yAT26SbUbu84Vh
	 Bz0o4xXxHLoTHxeDtjrMgMcaKXpPF2jaqOUgk6QKOWjsi55g8Kf4zu1wKU8tekla5A
	 5tKmgV5YhMaX/zStSYKAx2+YgG8PepQk4TfyjOeJreKBj3G0ApQk5dnFExdd3y3CKq
	 9G3MHgGW5pF7vpcQME2v/1kr98/as/ZVvMUvHkL5A+vCWybRD/mezkp+g+x2Rzqhn2
	 x8vCoAWbGqth2YvuKJ+0+0xRpcIxTX0708hKC+gUymPLtB8TfNV3+r2ha6X5uscbp+
	 K+rFzjO1N1kqoBoyDYpG9JoanFp1PkcuVsXtYM7h/Av3179124Zb8cosiNOf7rilLp
	 tggd7AnMqnsumrXfdHXz0H9tQYNikScH95pqrklUVzyJGScrUHprKqjdX0/OfQLJ/R
	 MON4sndLShL+wiigauXsdDGkaj0ZykOQb5jzAxCkPD6Er2CgjB01FCnm+cLHEev01o
	 6pGNU0InmJseqg8ZIMiw5PVM=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C10740E0218;
	Tue,  8 Jul 2025 16:49:54 +0000 (UTC)
Date: Tue, 8 Jul 2025 18:49:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 6.1 81/81] x86/process: Move the buffer clearing before
 MONITOR
Message-ID: <20250708164949.GDaG1MLS-tyK1MYism@fat_crate.local>
References: <20250708162224.795155912@linuxfoundation.org>
 <20250708162227.496631045@linuxfoundation.org>
 <46161d11-2560-4044-8ed5-bb50206f9da2@citrix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46161d11-2560-4044-8ed5-bb50206f9da2@citrix.com>

On Tue, Jul 08, 2025 at 05:35:04PM +0100, Andrew Cooper wrote:
> On 08/07/2025 5:24 pm, Greg Kroah-Hartman wrote:
> > @@ -895,13 +900,17 @@ static __cpuidle void mwait_idle(void)
> >  		}
> >  
> >  		__monitor((void *)&current_thread_info()->flags, 0, 0);
> > -		if (!need_resched())
> > -			__sti_mwait(0, 0);
> > -		else
> > +		if (need_resched()) {
> >  			raw_local_irq_enable();
> > +			goto out;
> > +		}
> > +
> > +		__sti_mwait(0, 0);
> 
> Erm, this doesn't look correct.
> 
> The raw_local_irq_enable() needs to remain after __sti_mwait().

We solved it offlist: 6.1 doesn't have

https://lore.kernel.org/r/20230112195540.618076436@infradead.org

so the transformation here is a bit different and thus ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

