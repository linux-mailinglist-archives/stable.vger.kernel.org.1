Return-Path: <stable+bounces-192415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009E0C31BF1
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 16:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1963A886F
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58A3224244;
	Tue,  4 Nov 2025 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e9Ddh+tb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BFF1E515
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268450; cv=none; b=WgoeAcaD1JSfbmgVutWxnQ9DGRAp21UYWIxQVaxUVxq7J2K31acJEnvK86XmgK9klxGjfyJsh81ckMMquZuqxLEo7i5mbu1Is5KoBMAmKj52TKIni+Ly/SjV+/xriIMcnHT/m+7qiVUrjIJGZgZsaUlfg03AYTv+be4Vopdx3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268450; c=relaxed/simple;
	bh=eKDPwZQ/Fbb+gmQTh99oVMn5UPkffNUDx43TdAguj8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFV7ntjDVBmRqeiLCfan4Lfp7UnMHJp0xsvp74QjonlUW8MENDPuQu7YRbtLjMuDb1LlmtCRo05toksa5wcnBdOBcYKVQThxm5W1hac4M1VHGwQJ8opGCd3JG2dcuLXkpU/oMnzSx5caouZne3OnDmex8h0XNPIvWOmoSBD3kkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=e9Ddh+tb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7F6C4CEF7
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e9Ddh+tb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762268447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMhMo+FD0DPSdoRsPCCV4u9kNEQr9FX1sBqbPLxKSmw=;
	b=e9Ddh+tbPemMu4NFBccXkLnLDM3vJ4ese90fY0pNIcBBjgDo0Arpv+xbtlGeNVdh39Hhu7
	do3Ax6+TLlQSZ6xNCzguJ841TJ1h+VlVKHXv+8YGIzu/1xzMHhy6nzGENNvPAb83wLkq5x
	g9RHszjdyHjJ+tDfsZXoI9CtL41WoKU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fa57fea2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Tue, 4 Nov 2025 15:00:46 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3d2ea93836bso3202286fac.3
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 07:00:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWweFvZapTeFpq2DfOaLIghwE6B3J/UogHc7MVHvZ5JoaiYHALN5uayiFKdN5imse4OEZyc8mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybuyYbloQH+TfK6w91zsTq6OVTriYT1fMMff/LITItLyBbamAZ
	7Ipx6ol6W54NBzYiy92/Ltf26oIqUwL/DO4mZRwAVzrGP09YdvZ6YBL3N6145NkyGZ9cV/P3/pd
	sC3+c6wv+M77oqguBohb1hLMoCPCUNAk=
X-Google-Smtp-Source: AGHT+IHXS/SPuiVMTem3zW3lMfDHfTOu6xBk8bXomDTl8LZ2Y5WSDsvq0QVQ9T156CV0BIURiYsG8QmzmpZKLMW6ZMw=
X-Received: by 2002:a05:6870:c6a4:b0:3d1:8919:71f8 with SMTP id
 586e51a60fabf-3dace28f2bbmr7683653fac.48.1762268444983; Tue, 04 Nov 2025
 07:00:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPT9vUT7Hcrkh6_l@zx2c4.com> <176216536464.37138.975167391934381427@copycat>
 <20251103120319.GAaQiaB3PnMKXfCj3Z@fat_crate.local> <176221415302.318632.4870393502359325240@copycat>
 <20251104132118.GCaQn9zoT_sqwHeX-4@fat_crate.local> <CAHmME9o+cVsBzkVN9Gnhos+4hH7Y7N6Sfq9C5G=bkkz=jzRUUA@mail.gmail.com>
In-Reply-To: <CAHmME9o+cVsBzkVN9Gnhos+4hH7Y7N6Sfq9C5G=bkkz=jzRUUA@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 4 Nov 2025 16:00:33 +0100
X-Gmail-Original-Message-ID: <CAHmME9rRyBoqA8CnCBLFMioZjkPG0tai-y2g0OMRFrSMrLK52w@mail.gmail.com>
X-Gm-Features: AWmQ_bnIdZ7LrOKmoG9HwsEkExs0NstjDaUgbpjdU1BMe4dlJHZfzqS78EGxxT8
Message-ID: <CAHmME9rRyBoqA8CnCBLFMioZjkPG0tai-y2g0OMRFrSMrLK52w@mail.gmail.com>
Subject: Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an error.
To: Borislav Petkov <bp@alien8.de>
Cc: Christopher Snowhill <chris@kode54.net>, Gregory Price <gourry@gourry.net>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org, 
	mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com, 
	me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com, 
	darwi@linutronix.de, stable@vger.kernel.org, thiago.macieira@intel.com, 
	jonas@jkvinge.net
Content-Type: text/plain; charset="UTF-8"

The documentation really isn't helping things either.

https://doc.qt.io/qt-6/qrandomgenerator.html

From the intro: "QRandomGenerator::securelySeeded() can be used to
create a QRandomGenerator that is securely seeded with
QRandomGenerator::system(), meaning that the sequence of numbers it
generates cannot be easily predicted. Additionally,
QRandomGenerator::global() returns a global instance of
QRandomGenerator that Qt will ensure to be securely seeded." And then
later, reading about QRandomGenerator::global(), it starts by saying,
"Returns a pointer to a shared QRandomGenerator that was seeded using
securelySeeded()."

Sounds great, like we should just use QRandomGenerator::global() for
everything, right? Wrong. It turns out QRandomGenerator::system() is
the one that uses 1,2,3,4,5,(6godforbid) in my email above.
QRandomGenerator::global(), on the contrary uses
"std::mersenne_twister_engine<quint32,32,624,397,31,0x9908b0df,11,0xffffffff,7,0x9d2c5680,15,0xefc60000,18,1812433253>".

So then you keep reading the documentation and it mentions that
::system() is "to access the system's cryptographically-safe random
generator." So okay maybe if you're really up with the lingo, you'll
know to use that. But to your average reader, what's the difference
between "securely seeded" and "system's cryptographically-safe random
number generator"? And even to me, I was left wondering what exactly
was securely seeded before I looked at the source. For example,
OpenBSD's arc4random securely seeds a chacha20 instance in libc before
proceeding. That's a lot different from std::mersenne_twister_engine!

I was looking for uses of ::system() on my laptop so that I could
verify the behavior described in my last email dynamically, when I
came across this from my favorite music player (author CC'd):
https://github.com/strawberrymusicplayer/strawberry/blob/master/src/utilities/randutils.cpp#L50

QString CryptographicRandomString(const int len) {
  const QString
UseCharacters(u"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"_s);
  return GetRandomString(len, UseCharacters);
}
QString GetRandomString(const int len, const QString &UseCharacters) {
  QString randstr;
  for (int i = 0; i < len; ++i) {
    const qint64 index = QRandomGenerator::global()->bounded(0,
UseCharacters.length());

Using ::global() for something "cryptographic". I don't blame the
author at all! The documentation is confusing as can be.

And this is all on top of the fact that ::system() is pretty mucky, as
described in my last email.

Jason

