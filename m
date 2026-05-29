Return-Path: <stable+bounces-256734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EClAGOXnGWpDzwgAu9opvQ
	(envelope-from <stable+bounces-256734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:24:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28151607CEA
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEA52302E933
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8023ACF04;
	Fri, 29 May 2026 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIJs7jvy"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5F39B486
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082634; cv=pass; b=bGPdZUbY3O7UjOw/HHjSfEroi9bqBSs5pZprEA1V7g94Hvfy5PH4vC3salbu+kekJORAuqEPqHuGlKDVtvdfr1YqcpsopL087/VkI2PM9wjW8tfCqKvYlRhk0uOIRygbJ+52zpA9TGSXyMpSE+H1sKXYekEAv/KY6Cbt+Dwpbck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082634; c=relaxed/simple;
	bh=oxt8Q+W2WsDLa+wW/HdAmzz3vSh3SBOrxOS7ezVfgWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJVluJ1W9b1aZ5CNTqBu7egfnWKTr1vLba7C8EBGsbYqeaENxCN99qYYZRJy5O0gwEOc73mi7CqYP5JkMLOEmxLi0AimorLIG9dq7pqbqA5Qpjf7FlwH8loPEOkyZK80Sw1W98mMOJ7LzZ7M+KxubnAc3yoP2tselcZEbB2Qui8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIJs7jvy; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304d3d3d8f8so154972eec.2
        for <stable@vger.kernel.org>; Fri, 29 May 2026 12:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780082632; cv=none;
        d=google.com; s=arc-20240605;
        b=i/E7VoCi50vkC+fUJzfVu6WhCakhw1ywEFwcxsO+OqORcmT9PhhU7S+VqkkXth5Ae0
         ntKF3gaMDSX06dQBIWL/buiEk6GXpln2Hmw85s+I7lCKbJUdi/5msXbeAqEnN9pSUPxe
         hQfaXjiH6ARr+hRJuAFiwk9eHqBUazad6QX5omVyMIlHto+H0bqUubWy21CJfGk+/34Y
         URrTBB6UjhD8ksKxp0J0uecjARXzfeyhe75xmVet8GE71iIBSurTYaLeTcfDDRnCNsGw
         HfvtnkUgwtcGhay8wAfizcjxfb0yPM7hNFbZJ1ztrPAmIyRS1Ttg+qBjSLTMfp9jhi1t
         zKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oxt8Q+W2WsDLa+wW/HdAmzz3vSh3SBOrxOS7ezVfgWc=;
        fh=bmvvXzQkIgv4Bhhl9fIbUokZOmjaptuIw9tEx1JcupU=;
        b=ft8LSGYRsR22ksM//yfO+i+FhpVtu9O19UMHQJQtWMICjt5C8m1lANYzBagPQEPXmE
         YvNgpZ0cf+7wdk6jF8rAMZknsM5pTm0wvXjHx4Pw3Jo0voZcbs4J0mEFTgvRmY/mTH1W
         vtc9OBVg5X9BFeiNtkHTDpYVlryuyWIP85OVZzTs1F6ncN303HpBhN2xcHwqcO/43rqr
         j8sNlpg7QmHEDXpOW8rOefd/HkCHIztmiv13SjKlT63IEUTZtWAQwIJb4Lv8VNLYiMnx
         +e6lIwDCdlh+67PXEqPGWTg9V16v1dLEGOas7Roqp7lTaYFkt2euAUMABVx+Q5DGa+pa
         Aj6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780082632; x=1780687432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxt8Q+W2WsDLa+wW/HdAmzz3vSh3SBOrxOS7ezVfgWc=;
        b=bIJs7jvy+SITLkKWxoW4D21D9hM8WH+hckPKqsrZ55c0yida+monRy2Ep76d4QDHqU
         rnNu494o3ZGrb7IL034ZvKkFsv5lLzKmIo5GjMv/UVAEY6zgA12YDIDKpb15pClSWJHY
         km8jatztw/IRpancTaYcgpmVGVWtLH4cg5ZssN0zEESPusv37Mz6Xn68EirBKJKmQAsJ
         idTfZ7LwQ7eZSjZ+l2SPYZt+3p8yhvNaPEiaj789P3+zPGD+m4OTnrsrZDcNUZr7GO//
         0EBbfLukPtJ1TEZCJ5fIyAijGQZlgdCcMfpvsqaKf6U24KL2XesQ6tanxn3XsWIz7E+L
         5igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780082632; x=1780687432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oxt8Q+W2WsDLa+wW/HdAmzz3vSh3SBOrxOS7ezVfgWc=;
        b=LwfyL9C48WPyJEFoeer+6yTarIDLX3GXQpVFI+789mDo0eBnSnmbt9WAjDo/1T1RzQ
         +wcMuMf7f9EUHAI6m7M/yHvWj2V+uwG+ROximzGXdeFEheoTZBDaTtbWqvunhBaeZmgb
         xtL3xcfWLR+P1Nx55lM/4rLAtTMFz7DWP/nCqIci+ORRZ6VCMR/gqi/Ld5mh4MWsZlkC
         HSEfD/2ofKaOkIic3m8ZmkF4KcigwJd8ABTiWKAYyCZyvkCm7kOGTbdCKwhqisiAt727
         fftpQaeRN34J8SBeK8YD8jkI0EIEcP0i94DO0BFMl/VLCx+ZfpzUdMsadCKkYhKZU9kQ
         5eYg==
X-Forwarded-Encrypted: i=1; AFNElJ8uOWdxzuzBTpEP++fdg9uUxz/dBVwbRCQ6NMhc2xytPqARdSv4EXoURuScLA5roPA4WfqkM8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsacJQO/qv5Ul9ShUmLv/yIDrzMaFN/v9ZvHRHCCEprddan2Z1
	UIKPUo8+lXfsE4zkhutNdKoNlPOZaEJZKZwFwSuzC8LuBlEReFW4zBFbqdAadK95U5QmnnmgSwO
	CB/qRWaqGLE/52v2oIqFust/LeFUnRu0=
X-Gm-Gg: Acq92OEwohIwGqWg5rkJqh1xONnFb2x/S1yGsoKI09nTT9j8eT7UcQ5/IHFKZkn9qeJ
	25zR+3odn5STlNvwrLTGeVfjjS2AAGBivAKCWYmNZ9oH/m2VtP3u1alq70lnbCNL3ggDs/JYnoO
	axA0ycwnfRlyQXxsNtzAAR57lUxVromJk6xeBZ071qgspupSU/nNQTLu3EHn3ZEgzQLEO02wIES
	XGxRR15hBmadMoUXESqzKjYBuwatp29KRUXzxFLJ2flhL5MgQLV7tVqgi63C2vf0//rIx/dJTDg
	bcVnOkfZvxtFtOMnQX0DSZ/B5J+x0XaYdR/dQCs4pDhteqsvtATaTvIWYSLjCgkljut+lJjAiLs
	dX70o6J8AkF5dcU4hhHAv6/UK0VClusp9Ag==
X-Received: by 2002:a05:7300:fd02:b0:304:c73b:79ea with SMTP id
 5a478bee46e88-304fa65935fmr269421eec.3.1780082632355; Fri, 29 May 2026
 12:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528194646.819809818@linuxfoundation.org> <20260529054139.120182-1-ojeda@kernel.org>
 <20260529185046.rc-reply-001@kernel.org>
In-Reply-To: <20260529185046.rc-reply-001@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 May 2026 21:23:39 +0200
X-Gm-Features: AVHnY4JA7t_ZnbW45aaa6F6ZMDmDXu8KTbZJaiGNMmTmWANvKuJkOpXJv3srhGY
Message-ID: <CANiq72k=M7bvd0ne8thLQFOOYACM5dRoDdNkTbeyTXaeL7qndw@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, achill@achill.org, akpm@linux-foundation.org, 
	broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com, 
	hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org, 
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, 
	sr@sladewatkins.com, stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, Miguel Ojeda <ojeda@kernel.org>, 
	Daniel J Blueman <daniel@quora.org>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256734-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[linuxfoundation.org,achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,quora.org,oss.qualcomm.com,linux.dev,poorly.run,somainline.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 28151607CEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 9:17=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Thanks Miguel!

You're welcome, happy it helped! :)

> Right. Rather than dropping the deadlock fix, I'm queuing the upstream
> follow-up 53676e4d44d6 ("drm/msm: Restore second parameter name in purge(=
) and
> evict()" for both 7.0 and 6.18.

Sounds good, thanks.

Cheers,
Miguel

