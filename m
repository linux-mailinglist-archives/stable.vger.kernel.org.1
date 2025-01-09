Return-Path: <stable+bounces-108084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7203A074C5
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A467A3181
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C34216E05;
	Thu,  9 Jan 2025 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="m1C9ZDLM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F787215180
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422395; cv=none; b=hVbMseh7KZb5OihUMe/hb0KbB9e26Bm8zxh9a700pAUjtT6gqzrqwgsOSSRCevwRMb6Zw9rWW/jlR562iVgwVO2mHnnEWLlPAKCO3eH2bOSbHtbzLxAreLoEABFEvBehLtY/I4wh7IcQKMi8ZpkLNXpQw93nomxtGkqhBRiLi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422395; c=relaxed/simple;
	bh=4DhZ7h+hC/wW/6sKaxaXfjhYlhEkQwNVKexSkchilg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0qbqQLN2lCSKi9pid/2l2MQ4hYqX6f/vVTIOShc9rOeOLu5CmtYqWu24UNWYVY+h/UDyGI9zVKWgNcInJMLVZ/8dduVd2BnLRCix+yFR/lE47hibuoWdzZL/mjMmLC/Bk5/LjAjxo9lvG2cL5aXrnIi82h5efIgAgGcfircxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=m1C9ZDLM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a37a2a53so7832041cf.2
        for <stable@vger.kernel.org>; Thu, 09 Jan 2025 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736422391; x=1737027191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WNvfIFwlqP4QKBZDPopcva26qRyXQCS+MMSSoxP4bMA=;
        b=m1C9ZDLMUIb8thLAPVkZpyIIzUkGpIRedwqoAbL8gy+YNpsIiZ6HZuZsf5n1cHVk2/
         QT2egSaB6+TjEKoTyW2ufCYR0iPRt78Tk4eVkWNx6P56ph2mBRyRzQrYexxZrdeQ+JYj
         67/7b+TtJGy/RjU80eRSPayNDA275vukivfUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736422391; x=1737027191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNvfIFwlqP4QKBZDPopcva26qRyXQCS+MMSSoxP4bMA=;
        b=rOFZtlNogg5Gb3Iu7Lp+ie4whvBahYzpuKL1bbqxqclU37/cUYwLrXymOa8hpvBWMD
         MguKMuoSdzHwo22JjeCeB31ILScDCr1U+OQXfOvA5PZoQ8EgmiI0tDfx7v1fNgNd4gVd
         zm6Mpjip3Bi40+elOfBNeBhK3SSXUC5mfaWmIIBKH982m2Ldeni+4txaSUkE+9FvUBDA
         eXPOiqZBI2e+I6ITU0N3r+LwKt4TeEvGqWXms1YwuFCgTRcxUXFCOmiL8gO7QgDdFQcC
         PBajQb1OLAsAlSDiO+ws3LcC2HFNC/kaGAxMWdkEOqqP6r0ZVvwjY8zJfNg6MufKt4MS
         wE0A==
X-Forwarded-Encrypted: i=1; AJvYcCVZjFOdKZzuPiyKHd2YlkLQlVoC5IrcSbDJhC5UYjYEmSUQUnZ68zUCcmeMHoWHGoSpG1y21qM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztg6PIQ2AAoVnkBjoZlfSAHglRX1bgmXM8pV+oSoHPt4Sz/D4p
	3qrzeDok8J3b6QHGUdrmbzz3t5z3SQxAdTTZMlaqV5lbyGgay9i2iPmOAsB/cZEOPI66lWtAfIc
	QFvv37cvYUfQ3ARzS2ULSAKyJsFeJ8dd4OQQ+fg==
X-Gm-Gg: ASbGnct6tgN4VizJcPgt1t+gLpjAqRfxly8uWP64t/gVjRPj1/cA3Zr4PeWT8M2GlcA
	InyajAq5u3aYfaKPyVfYiQtzVi3VaxYKQvYrFbw==
X-Google-Smtp-Source: AGHT+IFwF+BHLu4NVU2ZonM0UoppSCIW2Fzyjm5SsBV4QT8oZYr6lhlTVclwDivrwtcyfckItJp3sye8V8YUGJ57Tio=
X-Received: by 2002:ac8:584e:0:b0:467:7295:b75f with SMTP id
 d75a77b69052e-46c71083e8amr105665531cf.38.1736422391181; Thu, 09 Jan 2025
 03:33:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003d5bc30617238b6d@google.com> <677ee31c.050a0220.25a300.01a2.GAE@google.com>
In-Reply-To: <677ee31c.050a0220.25a300.01a2.GAE@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 Jan 2025 12:33:00 +0100
X-Gm-Features: AbW1kvZzJ5lz6Eb3KKrjH-1AAR6UFCjTUY-4txNP5rEFXavvONhHexqYFfIR2Cw
Message-ID: <CAJfpeguhqz7dGeEc7H_xT6aCXR6e5ZPsTwWwe-oxamLaNkW6=g@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] BUG: unable to handle kernel NULL pointer
 dereference in __lookup_slow (3)
To: syzbot <syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com>
Cc: aivazian.tigran@gmail.com, amir73il@gmail.com, andrew.kanner@gmail.com, 
	kovalev@altlinux.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syz dup: BUG: unable to handle kernel NULL pointer dereference in
lookup_one_unlocked

On Wed, 8 Jan 2025 at 21:42, syzbot
<syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit c8b359dddb418c60df1a69beea01d1b3322bfe83
> Author: Vasiliy Kovalev <kovalev@altlinux.org>
> Date:   Tue Nov 19 15:58:17 2024 +0000
>
>     ovl: Filter invalid inodes with missing lookup function
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ef4dc4580000
> start commit:   20371ba12063 Merge tag 'drm-fixes-2024-08-30' of https://g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d806687521800cad
> dashboard link: https://syzkaller.appspot.com/bug?extid=94891a5155abdf6821b7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1673fcb7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15223467980000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: ovl: Filter invalid inodes with missing lookup function
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

