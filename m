Return-Path: <stable+bounces-166854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB95EB1EA6F
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 16:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB993B48CE
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB6D27876E;
	Fri,  8 Aug 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnkAG3aS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8512B9A8
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754663849; cv=none; b=F+4fNMDV3Xs2WqhAFSI9+Nfmi5kqOlyiOZ7LdfifDiH4eE0Z/2rVocub/Uy8RXvHfPRg6CSo8TEGd/jfX6at7aDi4p/eGo7yv64Pxq3BKNOoK2ytedGZ9KR2yYMkYn2jSYK9EDMZs1gdXugxyRtRoAjkgk6IUtIcN1+fqDm08uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754663849; c=relaxed/simple;
	bh=eQMZ+CiFa2MQ5yBmS5IrIaH/9mmXX4Dtrvq7JE8whwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qe3DsgMzQ9bP7KzMEFZNQfxOA3pBtjUmSW0IBs4pAUnMK4Tq08cfWD1wJQ4aQhYir4T8Es5LpaEdMWQg4WCDS4T4/quS3kval+ZR+UGzfqlJ3t3rV1iv5XcXwte3o4xzqOlnJ6fbOK89yJAt9hQcWOTZnzWrh4dCFg5GwPJOnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnkAG3aS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adfb562266cso313284766b.0
        for <stable@vger.kernel.org>; Fri, 08 Aug 2025 07:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754663846; x=1755268646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+62NHinCYSr5yR3g3c9qlbv0ulbIVmyUNIVnnN95vc=;
        b=CnkAG3aSv/AVxKtpn+nOHXlgxCj7WKYdcm9mkwnsiBqw7Ugzt7Tf2NyZjq5xADRDM6
         YguTOGxKBp8InCYZfWirkpWSE1SIvSdfVhHVtryp3dU8M4Kc8Aznp2AoUSFmiGK9RUuh
         /Ss/HHRsMSTQ9A0jtZSS4koIjV2R4QHRbaCu633kIISrhjoFZEB8OLMofgEBPqwYKrG9
         3iDpEoPFGHSbMsqMOLDon1Rydf1UsZFjeqVG8GWc4q+qEEsBTzP6P0ODYFJYibLyB3O2
         wiZBuQ5J3B11Q0T4mdN7RS1Jv8GczwuoD2yqWmSinFEFtOznVP2oyy8VlIRuY4K8Ho0F
         Qsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754663846; x=1755268646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+62NHinCYSr5yR3g3c9qlbv0ulbIVmyUNIVnnN95vc=;
        b=okE0Rv6aoIZhVwY/G43GKSWM9jAw6I7frlOsFkPOAJRfAF3RElW42Krs+K1toSOm8w
         U+/hGdGQ7F/29ubZ0bTreyJIYIXNMfvvGz1VL1CGP5yotqk/qfRrxzGrHwIIk0XufnMN
         d4MA2O21MEckyMsey5fHvZRMq3t/Z0ROKyTkjfMpiPAUm8BIWg62O2X1wI30VLLjqLZC
         tXirk976ZNy6T9VsHjjlXjJu/SYBbw2YDUXXQzrtg7gZAnnWjt0QLrVIlEFIeSyw9Jpb
         MhyodudZjNFnI1jra4MdhU6s/W2MI1PYBsNXZdYgIrRMn8Oq1a03cYgV4Bu26IGO0zOw
         Od/A==
X-Forwarded-Encrypted: i=1; AJvYcCWyXKx8BLyVTe2V+MVGSo3/h5DbtKvWQrQeByf4NOxHls62fHFEXEeWOLkk83rxVU/a+cvAT70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xr74e1RIHniarLXoVqy9H1EXJeeLEfVE/Of9btAhdPpHPINx
	WYHSxZ7OlFBMzjwP6OTrnOBCEZk1nxFHM6OcT1Xfdl1lQaBk61ZS4OZXx2zgR0ORY7z27XYyRTJ
	uTRjrS75AqWE+hpsr4rBdeN5rt14AeMg=
X-Gm-Gg: ASbGncuFDtCR0mwJISgXY9bUHHBMIQVs2LJEJOO8NAJzJpn8YfxRUxE1H6MikwrT80S
	5MzH1Nn4m5oVtYmdS9nsp/xSk7OUQfRzp/IlR64yN//pfZEPBCOdqhfoaaO+buEOdQ9iFPzWr39
	+ag9aXPtz+pIO5y4GnvUsa6LLZn94IjLCf8PZ8B+JbLZIRxrH5iUFkwojX/fw59410KCKNTl+PE
	LMJ8jxj8w==
X-Google-Smtp-Source: AGHT+IE5944foTaedZbw+uIpFDVvyakr3YwxS1vXU+mfC2DP0YLfxtT3BoUxO5Ojt29yvIAdwVWX4Xi0czt/+f25U7M=
X-Received: by 2002:a17:907:dab:b0:ae0:de30:8569 with SMTP id
 a640c23a62f3a-af9c6330895mr297978866b.1.1754663845623; Fri, 08 Aug 2025
 07:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJmAMMyOk7AVqQRrtK4Oum2uVKreGeLJ943-kkRCTspoGApZ8w@mail.gmail.com>
In-Reply-To: <CAJmAMMyOk7AVqQRrtK4Oum2uVKreGeLJ943-kkRCTspoGApZ8w@mail.gmail.com>
From: Tal Inbar <inbartdev@gmail.com>
Date: Fri, 8 Aug 2025 17:37:13 +0300
X-Gm-Features: Ac12FXy5Ql8C0LL-N-OOd5L6QA2Q0V2HShdd45ZpaOEir98zODdte42A2TcV_LU
Message-ID: <CAJmAMMyt5QQQOavVy+Gytf00Y0F6G+GCLYhj0E9RZ8cV85gwCw@mail.gmail.com>
Subject: Re: [REGRESSION] [BISECTED] MT7925 wireless speed drops to zero since
 kernel 6.14.3 - wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
To: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Sean Wang <sean.wang@mediatek.com>, regressions@lists.linux.dev, 
	stable@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

typo, laptop model is:
Lenovo IdeaPad Slim 5 16AKP10

On Fri, Aug 8, 2025 at 4:14=E2=80=AFPM Tal Inbar <inbartdev@gmail.com> wrot=
e:
>
> Hi,
>
> Since kernel v6.14.3, when using wireless to connect to my home router
> on my laptop, my wireless connection slows down to unusable speeds.
>
>
> More specifically, since kernel 6.14.3, when connecting to the
> wireless networks of my OpenWRT Router on my Lenovo IdeaPad Slim 15
> 16AKP10 laptop,
> either a 2.4ghz or a 5ghz network, the connection speed drops down to
> 0.1-0.2 Mbps download and 0 Mbps upload when measured using
> speedtest-cli.
> My laptop uses an mt7925 chip according to the loaded driver and firmware=
.
>
>
> Detailed Description:
>
> As mentioned above, my wireless connection becomes unusable when using
> linux 6.14.3 and above, dropping speeds to almost 0 Mbps,
> even when standing next to my router. Further, pinging archlinux.org
> results in "Temporary failure in name resolution".
> Any other wireless device in my house can successfully connect to my
> router and properly use the internet with good speeds, eg. iphones,
> ipads, raspberry pi and a windows laptop.
> When using my Lenovo laptop on a kernel 6.14.3 or higher to connect to
> other access points, such as my iPhone's hotspot and some TPLink and
> Zyxel routers - the connection speed is good, and there are no issues,
> which makes me believe there's something going on with my OpenWRT
> configuration in conjunction with a commit introduced on kernel 6.14.3
> for the mt7925e module as detailed below.
>
> I have followed a related issue previously reported on the mailing
> list regarding a problem with the same wifi chip on kernel 6.14.3, but
> the merged fix doesn't seem to fix my problem:
> https://lore.kernel.org/linux-mediatek/EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8=
_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=
=3D@pm.me/
>
> I've tested stable builds of 6.15 as well up to 6.15.9 in the last
> month, which also do not fix the problem.
> I've also built and bisected v6.14 on june using guides on the Arch
> Linux wiki, for the following bad commit, same as the previously
> mentioned reported issue:
>
> [80007d3f92fd018d0a052a706400e976b36e3c87] wifi: mt76: mt7925:
> integrate *mlo_sta_cmd and *sta_cmd
>
> Testing further this week, I cloned mainline after 6.16 was released,
> built and tested it, and the issue still persists.
> I reverted the following commits on mainline and retested, to
> successfully see good wireless speeds:
>
> [0aa8496adda570c2005410a30df963a16643a3dc] wifi: mt76: mt7925: fix
> missing hdr_trans_tlv command for broadcast wtbl
> [cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1] wifi: mt76: mt7925:
> integrate *mlo_sta_cmd and *sta_cmd
>
> Then, reverting *only* 0aa8496adda570c2005410a30df963a16643a3dc causes
> the issue to reproduce, which confirms the issue is caused by commit
> cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1 on mainline.
>
> I've attached the following files to a bugzilla ticket:
>
> - lspci -nnk output:
> https://bugzilla.kernel.org/attachment.cgi?id=3D308466
>
> - dmesg output:
> https://bugzilla.kernel.org/attachment.cgi?id=3D308465
>
> - .config for the built mainline kernel:
> https://bugzilla.kernel.org/attachment.cgi?id=3D308467
>
>
> More information:
>
> OS Distribution: Arch Linux
>
> Linux build information from /proc/version:
> Linux version 6.16.0linux-mainline-11853-g21be711c0235
> (tal@arch-debug) (gcc (GCC) 15.1.1 20250729, GNU ld (GNU Binutils)
> 2.45.0) #3 SMP PREEMPT_DYNAMIC
>
> OpenWRT Version on my Router: 24.10.2
>
> Laptop Hardware:
> - Lenovo IdeaPad Slim 15 16AKP10 laptop (x86_64 Ryzen AI 350 CPU)
> - Network device as reported by lscpi: 14c3:7925
> - Network modules and driver in use: mt7925e
> - mediatek chip firmware as of dmesg:
>   HW/SW Version: 0x8a108a10, Build Time: 20250526152947a
>   WM Firmware Version: ____000000, Build Time: 20250526153043
>
>
> Referencing regzbot:
>
> #regzbot introduced: 80007d3f92fd018d0a052a706400e976b36e3c87
>
>
> Please let me know if any other information is needed, or if there is
> anything else that I can test on my end.
>
> Thanks,
> Tal Inbar

