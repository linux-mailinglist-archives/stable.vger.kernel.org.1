Return-Path: <stable+bounces-74086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A7E9723BF
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 22:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA311C235D3
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 20:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81DB189F57;
	Mon,  9 Sep 2024 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ymar0CjH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702017623C;
	Mon,  9 Sep 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913963; cv=none; b=NmAK2//WXKZNHpNA1cK6c42tIq0zTkL4GN2nO+W4Vz4X3dMlpwUUX/5j4bEy1U1x3UwALGFBCEk3dudzwGhMPKgJ0RC3DW5nUVxpwbl3G1TabJn2g3aBfME3oj3Gz3MlxW3JpBoJHF6zIxR19dtsmHh7MEXwfwURVrEbFP4QSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913963; c=relaxed/simple;
	bh=AJhd8owgl3wgf9vnWFFzARsYkI3LcQ0Uzl6xhNwmfsM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jBdFJ5xVt60aO/f0ACl0QTJTq4yXzOj7ICjRIYWaIAZV4JmYlYPR5uYUCo5Q5O6eOnAlfx3cMijTRw0Bw74b5P8my0V0OSkuBvn/LPzk/pv4aBh26yf6NKXZVDPZxsosqAikZC64n97PJIDfgt98TntXyvgMi48PUoUcB5TySEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ymar0CjH; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c354091616so27215446d6.0;
        Mon, 09 Sep 2024 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725913961; x=1726518761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJhd8owgl3wgf9vnWFFzARsYkI3LcQ0Uzl6xhNwmfsM=;
        b=Ymar0CjHKLPniBICg0K8ofRw+IogqfTWAxQHpJlmTb+ooSXfPKu59QUGMCgBFADAB6
         vT/1TodKII3g9DoPHcT6Q4Bkf/O4zRDuODh72xbyNAlj87TSh1Pu00Z4ybanRdZPtwXY
         Oflrze3vs2PbWcU7Wq29oXO6D8qVFphpym1fjCc/tkCegJGRyqzO2nq7lfKHPA1PF+T8
         1cnmIyZknzq9rDf6WBFiZvUaIIcOx9dw50UVhs8ThHLkSmHj4QIar1+pHkeHYo8gnpbm
         8Aa1AN8wkQ4qu0DidGe7iLHd8yyr5G1Mjpb5tZ64kuW9oLoksfwZLSHw6YbxoQzZyWT9
         ISMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725913961; x=1726518761;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AJhd8owgl3wgf9vnWFFzARsYkI3LcQ0Uzl6xhNwmfsM=;
        b=e4fGtVD4Jo3iq+BGtEPCAto8kJv2wXpj1b3sEIMU6UJIbc7o06vOWIJlrZQ/rB3uli
         m40YTXB56qFnx5qcfDxCTL4MMq2rCa3HLyPefRRqbe6SGd689YJjuPL7hg1lklQXhekO
         bt0t7eA7xv6K4KPJn9bPDsE8sb0OztJ9Sk2hzSVOd/jYe6fu/gptiwL2FZiop3BemT3t
         iuCqL1nLHsrazqRCbUFIqyQLuia9ydMb1qVq9Ow6RbGsOIkfIY5M0a2FGp5VtZpmk63J
         fRYVvuIhKMWLZ+LKCX/TwsEGyCUNvgwln922PnRxaabc3hurTH3f9ZPl61+8GHyTeqsk
         s3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIeY6XjW6Xq+3nxLP6I8H52bv1gFBf1qXkfbRBK7l18oMreDB1f09/WQ0JtjRRZY/gSEJV6+0Q@vger.kernel.org, AJvYcCVbTevv4iCiViJMENSwAg8TIgV2Jc0DBgDHN27fSIuJwq2YcWnNwaN0P89nVJxAZXqoN5s1R4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4NU6bMM3XQ6znRPQMRVAqIftViRCfjMUk5nRptWHRxW8Qblc
	4mUbEd0e5/ZyoO8EpuyXc0moCRw6EYN7RvMaLrc7FVY+J8VJBZWz
X-Google-Smtp-Source: AGHT+IGpOpN4QIrmPyS4/VyYBCv6C0MghytA7UdSQ6aM+1e63zWW6d8Cl9JLbV60071xSvGltyiGkg==
X-Received: by 2002:a0c:fb4d:0:b0:6c5:317a:a664 with SMTP id 6a1803df08f44-6c5317aa66fmr94833696d6.3.1725913960989;
        Mon, 09 Sep 2024 13:32:40 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d844sm23884196d6.77.2024.09.09.13.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 13:32:40 -0700 (PDT)
Date: Mon, 09 Sep 2024 16:32:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Christian Theune <christian@theune.cc>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
 Willem de Bruijn <willemb@google.com>, 
 regressions@lists.linux.dev, 
 stable@vger.kernel.org, 
 netdev@vger.kernel.org, 
 mathieu.tortuyaux@gmail.com
Message-ID: <66df5b684b1ea_7296f29460@willemb.c.googlers.com.notmuch>
In-Reply-To: <0B75F6BF-0E0E-4BCC-8557-95A5D8D80038@theune.cc>
References: <89503333-86C5-4E1E-8CD8-3B882864334A@theune.cc>
 <2024090309-affair-smitten-1e62@gregkh>
 <CA+FuTSdqnNq1sPMOUZAtH+zZy+Fx-z3pL-DUBcVbhc0DZmRWGQ@mail.gmail.com>
 <2024090952-grope-carol-537b@gregkh>
 <66df3fb5a228e_3d03029498@willemb.c.googlers.com.notmuch>
 <0B75F6BF-0E0E-4BCC-8557-95A5D8D80038@theune.cc>
Subject: Re: Follow-up to "net: drop bad gso csum_start and offset in
 virtio_net_hdr" - backport for 5.15 needed
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian Theune wrote:
> I can contribute live testing and can quickly reproduce the issue.
> =

> If anything is there that should be tested for apart from verifying the=
 fix, I=E2=80=99d be happy to try.

If you perform the repro steps and verify that this solves the issue,
that would be helpful, thanks. =

