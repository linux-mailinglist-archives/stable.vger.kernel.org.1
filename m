Return-Path: <stable+bounces-232796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCTVLNUszWn7aQYAu9opvQ
	(envelope-from <stable+bounces-232796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 16:33:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 743C437C351
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 16:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 186A03012CD4
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAB84657FA;
	Wed,  1 Apr 2026 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xofge9k9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734D44D685
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053506; cv=pass; b=YW9LZt+RUZyPB4fSkCitfgGglqeMoVHqJFqGmlA/MqeTAkSIRqOBM/lEEvXPllJ8v8uCpqTy9oh1PXQAMgklBx+UC8FfAhamR4+lr6KgQrDY7I2iLtKevULdEmdcOzNBgUy4ZL4QCb8vyw+neBcF5emy0edS/Kjo53E+wHuCXRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053506; c=relaxed/simple;
	bh=gSQ6pTcuTePG32M6XmGUQnNRHQHNKydM20nRxn05ChU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1NFZNpEAWBuM+l6KyOiBWvyMwNRlEvHs22r+WP1puVlErkjB7nxedBDp0mJG+KttgfdpEhFlntn6pDw7HcwKgCQ1dCQBbAfoFGg364+nILB9EuYpgiVsTmFvbDuW0iF2wKvnC+AXSUk4PstF6ALPyDGYBYUT4pFChOSZTz4z38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xofge9k9; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38be66a9fc0so72647441fa.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 07:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775053503; cv=none;
        d=google.com; s=arc-20240605;
        b=B+0twEmiY58nrKvRqGdreNlAEUdi5VzeTBm22keaMxQu8PugN6MOPO/8dIM496glDc
         +hbtxzq1Bt/x9uWmgs67xIjfp6H3UI3uSrpjdvUCycRixti5tq4Nsv/OccT/xJ01QO52
         ZSw5XJmlKGhpsoJ1INqVRR6GLgWqdRY8FpIPhxCeuYA3SKQNC+XH8lypEzroafS6nZqk
         N325lq+Jkxi3r3uBHNL1nbYKYK+OMd21QYAViTK1ZdKTG6NwdVCAId9uWwiFh9fMZq5G
         EAETHvLnu9KCrSadH9XCab2OYmV/fRgKVowRT4c7ISp2rEQnMiIaFaLksojVc8CnPA3m
         pG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gSQ6pTcuTePG32M6XmGUQnNRHQHNKydM20nRxn05ChU=;
        fh=dO/aBKFaiKrro274e2PQZDS4xyZoeit26Y6xjL/cY4s=;
        b=J3B6wmc9LqYRihh9ZGy9gBCns50EuzmVWezcgGkOD7+sGqNTfcvRl1Vj+t2RseU5B7
         3WphsY7rULbN9k3i8GwqNDRKJbrckmcR8/FmXtPwqs790pUNJxJDulUIhODbEALmN9KH
         fgNHghlktTAzjqPAk6E9lmoswM8Qqc5kHZoEkEbG0Iflgjbd4ntqbJlwwNZ6+pehxHMC
         Ik2q92LMmlvfcXoak9sh8PozuZuQO8wVeVsawhEZ3iKQO5cXvIsmefBKNPTlwbqebLBH
         3THLRXk2R3XKGxvZLu+GY34OlWiqi+f50r8PFLS6DhE5iw6OfYYhb46QcmNfGE6RMOdH
         7DkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775053503; x=1775658303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSQ6pTcuTePG32M6XmGUQnNRHQHNKydM20nRxn05ChU=;
        b=Xofge9k9RYYO7Of36FF8GfpDt/uyrCaYs6FmX3T1kxcsdFBwnS0Nvh1zd4qbrMZkL+
         nmGPgtAtkthl3E0uPCSKWS1WURe09D0MFkwuMR4j7Wk/bly20CifWMMa+VL1PntyQKPc
         1utfxSWMuh7ZUar3Z7OOcjQ1XQIVEIi2utvg8yaLKyjTyAO1veoYw1s53/bsGH56nVdp
         PR/2H3Ky7FsukRQa2DsIOcWSFxaClCCy8LhU1jf4fQNe6ZCDD2l+yQUjhFMihJbD+dPc
         UH/nbZ2bbGprgFui6fOXv+db6YTr2GzAszapfqPOluJIFA1G4sJMeAUy1Ua5YSG1AfoU
         iV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053503; x=1775658303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gSQ6pTcuTePG32M6XmGUQnNRHQHNKydM20nRxn05ChU=;
        b=J2sTkitGgrB0dzusJhO3hovjbUb0Es9OklBqjg0XXYIX/9+uWUQFsKsTi9NQFccVTt
         rtktG5jWH/M5QENZWuJrIn9CSbHdUBgA0KSGsexSpZd/ppkILixFfUiWQ5t1nbXMNnq6
         /6vTov7lzZ0JELxrJuXm+ONJXInKGEQM37e73cytuLrQ+/VWGnMRzlqeL9NFVWIhNpos
         hehtvVUhzVb4ULg40gtlZL1s5wZ/odbxS5+/QByzi/N5NprmmLNWMHdb6rPkQ9G+JkmV
         5VuaMMeQIMtVyjEYh73DUUQdYIVoR92VN6cY3Rn9Ib9cDfH82L4nkjDSDCAO/BgjtgpK
         GJYg==
X-Forwarded-Encrypted: i=1; AJvYcCXB9gNCWWDMfkqTQCLObEkSXIfzFeKeef00Mq74ZcMuT8vdkMXzXobF6w2BHqgPj342dBe3NaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIxsRLkGJ6RuPcrla2uvT3RMVbSOLokrG1XWit1TdbjFjhBKi
	EdrlWdblwb0yBZed5LKML3jCkZIq/OSP7dZFAq9XT6AjuF0lieGV+JeCdr4hWrQEx/6aJsrjWmR
	fPjs/HpJLU2QY52jnLpucFM2cLuSGs5Y=
X-Gm-Gg: ATEYQzyinE9cG0xKcHA+sDZTwFWgvV7Zkpcx6tR89O0SJsVsNGc1VQO6cSfiAzArwSJ
	smPMHJnYiu4Ks3+1IdDtwMGBw+NFbhXn+uQ3lt7tDeSFJ1d4stkExS7MIBwiBJWbmohD+H65U2D
	lb0H6n3Dc8C6FoUWrJQ8huiQq8ns64q0MAVHlTtLKgcBJQ12XeeaWkxc/P7WQo62qPrp+F58Gsr
	4rNC9p45WuObQxesd/+JwgVStw02D3Ng2OOZ9v9O3zrPEm5Oy2bVCt5RD7FE4oXcqVbCUBgd4rC
	1C/+/PY+vppuxVhIwLenyHo80uZ1anz7M8PBmUIXf6djm7Dh1lrL5uqRMITl4sd/kixx/8ZSHNP
	oaeAzwwQ=
X-Received: by 2002:a2e:a554:0:b0:38c:3e3:953a with SMTP id
 38308e7fff4ca-38cc30fed48mr13856341fa.29.1775053502521; Wed, 01 Apr 2026
 07:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
 <20260307124118.1d527749@jic23-huawei> <1166aeef-0c93-408d-b265-9037f2840074@amd.com>
 <IA1PR12MB7736AE6EEE95D5D184A15B9F9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
 <IA1PR12MB77361978ED21FF22F079034D9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
 <IA1PR12MB77369F79026F7BCB1D9C64999F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB77369F79026F7BCB1D9C64999F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 1 Apr 2026 17:24:24 +0300
X-Gm-Features: AQROBzBoZ-LI1caYHqTvdlVWNWIbminA0-gaXJPHQ8leXNSCDNAFQN7WnRQJ33Y
Message-ID: <CAHp75Vcg1u86z_TWwz+1Gk9QQ9RB63QmNcqpkGa5HQHZhSE=5Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
To: "Erim, Salih" <Salih.Erim@amd.com>
Cc: "Simek, Michal" <michal.simek@amd.com>, Jonathan Cameron <jic23@kernel.org>, 
	Christofer Jonason <christofer.jonason@guidelinegeo.com>, 
	"O'Griofa, Conall" <conall.ogriofa@amd.com>, "lars@metafoo.de" <lars@metafoo.de>, 
	"dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>, 
	"andy@kernel.org" <andy@kernel.org>, 
	"victor.jonsson@guidelinegeo.com" <victor.jonsson@guidelinegeo.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232796-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andyshevchenko@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 743C437C351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 4:58=E2=80=AFPM Erim, Salih <Salih.Erim@amd.com> wro=
te:
> > -----Original Message-----
> > From: Erim, Salih <Salih.Erim@amd.com>
> > Sent: Wednesday, April 1, 2026 2:13 PM


> > Caution: This message originated from an External Source. Use proper ca=
ution
> > when opening attachments, clicking links, or responding.
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
>
> I am deeply sorry about these markings. Please try to ignore them, and I =
will do my best to escape from them.

Maybe, but ignoring them might be subject to law enforcement or other
legal actions. You must get rid of them for your OSS contributions.

--=20
With Best Regards,
Andy Shevchenko

