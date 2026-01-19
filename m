Return-Path: <stable+bounces-210411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4025D3BA1D
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 22:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68FC9300A900
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 21:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827E52FB630;
	Mon, 19 Jan 2026 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDvFlQ8r"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD1270ED2
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768858589; cv=pass; b=L60r5w6XPSE+EahknIlwJMv+ttwuWhRp8OHxcFbL7I5JkJfVMw7owdRJYu30okpubLzrFZ6EyeojOWZRBn2w6T4XYNLa96GnPxXJsfMtSUo0JIGDXEHa9VfytSN46IJntkL2vDElxo6UC8cTxyLDvAMrwokvAL2J9SjXC6elFHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768858589; c=relaxed/simple;
	bh=ZIySP1q5PMnveIa/i279C9yGcJJ4/61I44p5rwmCYqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+eL+kacpGPE3nv7rHO/Cqrk0H+3Mgl0+ILq97FnnYTfpwsCybHqZhmESOuJz3O3Qt+x/fwNowQTQbCuI8DKn4bEWyIuKqvfTYr3/CMRz1nJK/3iRNofBhDIqLjQ7iDvi+8BzFL0/hHeIGlrTEH8OQLybaKNriTMFKhZAMj7HwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDvFlQ8r; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so4330543f8f.2
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 13:36:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768858586; cv=none;
        d=google.com; s=arc-20240605;
        b=C7DVfGHointDfwVSdNvfddgaGSDfh79ZnUtva9C8fieqPegqsI+4P+OTJyK104LPrI
         /hYlB1ZCJdkCzgBVMnH9waOdrGuzjoE7zI0MVaxw9FPSbgwOOsjniAXkslMTuVdEJz+0
         RxcgTz/D7XeueTD/1xOVTKglIeHL1VRTe8GlF3NvNFrZnr1hakL/Wxs4yRYG32F5AUNP
         6ZeuypsvC3N3nw5VCJ8MX290BB/DoFFbZIxJR+YiwgKNoswaucfOmGo1u8v9BR58IeqX
         JicejrYQscv2iq1u8b+q2tCamooDOF8qALs3p9Aeo4U2Porj42K1IOWCV1s4h2nv9VjB
         0QRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZIySP1q5PMnveIa/i279C9yGcJJ4/61I44p5rwmCYqw=;
        fh=r9uAV0ZNXhr1cm8Q+5B9PWdVG0vXYK69rZNX424O4UY=;
        b=RB9XrJz19l2kOfF+wnFGrX3VnIadQBScrApcuAkvjKqRmA/ymDmhpceBubmWbFrYBS
         bL/3q1kZRX50skqyKo85d2En2+WLoHdxZ2A6sb8KE+cF/lqlE7VuR5YWSDbhbDdTgPD7
         7FkuSglSfw6IVM0L2BZKeEp5zu5NtuTNJ3TRC0uDUQs0nTD2LueXtViw/QHuifgmQmt0
         D0cAg3AdsTBWlAqHrdcNv8b67nMRbjvN6QOh0x6xnJv/dRX4YPlknQgzRwhUs5WnQlPS
         qCxClbz6CVc65bVZqjGq89S02lHgqgosfX/aw7ZM/Sby7Y4YI5zFxKPuBsg0HR4podIa
         5rkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768858586; x=1769463386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIySP1q5PMnveIa/i279C9yGcJJ4/61I44p5rwmCYqw=;
        b=lDvFlQ8rY/TJOr1VLBm+8Ia/DFEM/PH7LcDmenl5MAHV2qzrX5zUev9rT4uzwUFylY
         usqzrfFmhSZmI/RislSWLizpYoPyrjfBkgw0bEihDJULFl6+U84DzboGD61yjhmKl2aQ
         IyKRydFp3ZbuGa475jnVS5QN6zIe7btK96mqQNCqFg8mnmjeR1FjRG01L9CPAxTh1j82
         3ThssChlAY0yuRJ6/vDSHsJjopqm9ftDPuJFSDcu7kFUZdF/Na8rWeMohMJBA3ednJZG
         lQgyqoTROkrqLz51V52wRsY/4+prFE7TV0HxTwELQjFykL1KxqDiDtMyEQsK11Iy1KDl
         LoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768858586; x=1769463386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZIySP1q5PMnveIa/i279C9yGcJJ4/61I44p5rwmCYqw=;
        b=t6rysERsVDG2+pU5XQENt7aOOibIp24umYL4Wb+Fl4UvATDTZLghf3kffuQq95j20p
         ZRS4SOEvNViNUcnX4HQShj2m6GBhZhoCjQ6hLBbttIl46r9am+xvjV7yzkH/cvuSC3GG
         E5JBNyd2IaLIiDjJ4k9UgGGDtFzKikpJEK8AnGhlZ2QwqQSAziNkA7JbnydqGatDXXtG
         z6yKNHEUew+bc72SEH3wGq3bdIIC/uMTrLbsbpUkCj2vf/OdQViezhvPq6+6+5dqRODW
         9LWhrI0XmwICsOZFP3oJF7D6y/6BqM/4y082KGl7UE6l4a/JET5xs9qR4DchGEecE8cb
         HxZg==
X-Forwarded-Encrypted: i=1; AJvYcCWaTr/fa+fZQt7CA4LJMXtlndnS66sjCqmtCm/z+FLtHG97euscNwnFR6fyP1MpOp6r64Oxb9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3zZd8ZfA6UdWis5oik8Gg44ffaWIz6lhgDQDFMGiN90skR1y
	WeUCnpSz5lUduD9WwbqtvkoN65c7he4aTIb9cB14hVz4QDLamE0VnnBdrfTwiLA7EktjMz7oTZ2
	X/IFkKSzcrM7R3nB0IY012jD+tZPcQP6r9rPNYlBf9Q==
X-Gm-Gg: AZuq6aJNAwn5weLzdJqIZlyKkzpDS310j92Gn6AybAf3cBI6dDD4isKTvZpYELUfgcK
	zu0QDpqVlUMFBM4Fh2up+XMJtdAoq9rbrrZ4HWXRx+OmurK7k9LLeLZ9fnTwfg3TFRbDiSjnW82
	8GPwo3Zbi5et8DCE4WEyzjDAerGR+MLGKUfTA+a3veMpIhR1xfVgi1ZJolzI/7XBkLN5WuhgSsx
	kWEAcA12Zf6tGe0ZiF+FQ2VVigGM/ZA5ePejpXB5s6LjvsQxEtdarP8fa4ciRZf8P7lr+o=
X-Received: by 2002:a5d:5d12:0:b0:431:266:d14d with SMTP id
 ffacd0b85a97d-43569bc5b27mr16203443f8f.47.1768858586150; Mon, 19 Jan 2026
 13:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-shmem-swap-fix-v3-1-3d33ebfbc057@tencent.com>
In-Reply-To: <20260120-shmem-swap-fix-v3-1-3d33ebfbc057@tencent.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 19 Jan 2026 13:36:14 -0800
X-Gm-Features: AZwV_Qh0t3pt4cR5MdFu-yA0efJKL9TMIvNsuFSc3OuE-QMB2P_HMtg_1D-vSZQ
Message-ID: <CAKEwX=Omzgh92KHhaFi8-mnZ0myV1yi6XMTkT4FFsFPHFnueLQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/shmem, swap: fix race of truncate and swap entry split
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 8:11=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> The helper for shmem swap freeing is not handling the order of swap
> entries correctly. It uses xa_cmpxchg_irq to erase the swap entry, but
> it gets the entry order before that using xa_get_order without lock
> protection, and it may get an outdated order value if the entry is split
> or changed in other ways after the xa_get_order and before the
> xa_cmpxchg_irq.
>
> And besides, the order could grow and be larger than expected, and cause
> truncation to erase data beyond the end border. For example, if the
> target entry and following entries are swapped in or freed, then a large
> folio was added in place and swapped out, using the same entry, the
> xa_cmpxchg_irq will still succeed, it's very unlikely to happen though.
>
> To fix that, open code the Xarray cmpxchg and put the order retrieval
> and value checking in the same critical section. Also, ensure the order
> won't exceed the end border, skip it if the entry goes across the
> border.
>
> Skipping large swap entries crosses the end border is safe here.
> Shmem truncate iterates the range twice, in the first iteration,
> find_lock_entries already filtered such entries, and shmem will
> swapin the entries that cross the end border and partially truncate the
> folio (split the folio or at least zero part of it). So in the second
> loop here, if we see a swap entry that crosses the end order, it must
> at least have its content erased already.
>
> I observed random swapoff hangs and kernel panics when stress testing
> ZSWAP with shmem. After applying this patch, all problems are gone.
>
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kairui Song <kasong@tencent.com>

Good catch.

From the swap POV:

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

