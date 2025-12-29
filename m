Return-Path: <stable+bounces-204116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CCBCE7C23
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 18:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E21D53019BA4
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50D13191BF;
	Mon, 29 Dec 2025 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq0gS5aN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B82798E8
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767029506; cv=none; b=bOu6PV7VqPQmBi/5SOet9QhzeV1MvCbk4CG/Gq6GNnJ9amt70QLINkn2z9nBvA1FuKaGd/C45vGPwcsvYZPB9j8zq6JZu/2fCjiLlmSWf8Gz4IxSYR1kYOaSBIGDHO6AZi0v7M/LKlxTmvYm7F9VQdN1dLYE3OEtCro7WEoXjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767029506; c=relaxed/simple;
	bh=sB7PMENR+fUJKBXKq/NIHJWq5FasyFV7oFqxpse5Luw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6olilPj+MELV2scw8K4IxpE7DFPVxl74Xn2+WGnA+rlUM4iX8iHZUhunOpndqgo/gQyyPV+IfY+nEyA39GfdKM0NhV9YXo0kYXrL6GXh83hFS2+p1ssL4z33hJLbXSOuxP2VP2FbIFmZxnbSofgJ2FIrcmf1HXKIlHoducv6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq0gS5aN; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a37cb5afdso123596956d6.0
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 09:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767029504; x=1767634304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB7PMENR+fUJKBXKq/NIHJWq5FasyFV7oFqxpse5Luw=;
        b=Nq0gS5aNbq7/2W6OwALp60KoJGq0pTdnv2L1v/GgAY1pxJ/64Gq89okt3X6l8yG+Z4
         +cR+DaS5WoGZDfyG1s2ka5V+i+57Ca3MFf+RiJRRbrjNJuo69Ka2Cb7qWsm3KPDVIwRL
         kSmAeR4/7zIA5MJd/t42MTLWOqPkua5up/jCsbiAirALATLYgbsCqIxTVPPirLEtTe5y
         MQ39Jm03wSvPz86TTQT9oXAqo1O0vjz9kdCyeg/MOUnXHDx4HorLmVzoK8x7xuOouPEW
         voTNu9s3hIsBCGVMk1JxXmd0NXynmAS2XikyO5yFQDGiJtOBk4n4LVavPUSEAeZJOKcW
         DZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767029504; x=1767634304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sB7PMENR+fUJKBXKq/NIHJWq5FasyFV7oFqxpse5Luw=;
        b=hzAdwYiwJGz/0AC/GQSf85uUSZCGbOahXDOOgXKk8A4rqX9Rr/69CGN/lElDkYcXEH
         KHMwL4TrCDLG1fLngPbjnWUpGMDC3BOM7m+SJn5BIX/RJUvxgZYiY6H9uxOvO2PXDhH8
         F3JHhAIkIZNKIdROMSshraXfSD++RVUwrtEUwacbpODmYck9LUG8gOFSS8h5X1ggjURU
         E/fVSiAaCf4ubn/9jRoPSuXxaP1KkxuSvlizhPC0/bYHcYO82kzeYUra3SWvyAX04jQl
         dQ/27nYK+mlxhfoJpBHskYFBzek8nRO07RJ4rv50jzKMxoLyQZKpnAuDxUfb7O9/WzQg
         7XoA==
X-Forwarded-Encrypted: i=1; AJvYcCV75qJ55+SVWSl1U1xx5sd3pLNtlhRUYnJ8wldGybaBcgl0Ufya8JOMavP7B8V3ZOAH312R4Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKC4Zp/xHjpcaF0H1IcqhXDpR3dnizFjg6Qr8h8xC1+VouXqP6
	hy7KCeXgxyYud2SuBvqu8dC1axa7D9HF4kNo0poq2yZOPZMKN8Ip3Vcvj6IPGq04KBRlQMp/QWH
	2QNfYFjqYFkwonLkE1QDqOpwZWtMO8No=
X-Gm-Gg: AY/fxX4ApQV7V7BdDHgPBms5qaw+88t8qcnLVcpOC5bw9C6ZRMAaPFVItgKcuFvdZv8
	1tdQbR+N/kbDAKSA/VUI5bRiAaDjs8vA7OKdkEUUsZ+BGWZDDM1iJg8dxvcpI8zpogzoq35LePf
	9ndvhApPFD9NboKFlev9GZbiTiDtXypcYS5A993HbswZd3wYUjTZzQc7hSBDmhyQwV6SErq9n1Q
	7HH+Vdy+tSllzsJuq/U+YQrHxlLcI69v2YWMSDwp1vT4IXuduVbw64fpq8tqC6UX+jZcJg=
X-Google-Smtp-Source: AGHT+IGDxLR7Z03xV3XbEXKkFDRlCfk/m3k4fSRe5IvkmWIbomYdGm1s3a5gug/3SMMWc8tWJUxPNceY4vdDTLUDSpQ=
X-Received: by 2002:a05:6214:acb:b0:88a:2d2c:3b4 with SMTP id
 6a1803df08f44-88c52cec520mr545716466d6.29.1767029503921; Mon, 29 Dec 2025
 09:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230-fix-use-after-free-gfs2-v1-1-ef0e46db6ec9@gmail.com> <1c3ede9c-3dc8-4ad4-9068-4e8747305856@web.de>
In-Reply-To: <1c3ede9c-3dc8-4ad4-9068-4e8747305856@web.de>
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Tue, 30 Dec 2025 02:31:32 +0900
X-Gm-Features: AQt7F2pbCId_uS0ILL_uCPZpwjAY6zlh9s_alBDWmFy8aNpk1UeY1OWbNgmFXwg
Message-ID: <CAHMDPKVyKBiiDN+SDv7D41Apgmw8_tdVPM388vnYb4NPkXapPg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix use-after-free in gfs2_fill_super
To: Markus Elfring <Markus.Elfring@web.de>
Cc: gfs2@lists.linux.dev, =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <agruenba@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 2:25=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.19-rc3#n94

Thank you for pointing this out. I will fix the commit message by v2.

Regards,

