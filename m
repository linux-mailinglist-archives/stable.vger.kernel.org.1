Return-Path: <stable+bounces-206336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E21D02B19
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 13:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9746F3097C0D
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A6A4DC55D;
	Thu,  8 Jan 2026 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAHJgCsb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228AB4DC54F
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875165; cv=none; b=KCndDsNWxps105X89Pio+AA2h7POM8UBBKkXcfHSc3tQZKGGsAzte6gGP+/68LQU6L3MHo0GRhhpOBX51rmgS1n1MXm4iH/f4cR0SDog/Txbk7Y524gFGBaBM3Y9IMce3S0X8ndv4cnpuNPNnDhrHcygA2ApUBL9qbQsWyShFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875165; c=relaxed/simple;
	bh=C/PxTgSERqJ6ILqTgSVsU+Sj2XkQpUudhpR6A9+mc9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQTppofHbjVQ59pJersIPniC5ay0vRiiK2JCEaEqBM3FID+gofKCwPbBDKVtBiARM4B3ef9BnpJft1f8GYMfhB/hR6No/TALu5d3je8lcn9Oc1wE6ryVr4t1T40jWjoKu/2pzcoOtAG5sYvhLV4oZFI475IlLzoyASGxLJfJVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAHJgCsb; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-790948758c1so33555057b3.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 04:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767875163; x=1768479963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQbP6K4LtPm/3Bomj038VWToPwF1ZlmXIxpj9oFDKbg=;
        b=WAHJgCsb05DN3q1CdpQz8DYDn3sRhH/hTCvrrYAKm/6sLDKBDNBI9G261T7ujH5CeB
         5Bvnk9Q8WRC+Gl4v2/c6BRxOWxviaHNT0GVmUw26G1uszDXOWoZGjM8QCtBQL1//WPTm
         fEv2XnzzDj8VhFekJiHO22xNmgx003o/XZbKWhdVX6SU2XEELInl6GxP8vv/tXxzPQrC
         YvE4legYXB5EwDUwVS250WYSgLCsSCmWXXp0beSzyKaqYEwCJYjB7QLGk/LaNjGB3X0e
         Ws3hCh0jtlo7CCnbpJ1bVnDGahzYj9oST7lcErARQIQA4DXsNbOjRc5YUo4jL0KI4Ayu
         SuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767875163; x=1768479963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XQbP6K4LtPm/3Bomj038VWToPwF1ZlmXIxpj9oFDKbg=;
        b=OfG8YtLmTJmddz20J7kcvn5puiLb3g9Wgo4MToVCRYt1eiZroEdosQPwejkWpSdi6Y
         Ry1WkIKyYhTPjDpFwFo1oAVXuh73JKXLNEwFUQTu1PK8HqrjXspUQUNtIkKOm9cwzKeN
         V6JFaEduBdu7vmy1on3E1As0K2jTCnHvqSMBl0oC3rHXYT6tAGPX1Y15mCENtbwSTZY7
         Oio86aGVOelUL4JZk9oTM8ObGRMIoAreLQocc2OaGrnAwavsPe5QNZnvsukOZsz22n06
         p1C3LMC2EBk1h+ZuKgnPVhx/W0zDlrx9jyV4L69Yr+bKesYfGU1vMn6HOocVJ/Q3nAKH
         3e7w==
X-Forwarded-Encrypted: i=1; AJvYcCX9A7Wn0WrFystaiPEkL/kxwzAh0REomwOQ+o6rCIezEBlj8rL+oa/1KDQL6E2y2Hp9VOGOlVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu90sntfLtal2lalCVMTk/DOJ2N1osd85H/8MgbR11DxyVo9Ck
	yiMgjx2h9t27C/Dmh/YpO2saeZwwfxcU/abOgLQU38DiZ9DsWbyR4tMMP66ZJeUeF7c7QkP1lwU
	caTjAfhw7Okh5eqcwH2pAiWZ8k+OZIBM=
X-Gm-Gg: AY/fxX5DcBFICZva1jaX/geQ1qPbL4Gy974xhRj8qKH3IklHXgQgF4auE3W1OsC8kQ8
	301FtGMi/Ks8qvXG/Ww0Cee4gNKV7lIS1tL19EMH7qc9/ZZ2ErrNtpJT9chLLXLHoLVsa4V6C2b
	pfwZWfR5N+aurn9HzIvlsGfAshySSuZbLc1ZUjpIy4mmfX9oRSUaTaqc7oqynv8OEirsugS2bWg
	JM8MwdEpIadDHtd3ZQ4trpWjTUXiH2RzlQhVE8J7XKThE5CsF2yhl39qK25B1FDMNozDA==
X-Google-Smtp-Source: AGHT+IE2yzRR9td4dYr8beCMOnr5E8Sv8b+0e37MZp8Y0hPbwVCOnvmprBO2NLzwb4jJvdl1Q3MsdWRhtLD5I5wdK+g=
X-Received: by 2002:a05:690e:1183:b0:63e:1df9:c895 with SMTP id
 956f58d0204a3-64716c50a58mr5519645d50.66.1767875162887; Thu, 08 Jan 2026
 04:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108101927.857582-1-edumazet@google.com> <851802c967b92b5ea2ce93e8577107acd43d2034.camel@sipsolutions.net>
 <CANn89iLxDc9viP0Pmj3uC01s46eUR2xu4XAUEo=he-M84aCf9A@mail.gmail.com>
In-Reply-To: <CANn89iLxDc9viP0Pmj3uC01s46eUR2xu4XAUEo=he-M84aCf9A@mail.gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 8 Jan 2026 13:25:51 +0100
X-Gm-Features: AQt7F2pvm4NEm6VrnYq0Y5B6J_pXuAY_73yxlKUTPRwclpCUkgoqjALp_DmIhpM
Message-ID: <CAOiHx=mWrizoJAOU=40NWk6A1+b99WCM1EkxVwLfiJ8Sv4pDKg@mail.gmail.com>
Subject: Re: [PATCH net] wifi: avoid kernel-infoleak from struct iw_point
To: Eric Dumazet <edumazet@google.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 8, 2026 at 12:28=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jan 8, 2026 at 11:29=E2=80=AFAM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> >
> > On Thu, 2026-01-08 at 10:19 +0000, Eric Dumazet wrote:
> > > struct iw_point has a 32bit hole on 64bit arches.
> > >
> > > struct iw_point {
> > >   void __user   *pointer;       /* Pointer to the data  (in user spac=
e) */
> > >   __u16         length;         /* number of fields or size in bytes =
*/
> > >   __u16         flags;          /* Optional params */
> > > };
> > >
> > > Make sure to zero the structure to avoid dislosing 32bits of kernel d=
ata

In case you do a V2: dislosing -> disclosing (I assume)

> > > to user space.

Best regards,
Jonas

