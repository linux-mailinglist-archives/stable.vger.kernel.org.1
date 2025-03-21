Return-Path: <stable+bounces-125785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C5A6C1C3
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6048A189249D
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9372022DF8A;
	Fri, 21 Mar 2025 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYF6vHtg"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE418E76B
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578939; cv=none; b=JzAOM1rxUqNktc7k9jdLNplMMflPTg2YS0y1TB5qHiBZPiKWDVkNiJq7gvFonYIlTK5T5ICtewcN/QFzfmfgsygQ62lrtDbMvQCa/OL+JTHKroxPC0n+Pv0lejCzMBgnRARqtbwRyQQ9blLitgNDiATyJ+RGX767/C55IiUYg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578939; c=relaxed/simple;
	bh=O8HNSU/IcyXH5CqMkoZUbUdAcq22bl16ho3hMHgyci0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGtsw6MwK8ZLxc/oRKzRnkoFH5xY05xsr2wQiYx4DqPR7y1mZBNQr+A9FR55KiQTpw8eeE0SqAWi2p0s1eSr/ITIMg3pOV4rPi8/HnQN0/Hf2dV/kOy+6FIoesUTzJlYTWwW1dpSXD82S2fU82mo+bloT12kbjgUHb2rvhOAf0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYF6vHtg; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso1999182276.3
        for <stable@vger.kernel.org>; Fri, 21 Mar 2025 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742578936; x=1743183736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O8HNSU/IcyXH5CqMkoZUbUdAcq22bl16ho3hMHgyci0=;
        b=eYF6vHtg+tZUArQIDbpqEU3fOMFe6z8fGx+yB8KOauzMY7JcQUz7HqCnUjVUbm6BYh
         rLgoJkx/T0qmI9rirIkYaN1EMRb8n2mKALBhGgKcvfTxL44Z4VQYUs3+s4qsCoPh0zlG
         yW8mFIfYrA4VRXNapbjq3ZiGFKrcjFdr70LVRAolWe41xtYA9PM0Wpo/eHWJ1Uy3/R6U
         654iRROe1qh2Sf9ecS5CW4ki1asr5chqZMyDqAmXyv9NFhjIQGltZuLS1keeqhszSAZn
         tl5Th8KdXt3t+0cjETSf+DQ1nDcStExHjEjOmJ1hwm91T6jsefFSSJ50xVaOGO9/BoVN
         6agQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742578936; x=1743183736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8HNSU/IcyXH5CqMkoZUbUdAcq22bl16ho3hMHgyci0=;
        b=xKP1pUcuuGreybNlzMNtwncPKhWX+2kajlC7beAGjkKMFmrr3VJb9LT/+IH4FStXQp
         MXHs+kFaQEv84phgcmLhwnBCuMCrXwt7KoHWx0Vs01WbikBEFx1TJMfiL9u/GNpQrWaC
         7lHZdXwkNem9h3uQVtS6GaYfIzxUlpZNt1lQCwSyt1SAvFc72A3XE+IKoYEoEEfiWnuH
         mmQKVMoOiwMawkmJ/NUZS/QPjqTjI45Sss6nPgBmozJ0JpBx4IFwTd/MFzqPlwzGSJpe
         PtN/b+nPxG4l+lFEhAhFhvR76XI5f6X7e8Cfvgr1WUxRqEQ9+HURzMCqYPWUmtRA8k1X
         2htA==
X-Gm-Message-State: AOJu0YzN6jW7cXk0UU6KICyhNpluwKFY1wAsJVnVdzqbWDRLHTqB0SB2
	x4p802O2VJaKz736T7TSIh3+mSg7gJlTCscopEGsvWEL3EzdRuOR4/TOsqzVYcXM9t3o1kLrOVA
	qgsvSkP6nJxXdbyRAc4UFghjyrtA=
X-Gm-Gg: ASbGncvUzY7pZJlRGhXF0QtALSaF/HCaiR80BLJoJO8MOhbo1pPmPu/ogjIkWZO86vX
	wigLvP1SVaVtBwxbqAbTldJLKM+gQWlINmDN+eepblcn3qbaMzP6/KaLjfQkn4pTbHVzetlDnMJ
	6JDNWt/SJaVzrnNBeJW5u+ueceDg==
X-Google-Smtp-Source: AGHT+IHJr615eXXIZU6bwZWXsBDn/nD1fjL5diPEpU9KTVY0IQ52JPSejW3pyrEbSpNOjBSF3l+bEmN+TQys6B3922U=
X-Received: by 2002:a05:6902:250e:b0:e60:b1ba:5778 with SMTP id
 3f1490d57ef6-e66a4ffca63mr5353925276.47.1742578935639; Fri, 21 Mar 2025
 10:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313202550.2257219-15-leah.rumancik@gmail.com> <6pxyzwujo52p4bp2otliyssjcvsfydd6ju32eusdlyhzhpjh4q@eze6eh7rtidg>
In-Reply-To: <6pxyzwujo52p4bp2otliyssjcvsfydd6ju32eusdlyhzhpjh4q@eze6eh7rtidg>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Fri, 21 Mar 2025 10:42:04 -0700
X-Gm-Features: AQ5f1Jo_oQUlRsboZQD1E30h89p6Le4WZFdnGod5zsWv_F3bYE_prYs5yPaJHO0
Message-ID: <CACzhbgRpgGFvmizpS16L4bRqtAzGAhspkO1Gs2NP67RTpfn-vA@mail.gmail.com>
Subject: Re: [PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover
 intent items
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: stable@vger.kernel.org, xfs-stable@lists.linux.dev, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Catherine Hoang <catherine.hoang@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"

Hey Fedor,

Thanks a bunch for the report! I don't see xfs/235 running on my
setup. I will look into why and see if I can repro.

Few questions,

Were you able to confirm that e5f1a5146ec3 fixes the issue on 6.1.y?
If so, we can just port this patch, otherwise we might want to drop
the xfs set while we investigate further.

Also, the backport set you mentioned was based on a set from 6.6.y. I
don't see the suggested fix (e5f1a5146ec3) there either. If it's not
too much hassle, could you see if we have the same problem for 6.6.y
as well?

Best,
Leah

