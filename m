Return-Path: <stable+bounces-111132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32679A21DF0
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6A53A5F8B
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AEA8462;
	Wed, 29 Jan 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JV7GcniA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C97EF09
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738157917; cv=none; b=bGhsVw/d9+MD+lD73EZapga4IyQvLPB1RXVYyRb7hpTSF4lLMFfZfbD7wBleuhMWkRyj7WJQhQfjn5g2cJwIbghx7TARROh1belhP9DMiouf0//xf5v5IRwY0Sl/mya0Ss5X6P3OWLrlZcz7R0IkCFGlcJ3cFT9c11E21yADeUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738157917; c=relaxed/simple;
	bh=geOXmdnl+Yq5Zr+Yezc7YO8AQ7EYXSmKc01YW0AqDwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/m/UkTpnNIfBXxJv4bZAWCzNe7iPl0XHBSNFcT9Jb9uSkqxkDCUrFTbsmTIyX1Wk6BE6EF9IUxBrLZo8WNGukuL/pXaYdqqMV03YvUwFoky6j5HM3qfeZMkLV4fg/CqNfrWyCU4iaxzppcbE53ZJRhuBgvcN8hlUtmqv9BD01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JV7GcniA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa68b513abcso1344931966b.0
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 05:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738157914; x=1738762714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=geOXmdnl+Yq5Zr+Yezc7YO8AQ7EYXSmKc01YW0AqDwk=;
        b=JV7GcniAqHXa1RAXtWSay5kv6rdqua95FUhtCrlT6HWJ/nV9rbVOAaNTz5PwFNfKJq
         2gDlMvysl2CHFkz/MMzObFBFq2Sw0MWAUFfTgWL2dbJ150jiF5UIl1LEJgV35nNMnr7P
         puaFfKRQ/GthqJ78qPlYY2w0TvfsAcn5i+l7n0F0ne2PUlDp2UsZaWekTac5UYfCM/Ws
         VqygBbx6SDkt8B+8PAHsBOMSFKeRS2BWdzQLrqIinbYqnGXO2k+MMAPX5spWFf9Hhuuv
         yfDH2CEmOkUjlE/Ja+pmTyJ2xeZFFlsm84mchjkiaypNOaFKKICOaUazKktXH0Ky++4K
         cmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738157914; x=1738762714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geOXmdnl+Yq5Zr+Yezc7YO8AQ7EYXSmKc01YW0AqDwk=;
        b=ViwuTp2In/TCeP+DR+/3WVxFxEZRvS6UAd5ox70sF6fmDOO9VmpOif3ZogHQ3TvJ6X
         1q5eij/9PhTe5dmNASpPMGj82NLrpNgx7AZndNufGBAWgdUGkkaXt1XHQFbY9dOUZtAH
         Pf/0X/5uy6H43li7S5ruGwGPxzI/FmxFMzxT2e9+YO7iPEENEAHQrY/gJE0UQjLg1UyK
         NXfLkDGKKUAiZKtTnP4nTZM+X2Wvup8tSXLR2mh47Lo4NDLD0rZvA8UbHn0j2MbVVQyl
         jVvcEHzl4Gbc6xrVISudEPI01zr4BI2ItfBaKENWwmEVnjmdrdmRZZEETlX3VchZGPfD
         GvDg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1BsvzE6jmoKuGAkr7doKNIz3zw4GTBXTUcDkUmZXUy5EDTcHQar3mi3Vq6oWafA6cQOwJtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKC2YwdLsMPPR+Xq7Ag+dPTUR0CXtidtSsNNKFK0o80E1MdOY
	IdesZ48PfghTV9zOoQ1ngW5IPaxma3pVsA5rsQAF2BJ+Jr+QPktw9AzDlKIjM4r4XaXp2c+CqEq
	z6Gg8wsXsvKSHizAsMB5Tvcsko/lV000gW8ccYxDkPAs9dcMb8vioecI=
X-Gm-Gg: ASbGncs6Ij967mxjxHGbT/1yPR8d/0rUm1xjz0hL7mVQVuZOT63cP55RFgSe4Q2rPp2
	hTdnhd96NMkXdon420l2G4VFeBfIoO9A6+2SUm6LVGcxfu0yZVbTeboXZStsYiHG+7X6ecDBBqz
	xRu0P0T14ctqJDCyk8QrzVtPdshOqx5bNQ+xFv
X-Google-Smtp-Source: AGHT+IFYaK79RKgTGAJVqdudRFWYrmC0jZoD0qFiPgjMHOc1wFuPxvEurIcZ95EBXDcl5L2L6SIOaB0J9+TXC6lQ+Jk=
X-Received: by 2002:a17:907:7f26:b0:ab3:30c5:f6d3 with SMTP id
 a640c23a62f3a-ab6cfcb3a8bmr352966166b.9.1738157914301; Wed, 29 Jan 2025
 05:38:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128150322.2242111-1-ciprietti@google.com>
 <2025012815-talisman-ageless-45f9@gregkh> <be95b807-dfab-4a4f-9e00-b498e548361f@oracle.com>
 <CA+PG2H1tRRJkWBVdsiA1fcqYyVMdOPauJqx-HJKhXdwxK9frJg@mail.gmail.com>
In-Reply-To: <CA+PG2H1tRRJkWBVdsiA1fcqYyVMdOPauJqx-HJKhXdwxK9frJg@mail.gmail.com>
From: Andrea Ciprietti <ciprietti@google.com>
Date: Wed, 29 Jan 2025 14:38:22 +0100
X-Gm-Features: AWEUYZmr1JXaR2S3-N6mlYHN6HCOoApSsr1HrzBRTmltjla6KSQk3iWGfcU27WA
Message-ID: <CA+PG2H1-u7ikrUjTYeGHZB7ezsxSSSpOVJxsOZczzLYGgHaqeg@mail.gmail.com>
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Greg KH <greg@kroah.com>, stable@vger.kernel.org, 
	yangerkun <yangerkun@huawei.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all, thanks for the replies! Understood the NACK, so let's drop this
backport.

Just not to let Greg's questoins go unanswered: this was meant for
linux-6.6.y (sorry forgot to mention it) and the additional cast is
required because the type of `ctx->next_offset` is a u32 in the 6.6
version, later changed to unsigned long which made it possible to cast it
to (void *) directly.

Best,
Andrea

