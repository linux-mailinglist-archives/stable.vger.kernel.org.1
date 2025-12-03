Return-Path: <stable+bounces-199937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D56FCA1E52
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 00:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5548300769A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130F83254B9;
	Wed,  3 Dec 2025 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY4K88Uz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C132721C
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764803246; cv=none; b=iJxwZkqG4647qGTxG5X4FguRJOoTFQuuQdvmVZEPs3XkfHYQdgkUdnFAy+3jHqEJZEe4eS/kJnuq8G+q6N2otkLEmELESReryklcii+xwE2BywLDECZL2ph3VpoZuPbvVfZF7k+T8hR83hF+nbKMc1dE2Sntv1UQ1Ce5P0Z5few=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764803246; c=relaxed/simple;
	bh=ARjBU24hBcskgb7NtDM1BJQCy1LB2oT4dOF6omBJasE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCEpe6aSAtPMZg5QV5bX7d01vicw6MCyzL+G1rwjV6Dl2a9DuXdDpXAU8zsFxr6YGWrH2gLuDtVgoUKwvdSlkFlSInWzwoz5Vqq5eGPCwjw7bd2UtfPxZbpakwZb6h8U2FLiO+QQaFWs52W0MvJ1+AW6mt9QjTUijjnf8CCsq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY4K88Uz; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8824888ce97so3305106d6.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 15:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764803244; x=1765408044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARjBU24hBcskgb7NtDM1BJQCy1LB2oT4dOF6omBJasE=;
        b=OY4K88UzxcvkONG26+JORFBUO2QDasetSxjwW5bSA0nRRXZ92JS7pMr2Q8g7aK9o3+
         MD51NDs34S6ZwVGm9X7VVRcTeRcFlQw1utEkK7ib3kCI2L5YclEtuIE0VsjbFysXXxwG
         LXhbeR2/iSxRjg7hgD7iTaCi6S/JgO6O4tETbrTcXL/DVxDgR1ZxfgqxVpcYaKtmh0VH
         ChgpRRHdlKeIyNeyraFTeVuF2QS87oOAIh0yhQHEmdXhZhnxuhRk2Kq5iv1bEiqUk3RZ
         o7jGyGzHZYnQ0huRw9/C1NR7JuLEXdfIi4W8s3rYn7c+HoJfgVhYv5PooXsc/rhVVRwq
         +KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764803244; x=1765408044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ARjBU24hBcskgb7NtDM1BJQCy1LB2oT4dOF6omBJasE=;
        b=GLyImsua3c46Z1AGprHtb7Nie88+mBH2fMu5yv8OnOLNw9+UJLWbViiPWSv2RG0sm8
         F6+1NER1sCmnoiFxErYu04B8PK0mQOcxPMj8LKv37yRimYbl4NYGBfVvKo2Qhc7wA9hx
         tBjo8WYBSYLe4OjFKa1QQ8SH2poMmcCj/8Xvl2ajk8aLFB5zkk1X/gfvhPde/8C2v+rS
         sMy8wzKYde+zKcKNx2Lx91QhM8pJDYA4CzGkKAi0N2zP6FYdEsjD0HJTP+feH0k/oL/u
         ArPYvnrmMaQwFJi8Vn4v5U47+j4Ndn5evkmL6Mhk0zly9VlyVAnlCsXtr9CRdxyv+2Zl
         atjg==
X-Forwarded-Encrypted: i=1; AJvYcCXAz7RE4ofvuGHRv+BLS7pDnHdzgQO2fviAifmtE2+kSMwqdCW5/leQp4bkcHVoFXAqL53A7lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKDoKpu7sGRqj0bo0IA4hUqoDUGn+gnogHuDYLgzwzqZx3HeF
	el6wp4hh6yYwlBecw6NgX7yyeGWuTeaSM+rXCSEzc/TDShJDaGdDeW+GT7BBdWOslfy9C7e3hMm
	vyWNnB9joBL7DHr/qgm+1rlCsojsylqU=
X-Gm-Gg: ASbGncubBlG/vDWIv27REilXntt3nU7lfjXfA3WCZaN5Gf7qWEG02RJ4ijVqkMLI4HJ
	AFtyUoPxiYzTApITVQ2kOxOW9uvx6X2xZ3vdlCAtsNYCWvOVdWspkHYzpAt3SSlwoXWSCo3XfHR
	U/FT/J3pWJSZLu1S0xtDlvpU/rVblBolfm49ybcK2OReFrQVJm04IHp+znvYBt/txTffL//BQf6
	3HMuWDQjZ+KMn0Ss/Kgox+OlPKJT6YAh2x6EDbnkgzzLDOkV0/+kaPsUF7JJdXrU7gH394=
X-Google-Smtp-Source: AGHT+IHeXlWltuajJrx5d5zaBmOs+3Uu+5HXat5Ce2MX4X5ZPI8oXVau0JJuFiDWUeYCCz9yKCjgfAUsfswBi07X5PE=
X-Received: by 2002:a05:622a:3cc:b0:4ee:1b0e:861a with SMTP id
 d75a77b69052e-4f017592726mr59846181cf.13.1764803243439; Wed, 03 Dec 2025
 15:07:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203202839.819850-1-sashal@kernel.org>
In-Reply-To: <20251203202839.819850-1-sashal@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 3 Dec 2025 15:07:12 -0800
X-Gm-Features: AWmQ_bmqhNk5StWxxmTMDLwKPZbVHBIiLQfZnv8DcnlEQfJufs1LWeozSv_ldNk
Message-ID: <CAJnrk1aSf+bTiRE40BSM72y8p_0CZjeJ4AHF78QbxxPicmPMXw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.18-6.6] iomap: adjust read range correctly for
 non-block-aligned positions
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com, Brian Foster <bfoster@redhat.com>, 
	Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 12:28=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Joanne Koong <joannelkoong@gmail.com>
>
> [ Upstream commit 7aa6bc3e8766990824f66ca76c19596ce10daf3e ]
>
> iomap_adjust_read_range() assumes that the position and length passed in
> are block-aligned. This is not always the case however, as shown in the
> syzbot generated case for erofs. This causes too many bytes to be
> skipped for uptodate blocks, which results in returning the incorrect
> position and length to read in. If all the blocks are uptodate, this
> underflows length and returns a position beyond the folio.
>
> Fix the calculation to also take into account the block offset when
> calculating how many bytes can be skipped for uptodate blocks.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>
> LLM Generated explanations, may be completely bogus:
>
> Now I have all the information needed for a comprehensive analysis. Let
> me compile my findings.
>
> ---

I don't think any filesystems had repercussions from this. afaik only
inlined mappings are non-block-aligned and the underflow of length and
the overflow of position when added together offset each other when
determining how much to advance the iter for the next iteration. But I
have no objection to this being backported to stable. I think if this
gets backported, then we should also backport this one as well
(https://lore.kernel.org/linux-fsdevel/20251111193658.3495942-3-joannelkoon=
g@gmail.com/).

Thanks,
Joanne

