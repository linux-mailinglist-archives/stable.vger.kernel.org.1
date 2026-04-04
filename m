Return-Path: <stable+bounces-233291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP5cOgMw0WlaGQcAu9opvQ
	(envelope-from <stable+bounces-233291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 17:36:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763239BA2B
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 17:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3425300B9D2
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F072ED15D;
	Sat,  4 Apr 2026 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="T2mdnljE"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58FE2BE7AC
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775316993; cv=pass; b=TleeutNsJOFW2Ug/LTUDc4peI12GRtVtfuKbeybZIMm9Vo7DIXwYylK3m4xv8USqm6su+ka2Hzk4rOn0c/7/X2b2T02cxgQUBoUm6n0wRCHXwMG8oxpZMTgc/akEJ+SjZhtvkdGaphr6VFdwtSde8OfiyYgwh/b3Zik2tGcxFzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775316993; c=relaxed/simple;
	bh=Pg5SggtwfN6uXyQWlws7Hd6R8St/1Fbi7PcwL9rd5mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFiZYSgwfA9arqyraeC6G78LlEx2RyN0/TgiSfrswxcsNrCmIon15w2u0MmoDrehJ3u4/c/Ljgw2aWQ3pFGEJtUc635Bczojt1v95WYAlbmBf0zM+sxMF9Ch9CY3tcsH8F2sEtZhY3+sR/fJGuPoAcbEBZVWLnamxA8fwopGAFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=T2mdnljE; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a58057d7baso42388466d6.1
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 08:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775316990; cv=none;
        d=google.com; s=arc-20240605;
        b=HJsqhABoHh5sra8sPxqgMtxYVmtYqjR0mPd/NNLyNl9fYgNfOKocqPBynOyay7+73Z
         XSvrtCgnWsYskbphNepr+SlZtrDhi/Y/M7ZAQKcmEMLH2a0HwuO1UtZbp9FgcJbEGhwB
         VKAsVN4gj5ZyHNiGBHYD4t8ZbmjzW4ZENKDiAxbzpK+DBqarNGj9nRzb638xTIrit1bN
         UfuIqUmFLKbMnkANfxgwl4I75DBCP6/oSKd3Y7ANtBAg01xb1TkZqM4evVwBYTQk9mk2
         7Q4hQmORdZFHDrK0zVVyR/2WKMXBvhosvkohS8zOwIIMhThpQHe46b3KcCS+jEwD23b9
         tOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KzuoZ8HM/SoNsGUQB/5mgoUVmdECVRtOWQ+lUdLTJ90=;
        fh=P4PoptAtOne2UUJUKc2V7mAPJr0YKZKjetVqj0oF+DA=;
        b=edDstM8hRkNBtrNCaITFlbGAqu1fEV47IA2dw/p5yOk1Yal7RwY1+qbBDUWCw4dYGI
         AvUFhm4VywTaRAm7EMRNFutTLfLusEGKotT3WB3IWeLpPHNhVpGb9D+A9If99VGdC2mX
         TX3pReVm6G2K9uCXE16QPFhopjo00gG/1jbwi1UR82v/dQtUi0GgfbIip0wDZ81t6CQR
         WFKI/CG5ztCYOKgr3mrdBbMY2J3RTW8XV8G5nP4vpMV7/9yIVVAIpuDCTPVkFT65/Efh
         5GZw+Y2M25t/yDQC0QIbqmeNWJ4a3Ed5qZmqyUXfCRuo6bDnYhBOyxGMnXHJ4g01t3bA
         40hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1775316990; x=1775921790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzuoZ8HM/SoNsGUQB/5mgoUVmdECVRtOWQ+lUdLTJ90=;
        b=T2mdnljE9od9VH5IZmitF1YW5qTCa641r+DujKHL8a24LjPSA7GV04zu5YVXp/rrTc
         vcHvKTjBXLoIq0fk/cqTCWaA5B29xhWSqaBmxDXcunnc6t2MSNsHHyblHVFMfgIExKtk
         lxfNeE1a69fNSzG8i9YIIUyWib2f1OWjPuO56c1XoyRIRgRFOCP1Aac6SlW9YcBQVzNw
         WAj0xPtnRnGsitaEsjm/3voP7oCE4t7vkNalPAt6VLtbIbPd7rFNXaJBJ5T4jsNZpG/b
         UVpHwKD6EC4lSXmdzjHoySrfeZk0mJO97UIE9JHaleoJKMWn5G2p7f/GtJr3WPFmcdxu
         /AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775316990; x=1775921790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KzuoZ8HM/SoNsGUQB/5mgoUVmdECVRtOWQ+lUdLTJ90=;
        b=DGdCOPSZTcqb/4hQRHrDdCwmxVYEA3xlblHNPWrfhFFjjqkbq5T9S7UJ5kwkwRA8Qd
         +4T+BQ0Sz3C2X0G0wsyNKZ4U6/f3l5sVta5uqnU87MmFTIvOsWrDc4Xabui4JeHro7Ea
         fQKLoBSI0ITcDL24xlz86fZWCvxhyUsriVsOGSzWPHlI5Ao73CXM9JIffk+LN2pAzBUx
         imcBtlcXg/DtBD9Y6HjMW8fgnBZXNhmqTcViKoSO3g4hXkTgDS8pwGEXATbhwCqueeKf
         EHHpQqzUZ0zZe49ikXCekR8hzW3Uy08OAnOcoW1fGlbGEoteGndUuu4nstdKgiCXw8oO
         zhpA==
X-Gm-Message-State: AOJu0Yy+6yZFW3H/CEikpd/fdj6ySemj/1+su6wo1qVaQsNI1idAT9gm
	NMtnOY6POx6nJ+Lp8XjJr5FBmCgld72RgJPmOWkR2+wXctjcXNLZ2m41lRXYhyDnMNJItuTy14E
	HQRZ4qnhbIgBFa5Y09EXErbPSsaWG9N0HNEVldSoAPzaba8R7KQ16xp4Gfg==
X-Gm-Gg: AeBDiessjeclQ/4bPWRmRJHHM2UcRafMsU+YKi+nqj+8Tyx6HwwY5ZlLmvBi3ZkvcFU
	ZYOYedaexq3ve/34MFHyDQ34u5UzPgs4E5C/MM7Goup3m6P5bxSSpfqphIEV0Hu+/OxdoIbxkxW
	N6PLgE1AHm/L8F3VPZqtBVDeY3cOl8tLlKQmAxKOmmnS2h7Kjwa8kKuayFYiOWEczuhBOc3mT5J
	FQ5FgCnZE0uaTyb5MiyR6Wbn5hbcYbBqs+BtJogQCTxoxQ0cPbw+guZTFfmH1B1jWeWQA6p9Weq
	iUNSA3WuGEvw92OJ1GWRFKPmoYdZDIoUD2/pL1M4PxyLd15oeRNscTvB+cwNMz0Q
X-Received: by 2002:ad4:5d41:0:b0:89c:c3ac:e5c1 with SMTP id
 6a1803df08f44-8a7020bcf0fmr120090216d6.4.1775316990654; Sat, 04 Apr 2026
 08:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOBMUvhG4DQDiEarc_P132=a+zGN4hySrNPYigUf6qC2Kh9iqg@mail.gmail.com>
 <2026040448-prideful-feast-eae5@gregkh>
In-Reply-To: <2026040448-prideful-feast-eae5@gregkh>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Sat, 4 Apr 2026 11:36:19 -0400
X-Gm-Features: AQROBzBhyUeac_Xb9DU5_sJbHRmCzZ5M8HHIdsy8EcHMk5yzOGBF0RMM2Av5jn4
Message-ID: <CAOBMUvijA=zGwbnt4KONVTfXPDgiYWo3T4ZajwTKp=g2BuaQfw@mail.gmail.com>
Subject: Re: Backport request for fda024fb64769e9d6b3916d013c78d6b189129f8 to stable/6.18.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ciq.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ciq.com:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233291-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ciq.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmastbergen@ciq.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ciq.com:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 4763239BA2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 4, 2026 at 2:24=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Apr 03, 2026 at 04:30:35PM -0400, Brett Mastbergen wrote:
> > Please consider applying the following mainline commit to the 6.18.y
> > stable tree:
> >
> >  commit fda024fb64769e9d6b3916d013c78d6b189129f8
> >  kallsyms: clean up modname and modbuildid initialization in
> > kallsyms_lookup_buildid()
> >
> > The patch applies cleanly to 6.18.21
>
> What about 6.19.y?  You also need/want it there too, right?

Yes please!  I was able to trigger the same panic with aarch64 running
6.19.11-rc1.
fda024fb6476 applies cleanly and gets rid of the panic there too.

Thanks!
Brett

