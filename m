Return-Path: <stable+bounces-204570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BFACF1299
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 18:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23F26300051E
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACB827057D;
	Sun,  4 Jan 2026 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="Y1mI6M70"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B41E5B9E
	for <stable@vger.kernel.org>; Sun,  4 Jan 2026 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767547389; cv=none; b=jOCRAGwlEe30AI1kqIBoOsnCWgBjdiYfzXyybMAGAey0hQ1/BgnCgeNnEu6CO8u/ILlCLUGFxKTIj8KPVv1wcmv1ZOlTeMwFVXqD+usbMLmykTpz+FtcChK/4fwuJz78pQwExO7nAgkkB+qK9ICybbisETgVoq+J8y3MNf3oAyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767547389; c=relaxed/simple;
	bh=6ZcchofEi36ThVNQ9UrQ1o1oKgDERRqmMyNsvSuL+vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfTCDpI6Bvc3pAtZnnyV/eP03ZNh6BvVcBxprauQ2/oOtLhq7143OD4UDlYp0ctdONrozt0TWnf4saJnVbrDLIiCOKXaEvRkKQsj5HnfWrX6I7ZQoK+zlTNNRerpmTLezyqJujQFwOzT1W96RsSGL9SPTFt9+2CunIFde/C7OPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=Y1mI6M70; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a097cc08d5so35781295ad.0
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1767547386; x=1768152186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZcchofEi36ThVNQ9UrQ1o1oKgDERRqmMyNsvSuL+vk=;
        b=Y1mI6M70vXiWFSDo9OcCONzH44feCHzNMaZU0QtcQ3xgm1Fjlm8B5T8YA+aipuKdZt
         nszbP9LlyImWui/IfZCULJ6bfwyZNSOpuovaL5DcUOKWjjqkxd16kopfuOPqmbaRNt2x
         6XqBUusnrGtf8Hbft+Rru6tEnZX/MVhpqP0oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767547386; x=1768152186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZcchofEi36ThVNQ9UrQ1o1oKgDERRqmMyNsvSuL+vk=;
        b=QFN3ejDq47cMqcMoVQFRiOnIMo5OMJnkw0XRuMZ+gU3pzBoVy+v5c0z3B6q9jaBPw5
         cZ/lTk8YRDYVQToDA/doUqeHX5xSrdZwIfyzyrNUs9VMm2XZjndxUVWDBXIZae4OoCcX
         vCd4phEIMIobGxggeu+TtMb4FaZURwl8+fwGV5HIsXp+la2dsccugGiW0Qqh0Bfda56A
         uZjQBbw/FypIA2fYp5Z6DyCC6tiVObp69mUQGTk2xujVIw1cquwHHSqiUFNosz7DRGwm
         UqRUqXNr80sOgs8H7uhLmctsI9R79GPo4rh+x0bBV2MHoVk/snzPgmepn99T1897W+4S
         jEGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5PoHLbI+RvQn9r3BCAg7726VRUljhmznFOjRebE/h27gwjcYkzbh+ld+LZJmDgSVaHoON3Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCWwOCbzbRYoEimZjxu6RlLSEh4wVWA1GGsuQmxZHmjbNdkTll
	TvAwFJC+itYZMwlNh5pqM3xdPdah6kgwI37wnG88Beo0Hga0PNfxOyMh+49MkH3+k6s=
X-Gm-Gg: AY/fxX4URRrcs5fHJi7A8MwURNDl7Tnvez3Rnnz2HSv7j2wxL3aXaMOAXD2pt6wx/rm
	ERV2xkx26d/nSb7J00E9WDysYXpM8cROAka/X/IX7eXGeu/uO1ELinXOV2NcA9p8K5WBB5OHvBc
	Z0BeXhmPjLH0RskOrY6lZccgQCBMxrBrX51PU6Z8cuVf+GhNg5VhCjwAVurAIOAjw46u40jkHq4
	FWPRdHDpWL3NsvTsBKSoAyk4/rGVRB3t6pSbaio5GTK2YBt19PNBPQT1aoJX8CaH2EHBAWXxpB7
	Uhc6Pf17ikE1vk8IKI7qvy+lYACX912VsKOEio87hZpFuOH6Of7x0k/sMAmSv1/dYXGEMG8fOxj
	UNKdw+CYYZL2nGbYfQpwLxdPWtsXrFmILiiDoaIORA7cT6f5PAOkbzgUjXJOmsJT803V1tL1k6j
	020ewBIQuEIZXJEsXbDQe8Dg==
X-Google-Smtp-Source: AGHT+IFq1wQeOHj4XiMgK/PWixrUntIiWDaHHxHZChAU5sfw+AhrmATz9f73AArYQ8D9GaFsUTLP7w==
X-Received: by 2002:a17:90b:58e3:b0:332:3ffe:4be5 with SMTP id 98e67ed59e1d1-34e921e63dcmr27091132a91.7.1767547386098;
        Sun, 04 Jan 2026 09:23:06 -0800 (PST)
Received: from MVIN00229.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476fb838sm3959403a91.7.2026.01.04.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 09:23:05 -0800 (PST)
From: skulkarni@mvista.com
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: syoshida@redhat.com,
	davem@davemloft.net
Subject: [PATCH 5.10.y 5.15.y RESEND] ipv6: Fix potential uninit-value access in __ip6_make_skb()
Date: Sun,  4 Jan 2026 22:52:34 +0530
Message-Id: <20260104172233.1912893-1-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251223185341.1850880-1-skulkarni@mvista.com>
References: <20251223185341.1850880-1-skulkarni@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha,

Can you please consider this patch for the 5.10.y and 5.15.y stable kernel trees, if there are no problems detected with the patch.

Thanks,
Shubham

