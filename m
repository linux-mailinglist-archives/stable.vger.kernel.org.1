Return-Path: <stable+bounces-74042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE57971D9C
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744C4284217
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36352E630;
	Mon,  9 Sep 2024 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GginV7mD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC371A716
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894582; cv=none; b=DBIq/vwr1y59hTq4aR9OFL/JThtXs5LjAtY0zb0C7InqIDN81WPMH24g74/oFeDis3z200sCYJ1zhyWRFAX32XeFhT6R/mW6flQV7v0upkeJbuf1i/ebFd3U9m/FTciS8vuALKYJwTQJhwl86qfh2KCBNxI/ZbFQbSR2IWwuL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894582; c=relaxed/simple;
	bh=mVq9S72lk5b5xTO/FfOh3PUK79hfKisoPxEm6dY2/Zk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ADz9z/Q2jYehqHjEJs4Tqv34DFAS91TXRUO6SJeEKKrBKGBpXMcy+xCfKICe8mJO+c95YH+v4TYIvpHfLtVdMx0kSArQfqEZhq0a6ky0kSqzhfL6hnQ+PecgMcIGcLqZzYj+tFSVxqdARwURUW/vyjfG6/atI613FXQGykS0mLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GginV7mD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71798661a52so2663117b3a.0
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725894580; x=1726499380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXq1QAWAAsQrYNlJmOFWR9qiaSyJPA0zyCX7aY9ZQ1w=;
        b=GginV7mDlum/PUuoJf13Wlfvv01cS3gr+aqN0e263izKQuL8U9nn0vG9gQIwykX1Jb
         uRB0y84NuBUfcQOmZTjgvsvNZHRcsHRn24j4aGIiD90RPj1oJDTxIAGkdRgIcyrY6LTT
         +Z2jChAARIITpoHdsctmhWyePoup4v7Jx+UXRsBfB8BxdBvNVv9ec2S/1mQk3PWj8/pg
         5a3qMDvZIi85yKz4LVioXGlg6FXtM3R9DpKHY4s7wpkiKAYH90RzZThnNCGUjNjzwvcx
         6g+o0T7YVWQzKh7YYBPzFShE4xzSaJJm3bOckmgnGpQy7W/hWSL0zlCYESmdY4as9LUN
         fFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725894580; x=1726499380;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXq1QAWAAsQrYNlJmOFWR9qiaSyJPA0zyCX7aY9ZQ1w=;
        b=XZ7RQuOEuxUf96+ybkaiqlW1hoJPhMIcDV8rQBR+/L0lTpzrNon45/kWfz9dZuhSqt
         V48xflLAPEk/nsnETk6UolAEjeK27p9xFkqU4BAh+ccHbpnMigdC6mGamh0wQ98TCi1T
         DZHrE5vbe9BxhsRZTwtLqr40MJe1YCfT6ctQfKcU2j1Lzw9u19smJt8B5b9daUtVqXeO
         x8iwIorOluo1AImaXNlpCAtJLr+ODeYH4y019ZGr4JeHT81I4qjwgvpAz5GAX9d+Jp0z
         taKRnO2JCvoNELXkbQHsG8scay20qFWM9MfmqNBx5+MOuus24WsStyqMGjOIRQGvUuwN
         y6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXijR8QSGaqCyOSXtf8ouCSt+NPJuYi/bkKooh34yuihSwd4m7ej4IW8rJQzPEwHI+SbHlWXic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYSQI7ZszxfFPb718zeMurPHqnmdiwddZgHzi1HO+RnuRy8cav
	tbGZHTsRJl8j1LvNQqlU4P6tkikjKArk02SpU8DripVoVdzVy2BBZBiSHRUv6hDICd9hSVN4rEn
	j
X-Google-Smtp-Source: AGHT+IEvd2jWK6AbqOEXtcOcRMgffXGRbsFWC1ymbvQmWwpnadQlLSPtVyBn+FRcmaDqcgaSeIBSdA==
X-Received: by 2002:a05:6a00:3213:b0:717:83bc:6df3 with SMTP id d2e1a72fcca58-71783bc6f5cmr23496474b3a.11.1725894580245;
        Mon, 09 Sep 2024 08:09:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58c1d6esm3632805b3a.75.2024.09.09.08.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:09:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org, 
 io-uring@vger.kernel.org, cgroups@vger.kernel.org, dqminh@cloudflare.com, 
 longman@redhat.com, adriaan.schmidt@siemens.com, 
 florian.bezdeka@siemens.com, stable@vger.kernel.org
In-Reply-To: <20240909150036.55921-1-felix.moessbauer@siemens.com>
References: <20240909150036.55921-1-felix.moessbauer@siemens.com>
Subject: Re: [PATCH 1/1] io_uring/sqpoll: do not allow pinning outside of
 cpuset
Message-Id: <172589457900.297669.16381515839828801822.b4-ty@kernel.dk>
Date: Mon, 09 Sep 2024 09:09:39 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 09 Sep 2024 17:00:36 +0200, Felix Moessbauer wrote:
> The submit queue polling threads are userland threads that just never
> exit to the userland. When creating the thread with IORING_SETUP_SQ_AFF,
> the affinity of the poller thread is set to the cpu specified in
> sq_thread_cpu. However, this CPU can be outside of the cpuset defined
> by the cgroup cpuset controller. This violates the rules defined by the
> cpuset controller and is a potential issue for realtime applications.
> 
> [...]

Applied, thanks!

[1/1] io_uring/sqpoll: do not allow pinning outside of cpuset
      commit: f011c9cf04c06f16b24f583d313d3c012e589e50

Best regards,
-- 
Jens Axboe




