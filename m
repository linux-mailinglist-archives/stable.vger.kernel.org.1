Return-Path: <stable+bounces-12307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D0833268
	for <lists+stable@lfdr.de>; Sat, 20 Jan 2024 03:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92672283FA5
	for <lists+stable@lfdr.de>; Sat, 20 Jan 2024 02:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40878ECD;
	Sat, 20 Jan 2024 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+rECQYu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E88A52
	for <stable@vger.kernel.org>; Sat, 20 Jan 2024 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705716807; cv=none; b=PUNty/RaRaHp181+hj0uBGAWDnnttvto99GfPQlR7JfmVOrHZk9Wo7+2/nRUql4PO7HprXzDDnSiYrXLeExpI+DUugoy0CsnccAqsfrrHwQvSBBtQdOcTRPt0uA3MPYLj27g6Hue4nxMdY6TVSGGFFLoYyHflrEQgwMvSCBAqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705716807; c=relaxed/simple;
	bh=FkpFU3iTdhrNoeuwVgf20iTnnMj/XaFbTby6SSlbtHg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WXdRvixKbxbIxtHiv9iCrWB4n56YGaKithdyNagh4jUdJpjJyysiPVgy5qBo+RwJuj/R8Lh71Jh4CSyTzgcYt07DSbXRMN4L9f0vE4FMgGEMXyvrOI5l8uHMb3nTD6KZXS4lZOk3gEEUmELAOe3hTmweBtJLvmTm01RaKLZtkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+rECQYu; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-429f53f0b0bso7909671cf.2
        for <stable@vger.kernel.org>; Fri, 19 Jan 2024 18:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705716804; x=1706321604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FkpFU3iTdhrNoeuwVgf20iTnnMj/XaFbTby6SSlbtHg=;
        b=R+rECQYuXUue/ODN97k5mJxv/9un2fqOr/epw/S8vnF1w0pNn6w7qa/E+hO4YG008v
         8+gvvSnh25xffse6r56smaLfL/6bhL0IF2vqBYabO7JV7+0arSpv4RCKqeFMfyGg254m
         bIZyzxuiqum9GdJDv+RcsUqtYQ/0YrjtkXv2zSKhRbg4leMXuAdKksC18zkYk7da9Qah
         eTyLbK4ecbrQX5Q4wUn7HYXqrS04tJO8NUJ1g/7bUOwK063DTyACAg8a/KChvf8wXIZb
         9u2zm5qKaUw6cPpYN9XLEpX0+RfAdmqOZW2zMYHLfC9eWx6vkP4PyB3jLE79xlW3uAO0
         00CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705716804; x=1706321604;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FkpFU3iTdhrNoeuwVgf20iTnnMj/XaFbTby6SSlbtHg=;
        b=mYDQzzp7ilTiYyU/ZRSSiB9b+B5SKe0zsXAR+AJrPD25Iy6t+t0AsAE4Q0f5pTzp4V
         Vu/adc0df/+DGGNoNLjLQuxQyOONGryPtixAHuEytV2z77cic+pHkaXD1XN0Q+WOclOM
         ZOUCEQTzZvw1h6UMnPkcwHMxhqOvQr5YBOS7XzfRilIUS+Lfnx8AVEvibpElDN15tCqS
         qChogfMgiZLb6ji9P6rM4SyzsgxrvHm7C/ZmLHPrWQzIcOhojEac5jmM33fdWC8EXrez
         cTz1t5C//smbhUR/mzfEOhVYfeDYAJXmHMYiYZs64gu82UVcjnF8r3nzs84qSWJsY/vY
         KNNw==
X-Gm-Message-State: AOJu0Yz+A6Cg0nyiXSGbNsw4DvuHigqgiDmf5Hn2D2Cu+eY445ewQWUZ
	E+xySPgFCaosK9xTIzNN0C8YqzXkn47XHDXuQKXrufaiS12b04bx+2wsY2reFmLmiGj4QnnJyFK
	iJy7luQsE5JwEVSK79zeOm2MBd0w=
X-Google-Smtp-Source: AGHT+IGmKSuRNkCGgaDdAkt7uKfGmCcOXUt8ddkRT7AA/RDfTa7SiEu7SbzTVpLxxO/9b6vCSWePc41gdtcP1pW98rM=
X-Received: by 2002:ac8:7e89:0:b0:429:d600:e94f with SMTP id
 w9-20020ac87e89000000b00429d600e94fmr982909qtj.127.1705716804762; Fri, 19 Jan
 2024 18:13:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 20 Jan 2024 03:13:13 +0100
Message-ID: <CANiq72koa-tTXuxKRujXMuJUCw__WiPbgnxj6i9J2c6Yby78Uw@mail.gmail.com>
Subject: Apply bad098d76835 to 6.6.y and 6.7.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Greg and Sasha,

Please consider applying commit bad098d76835 ("rust: Ignore
preserve-most functions") to 6.6.y and 6.7.y (6.1.y does not need it
since `__preserve_most` was introduced in 6.6). It fixes a build error
with Rust + `CONFIG_LIST_HARDENED`. It should apply cleanly.

Thanks!

Cheers,
Miguel

