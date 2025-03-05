Return-Path: <stable+bounces-120444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA05CA5029D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 15:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D14163B42
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8790D24EA94;
	Wed,  5 Mar 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GpPv39p7"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BBA24E006
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185931; cv=none; b=HAKRxJ9SGs0WAO1VxT3kiOC8E5shbyaK2XAha3WG+zBoj/a8wd+UIpGj3Kyv7MnvBx3HLThjtpa0Il/N2mUe7O0pqw804n+Pochbm+oSWH1qkou7cBXuK+hXko6KeqfIl7GSkQHRDgMUN7FVLLxtcWWhwjcM+G62kyeCjUInjCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185931; c=relaxed/simple;
	bh=Cmk1xtK9zj/mZKksRgzAj6pkbkT0aOMNt6bwRChxyTg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L/aeHcYFH5zEmQ9A8OU1gYfPa1czAhTlLanGGEfH1KaX0xMtUgmYgvfrzw0afcorORd+Tti7GT+GR02TomX6Jqoy/1+UHhRfJXCKRdB0nS/6u77dVyIin5CILWe/OzYIuBITOU/DD0xlUYWNaZlk9b2KXbvWza8xobNUeGCZ0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GpPv39p7; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d3f1658a64so14252435ab.1
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 06:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741185928; x=1741790728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mtFeKx17Yutqyl4iJJ9qPun4qwlSidhHSO6yuTK2pU=;
        b=GpPv39p7F0jzsUxYCnv0nOJcQ9gfdwlfXpTmD4Q567NUXMLjqYXSHZIUnRQFlgwJAl
         rRUpaVegoC5lloIXI1KkLJvkMWE9yaW7tWspFYimbzhXuDVD6ZvgQRuBZgxB/kdOvsDh
         rpRj6aZawoHM2CQzhk8tHGFVfODLP8scexxh5HWBS3ejchXwQzg+bfW1QYJ42vEdApQ4
         Rdxn5hwPf2AFWaMTwx0sGJevA6ZfD2bXABUz8AwXQe/KHzP9UGO558mCjIK0kElq8AM0
         p8CXXGFAnaBNnumJ3qrr2QvA9crMfUKteDhIj4qqInFcr2Bav935LFr0FykJqFDCOQ8P
         bXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185928; x=1741790728;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mtFeKx17Yutqyl4iJJ9qPun4qwlSidhHSO6yuTK2pU=;
        b=hhFj5ORNhksgBIUSLShnLBA6BXYlxtN1Z4auo9YKEQhAA3rr0Sdp1/gLIOeSDht8rc
         B3Ym5N4vWFnEYOe0MszaAqp/fYBFrFj2QM3EnWWk6ZbWUsccM9b6On+p706s5cRKyF5y
         Bv7sDFHXHfhP/+8fsHInGeJUswfKd4UHxaFBxOp8TPFvJQIfEJarRvgK2G957TCYwLD0
         yJtbWyeL9TN8jDzJD1JHOTQZZzMrboNoOEvqfwlHlo9rC4Vo5G+Ob2ot9yL3UblywVpP
         sx/CGulHVDxWyJIG+rKwfw78Gbjfvg/M2tcwZm0fTMG1h2b4skJobkHWfvrsw2rM36AQ
         hMqg==
X-Forwarded-Encrypted: i=1; AJvYcCVjaiLMOCmmRQwxD5VlYI2afQKN1Blt7Pix52BOW70Qru6VAHxCQV0epBdVB8aC7pr5a37sBvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz691daEyBD88yT8af07PIQQS752ikvjwU4rjJe+rK4ez7tWCY
	Ro/MkA4mOD0k6AWh8/2zQ1L2iGH/byOKWyV0P5/BOUY+R80htZFuTWLclgsjrZ2tY5XPZtUf8Cm
	H
X-Gm-Gg: ASbGnctxU8u5QI4BRkhynYisBe5tWT+UJ/QPXUuQGMvqPtg6ipaxYnaOniRfZkz6XS0
	S49wVUoyuue4JoC6EQbQu8qhJUm4uuIa1xkl3atLvfRxTuI5jFDPd++7kBcrzPQvKEN4qTDAZIS
	tf/dA6cs1+/egOVy9Udfe71l81sVl02J5RsaVqlC4x4QWKgNPAVPi2AZ9cpHUsWlqUb6f7lG86B
	x1alRN7aQnJYTfVN/jhfFCEZ1xC0AfjPpyyomX3C4hqXR2T9Z9grSrJQiSrOfaJdPjaUqBs2v58
	05zZ1KIQIkmaOW3dWqnpqiasX2jcPitn4eY=
X-Google-Smtp-Source: AGHT+IGsBmYSs3QMp0F/1K4jts+fZHuzb1nFpuhkf3zgDvndXF+r7uxykpB9Nima3gyrxwD3OUT9Eg==
X-Received: by 2002:a05:6e02:18cb:b0:3d3:dcb8:1bf1 with SMTP id e9e14a558f8ab-3d42b87f6bbmr41882915ab.3.1741185928232;
        Wed, 05 Mar 2025 06:45:28 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c07b73sm3585381173.23.2025.03.05.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:45:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: linux-efi@vger.kernel.org, Olivier Gayot <olivier.gayot@canonical.com>, 
 Mulhern <amulhern@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 stable@vger.kernel.org
In-Reply-To: <20250305022154.3903128-1-ming.lei@redhat.com>
References: <20250305022154.3903128-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3] block: fix conversion of GPT partition name to
 7-bit
Message-Id: <174118592720.8596.17751872254586866019.b4-ty@kernel.dk>
Date: Wed, 05 Mar 2025 07:45:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Wed, 05 Mar 2025 10:21:54 +0800, Ming Lei wrote:
> The utf16_le_to_7bit function claims to, naively, convert a UTF-16
> string to a 7-bit ASCII string. By naively, we mean that it:
>  * drops the first byte of every character in the original UTF-16 string
>  * checks if all characters are printable, and otherwise replaces them
>    by exclamation mark "!".
> 
> This means that theoretically, all characters outside the 7-bit ASCII
> range should be replaced by another character. Examples:
> 
> [...]

Applied, thanks!

[1/1] block: fix conversion of GPT partition name to 7-bit
      (no commit info)

Best regards,
-- 
Jens Axboe




