Return-Path: <stable+bounces-201118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 238EDCC02DD
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 00:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E23DE30115FF
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 23:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE54279DC2;
	Mon, 15 Dec 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUklajie"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565EE286D5C
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765841393; cv=none; b=kncUEXO6U393iQY9oPUzFzIYchURiUL0BvwxrJeuNmzVzLOLyzfHWGptTwv201ZOdnZIgkDgshjQfkz0MYbb0sEc+n6SnqsiKOXuH8ru+t5quCdF3YtyuSFG5on0bH6Ac+OHk+UZ0Bgco3AF7ChPqLLM41bpflkreTLcCwoLOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765841393; c=relaxed/simple;
	bh=XOoPPexklsz7SvupO8sfvwY9ZiR6aEvcYtpvbQTfdQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7VeVb5PdeSyaSX5za92t8FUKd/sVcTr2q8JbCd0RQfD49MaimJ2zAIopPg+IU9eZmhDnKK4mBsR76wwhVj/wtjFQoIWsaSuZxEfDlvtlAX0z3N7XulqZL+liWE54uZHlbUFVYiqk5nMcTQj0Q08bRcS3Y8yQ5z8s/h+wcQzjqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUklajie; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78c5b5c1eccso54096857b3.1
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 15:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765841391; x=1766446191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOoPPexklsz7SvupO8sfvwY9ZiR6aEvcYtpvbQTfdQY=;
        b=eUklajietZuZppPAGM2ri9GnM0Sy/7Zm5ZtoA6Abd/OUPyvJ5zztm66iVEaBklhEka
         NG7lQSI5j6oVsiWg9r8IQkVAo9Ec6SEHHXEVjzFyVhMCmWZ+5JbTuzONcefRqXol7YIo
         jgc5dxCwiIGtkW0juQ8joSwbkAq1/jHdd3DTAvmesnK9bpVX8A6qdWuEbfkJLkYBkPEM
         y8BryzYTJyB1FZHJ6E5KtaBYvkrqBg9yWyADHWh/UTHAxz2jrkzZ14A+Ra167/qV9TBq
         KBYXuhZpUpqi7B/c/9pig0zpFxS5KlM0VcA/MTjvFKDo9SMGEPBJjA5zRZfVfNOeBx+X
         EF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765841391; x=1766446191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XOoPPexklsz7SvupO8sfvwY9ZiR6aEvcYtpvbQTfdQY=;
        b=pID4xewVsOpRXlLUGwl2mE71rgsQznXgaFvwgKS6iOBEQc/oIXKYo2nY75UX9d4nxP
         6bD2j0yqfo4FGwBiKS1yfzpO3O/6IM9IfwSqdRW97gjxOWyEvZkBk9bejqAZriG+GEQF
         b5XgW6Bv3IFdOLbxD1mN3TgUAgygOwCB6F6M8ZZGGBrw6xNamCjUSyEfIAuJsAYKtzEu
         TDvm/E9MVMb25KAYbO3M8t4QV5zWvuNBCVxLjilw9/+xuG1Syc2eHHbEtiCFinVyLUkf
         N84WFnsiOZUIzVl7BMcgZgR/64cM8w2/GYt8YYSOGy3h6qDjs9vd0i78Lr/FOoY8J+UR
         scmg==
X-Forwarded-Encrypted: i=1; AJvYcCU+cQFFR3d4Y0c1nMH9h/yzuFIs5EiXrCyyO/VlrelcCraT9L8FXAuUhGnbagmc+N9wRxWChZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt23Ix7wUHzZiJCXGYra0u+KdmRsAWY4msivnkd11N99L/TJRO
	prc1gOF0QDfs2Kg2/IDyy2x50yUodUvhzpTdRYw+hIY500Xi+hi2pMWYwW+ZjqKsgeFskFQamky
	CQJ6oof/uoHooevggMEcW4xd6i5d0JhE=
X-Gm-Gg: AY/fxX7vbFbgoheiA5Rmp8dNfDjiXkicwG803buVEDngf6T2fP3kyfEx0P9gtNi5yCy
	NK/hcAm52AplWqU7W5H9UPPASnu6S10mJPOPAPywVs36Mrd4NimsHhmXuEHVBxdiB/TQ8eCEafw
	uHTGSARnjLm62U2lIOfSeL0Tl3AtuWMBbAxEM0LfjsRfF+6W6IdufKnVWxshwcyhuB6IXSZGf9H
	Zdc6ARyOkS/mN5GBv5qAdITslWcRki2vSO1JQR3+DVzndhZ1S+ArqyoxGtg2MO9vNqui8QJ
X-Google-Smtp-Source: AGHT+IFXQr+WLdQ1LBgwmIwfs8QhQuZ97Em1dNVvE3JkMPBG6CA9xvDlyU87aqQvCFKYiFCctQjC/F8Jd4LH9bQoF0w=
X-Received: by 2002:a05:690c:385:b0:78c:4f8:f4f3 with SMTP id
 00721157ae682-78d6dfdfd98mr135081087b3.32.1765841391153; Mon, 15 Dec 2025
 15:29:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215004145.2760442-1-sashal@kernel.org> <20251215004145.2760442-3-sashal@kernel.org>
In-Reply-To: <20251215004145.2760442-3-sashal@kernel.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 16 Dec 2025 02:29:14 +0300
X-Gm-Features: AQt7F2othRtJTu3qTB-suXBFqWXz6gMb9saSL-bJoPW27po55zjiWbgVkURPqXs
Message-ID: <CAPnZJGD0ifVdHTRcMzKBFX8UEf_me1KTrkbwezZrhzndcTx-3Q@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.18-6.17] ALSA: hda: intel-dsp-config: Prefer
 legacy driver as fallback
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com, 
	ranjani.sridharan@linux.intel.com, rf@opensource.cirrus.com, 
	bradynorander@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 3:41=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Takashi Iwai <tiwai@suse.de>
>
> [ Upstream commit 161a0c617ab172bbcda7ce61803addeb2124dbff ]
>
> When config table entries don't match with the device to be probed,
> currently we fall back to SND_INTEL_DSP_DRIVER_ANY, which means to
> allow any drivers to bind with it.
>
[...]
>
> Reported-by: Askar Safin <safinaskar@gmail.com>
> Closes: https://lore.kernel.org/all/20251014034156.4480-1-safinaskar@gmai=
l.com/
> Tested-by: Askar Safin <safinaskar@gmail.com>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Link: https://patch.msgid.link/20251210131553.184404-1-tiwai@suse.de
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Please, backport this to 82d9d54a6c0e .
82d9d54a6c0e is commit, which introduced "intel-dsp-config.c".

--=20
Askar Safin

