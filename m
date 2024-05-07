Return-Path: <stable+bounces-43185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317558BE572
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 16:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F0B1C23C26
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9D516C87C;
	Tue,  7 May 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qqcv7LlC"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066C16D303
	for <stable@vger.kernel.org>; Tue,  7 May 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091189; cv=none; b=IjwtM2WhB7MyFfSJ/Cx7ZXLR/eXcyjFbypZFX8huJnBcXBOYpezn1muWSLTCRWpCa7Un9oZTLZwULTxevYHNRd5gHx+PW1gOnZ+Kw/sCWPgyywaEEuyi0J5Mwh24Dl7oosMOA27EwNKaDKT2I4LL/rRNO9CmZmLVlbPZ0wSorfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091189; c=relaxed/simple;
	bh=zchA9qCZkbTbiKP4dWASuNmwzS8UpJKwMcrmBhDATqo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RNznPScndlLgh6q8Kl//W4JOvRg++67BLfOPopY+g6neOnpfRnweTk81+mh3DI/jPZnkSjNF9J60sAlKYMXBBnFDJeFXGSJX/YKxXZdSQRdfKv4m7dpjCbZOqVbZTB4dtXncrNBc7h70rOv+6fgs+ouMcWUdcNSSVZsTlFAynww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qqcv7LlC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so70114507b3.0
        for <stable@vger.kernel.org>; Tue, 07 May 2024 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715091173; x=1715695973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WETraqwVUAnZYIOXp5ZtLEEE1VYRO8MGNkm01fdovIk=;
        b=Qqcv7LlCIOJvBe8ClD5U2l4Vj91uUJ1zIUjEjaKr6vohBi/GFK/kCBkhW9qZZdGHpC
         nxwyf2tAeD9my0a/qM1hJuFLQ5WLbt9BIL0qxKTsdW5atZMtIoDfpEumiMKhONL+q6GC
         72o1+zEuLefO3WFSRbvMdj98ysyUkJMpfe7bhvl6A005A3nsrGayxqodnVvhsMT20pAt
         yNYTWrA21yYGzTAFWGKYYldNzy6HfLhHLr9P8AMYSNlf/aDrueIH/wUsf3uXieIgzDX+
         O5JA/bxh+xBYg6hbKTMR+zx9CtluRtqSpv7bEPdFtCNAqD41I+kZK/yYDSFaH5tcnybA
         cKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091173; x=1715695973;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WETraqwVUAnZYIOXp5ZtLEEE1VYRO8MGNkm01fdovIk=;
        b=UDVxYr9QofxgkB12hkVgnEKP5jHnSlrTpVAlizKV3/K5OliAfWQbuLoJAlOHSMp18m
         h+3pWVTz8F1fpKRuzoL2lR6PL15MTgVTy19y24Ts3wFSKQHRDZb8PkGuGlGJhais+vKC
         tJLKxjSHtT3WyXfMtNvE3Fs/C0P+2LY4oLxnIWXM1nKae56rkqsSCZL6Ti5MZLYxuufD
         9Xl7romT3gKIIoa2FII/RHaN4X9HXkQbd0areTFVjKARDC00AYvHIZRXlsOdRwxjQKB2
         FTlQu2GBj6eICwNuFAn0SiJSC6/7e9v/Lh6mHAAtOFRxnQnt0JtwTsjnvF0VBmkQFOqM
         foyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw1cH1RHMrL8KnoxHZv1zDcgmmIFyX/zPsZynz7JRitrdrB0627PZsnaEDbIEBLs/lhDSrAPAWSLMVF9N3p8ls0lt2WqMv
X-Gm-Message-State: AOJu0Yza+hOVNiCrvqal1mbsDVRX4IJNiq4J58ftafncZGeBzmXJVqb1
	aRDQjv9zmFufUgYqk8aHPm6iCHHtTkXBIB4/ie9dRdZUHJjSJFPaGz7whjtZ1sGtFwzeIlmtF64
	nEQ==
X-Google-Smtp-Source: AGHT+IGplKwNSTSkBTAvhdXpqfJnr+yrgmgSEfcIAM5opFxBtA3BpCgSqdbY3obOQsQH1wjTlAweJ+rLPgI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:69cc:0:b0:de5:5225:c3a4 with SMTP id
 e195-20020a2569cc000000b00de55225c3a4mr3998230ybc.7.1715091172929; Tue, 07
 May 2024 07:12:52 -0700 (PDT)
Date: Tue, 7 May 2024 07:12:51 -0700
In-Reply-To: <202405061002.01D399877A@keescook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506165518.474504-1-mic@digikod.net> <202405061002.01D399877A@keescook>
Message-ID: <Zjo1xyhjmehsRhZ2@google.com>
Subject: Re: [PATCH v6 00/10] Fix Kselftest's vfork() side effects
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Shengyu Li <shengyu.li.evgeny@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	"=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, Jon Hunter <jonathanh@nvidia.com>, Ron Economos <re@w6rz.net>, 
	Ronald Warsow <rwarsow@gmx.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Will Drewry <wad@chromium.org>, 
	kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024, Kees Cook wrote:
> On Mon, May 06, 2024 at 06:55:08PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > Shuah, I think this should be in -next really soon to make sure
> > everything works fine for the v6.9 release, which is not currently the
> > case.  I cannot test against all kselftests though.  I would prefer to
> > let you handle this, but I guess you're not able to do so and I'll push
> > it on my branch without reply from you.  Even if I push it on my branch=
,
> > please push it on yours too as soon as you see this and I'll remove it
> > from mine.
>=20
> Yes, please. Getting this into v6.9 is preferred,

Very strongly prefered for KVM selftests.  The negative impact on KVM isn't=
 that
the bugs cause failures, it's that they cause false passes, which is far wo=
rse
(and why the bugs went unnoticed for most of the cycle).

