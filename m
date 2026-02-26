Return-Path: <stable+bounces-219787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO0TDjIdoGmzfgQAu9opvQ
	(envelope-from <stable+bounces-219787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:15:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D471A41A4
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10D893007CB1
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839A13A0EBB;
	Thu, 26 Feb 2026 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F17dWZXn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7E43A0B1C
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100909; cv=pass; b=BDl/F9g7wLtkQAUEg+ac1Q37v7mVjHoGekfuNVVpMGHJFLo5C6iNg0mRTqga2uoDUF4ieHTqhkjFzZPPAcBEQjLW8R+eY4eVF1KlvYL7Sdtj562QHwIO25Ni4Xm+GJUKVTOZu5/wVfOzC1okzJll46YI6BcSI9c5HihSs7KNyZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100909; c=relaxed/simple;
	bh=tcfsb19Wmb3McbX91tb496Zb905WaaM6x2v3wHSTyRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtqDPwUeZcXzlGM300S+Y4b0hGtXbo+/uQiu/KWTd4brMrsoGh2QGo3I8M1+TPqvz48KmiDMOY21P8UmSpc/eG/nSD0jA0DeYyXSWGQq72QiTqr8hWS21XsPFlbHBZXxf+5nKBMzy2jEtjzA7Vk4ZeIXSodPHZd2JSzrEUdaaJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F17dWZXn; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ad8435f46so678299d50.1
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 02:15:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772100907; cv=none;
        d=google.com; s=arc-20240605;
        b=HlNdM2rSI0p4EaYt4TBP0HBR/d8JPsydCDVgy9muWQ7gyVvn65O2CXcfBfErYtaEmM
         9cZIEOMsbqu9ZbiGmBqQQ2tCk/HLqUpHb1AAeXcWJNzhAt704zzze8oRfHgRAI30qFxD
         hL95356GgX0aUBPJkjottoQ9grpl6HD+vupEksaUAd6Zm5JUWWf5b9qgimEztOLakhCp
         ayXYfBTDQJPxqo0ERdMC7GmIDXvfajQttZXBBWq3in5T8jwM7IIMu6aFBjhzMJgSheQi
         fUrChy22L3y1IOFTFfG+fVAjyeS0k2M+LAhx8afJ+006F4WYXk6vjkh0e0C/BuALWybM
         5OEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D2S2ck2OTwevdx4H8sprHvjm0zbAGFrPm+nHEgDwTiE=;
        fh=QRZsSB80q7MaXqpPipQAuaH0TWvwwoiwUOcLc39/ySI=;
        b=S2KviyVjrwbJoRF6DXzv/7CmuoW/BKeMUYe3oy0daJhXFsuMn7UgupEb+H0ffxOVgh
         xRjkJFdynavF8hyg+3TpvdhAuRl4WPW2KCdqVQw9W6WsbVnL2I85c+SSLB4FQnHHcThg
         FoX9lF6glGX1bktY5CW0WzP8VKQiu3iV49qdrqIBk8zcY/J9yPUaR8kS+xv8KY/6aCl0
         7XByI8+v8oXjv8WnO8LbXygmTcO3Q8aiygjdAg7r+UrRdFPKto0iR5QEpInA5CyAfVOf
         UFZnPJzJTKfnpZhrjlifWXEL8iRLw9MxPUf25h4p7cMHnVfqNOTQ6Ugk9rSEyNTQYAhE
         e+jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772100907; x=1772705707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2S2ck2OTwevdx4H8sprHvjm0zbAGFrPm+nHEgDwTiE=;
        b=F17dWZXnNm5dvBwL1J3PoBgE5C973MH1sb5iI7ll+Js5++e4ReyslfuKnw0UtYGH+R
         VrEq1H2xpRQd3J8BgntdLm7NtAvH8UuB77MOauMAjTSNLqkp0naC1xtF9DmBtJ+ZdNwC
         BP5/qGru26v75yRTOg6qeSQarK3I/sk0XvlDjRJvaaFzmj4AxXyzmFRNOODKAYmlbdzO
         Iuw6qehLYoN2WHm64vq/V8j1laYY6XqvphPM7VuP8+/Pn2GtoA3xlq7XDyKRnFQIf+W/
         TSncYOmH2C8xO03Wh/vOe9sY2pT0DVnWJF+SWcdp7ubUvGpt0exmexdDcYy6NfQNQybI
         ZpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772100907; x=1772705707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D2S2ck2OTwevdx4H8sprHvjm0zbAGFrPm+nHEgDwTiE=;
        b=HGPrbpFIVTFJMA0vWcTibB05H0DnYMxqQTHm0Vlgd4H5frH/5l7bW7e01Fe6i0S/X1
         rUw9j0w1VE8LD7x5dBMgD6XEYIoO6G1EU72C20yQxLPBG6V+CNQ+oMl9gVha85VWQ9j5
         MZWjAEiqCdVmT2l0aHfGGsv5liNy6ukbjw832/CU+nhDeatp178fTejRXpuqe5ou1x62
         F4Mj5nASeOrOap1QWa+dM0h4UjmQ3P76fzNYzhNB1hDhN22IUa0XdTq14DIANYelVIfB
         xgkJ9rLQld8+mHbN7yON3NL6q0OKnNol7F2LEhdBkdCPxEa43ekEDwEAwc7uRZlytUrB
         thGg==
X-Forwarded-Encrypted: i=1; AJvYcCUW1kFq+UurdPsRAhyUEnPye6B/8Khajp9Bc1yVovEc4Ucg1Z4mKovybIXne1Hkk7skz4j429U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz++Dw14GKNjzrOfscJRnwQ20jvdlmssdHxL9s0ZrydBV8/vjwK
	7Fm9pGAWiGX7xQfqBpBLaYov17pELq9EkKeX9wMjoU3DPFNckSH63OEKUViSNhKwwylxO05Ad12
	blxLNPvKw/EVobSAaUm1yi0ylUGA+58I=
X-Gm-Gg: ATEYQzzfm6mKC4yIXN0rCT/25IRDVAVyubdOz+1sMsUTOiTEDnBnj7u3mC8grm9gZDm
	TSZyA+rt5aDKjXA/FbsH2KdcjaCyGx0bRqMBKbHHPQPy2iYMOmP/wEOiv6OnhIXGAs0VNtYbruY
	oHGDJc+ELIjtn5k9NAXbEw8/npAAeEnIdtAdKY/E5G0qWnHZBUG2FSGroxMLECD3jEg4VosaCz+
	l3AF1OB0Pg+DZJ6CrVUyd2LoZJxjny+FiR+Jbb3d7y1yL0blDXNlfcfu2cGpT5roS9Ck0fE/MXj
	ETAxsDRJ33t+WA5jx06ekC2VprQYCe4sD1YslV6CkKhW
X-Received: by 2002:a05:690e:1304:b0:649:b851:4a1 with SMTP id
 956f58d0204a3-64cb261e534mr2950603d50.86.1772100907088; Thu, 26 Feb 2026
 02:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226011632.4186353-1-lgs201920130244@gmail.com> <2026022555-improper-fanatic-cd10@gregkh>
In-Reply-To: <2026022555-improper-fanatic-cd10@gregkh>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 26 Feb 2026 18:14:54 +0800
X-Gm-Features: AaiRm504D78DlLbIwpZzyr2omqQbZOc4f4my3Tr_yLvb_Cea-wkRjNG1-eCP-pA
Message-ID: <CANUHTR8hzrnM6s_ysGea3kO8crbeq_onzgcfDTV6UAMB9QFogA@mail.gmail.com>
Subject: Re: [PATCH v3] uio: uio_pci_generic_sva: fix double free of
 devm_kzalloc() memory
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yaxing Guo <guoyaxing@bosc.ac.cn>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219787-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89D471A41A4
X-Rspamd-Action: no action

Hi Greg,

Thanks for the reminder.

This was found by a static analysis tool I designed. After a manual
review, I confirmed the issue and sent the fix.

Would you prefer that I include the =E2=80=9Chow it was found and tested=E2=
=80=9D
information in the commit message?

Thanks,

Guangshuo

Greg Kroah-Hartman <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B42=E6=
=9C=8826=E6=97=A5=E5=91=A8=E5=9B=9B 09:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Feb 26, 2026 at 09:16:32AM +0800, Guangshuo Li wrote:
> > uio_pci_sva allocates struct uio_pci_sva_dev with devm_kzalloc() in
> > probe(), but then calls kfree(udev) both on the probe() error path
> > (label out_free) and again in remove().
> >
> > Because devm_kzalloc() allocations are devres-managed and are freed
> > automatically when the device is detached (including after a failing
> > probe() and during driver unbind), the explicit kfree() can lead to a
> > double free.
> >
> > If probe() fails after devm_kzalloc(), the error path frees udev and
> > devres cleanup will free it again when the core unwinds the partially
> > bound device.  On normal driver removal, remove() frees udev and devres
> > will free it again when the device is detached.
> >
> > Fix by removing the manual kfree() calls and dropping the now-unused
> > label.
> >
> > Fixes: 3397c3cd859a2 ("uio: Add SVA support for PCI devices via uio_pci=
_generic_sva.c")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> > v3:
> >   - Add changelog below the --- line describing changes since v2.
> >
> > v2:
> >   - Reflow commit message to keep lines within 75 characters.
>
> You forgot my question of "how was this found and tested"?
>
> thanks,
>
> greg k-h

