Return-Path: <stable+bounces-45425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C868C9468
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 13:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A52A1F2169D
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 11:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F35433A8;
	Sun, 19 May 2024 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy3HbUkK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3933D5;
	Sun, 19 May 2024 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716118164; cv=none; b=dgZ/O9Uh/jlA2gBKjw7QTwIbTJHGJD0yuMh7RMoqfFbT7igBzumZ7BJryqSU8qdl0bg72ELdW0dLIfS90XGAdLOPThdq7JcHaiW2rT/4LpNFepjRcAqw+Js96FRnltE1qZJOz1WOMyqKS1b/sx1QOHHYpSaQ1kfIyiDsfUIAmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716118164; c=relaxed/simple;
	bh=WLT9uocrfUoeCTMoX/+FhyeHHMbgy93Nnbq2e26GqVA=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type; b=jnJqesjCugzmIIYswO2/eG2tzYE2YUHlDWBxcw5amPI+CI31L3NJlBnuXyxqm71ED+n6JtdZOnABE58bON7+ajBuW9HfQHgHhtzcBzK9VnyOTbQ4PdMCfiXf/nw6xjmQShXahd/3ZRJsUBCw6a76+xTFw73/YxB7xbbta5JF/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy3HbUkK; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so2940571fa.2;
        Sun, 19 May 2024 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716118161; x=1716722961; darn=vger.kernel.org;
        h=mime-version:message-id:cc:to:subject:reply-to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgwPOHi2IvjHxAmbZFb0XYYddVSt1WB+5/iwnDhelds=;
        b=dy3HbUkKCFvUIowHcnpOp/u+/A0hQAkXlSSFcN0Ht2x86RbINNZBdMTr/wRhN0MmMP
         lRCuPFAGA8azkLY4eb7/Ag8kyeeIH4NC8Mi9ms9jTI64qTCzaZLb2YVFdb0HLQlBDpZ7
         XpUncXUq22pVJS+6Vo6XxU0j7aP2u1q2wE9+fiUwcF1aHiLOjrhQlzf6W/Otm0v4CajN
         Gh+5ACDYQqp93fH33GdFv3gdmbG9s96BniJmQVCSU9QrNAL62jRn4H7Oyx+HEXoUTSMd
         x49NRcjbp0w+b1dA5C5u0+vs2vNl8Mds1VXI0eReLzId0s6tQruRsU+DpDHh/MiJq20c
         3J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716118161; x=1716722961;
        h=mime-version:message-id:cc:to:subject:reply-to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgwPOHi2IvjHxAmbZFb0XYYddVSt1WB+5/iwnDhelds=;
        b=co1ip8hZg6Rp6K5WtKBgEIIT2AE+0P0Zj3qpHf7zKjZKFkIc6GpeS2qZTsQlfYfpnW
         jT+sJR9RVqTbmLwxpF+N5QMfcqxR5OouTUBjNc1fSuFmgu1a2wTST/S1crfUqhX6Pw/F
         U9LPOYSFk4gQTmvPdUHegav4X5eP5zFpyygF0xhNbR0CManb/adNbSGbfU+nm2j+ckx6
         9BhNqsrGRhEMcALu5uXlIvzDXoFg3qGFZJePQtHB6lRL8VAaUZLMyeJo59Rtuj7d34vc
         dr/j0rGZpmS5W+AAOqBXiSlz+NIrC0zEOQqgmG4fnxDxEZZwIGgEqmMn7AVyKUtGrOVT
         OLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNpJVi5WywdsfYSJPDJ6izSNBtgbke/o4AGQgdjN2qYoR9eO/KVzh3jpqC5FlP9oHlK540On/weyXVwG7/yZrFn2dwzct2
X-Gm-Message-State: AOJu0Yy+BpBmOILHAwnI3plmOgCH9xfw0WF0a0Y2yzEZ31jU9bBc16hy
	GAB6uAT1cACUiIu3iyrX1FDXxUq6M1R9p4LmLMIzmPx8Pay7UeJQ
X-Google-Smtp-Source: AGHT+IFtOVFTXd0A+2n43urqgSMYE2e46NTPC4KJzfPIOtTC4MdFW3aIT62AHoa+UsPAyZ82oAj8+w==
X-Received: by 2002:a2e:9f41:0:b0:2e0:42db:df7f with SMTP id 38308e7fff4ca-2e56ea3af7cmr149431791fa.0.1716118160471;
        Sun, 19 May 2024 04:29:20 -0700 (PDT)
Received: from [192.168.1.35] (82-64-78-170.subs.proxad.net. [82.64.78.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fd97e842csm370275675e9.24.2024.05.19.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 04:29:19 -0700 (PDT)
Date: Sun, 19 May 2024 13:28:58 +0200
From: Paul Grandperrin <paul.grandperrin@gmail.com>
Reply-To: CAK2bqVJoT3yy2m0OmTnqH9EAKkj6O1iTk42EyyMtvvxKh6YDKg@mail.gmail.com
Subject: Re: [BUG] Linux 6.8.10 NPE
To: rankincj@gmail.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <A8DQDS.ZXN0FMYZ3DIM1@gmail.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

 > I am using vanilla Linux 6.8.10, and I've just noticed this BUG in my
dmesg log. I have no idea what triggered it, and especially since I
have not even mounted any NFS filesystems?!

Hi all,
I have the exact same bug. I'm using the NixOS kernel but as soon as it 
was updated to 6.8.10 my server has gone in a crash-reboot-loop.

The server is hosting an NFS deamon and it crashes about 10 seconds 
after the tty login prompt is displayed.

Dowgrading to 6.8.9 fixes the issue.

Regards,
Paul Grandperrin



