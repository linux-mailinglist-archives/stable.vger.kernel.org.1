Return-Path: <stable+bounces-169445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C15EB2529C
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 19:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE38C3B3B13
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 17:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3BF2882AC;
	Wed, 13 Aug 2025 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyQBlGET"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611D241679;
	Wed, 13 Aug 2025 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107602; cv=none; b=Z1Re2k39mAq/2ihP2g/LTeANnYT/dUD/XPqjJ3khmpZ8av0WoeDAdRWnegJ/V7CE0fZzE+GGTSj3Cr5Gh6qZMaNlqIlgVphuj1/3N3+OI3NjjPaiFozaYNiJ9f8oexLXIuLqeOmyKdjGeU9E8AMvvQCj5bNCx3B2GFDeLBqMdsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107602; c=relaxed/simple;
	bh=4pM8acUVZlefs7RczFwTJbtYKC7kqGX340i7U5xddxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMsNyWXDRtO8e/2Tqc0YyEKqt/DLTysCvkORgB114Ezm/w8667wH+Zk/AOvXY8LLg+B1qRzYLnmdEvZ6VGTzIYnZOzDScVZLZf4SgmdCW7tnQ8i11Wks4peITJ9MMGB3KpUFu7YdjBT47FmDYF2jDxSj6gBdNDIVkn3K9mVmgDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyQBlGET; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so205355b3a.1;
        Wed, 13 Aug 2025 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755107598; x=1755712398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiBFa64B+TqjeQ4CTY4701tFH3TlWQC89fh/+LXkdcc=;
        b=FyQBlGETQwkjlJuBFclVtmCSZv5MF5klQWa7Y5jKjl37JxzSubtpK4gQMbW5djDRfZ
         2UYBMEaEYnpevUYYgTpjQUcqSHZ1/UNwEdhkAxGCvulYo3XbNo+YDnqZNp6u2zC5XHz+
         mqiYQsSa+mwPr3Gz/Ggwriz+QVQOsZ6XLoqsgLYdWgZRO9xTm41mFX3CowYfw6Bc883S
         oonwZ/br28BnFWW4x9PnkWVI5KyE0eFVpZ1j5Oo1AjeIjV0dbIA99ngK/WE4MPYFdBph
         Syf8z2uNmkD5/PO+mp9VcKVezlp/Vp5M7WRUAJYDQtYxvENxEGmFYMyMAq46fP9oloe0
         6YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107598; x=1755712398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiBFa64B+TqjeQ4CTY4701tFH3TlWQC89fh/+LXkdcc=;
        b=BtVPw5tyVFDdsDLeY6vohYPH9xn8PucS71iC18g+ZzVJui/X0iJ1KwzPCj606hXzUM
         4zm83c+IpYEosTfVlciT4M6dMWEuKFc79DlFd7yT0/+rhsEx2uH7O9ZumvE8d2jiJGCC
         TWyclvHLM5FuOyXnMN0i9ivA8cFDqMbQyZT0OJS3JyPgikUsFLQkIlWgH5C7zEfdV1JG
         VYtD84f7/aD6N6dEnxrxknohOAqypu0BjEu06iBmMpLtYcoVEyrGgj4LO1/y29406yAU
         cjujH826QDOIudH+BIUCn8cN1zyX2B9SqU7KRcOeBkOrwDEqgN8LvAs5JkSiOP0UW/97
         UDew==
X-Forwarded-Encrypted: i=1; AJvYcCUlI5DZJzxAi2FvduFBIZFwoQf1Ic0Bi5MFYNH/rg9tShODuuB4oCbog9WNR41uimL1SbH+bJaW@vger.kernel.org, AJvYcCVrYHIRLUMFHsYFsPaikcNWb9aDzXJ6lp0EGWELDute6m3y/tUgXce9wNXzb+ToBriFA76LywBOHeG1@vger.kernel.org, AJvYcCWf5Of8aL+G6AG/Nb+8YDkEOqCEyf0m+wJqe3OwYPcomYiRlZ1ZSbDxPley9GLOullnO+eFlVn3zJDexus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5cm27sKuGRFWZzEp7PXmv3PmD9lIYET+xMeTcahu+J5OhSjMa
	6lXIa9QX539noiWquciSlLyTm2KnQ9DnQByugIz/1QOrS0g5EMqfxoxO
X-Gm-Gg: ASbGncuz/RthzEudd4tRnBa/+v8tvgTsbxl2EEpPGDWE5Oof3Ck/rStefbEzrvnVln+
	a7zgIJ/B7hD6t7yVfbUX0hVW8D360Xxegtu0m+cD2evZYMyqCQX/4PxCpu+vitmPy4SXiNvyRLv
	0W0Voj2G2xGZND70+g5U02BPkEhvVWtPy1MjXjZxYOuMyGwoKfy7Q48YV9Zmizxho/aD2nJY0JS
	azPKBRW+BVJW1PfS0xoYJ+Dk83oZZYfK4NKul//559pTOoBVxrrSQfAz6j///+2HZko8SJjxqNI
	ZzZW97QMhuwFjPPPhO3CEUxXwUe92shUqUIfpzejHB9zhZGrrfu8RyUugwkWVNuliNjL22kn97+
	uneQi3RseJrpbnX2zedddF1oavbOL2Myz+vf3axw3uRt9alZAKz+a
X-Google-Smtp-Source: AGHT+IHqrM9uEOkafaKQfwMA0+vdA8y+BGI0C4GscUL+snfpOfuE8+hq5m7BEW2qa3Hpbmy9MdwdGg==
X-Received: by 2002:a17:903:90d:b0:240:49e8:1d3c with SMTP id d9443c01a7336-2430d223d86mr54937875ad.35.1755107597681;
        Wed, 13 Aug 2025 10:53:17 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3232576410csm727158a91.11.2025.08.13.10.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:53:17 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	stable@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: Re: [PATCH] USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles
Date: Thu, 14 Aug 2025 01:53:12 +0800
Message-ID: <20250813175313.2585-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <ff043574-e479-4a56-86a4-feaa35877d1a@rowland.harvard.edu>
References: <ff043574-e479-4a56-86a4-feaa35877d1a@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Alan Stern <stern@rowland.harvard.edu> 於 2025年8月14日 週四 上午12:58寫道：
>
> On Thu, Aug 14, 2025 at 12:24:15AM +0800, Zenm Chen wrote:
> > Many Realtek USB Wi-Fi dongles released in recent years have two modes:
> > one is driver CD mode which has Windows driver onboard, another one is
> > Wi-Fi mode. Add the US_FL_IGNORE_DEVICE quirk for these multi-mode devices.
> > Otherwise, usb_modeswitch may fail to switch them to Wi-Fi mode.
>
> There are several other entries like this already in the unusual_devs.h
> file.  But I wonder if we really still need them.  Shouldn't the
> usb_modeswitch program be smart enough by now to know how to handle
> these things?

Hi Alan,

Thanks for your review and reply.

Without this patch applied, usb_modeswitch cannot switch my Mercury MW310UH
into Wi-Fi mode [1]. I also ran into a similar problem like [2] with D-Link
AX9U, so I believe this patch is needed.

>
> In theory, someone might want to access the Windows driver on the
> emulated CD.  With this quirk, they wouldn't be able to.
>

Actually an emulated CD doesn't appear when I insert these 2 Wi-Fi dongles into
my Linux PC, so users cannot access that Windows driver even if this patch is not 
applied.

> Alan Stern

[1] https://drive.google.com/file/d/1YfWUTxKnvSeu1egMSwcF-memu3Kis8Mg/view?usp=drive_link

[2] https://github.com/morrownr/rtw89/issues/10

