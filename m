Return-Path: <stable+bounces-161675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F76B021F7
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 18:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3391884516
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 16:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66662EF66F;
	Fri, 11 Jul 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e04bJeVL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3F2ED843
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251936; cv=none; b=WgzIefgXaLYhN4ErG//zMWBiAfDY/WmVCzFACCL+C9s1/NP332GRgpgjDRtdQJbGWxKyqRtrSRHkf2uvpvugA09oWeYyU8cnTKhArhpeIDGtQPhduIyZ+CmRODqZvjsP1F4B+5YDsLD50O+8Dru2/Ro0WEmoHtZYnHKdn8lF2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251936; c=relaxed/simple;
	bh=GUHNdNzh4MVenPnIJ3b3PJlz94KSj55El0YY2Y5dRbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDuRbKmBdEI5ZxPHV+evJ39aUnkDpDsQ1ev7DNDTGt8OHXN9tV1TrGObfjaieT4RZSJ22pXs47cV4MeG3g2VzwFTC5tfyBT6PFI5cOO+8LPE+zN1T/aBIX6wbbZ4nP22oIiudVtnMbX0iovodIYQ74E23Fc7WMUueELJaQ7g3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e04bJeVL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-611d32903d5so260a12.0
        for <stable@vger.kernel.org>; Fri, 11 Jul 2025 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752251933; x=1752856733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUHNdNzh4MVenPnIJ3b3PJlz94KSj55El0YY2Y5dRbo=;
        b=e04bJeVLhcRswe4mTIUzewlyQiA64c3rHvgp7J4vnEC8jv6gMUPdTIaaeqljIRXeMq
         ttWFcFx0W7Me790mThOJdd5YNZCUYPPHGZjb/H0i7nUf8uf1xunGps8iWlCTbx5mtOmt
         3FzXhKD3AOlvw51G30chEbIKtssSNuj12q4fECjRzDsa4XLq3X+H0z8wiBaOhVjyfDnY
         Ghk9LVCnMgYMcvnPREauQcmj5wHeVOwnGqpDkKoXH3dHw/wC4RZ++kixW4H6hB1iQ5it
         gdTpdLD/ozQFUkIiBKOEAQaU1AXDWkdAsWuZglaXz2IsygngyJHUh7QdZtGWVUo+v2jv
         GsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251933; x=1752856733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUHNdNzh4MVenPnIJ3b3PJlz94KSj55El0YY2Y5dRbo=;
        b=UM3tOo3J5COxh4ODEGUMN+Enpi+QcMmt+mUS6dCLaKxGTbC+ZJPFv3kKhzs7mi4/9Z
         5bzWF3kEpeWRukSUJIwlF62y2agAtlrdgZq0AK8H23jJpOcUfT95v0ZcJSmrabFqQ+7y
         UtOUihO4P6DZ2r+a2wOEFJWTA/J6v31EWBIkYL9xPj1jxBfTm84t5Zlt/1SN7uoQm4gz
         3E0vEQpwmYtgwu7p9bNh9VZujdEnSllm/3IGX+OO16aLmhYEigdrCYrhYKJlgGratjvB
         UR32/Fm2nUrqpGtDx7CVaMXTneO3TicGzgj62u18Te7A0p3jooLSUIXktsgDZNjO7H/u
         FKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Iinr+mLGsSayhhgYjOX+idxO2QqaRjqhTHr+MV45d4z1WK9EmVBi4DEPqadoOankkd6Q6BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZyzZScDlYn0MbhurNtYoyo7eV0iM/9IZ/c02tzID4w8cKSOhh
	ElGuUYlqqGr/sWOHPddCUk2/Tti76Tj4752+ZTTtNBzgV3Yk2jttIgIjwEuIhcBwNPEfgRYCV0+
	Ckpx1UsaamggBIDLS9qPK5RsDKy39XrxyP4aEerXI
X-Gm-Gg: ASbGncvQwiXI0ZtMW2DMKJ/+3aM9DO8VDZ/PYsArPiQaIWrKEdBPe8HVX0W0aMPFAW4
	toQonUlAkdm0X4HGg+uzMjhuDgX/6Yq93Enr+wQbdaRZfRYLYyZGiFvofTgj87YCO01U3Spay/t
	z4X74a56U2zu10byW1Jg/665pBzXc1wVjS2iOq3OTf8iOt9Ovw16h9M+LJr7JGzGgXwE0fzDq7G
	enrOWQh/Wa5/w5CRALCCo3buNAubkwkpA==
X-Google-Smtp-Source: AGHT+IFMqWeUnIhM2GUfvqZasar43+JRQEzyaYqWWnI+VEdWQL/yjU8uiXyK3Tt6lYFu66zeKZ//khzG9Fk7nhUZTPA=
X-Received: by 2002:a05:6402:5519:b0:606:f77b:7943 with SMTP id
 4fb4d7f45d1cf-611e66b19acmr119955a12.0.1752251932816; Fri, 11 Jul 2025
 09:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-epoll-recursion-fix-v1-1-fb2457c33292@google.com>
In-Reply-To: <20250711-epoll-recursion-fix-v1-1-fb2457c33292@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 11 Jul 2025 18:38:16 +0200
X-Gm-Features: Ac12FXxBR0x-gWBXPHgR-w1y-RdUePMpUnV9bTKOU1Vmk9DbTBaD1sVhfK-yPDI
Message-ID: <CAG48ez0fWFjw8-RCLfKGXR4aNaRfZ37-GdDH=Rw2TFupAhocVg@mail.gmail.com>
Subject: Re: [PATCH] eventpoll: Fix semi-unbounded recursion
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 6:33=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> A more thorough check is done in reverse_path_check() after the new graph
> edge has already been created; this checks, among other things, that no
> paths going upwards from any non-epoll file with a length of more than 5
> edges exist. However, this check does not apply to non-epoll files.

... of course directly after sending this I notice that I put one too
many negations in this sentence.

s/does not apply to non-epoll files/does not apply to epoll files/

