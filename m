Return-Path: <stable+bounces-200535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7A9CB1F28
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 06:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1549E3064797
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 05:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436D222FE0A;
	Wed, 10 Dec 2025 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev31/y3J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23EA286A4
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765343853; cv=none; b=qv/OOqCdbhHNSNzVDXmSFmwQkna7RBFpGBMF/N86WcJhPGyPeKl5p/0P2CHnb/xqPbZMkHrgLdm262Voru2mKvBYxquTBNsxjZtguAJGoq/qAPPCy7VSBVMbfE4I6k6zrKKh7ye5hYVKBlxnSFNykty3slzBLZKox1G9Gk7LNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765343853; c=relaxed/simple;
	bh=qExcs/8cNN5eagvc96t1kzVCjlrfymwy5INWit9g7qI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7r77lP79XMQ3ev+nwtj3b7yRiu1eOScOlLk3YZ8oDy3xr/2sIgQ5e1peQV7YV7PR2nylDCtso93sZaB5dDG+dWzlH89Lbs1NJLXdk4ZoTfshZZf+hBfWnbOckI2W2sFZiWyfW8eimiXmsvz53b6pTXipPDZ1+S0dtrobFFLpRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev31/y3J; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7ade456b6abso5529578b3a.3
        for <stable@vger.kernel.org>; Tue, 09 Dec 2025 21:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765343851; x=1765948651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qExcs/8cNN5eagvc96t1kzVCjlrfymwy5INWit9g7qI=;
        b=Ev31/y3JtN0kTpRzSGzbY8HCzLfJjL3fuIHVLCFFnfp3BsRYMdF9CmRPoWf77h8yUS
         4tv1N6dGXxr0oKm17MNsOy5w1qq5rRY6dmwdBb11+TkjeXwQdGMEZITgkh71hMBf6+0S
         U4Uv/kI9Wnv3+EUDI5B+ESxcI7/ZG7N6bGORBFTB16q8N07enurlRMZmvZW+IYBakh5h
         98wOoXWjuCxt0NZnRNZSPblr+QaFGHZ74VqDVx+Q/VIFb6cC9q8XErmFkLosd2tfq92T
         G8VR23+Xa4N0EznkIgFiDrMwzpBuz2SapAJ3OqysiGFTmJf9WN49hIO0WclaFF0pPgco
         s4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765343851; x=1765948651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qExcs/8cNN5eagvc96t1kzVCjlrfymwy5INWit9g7qI=;
        b=f6ETJ40xg+nYngSXXlsPJXR75avQxtmh1sP0N0rmhMZA2kWwlyOgleF2/wvG1/cIOv
         a6WZZQwEAr80RZtwwT/WUiU6ke8RjL8OtSSi0k6XZdxS8BIbUlVwp49LUvNx0oAECCkS
         M62ZOXSXsTXMETU17C38MiyBd3InFOGREyhc91jrtf0fUolJaEY2CUC0zhCey4Qj4Z1o
         Gl4N4CeNaWXMExUet/PHIlBYBMJ7O3z99URT0MIkYW51zpLODfWZuBp0dMKMG3N82g9V
         y+pozMP2p1qbkwGfmn44SG+su/gp2HUgzDM4TOLedj6DX7Iwpqot7FZYrtCYTDVbLMam
         Rj4A==
X-Forwarded-Encrypted: i=1; AJvYcCVPVei0+8pd3FJQxuVzXGo/vOixLYgO01Om6bjhy4jOd5eKJqTjWpRKfx4edvq6fE/XQ0mGdwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLcYWtstFKA72bMp4QCpUKXN1Ae5KvOpaERIsAOIyjHgdw/Hu
	DGHqm18IgUN2mZo+z41Beuc8klD3TvKfvdJpuOCiS3oKwqAGsK7dITLc
X-Gm-Gg: ASbGnctMP6xPxZ4Wr+I51RgPU6JcQK6Vmu61J6R3p/BfNvOo9IAHGVmqnl3DJ4rT1CE
	oPoQ/KVQfHh46DPEeo60D8h9aHAYzBcV7Wq80J8OrNGo2JaKyjN9DSsVhSRYh+i/2sCO2ECUZCt
	EEtNark9h8Qy4yaxR27OqgI68fxN3d0+EWD1T4tzeIufVLsARMQIj9S52FUCXkjqIku9ZVGPCAJ
	PwqVWAANJLSJX+zfUbdwrvIak1jtNH+DNK2dg1f8ZQCTl4H4kXdLGO6cznbrdmQUovKY4SSuEKI
	cKVeaEsP3PM8bbwN5MzPq7g9DLC7IXISM0RiWpRjMUSQVagNO0yUzzVEdBAqiuLtVoCORou2yvQ
	6M4eQmlqQsSPnCHsNq+45huu2EAiEiu0Xasf97CezYz5OuG58Mg1XSZ0zQ/a96w/+73XOtT3Dt8
	18VI/JIkn8OviXN7yrz0/zolckAzYScLlF6GtHxXJw
X-Google-Smtp-Source: AGHT+IE7dAyrhHFXDV0DqTye5pV+Kje0+qShbKFX11hx5UetNm9KCsnU9gUS/FqIteY29lCKfQuyRQ==
X-Received: by 2002:a05:6a21:328a:b0:366:19a5:e122 with SMTP id adf61e73a8af0-366e1006f05mr1239285637.2.1765343850958;
        Tue, 09 Dec 2025 21:17:30 -0800 (PST)
Received: from localhost.localdomain ([121.190.139.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f046sm172108995ad.61.2025.12.09.21.17.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Dec 2025 21:17:30 -0800 (PST)
From: Minseong Kim <ii4gsp@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	stable@vger.kernel.org,
	Minseong Kim <ii4gsp@gmail.com>
Subject: Re: [PATCH] input: synaptics_i2c - cancel delayed work before freeing device
Date: Wed, 10 Dec 2025 14:17:24 +0900
Message-Id: <20251210051724.13564-1-ii4gsp@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xeski4dr32zbxvupofis5azlq2s6fwtnuya7f3kjfz5t7c2wnq@jbvlajechlrd>
References: <20251210032027.11700-1-ii4gsp@gmail.com> <xeski4dr32zbxvupofis5azlq2s6fwtnuya7f3kjfz5t7c2wnq@jbvlajechlrd>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry,

Thanks for the review.

Understood that cancel_delayed_work_sync() is already called from the
close() handler, and that resume() can restart polling regardless of
open state. If we keep this driver, I can send a v2 that adds an open-state
guard in resume().

However, if this driver is no longer used and Mike confirms there are no
remaining users, I have no objections to removing it instead.

Thanks,
Minseong

