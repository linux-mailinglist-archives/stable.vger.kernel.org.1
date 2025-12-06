Return-Path: <stable+bounces-200254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9864CCAA986
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 16:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7CFF30E1AD5
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 15:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B78381C4;
	Sat,  6 Dec 2025 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYP6xl/x"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570AB2F5307
	for <stable@vger.kernel.org>; Sat,  6 Dec 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765036513; cv=none; b=AqYNpvcx6xAoYi94u2rVEVADJV+IJE8JsgNoCyrOKxpYA6eXm+vAjA/iverM8dFqSiG9+vzofL/b7+CqHe/9RtJ+MZ2ohFDVrMQMx7zomVUbQWh/n3KEOHT42JGCJLu2h0tq0gzEk7ls+RZw4Ho7EJ9d/FBMCb57A5qbG3Y1Pcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765036513; c=relaxed/simple;
	bh=qHpFPKknypA0ah2igyAH5y08BG2rl6SyKPYcke6Zjys=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IH05iQsByx4R0ggj7UD2j17JL86a6XOVSqaPRGM3cKMKqQrljTa6wTBTJ6zzQY4wh/rEXNrPYI025rnKebpg/eb9cZt93A95r8AT837ucnHdGpuBpWNSMYD2qEZe7Gb2VKys1P3ciZKsKy/fJLCdWh2jH1AmqdWGuRgMMBSTu6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYP6xl/x; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-55b0d4b560aso2830830e0c.0
        for <stable@vger.kernel.org>; Sat, 06 Dec 2025 07:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765036510; x=1765641310; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHpFPKknypA0ah2igyAH5y08BG2rl6SyKPYcke6Zjys=;
        b=UYP6xl/xu4yOwYCehn628FZG/CpT/DYIxxatVScaj8m7DV4SVdRQ/sFDmlsIPtVLq9
         rzXEaWPvXRZBbWu3NTcfJ+ZQFj1MS+F9dzUL6gtOWhEk0G2Oj3bi5UfZg9TIosGyzmoq
         hOwmuAkc3Y6QM5uKUf+/f8br1fDh9qaSjMp1AwePmoTgnlEk+QRFCdXtSf9Njq3+XwLC
         bw1OEPX+wfm+s3T1eLxhpoLcw1WTkMrsYZMOiAWsByGHbyRQLwGc5dq9Azo4zJXvuxtb
         GRuo1jDIF97WI7xnzuSfMxcZl9bAIk1OeDD8b/VYZYrRn6i9cQV4T5b1m7k5lH+9ahAt
         pVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765036510; x=1765641310;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHpFPKknypA0ah2igyAH5y08BG2rl6SyKPYcke6Zjys=;
        b=Qp6sXzkxFPqH460VNGIw0+KzI12DXPPp85BpR582n81/X5B7hia2D8C+GDrLUv4Htb
         6/fPoKYACDWX6PDqr33QLbqDebVdrqt8e7Pef7oRFOeQzuSq+WWZfuQLdc550+FxeaHk
         8NHs6rB7xJ2/ZZOzK6pyOQ/dEQy+sB5ky4vUyk8MHHdsB2q/hS7Id9oLo1U7Hy2DiYI5
         7Y4Z+ulUSJpnB2nBdbW5umq3Fp+M/TCuMQhOHL9SBvuhrIukh/fKQgco4/1QRenontoA
         ZzLR0/BoL1etVj9nzw2iQrYjIpAprCnPADPcCODAV9NzpldO7jNke67ZvHGavhKPwgnJ
         reOg==
X-Forwarded-Encrypted: i=1; AJvYcCUbmRIPrsAgBWVB6IRGViZpZrAmAEFoEAS/QM7ZTbLfakye5rcV/TGI9Qv9zfSYl3/oG8fVYCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl9T2uuCSCE/vC8W5CxWTmDijkG8wWAp8O6y4w7zPSD0y2ptcC
	jVirmkTgKIjECLOuLt4qdhBwW5zsP/n51Y51gy2rDBusxPuBDTu74s5Q
X-Gm-Gg: ASbGncuomP6hpUhCEHBTPQAVXdSKhim/dSnE/e5G7AZRfYPeRLg44PzVqbVBySk0Mba
	ZbYZsAg8zxBNIc/NDA4Yrd0L9hXRoqhzdxIEEm8PySX+ychnfxYqJm2cYLZamUYjHVBb3ibtP8Y
	MZNlAnF2bimqc7tdDfpn+bLFHilUUapq4bxiU7vSqVwmm+Y3m/sWEUPtL1fAu56nNWVjJcsmjHy
	ctG2j0xmEBxWwPKdb/qcW9DcH4CHBEfT7sLuZ77ccdFERv/IWAsjX6H7vAD6bxijowAQvNtD41g
	ksa4ix/mxzJ52k2yVxlIzC+Mi7ggJPL2Qy6jh6WrtjCSzvUcm/c8PHwFYss5NCKtZTVmXSt0S4q
	UOp67BF/b2U9anww6yKwD4eDsHmRCJE1LMPqbaosvMR5ithb4ncOqu0k+JA1wBevJRl+jD7nD5f
	8ugU4=
X-Google-Smtp-Source: AGHT+IEvRv+kygrTplD6p7uaH0hNC2+/LeFm8cJChsnRJhKxJnVtaAvlqNfs/qdzkRiP1g8V6Doe0A==
X-Received: by 2002:a05:6122:2194:b0:559:14e2:9fc7 with SMTP id 71dfb90a1353d-55e8443b290mr987345e0c.0.1765036509721;
        Sat, 06 Dec 2025 07:55:09 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55e6c939f42sm3717810e0c.11.2025.12.06.07.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 07:55:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 06 Dec 2025 10:55:07 -0500
Message-Id: <DER981UI3N4S.1TN7U3YSJ4LXG@gmail.com>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Hans de
 Goede" <hansg@kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <Dell.Client.Kernel@dell.com>, "LKML" <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 0/3] platform/x86: alienware-wmi-wmax: Add support for
 some newly released models
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>, "Kurt Borja"
 <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
 <49c9bab4-520f-42ca-5041-8a008b55f188@linux.intel.com>
 <DEQIPUKHDQYB.2LLGMK25N40VN@gmail.com>
 <20251205-masked-classy-ferret-9bb445@lemur>
In-Reply-To: <20251205-masked-classy-ferret-9bb445@lemur>

On Fri Dec 5, 2025 at 3:57 PM -05, Konstantin Ryabitsev wrote:
> On Fri, Dec 05, 2025 at 02:08:52PM -0500, Kurt Borja wrote:
>> >> Thanks for all your latest reviews!
>> >>=20
>> >> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> >
>> > You don't need to signoff the coverletter. :-) (Hopefully it won't=20
>> > confuse any tools but I guess they should handle duplicate tags sensib=
ly=20
>> > so likely no problem in this case).
>>=20
>> Actually, unless I messed up something, this is b4's default settings
>> :-). I'll take a look.
>
> This is intentional, because some subsystems use the cover letter as the
> content of the merge commit.
>
> -K

Makes sense. Thanks for clarifying!


--=20
 ~ Kurt


