Return-Path: <stable+bounces-223449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP37AzFIrWmH0wEAu9opvQ
	(envelope-from <stable+bounces-223449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 10:58:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6F122F42A
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 10:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE66E3012BF7
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 09:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E5436C0D5;
	Sun,  8 Mar 2026 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3mH0jGb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4117036C0C4
	for <stable@vger.kernel.org>; Sun,  8 Mar 2026 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772963876; cv=pass; b=gZU3LAxOCNP5nm9RN3e5rVvRJoHDKPjWggcEbXMmVKCzXa1AHRlpphxMJypltHkpIXbP2Q+mySg6fGx/I+DUKKVVytWQ7ZRueVCOga3ps9Jopw9jClvUzxLOm+qBRwi8E+KDTdIqG5okrltJ5OBnPORaQKCRhmnfdxFWunNYTFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772963876; c=relaxed/simple;
	bh=Vvxd/ab6l+0dULFpMMR+i2N7Xct9SlvBw5IaFdtl7/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ranVM6RMKHIj6/S+GdTIL5VWQ3c0b9Je5DVvin4b71PUAAvqHxB90RMVZXPf3wZMnYN6pWcnICspY5yZqpT6nqt3cPzXVWCeMcJeS/QlsYEKflzLCmkrv5rQ0aGWTWAwc4g4iuhQvovU4BNNzXQHvsTjKmuTsFA8WRMypEZO/Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3mH0jGb; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79881805788so111838177b3.0
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 01:57:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772963873; cv=none;
        d=google.com; s=arc-20240605;
        b=kWazjDm3zUREqzR452OdoYkf3scEmGuWf8qLJ164wETpejwwk8WtttX3eo9xk8MFBH
         RbNPl1SbKOH1fQ6h1RwnaQuXXJr+JC0/cAdajegSnYLY+PPDqr1dRZF0BF/Osj+nqxoA
         41WUoFsSoxf5g2B0OToVyJYWVUNO0fBaWC+tFdF9w4/r3VhnmHrHggl5x+OZFKYdJufx
         bRaZHYrMkr60WX5W9NDKAFiYemnfy9yRNiniDNfKFgOHLOQ+8fzGLcnA+yRS+iDf4w+9
         7Z3jOEEoA7ctiTSDJhySJIIazc2b60p/JaR8AzyxxwtPZ8+i3tL/nFmHozEKKvfc4+QJ
         IbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OHApVhRpgBms4jT3GrxYX42NYRA/ImfA8E/bLAmLCdA=;
        fh=suzuDxiY7DePxzl0M8MBHpR1YDo6f65QclHoeKRivbI=;
        b=P7I2c31VB87T16rFmnJb3Ry+1eB37UKWeXi3nO8HJbaIRJXJ2x75wkvmdqw5mlD2d7
         jL6EnKpuyHtLqEn5cJ5yTEWbjFRB+QB9UNj8rUYnTGgQTTO37a+jmPtyvpsFB7AYq0Nz
         BTBaXPj5lAVpwbrNg96pjDVgWDFFMUTsO0De+D1v1UMXVLKwrxcqjizSpX04QAr5HVnQ
         Xweo3kkrv+McUUzftfIDi60xUTr+HAHGrIqqcfb+Y6t8Yl3FH4Vl871Prlva2aqUmlpc
         OL6WbE9VtrXLujK1jzQGDT3FQPnZQtrU0iTAKOcGLP5eSw9LTKbh9Z8kUn1BtGZoWwKo
         DYsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772963873; x=1773568673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OHApVhRpgBms4jT3GrxYX42NYRA/ImfA8E/bLAmLCdA=;
        b=I3mH0jGbfVxAC5ija3qnNC1obYnvb68Zo4dBnEQyZr42ZqmpC4rOZ46jGG0YP7yw6S
         NWfXm5ORD/E7FPJsKXixxVEwf3A2j6XNB2mWiksDgtTsb22UcVNNr9IBoDc/ewzmLr0N
         6IRcB29zrYv2URQuvBG4kG3+8VNjuFQ5dHcLBD8RQq7nkdGB8It3a5oTHH62g3+7GBNQ
         WXPuSRR/6B1rj1Jpd6okLLLbILJUjnsyt84yM4EOT1Cbt+oqhb6XIEISNdGg0oXS4+am
         SjFbkdKeff1iWNpvyWE3N/rREloeytlbCa7+OMbLmzTcBFOpPCN3l2oZ2XvgVcJAhm/H
         5vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772963873; x=1773568673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHApVhRpgBms4jT3GrxYX42NYRA/ImfA8E/bLAmLCdA=;
        b=lC0LmH4BcEI9MrC1z6cnCC9Saz7zm86F+txtGrmEG0aMIKoEZ1dytJ9c482qoclaJ5
         9Ei/bc6xiuD9Gj5CNaah94dL/PxvGyGEySZjI7Ool3oj+CgHMsNjjfqUwKJw7hfWXxjA
         nMQAUrPrx02/uBvvHsaGdUehEFVuzESD+qgKjKwsBWylg16nDhn/kiyhp4GA5lsxw7S0
         cNY2zosCQJ2is+UQZYoRYi3bT6pQoszQYW1Tn3VHJGo+Z5QjSiIFK0genPS7vVTYfj5x
         XN0DBeBY2/Ud1rbbBnIZgURU/RxQR1T6NCyAVjycs2UbMPvDI/x1N//SzpOAb/peirXP
         ODKw==
X-Gm-Message-State: AOJu0Yzce7a6ev1eKZPpjtNQVEmWb2FugLCBAP3iJRmvLFs1vz9aCEfg
	I/OtsmJpLvLs225geUpPErZMBxW5IUS4hY0+loa6HLw+9qyH2pqopyz6ZF2YSgRmsDHYyFahoiV
	cgTUb/YJfW2vN0sZAjznk/IyLRY3JeFa5EsMhaBkiyndJ
X-Gm-Gg: ATEYQzzOz7Ap1ksqfver4SwLuzcl3qFMmoumNKDcfiO1g48hPqC2hgJPHtvg6eoMv4f
	hIo0dXbRYU264+Iv2PltpfH63YRBotZffWIGPRAPqqL91cJHEh4c7t8/VnaW9f2q6uvm60ygmX7
	AACQI6HpsUEpqXAC9AEVkjy2VrWZmIs94bZnvxj5PJ/9WvW4pdlRoV/LtLodpuywn70f4e8Tf2h
	2OOHUuEXbJr6YkETuADWVehrnN/IJaa8d6KwI1MdLcOYSDdXxAX70Krj5x6L8Y96jbA+tHJ2xCV
	h2PZqTcN
X-Received: by 2002:a05:690c:60c1:b0:798:1219:c780 with SMTP id
 00721157ae682-798dd67d2e0mr71860667b3.26.1772963873226; Sun, 08 Mar 2026
 01:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+tjKGrmADg=oG9CT74_mgGNN3h17=LLmnv51K=MggAqo7q2Eg@mail.gmail.com>
 <2026030839-applied-prominent-b774@gregkh>
In-Reply-To: <2026030839-applied-prominent-b774@gregkh>
From: hgfdgjn <shichuanyim@gmail.com>
Date: Sun, 8 Mar 2026 17:56:44 +0800
X-Gm-Features: AaiRm51SQeSnd_04IO3aC60QnGAmb4XpulyijeEO_HuTpW5Xx2vxx8EEQKdyFwk
Message-ID: <CA+tjKGoWW70TRw6C+PMDbhpCh5P_jyJ9ciY3HckJystb+X26Mw@mail.gmail.com>
Subject: Re: [BUG] HDMI monitor shows no signal when the refresh rate is
 higher than the default 60Hz
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, rvojvodi@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7F6F122F42A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223449-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.886];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shichuanyim@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

7.0-rc2 can also reproduce it; after locating the issue, it was
reproduced using the stable upstream master branch.


>
> On Sun, Mar 08, 2026 at 05:42:39PM +0800, hgfdgjn wrote:
> > Hi maintainers:
> >
> >   After updating to v6.19.6 on Arch Linux, if I set the refresh rate
> > higher than 60Hz, the monitor displays "No Signal".
> > I tried bisecting and found:
> > > # first bad commit: [3471b9a31ce352ffb343cf02a991261880aac3a7] drm/amd/display: Rework HDMI data channel reads
> >
> > This issue on my machine was caused by this change:
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
> > b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
> > index 267180e7bc48..5d2bcce2f669 100644
> > --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
> > @@ -549,7 +549,8 @@ void write_scdc_data(struct ddc_service *ddc_service,
> >      /*Lower than 340 Scramble bit from SCDC caps*/
> >
> >      if (ddc_service->link->local_sink &&
> > -        ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite)
> > +        (ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite
> > ||
> > +        !ddc_service->link->local_sink->edid_caps.scdc_present))
> >          return;
> >
> >      link_query_ddc_data(ddc_service, slave_address, &offset,
> >
> >
> > It appears that scdc_present is always false on my device.
> > I reverted the change to write_scdc_data(), and the monitor works
> > normally at high refresh rates.
>
> Can you cc: the developers and maintainers of this change to let them
> know?  Otherwise they will not notice it.  Also, does 7.0-rc2 show this
> issue?
>
> thanks,
>
> greg k-h

