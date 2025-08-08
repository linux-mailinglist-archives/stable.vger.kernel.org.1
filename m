Return-Path: <stable+bounces-166838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E88B1E8FD
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 15:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8ACA04C93
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5D127C145;
	Fri,  8 Aug 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fozgd05L"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92B279DA0
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658901; cv=none; b=bTX69XgAO3CoLNzh3eZIHXb5Vt7KyFOs11baCGomBeUXh9gBE4yGG6jiC9ivYJ96dQMAWCqGIY6CEGEssx1nZ7Es5wgTeynaLANbGr/Z5QFrB6wTAFM6Yv4EUbV3RHWOMUC3E4tCe1WItJRmaQfl1EB0U3+plQbphKn84cJx1kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658901; c=relaxed/simple;
	bh=LzZ2gmBzKad8vP6vcqj+QiAbXuf+vjCf/xlWhLPeWco=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p23HlkV46dVQy8qYfGR3GFVo6Oe1tvucXuUT6n4uo9YSViYtzVSPojfWT50dfgA2ZI/DXHbOvPa+Oo7MyBnsppdn3QQYgyHFUz5LzBr14/3AQ3NTcIfODjJp21PEs0g6uPpbIpnaAUp9VktSvjdj1WZSRM7XELzEMHKEwu8ru30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fozgd05L; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61564c06e0dso3377385a12.3
        for <stable@vger.kernel.org>; Fri, 08 Aug 2025 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754658898; x=1755263698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1G84+v4zX75P6WqTk0EXQj0TqNSq6e+rkwRaOXJCVZ4=;
        b=Fozgd05Lfcq57iLnHJ0VLysBZ0+V6uu+fvxQc88/014IZwbUC+4VUnah/UFzkGVhxG
         syHUtGtKNllALyFvlkGA/yH+wWZXeatpz4YWac65EeTkyZMCzBvx/5R/AaTlLYd+yroV
         nTZ6oyBHuvJfE0KE9NsKm/Z033gIhNEB46Hf8jlxaK2nw5EjrgQQBLQkzKQjNx+NUVZt
         A69szAYQA7WCY7A/VXZ24h8cA3FUzTEBIprizzi5ERhhxdkMEyi02M9GmT9xp4b1l5xx
         BsJT6CfoeiC6q2l9YGFqaauPw+Q8gkjcZRRgF0SYPKs+x8SLId5NvEyPkNb2LbXcguIO
         5g5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754658898; x=1755263698;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1G84+v4zX75P6WqTk0EXQj0TqNSq6e+rkwRaOXJCVZ4=;
        b=B9Ztwj5mcyV7GqSe0M0i44R2icp/lMGiWgjlwSt0CzCX3ukmV5iTcbCrv3wVU1JMxO
         5Ik/buiQ54bJCbSmNDFIFsvtKCvh9Vg8eRXSIMUX/BxsV+K998/bx44Pxf5Tj4J5PtAn
         mtA+XnREx9yIOOoMCJ7zRUw52ClD82uPaAWC3dvEpbQPk3vEhuDop6GBrfWOm8Bn+6FN
         AQD+LlVphNY0MPnd8MYUnwRAdTsp1jbwRGCd829K3y/9NDMbNGOKJnh5wCRoh9NojDrs
         yHASIFNy/Kz0bfK+5aC6rWe0I7aFdL2CfMpAVIvC1mmqlRZ9JNGpU2Lm/Z+ymLBujwM1
         jybQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmPUClCvlcTc0P3uQ4GaA2Dj0JrNg2TcToPsHLUsQwwYPfwtK7P5ZMi/NKqjfcyYB45/3I+xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVyHRybCoLuR2AAAgUxFSIkKgcPP151ZhzRSSVEptRsUN6nIn
	XkwLjVStV0FXGgEpeqADakKa82qq+0CUbfv1pyZmwEuwZaqMXI/Q2kUAh6e20FgOnHJgDQJfz99
	CvTVWxiubaxXnDoLf+7K/z8nh+QUuVxfw7sQj
X-Gm-Gg: ASbGnctiEtqfLXQQqguJ+pG9K4ijr16n+o50iQKy+x4G33wxlHpiDxt4TMMi16k9YYz
	MJSjmvICHldemTSBzDlWuC1nZsohrXSzrFsKX6A3VCk9YI54hGERH2X3hgbAE0mkRTb17DvrYid
	BldSSh9721S4MhDGhGez0XSVvtLLWqdjvgg3onQV+DSqHops4NpFgXZ8qK8SKAPlq2zx5aEXiQH
	PS8XhedLvjsVRfWVk7o
X-Google-Smtp-Source: AGHT+IGevCoZbL9izzwy5cwLKx4/i/TmXKqJBSAQOcJkM9XKP6Ea/sJmVJxiOYQUmUx3N5L5pL8CK1+aI275dIXumZs=
X-Received: by 2002:a05:6402:2547:b0:602:1b8b:2925 with SMTP id
 4fb4d7f45d1cf-617e2e95eeamr1953333a12.29.1754658897651; Fri, 08 Aug 2025
 06:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tal Inbar <inbartdev@gmail.com>
Date: Fri, 8 Aug 2025 16:14:46 +0300
X-Gm-Features: Ac12FXzGwyXXWIsqoqW4GYVdq-yIoDbSx7m80eMIrFIy-Ylc2aYJJ2tFHDO8ZrQ
Message-ID: <CAJmAMMyOk7AVqQRrtK4Oum2uVKreGeLJ943-kkRCTspoGApZ8w@mail.gmail.com>
Subject: [REGRESSION] [BISECTED] MT7925 wireless speed drops to zero since
 kernel 6.14.3 - wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
To: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Sean Wang <sean.wang@mediatek.com>, regressions@lists.linux.dev, 
	stable@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Since kernel v6.14.3, when using wireless to connect to my home router
on my laptop, my wireless connection slows down to unusable speeds.


More specifically, since kernel 6.14.3, when connecting to the
wireless networks of my OpenWRT Router on my Lenovo IdeaPad Slim 15
16AKP10 laptop,
either a 2.4ghz or a 5ghz network, the connection speed drops down to
0.1-0.2 Mbps download and 0 Mbps upload when measured using
speedtest-cli.
My laptop uses an mt7925 chip according to the loaded driver and firmware.


Detailed Description:

As mentioned above, my wireless connection becomes unusable when using
linux 6.14.3 and above, dropping speeds to almost 0 Mbps,
even when standing next to my router. Further, pinging archlinux.org
results in "Temporary failure in name resolution".
Any other wireless device in my house can successfully connect to my
router and properly use the internet with good speeds, eg. iphones,
ipads, raspberry pi and a windows laptop.
When using my Lenovo laptop on a kernel 6.14.3 or higher to connect to
other access points, such as my iPhone's hotspot and some TPLink and
Zyxel routers - the connection speed is good, and there are no issues,
which makes me believe there's something going on with my OpenWRT
configuration in conjunction with a commit introduced on kernel 6.14.3
for the mt7925e module as detailed below.

I have followed a related issue previously reported on the mailing
list regarding a problem with the same wifi chip on kernel 6.14.3, but
the merged fix doesn't seem to fix my problem:
https://lore.kernel.org/linux-mediatek/EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=@pm.me/

I've tested stable builds of 6.15 as well up to 6.15.9 in the last
month, which also do not fix the problem.
I've also built and bisected v6.14 on june using guides on the Arch
Linux wiki, for the following bad commit, same as the previously
mentioned reported issue:

[80007d3f92fd018d0a052a706400e976b36e3c87] wifi: mt76: mt7925:
integrate *mlo_sta_cmd and *sta_cmd

Testing further this week, I cloned mainline after 6.16 was released,
built and tested it, and the issue still persists.
I reverted the following commits on mainline and retested, to
successfully see good wireless speeds:

[0aa8496adda570c2005410a30df963a16643a3dc] wifi: mt76: mt7925: fix
missing hdr_trans_tlv command for broadcast wtbl
[cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1] wifi: mt76: mt7925:
integrate *mlo_sta_cmd and *sta_cmd

Then, reverting *only* 0aa8496adda570c2005410a30df963a16643a3dc causes
the issue to reproduce, which confirms the issue is caused by commit
cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1 on mainline.

I've attached the following files to a bugzilla ticket:

- lspci -nnk output:
https://bugzilla.kernel.org/attachment.cgi?id=308466

- dmesg output:
https://bugzilla.kernel.org/attachment.cgi?id=308465

- .config for the built mainline kernel:
https://bugzilla.kernel.org/attachment.cgi?id=308467


More information:

OS Distribution: Arch Linux

Linux build information from /proc/version:
Linux version 6.16.0linux-mainline-11853-g21be711c0235
(tal@arch-debug) (gcc (GCC) 15.1.1 20250729, GNU ld (GNU Binutils)
2.45.0) #3 SMP PREEMPT_DYNAMIC

OpenWRT Version on my Router: 24.10.2

Laptop Hardware:
- Lenovo IdeaPad Slim 15 16AKP10 laptop (x86_64 Ryzen AI 350 CPU)
- Network device as reported by lscpi: 14c3:7925
- Network modules and driver in use: mt7925e
- mediatek chip firmware as of dmesg:
  HW/SW Version: 0x8a108a10, Build Time: 20250526152947a
  WM Firmware Version: ____000000, Build Time: 20250526153043


Referencing regzbot:

#regzbot introduced: 80007d3f92fd018d0a052a706400e976b36e3c87


Please let me know if any other information is needed, or if there is
anything else that I can test on my end.

Thanks,
Tal Inbar

