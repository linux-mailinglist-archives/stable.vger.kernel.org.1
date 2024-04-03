Return-Path: <stable+bounces-35672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7B7896483
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 08:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA301F23BBA
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 06:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E964F211;
	Wed,  3 Apr 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFmlawVC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91A6FC6
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712125799; cv=none; b=mlHKjzoElBFTzr2vFmGNmHhI/LitykU/Xu8pnTobxznfl0XAFAnpB3a9y7UFqg9mhMP/djg8FiVbWZfiK7nhw/ob80q8SLLNz4jONSNk4Syc2FAD0godPgVSHoB6gV2SxBPBH26dJ/L6SO7JRz0w4WWb3b6U7v9W/n5NNOQ4RhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712125799; c=relaxed/simple;
	bh=ufWpwsQwO3w7N5l8kfrUN4zifR1toWasT3o5ZR9IzrI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tNATRaiw3EOBp2bz9IkF8Cy18vUaBYeYheYC9qX/WnxjUBHTT5WBXChPSFhjIkjCr0acb9JZmhVJKIDkmXU4dp7ytStcwZbdKi2UGCV5AHf7/prCsgKlydban93lg8x1yrNI3CdA5Dx+CFDfghOq4AemAT4GpbnjzATfqu+ATQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFmlawVC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56df1dbb15dso1687349a12.3
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 23:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712125796; x=1712730596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ufWpwsQwO3w7N5l8kfrUN4zifR1toWasT3o5ZR9IzrI=;
        b=TFmlawVCoW1zYZqnlctGUk6msr8po0LXoBLh+bg5L0oMkPLL8eBW/C7cLKK+YNAclt
         sRYVwxbWOo0sur85FPHRr1W5A20MiGUAHe5Tf8x/HK/pPn3Jd+WKmQRVWenwR6X8MAgn
         OzK3QoR/nrTxO5N42jghQikCWRkc58UmUrL/L+kJ8jCKay8UjaTtMHni1gsRUP/Gj+vB
         Xv0AmLZYan4dQzzhpZmYN1rtIlm22onSZ+iDJt2CA9aFwNdNWL4pfNPlE5COHV10eESw
         Hz2LdRfncQZrgTsCEgfiw2nO0Ykgd6DR+bWQq4i5P7a51qiXbyuhNURLZqz44Xw607fL
         bXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712125796; x=1712730596;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufWpwsQwO3w7N5l8kfrUN4zifR1toWasT3o5ZR9IzrI=;
        b=fzCbX936tE36LJRBtZl3EZAFMTPb84xcZJsbKuXHN1V0IE6zoCVBsXVneDcS/9RSZw
         gVLzUOoJ4bnHRmCMd65Iu48scNXbi4tzA/RSbD2flJ0SgVCHpsRYF97vOZ3iyvmFc5sP
         Nsg4eYC1zizjSMfuLJ4gctEtBJJ/7y9nuc0YknJFp07VfbFp6YAIQMlmw21Wl2tjshIw
         O7uxvJ9k4+79UYbzdZYqpKrh6tuGSxo++LTGvjK+bFK5JLAMxgozHf7R/HXaBNAfgl5j
         d4M4Kg/H5AJKfaRsRiUbqizUM9LJG4lF71BMKw/7Ei8Tz5rHYJUteTklDpolU1tEd+FA
         XoMg==
X-Gm-Message-State: AOJu0Yymopio3+nKGfZ9FPRCZ7jG9mYEPKl2D0tNZOr12MMpk+bf9tBE
	YvygnxUkNoUE+99MFlBo8qhSb4gBIfCOWnb6LExxiaGy4dxuPQmB+zOBYiF49pLwLvlHaPRtaRr
	O2jnS3U+EcwS+63yb538VIFx9mZ3hSwzDwLY=
X-Google-Smtp-Source: AGHT+IEw1IUJ05ESw0+9IgYBDtlIPGjcDwv1Qm647jQ9N1+S7uWQmI5uxHbQWlOHe0QLTUMaJqc1Jup92AKBY2waETY=
X-Received: by 2002:a05:6402:26d0:b0:56c:3b7a:632b with SMTP id
 x16-20020a05640226d000b0056c3b7a632bmr12346496edd.29.1712125795431; Tue, 02
 Apr 2024 23:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Wed, 3 Apr 2024 11:59:44 +0530
Message-ID: <CAFTVevWEnEDAQbw59N-R03ppFgqa3qwTySfn61-+T4Vodq97Gw@mail.gmail.com>
Subject: Requesting backport for 2c7d399e551 (smb: client: reuse file lease
 key in compound operations)
To: stable@vger.kernel.org
Cc: Shyam Prasad N <nspmangalore@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Steve French <smfrench@gmail.com>, bharathsm@microsoft.com
Content-Type: text/plain; charset="UTF-8"

commit 2c7d399e551ccfd87bcae4ef5573097f3313d779 upstream
smb: client: reuse file lease key in compound operations
requesting backport to 6.8.x, 6.6.x, 6.5.x and 6.1.x

This patch aims to fix a customer reported bug on the smb client received by
the Azure team. Without this patch, when a file has a lot of dirty pages to be
written to the server, any rename, delete or set_path_size operation on the
said file, on the same client itself would result in a lease break
since there is no
lease key sent with the request (even when it is valid).
Now, depending on the server's credit grant implementation, the server can stop
granting credits to this connection; which causes a deadlock.

This patch and the 3 patches that follow are meant to fix this issue
and need to be backported to the stable kernel releases to resolve the
reported bug.

Thanks,
Meetakshi

