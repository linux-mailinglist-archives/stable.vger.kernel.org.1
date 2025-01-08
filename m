Return-Path: <stable+bounces-108035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBBAA06680
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 21:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5927F188A47D
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 20:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B5D202F80;
	Wed,  8 Jan 2025 20:42:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9192046AD
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368926; cv=none; b=G4Fhq/f14Ph0X8Ic9TvN70qKxnVP1dTYq8v692Yq/2zt0RSuUBHshRpBVtLWW8UqtCrSmEpS5VrGv96fwLWtmgsKcGf2Y2wpCoFBsCMg3diPIvCPXleadnoIXcvjzwSJcLzIwsZ6RwU/BAiX5YcHXlyzWDzdI50qR4ViueFBmM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368926; c=relaxed/simple;
	bh=rJ0PBgRJ8JQ65hZJ2DfAQJvAcwVTjGP1dqjfW1aqmOc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xc/q3b+f5dl7dp0xZbDo6j7wcuAutyD1MESrIz9GX5gFM5z96oUvqD4Ag4TpxwyyNYVuvCU6wfR7O5Tl491o1m5W0nsx1+VlA4QP9iexR6p5c11F6dpT4Ov2NzQKOSLj1mMCsTkObWhFAHzcKEdbqhqZNfcoWwX961pz8OTMvus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso1150205ab.3
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 12:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736368924; x=1736973724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNs6O3kkr3r5I7w/dw3fJq7XUHf1uqk5MiUvua0Nv68=;
        b=QaHfE5JOLEIxiC5KUFRo4FUE1Z0Oo8x1P7vWyhXl3eJn5A38rNTxALExqarsmuK5gq
         ag0+e8CliNAulnepP+UPIag6UsQ+/TRHj7pktvVtyiFKjKqXCc9cQr1tO64y9eggAVo0
         rKVFQK1qWM/FCbpdmSMrCWQhPiNVjmSZ6aNAnKjlHDMq1ivxvFeQdeQT8tbKVWUyOWYv
         GgwbTQhHAk0DAtx4hnUNhYdNWOcbKAQ7db6lfKI/9vax81WboZKoWFrnnb0FZUTm7jya
         xYuwFHZEF5uzRNHOekk8LRMUvn9rEENCezIGfnWVyW8NU9gQ8bxoxrYyKPGpMeKOtUmS
         pHTg==
X-Forwarded-Encrypted: i=1; AJvYcCUjUYbAh/iShTE086hEWUuj1/agjL5A6rCXMOTUTZbwk5mJ3LUnbgMu6ue+MgEUK8JWT2+DPLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK4OE13gP57Z0VhIdajmlgfFixJWpYWL7lK4WBLyoU8Kuq3X/r
	OIjGsNQ1Zpz5iegsjpkfS5MyawDMWQ6oad3z5s+lep/04DRP4fkDP+tZc50EvoQSXCPZInSoCxY
	EJfBHwGJ2uedjgy/f+oEMl27/nPlTtmQfFqvhBiWiulh4knCRLquNT9Y=
X-Google-Smtp-Source: AGHT+IECo9lGm603Dk8vIUiGK8QpkBSx6h1ErbJnWMSVgNgDWyfFyYFqwgh99vQBrvmYiQIujlLwDkp4H2G7ucDx9e5v5WFae6xI
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:3a7:e800:7d36 with SMTP id
 e9e14a558f8ab-3ce3a9b9cdcmr31182255ab.10.1736368924026; Wed, 08 Jan 2025
 12:42:04 -0800 (PST)
Date: Wed, 08 Jan 2025 12:42:04 -0800
In-Reply-To: <0000000000003d5bc30617238b6d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677ee31c.050a0220.25a300.01a2.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] BUG: unable to handle kernel NULL pointer
 dereference in __lookup_slow (3)
From: syzbot <syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com>
To: aivazian.tigran@gmail.com, amir73il@gmail.com, andrew.kanner@gmail.com, 
	kovalev@altlinux.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit c8b359dddb418c60df1a69beea01d1b3322bfe83
Author: Vasiliy Kovalev <kovalev@altlinux.org>
Date:   Tue Nov 19 15:58:17 2024 +0000

    ovl: Filter invalid inodes with missing lookup function

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ef4dc4580000
start commit:   20371ba12063 Merge tag 'drm-fixes-2024-08-30' of https://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d806687521800cad
dashboard link: https://syzkaller.appspot.com/bug?extid=94891a5155abdf6821b7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1673fcb7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15223467980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ovl: Filter invalid inodes with missing lookup function

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

