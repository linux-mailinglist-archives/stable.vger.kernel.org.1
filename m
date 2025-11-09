Return-Path: <stable+bounces-192854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AB2C44473
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 18:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36413A2438
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474D82FE067;
	Sun,  9 Nov 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbBFIEPE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B512EBBAA
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762709324; cv=none; b=RUmK1TZ5/6RI6NcUwWIGLU1llsZfoFjzQEwI4eFs5ufcOWO2AUfiSWgtKtGgIV6+v1eMnZmhBvegyXlLsl+a+tZ4c6ZyQrWxTEaQPPfrMkEIiXimaZCuswlyl1437V1YahvxZzfBrIgy246UPd7ylw6kNc5pF527Trrhx1Jm4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762709324; c=relaxed/simple;
	bh=oaZbFrrLK6gcB2BJgc78QjZ2h9TO6qaXihmNe77C4rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5M19cihhxpUvsfT9OAD+fqFwjv0fJLduJcQuMytnq0Q0iHe4UEF1x4b1UjWk0KIsjVUxD3ghNEzf8w5P2Wkat39yrtl91T6ZXMa9EH8f88rh5Ch7cOmpFyTnYE38Vn/E1c1DXpxu9CuXa553KlnSNm8rR5xDWk1jveysHldFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbBFIEPE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-343641ceb62so324600a91.1
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 09:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762709322; x=1763314122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaZbFrrLK6gcB2BJgc78QjZ2h9TO6qaXihmNe77C4rU=;
        b=KbBFIEPE+rfBW7NgQs/oHPQp/hnMUruXsw/XratFdRJiFytuPrZ9n1z859mDGhx4FU
         yv7vUDZNs5tENse6kC9MTr8A5OApjI6Ky11w9wtDZx9MYxe+GgQWCRkm5Va1N4vxTk11
         an8sQB/lDUABf5yQtvk86J0gXW7TiIQb/6P2i0bBkVCxBG7QfoKL4RnZge/oxv/1P9+g
         5xItxr10zRVE50rcLujq1GDcoEJthOHD/+uCeBJKF/zEdJPj2uj/TEJHxTpw15JBY2TH
         FZWzwPfaZT5dnL8kGpVzIdfsKYqpzRMbb2SYtZcMoyO248eJLq2eJam824aIxb3G5tkQ
         K8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762709322; x=1763314122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oaZbFrrLK6gcB2BJgc78QjZ2h9TO6qaXihmNe77C4rU=;
        b=ZaoAJOBhnq0s6CPK+YdkM1NhliyLD9ouNY0T0LfNYckGMfjymrN9rkkyljDmkkAC1v
         UheTWhdTLcb+LEQhWTAMMhR1agVJI5mHee+EZj3tgMBbWyFcjvA6DkS51oLp+LtOGmFx
         af/M/U5iiGn/nt2DuxvAq8ITtOFouBK/UBn6MFnIYcaJayPw3EA0Zs96td0X+3dCM1vl
         I2JbVaBWIS+TLyarCRVqUFRYfHvOO9nAbhzalvRebbbCa1hdxavEpQgBWdgo/2ReKXR8
         yh/dsB9a9drH7pYMRVkwAe1FobqufEeeVnQsKatLBUPBAa6APkn2gaRrJ4gpNb8VHrQX
         Or2w==
X-Forwarded-Encrypted: i=1; AJvYcCWt+/e6NT5GjHpI92qrLcqGYzfayKpd3mxT9DSKhfDK6Zb4JHI22Rly3G0JvzGK57Nj1tOJvQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqoKDEJWp00KVcAhPG6fkJercj+bVu1HJXinBXWFoJrGrpkPCT
	hIIgjpdYFY53eSZNeubZ8WWNw7BYpC5k7PiWuuCZy53tcfFnH18pzD3PCaGO1afcwWkPKOostC6
	sHcqPQstFiKRUqDuzf2n7pRTfa9gdh0I=
X-Gm-Gg: ASbGnctrQ5SgIMS5JTPvcST5T4DqNT62bYovraTBjXtZNCxkQ20NeTSbls57kwXodEd
	SFvRrDjcjk50R2pzD7z6oi9N3Rwx0W6I1mGME1yctx8wmh82vxdhkpSIxEQpRx7ZDoS9fBepJ+S
	Q4nxmJTydb240kZYrS7zp93+PBZBMSG3gxbBjRYVl8ofp00ziuBpVuEJuxQ02ObIsdqNAJnWuo1
	2igemqK9nUY3B3eUFNMElhIpfiyzjGyGtcXI/AoYn33PMNDSN7gZvv8Y3hSwheZvswWq4kHVWn0
	Y8HY1Oe55CYEI95GukS1ToC2aco+4GuQhDS09Ldcd2i3o5N09aZ5NlDv25MmoxUYTgOLTFYpIoD
	6ANg=
X-Google-Smtp-Source: AGHT+IEmVeP2I5vWvNByBcdTD8y7+55gQj7tDg8bVmRJ4Wt2Gu4r+jl34CQq4iAnjs5yqrZbqVdAnmSpp/v5gYbXOt0=
X-Received: by 2002:a17:903:2f88:b0:297:f88a:c15d with SMTP id
 d9443c01a7336-297f88ac5abmr25523995ad.10.1762709322007; Sun, 09 Nov 2025
 09:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025110805-fame-viability-c333@gregkh>
In-Reply-To: <2025110805-fame-viability-c333@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Nov 2025 18:28:29 +0100
X-Gm-Features: AWmQ_blX8FJGrS5-kua4_ptsv7G-opHja2iQB_Sx7JMlS-6hc3lPjnVs0Vlxy5s
Message-ID: <CANiq72nZO7h4ktLGNNx1wixAdVsPUkJkAAJSsN3regBKNG1LMw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: kbuild: workaround `rustdoc`
 doctests modifier bug" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: ojeda@kernel.org, aliceryhl@google.com, jforbes@fedoraproject.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 6:24=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x fad472efab0a805dd939f017c5b8669a786a4bcf
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110805-=
fame-viability-c333@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

I replied in Sasha's sibling resolution -- there is something odd in
the log which I would like to understand.

Cheers,
Miguel

