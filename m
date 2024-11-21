Return-Path: <stable+bounces-94539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA09D5055
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 17:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA1EB21C3B
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C1719F489;
	Thu, 21 Nov 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0cvqsn3"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35B2158A33
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204894; cv=none; b=dFgS45qaOw9v4cQaXRaCMWUbfIPBFWu8YcUhIfbuEqdIzvO7b7JktntJPoixEeUDKwmz2TmHWJ8zGHG6MpusysKaK2KEcHD80O/3Ss/vMqx2THeUQvLS/DlzE3+knYgn6lIy/qgbqam596/lJEXppeY0erNyVD/MllvHnrZdnGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204894; c=relaxed/simple;
	bh=yfGfo8yeXe6p8xGVfCOZSYvwV8H7ZvZDgq40OIEYuXA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PIr9UwBriA4kceo9SKRU1cn8dkwueo45UN0EKD/rlbSK+EtH7LVNXLPOFu4bxDaLJacuDSAzg1S4X9LEHuwsliRHepVr5xdsaprnvtg9sqosrKlYax7cDxkjFXe440rTd38BF0Vg3SLe56geMRTukqNmALBtexq3MwdgyuwRh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0cvqsn3; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53da24e9673so1090198e87.2
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 08:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732204891; x=1732809691; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfGfo8yeXe6p8xGVfCOZSYvwV8H7ZvZDgq40OIEYuXA=;
        b=N0cvqsn3TUBtN5dSNp3Ja1vqEWP+Yfi4AYfP7KdV9YS3097DD4ilDFdGRn/ZFkGWmc
         3OOxw32MPw+fM4RCF5EKMd0XQDNGXtiZK0F6I1+GXI1c1rSEINnHCA3Hbk74s058dx+P
         1QXIyBYGj75ocwQuckoY85MtauSxuwA0QsEculJ2e9hgz3wUCSneukrsKF/vL3C6BdHU
         5e1z9f0VZKUyHA8N0xanO8YR8i2iomj/lx2IHSlM6lPTfHGAj/GeuwHlzOdQVvt/XvP/
         GY7TmSLVrqqfLf/+I+5vQOaL/ehTcZJYvkvoOLLEzi8ovtM6s5A5EdlvaNyMT4Ufr0Gk
         gXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732204891; x=1732809691;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfGfo8yeXe6p8xGVfCOZSYvwV8H7ZvZDgq40OIEYuXA=;
        b=rh37rH+IUqAOtSV9sLex4+fCMAYuS9NFne6b3qVGcKle9yN4K4HShFcVlkgPwyx33W
         458z9BmlmaT7VR/lwzQArvh7dc7ccnvxcapQkyeypBezbGN8vcNYuAdSGqSy0VYn700W
         JADnEFSBJrh4e1/NIMSOxq7a4lMYb/vaVfQXZxxiCeFReUon5udK5Tv/2vsk/pLSTrWw
         tJw8zbMTprlONSOBul/bcV6y4cVByUBqwUSotqMzK6a89Xu6+/Zmy9Aay+XVkhVV+BHK
         SZZ7gyQXhUPjKyVqphNeBO4YF/AN9SOZBwHI1/3fFSGuGiDuX/RSfgvYpWqZMxSMbGQ5
         aN0g==
X-Forwarded-Encrypted: i=1; AJvYcCXMT2eTec3x0ZLSHGjaU8Dmee3dokFA2oHuz+mvY9ZT8KWDa5wmodnZEyluKb9b2YHv5LIelz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvQPMTL5dqv6Cr/GPAKSlU0h9WXtgJsYiMzMJpZ8wLY1Zy/AL3
	j3biJkUCV8jM3Na3yaYlz5nnTsvanx/bbTtB5OyZO0XggqQDS9O4u2Y+usonq7+vTXIT/63phA/
	8D+sdI6qu+qcUbiNXnpMx6HC983g=
X-Gm-Gg: ASbGncuZ5T+IQbSmkB2TZvGGhF7ZEnRsXw6VVl98t7cd1kmeqXNECqa3UusWlVuaKrY
	JYTOuqGq67cLYo6jiu921NdDPVMkopsucEyMJF/wbkRrggFqx6FT9aAXvjtQlVQ==
X-Google-Smtp-Source: AGHT+IFrPJj8xMOBAAQ0aKVbJDA7q02OWiIuJ4qE3hhQuwvd/tPHnyL5InoCvFRx7J5U59A2RiguiId/qMkpD5OfJAg=
X-Received: by 2002:a05:6512:33c8:b0:52c:d819:517e with SMTP id
 2adb3069b0e04-53dc134330dmr3524288e87.30.1732204889733; Thu, 21 Nov 2024
 08:01:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 21 Nov 2024 17:00:52 +0100
Message-ID: <CA+icZUXkiFDgyR8qH4VC3K=zK2vkazr8cgYDT=TymD2F3LD=vQ@mail.gmail.com>
Subject: linux-stable-rc.git: queue/6.12 VS. linux-6.12.y
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg and Sasha,

Can you please check the queue/6.12 Git branch?

Looks like it includes queue/6.11 material.

Thanks.

Best regards,
-Sedat-

