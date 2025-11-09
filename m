Return-Path: <stable+bounces-192849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F26C44325
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 18:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7173A41EB
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3F3002D6;
	Sun,  9 Nov 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjNWwBi2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE7883F
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707938; cv=none; b=C20eQvYZlWyP62TLyNPgx4atBS7RWJEuOQUXDUgYnqoQhqwq/wn6PxgPgkrRDaA7ExJsSxUm3N41SH64fxmPwklZCE/C7FES79I6njDHk0tZ0QJ84L/EFeb8ydEBAboZFtE0LYpiqJFpQ0Xo9I4AznA5zvg2A9EtQtNx5i9tuns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707938; c=relaxed/simple;
	bh=AqH3W23jxyu8ISAvGC0IDlGpJ7WUaZjaX4DpbPxK1fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svkjqE8SB5mI2LIQACjJjE8MMlOZ+2muZnk4hCZnNNF35sUNyFkWxHQ2WTktPPCFN/Ad+4csdRhBy+ckrZ26JEgiDpWdN9rmuYECqCLBq2LA8UnWUd1g/8HRHx6k2tG54hE+r4vrZS93JJ1XhoMs+4nYUIS0bxDA0Bd8GksYNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjNWwBi2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-343514c781fso346557a91.1
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 09:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762707937; x=1763312737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqH3W23jxyu8ISAvGC0IDlGpJ7WUaZjaX4DpbPxK1fc=;
        b=cjNWwBi2q4c6P3imEIeF+vyRZdQjBl9k2XY8HE6Z7O/ev6AiKOIJ3QtTRMANFy3kmt
         79lcVCVl4MfY/W2LBXLsYiomefDztHjcxuOv9to+P29Rk1nhMa0fUC5ykd2qW7k/HbvK
         oZWEBiJJQLnDYGOXT19BiuWspmC0cKUcxpRXKa6pZ1P7dZejJHaymcIpEq+V/b06YgEo
         6S2UtRUjroeqEMv7qkZnFl+dqbSXyfG5ScaJ/TjuymR8sRnMGAc92dL5FPu+WK9dFjFe
         ztF5hm4Y5xE8YUiapm2uhN8/rE8dPGvlKr/VyELDhbYvlSaf7zXWs1fVlLR9dIXC7jg2
         IRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762707937; x=1763312737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AqH3W23jxyu8ISAvGC0IDlGpJ7WUaZjaX4DpbPxK1fc=;
        b=QyGXI6DwyJM07rFBxiZTgs+pQyoBIau/eURDKNjEc3DHg4zPh1jkzPC2FT+lRlcs3n
         iFOLGKyVvbJYiIJTwzrhLllkJthYtgyZKz85t7Uf5fbEX45PXK1XCAp1KNYZZjLW0eGn
         Ld9aDPK8Vl+YdPNPoMqFDPwMCf++/MZYnwkvapNb6hTTewDCYaVjTfMgFAFxLNib33A+
         DRTCYd89CQ1iu1IWq7GTcObpuAeDdDv0PwSWxvj27m5CSd9XQ/+IwicL1RGTAQnCrXN5
         x/aYGE9zAEdjzxvTvzhfGDD225hsUyhfhC6oI3/rs3XOeGqj1xvsQm76Iggk2GOHf7Nr
         VtjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaVTIgCX0K1/KbrvOTEbQ6DWQZfy9uP0NtP8WSQsh9/NcsGQSb1gO1R4pu+ifBOU0SKwRQbZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjhV/AsmlD1yR0b2feQCcBL8RRAGZLIqppo/LXev/YuY3kDfk
	FjmUaTZzxFzPu8ckukWjAXVDQ51kOjEaO/C68cYaSsdxbxTITPBTZ9LjcSIy1Bv+olZphiXsJ2W
	9HVDOnu0gDfnBqlPX9e6Z15rYkFDJbMSot4Pc
X-Gm-Gg: ASbGnctCdXeeyQuzA3BeOTkO/GoecZcrDuSbytuCt3aRUhedqSH5T8M4AYoi58dx/jQ
	P5qjj9Nlh+7gryNqQ+NcEOSA5K+NS6n8Ydsk6BMZt5qrQKRVszDI3pzNGrM5zaeAeeNGk2xSUf9
	hMEeaK/ud23LtkRqOXpovCCUvC+Ca5B14FLMZI8gYHajHKZFkKScLZYZ/M5bg5fvTqbvJucN3nf
	zxjuQwMb4jd+1zgw9cIKKqGMkBPj8uXnASV8udHcqWWhrSJASe3uk8W8lkEenzNPHEkpOEJo6ZF
	2z8UNKfHMQvN1MDAH4nMoIE0qzth+8qvA8mlwyEnkfzj6dqVMcojnK+RmlFE7Jbd/Le+5e7dtjK
	5mCxbqEJlyL9ABw==
X-Google-Smtp-Source: AGHT+IHM/p3iEmXAbDup/KTdxfoL2rrz9hF/9N9A+tH0YWr3W8mlgY9SovApcgmfn3Kl7Ifz3U3yJl5LrcD4uh7QzvY=
X-Received: by 2002:a17:902:d4cd:b0:295:a1a5:baf6 with SMTP id
 d9443c01a7336-297e56d674fmr38514655ad.6.1762707936829; Sun, 09 Nov 2025
 09:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025110816-catalog-residency-716f@gregkh>
In-Reply-To: <2025110816-catalog-residency-716f@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Nov 2025 18:05:24 +0100
X-Gm-Features: AWmQ_bnjhkpcTi228qrVNi5uFUuk0-PEVeODZR5iXYzELsgCbQygtlnnR4NS4vw
Message-ID: <CANiq72m2Rw2tFVH5e0PKo99k6Bn4fn-6N39DnHGsEDvmNhGYMg@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: kbuild: treat `build_error` and
 `rustdoc` as kernel" failed to apply to 6.12-stable tree
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
> git cherry-pick -x 16c43a56b79e2c3220b043236369a129d508c65a
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110816-=
catalog-residency-716f@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Sasha's sibling resolution looks fine, thanks!

Cheers,
Miguel

