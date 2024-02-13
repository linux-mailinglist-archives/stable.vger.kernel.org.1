Return-Path: <stable+bounces-19721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD8853217
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C68628210B
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFFA55E72;
	Tue, 13 Feb 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzmCUkwA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C2D56449
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831569; cv=none; b=fb+73PDNRyQEreRY5jzYqJZ85/CDcsNSGSiwp8t2L1E26X7y8R1LnjKQKG4j0NJHmnmbT7nWzP926cenwsdmBTY92OiCFoTOJolJkNP1uWy75yvrZNGl2RXOlELEVmMnTTSHUfYRY1bWE+8jp6SCQByU5YT0b5CMTQQKn0X7/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831569; c=relaxed/simple;
	bh=aHDbXR4j17Pd/YbFFL1AbFg1r61BHyv5j9CRgT9Z1iw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGzPVLC4DhqGwFJdza/xc9Io23E48gl4kknGc2PVx7dLvBRA5PVroMTGRifE2ROqWLy/TjcX/MhgCGs3UGnQdHoyZL+5jim1N8VZCs2/mV3PHyWhtP68VLcgfPKhX6MrmSvPVu1o75ulOCrenMckaiGNrvs+u1AWQVmoTXiwQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzmCUkwA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3122b70439so561438466b.3
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 05:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707831566; x=1708436366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHDbXR4j17Pd/YbFFL1AbFg1r61BHyv5j9CRgT9Z1iw=;
        b=MzmCUkwAT4YENgapEf1SG/hV26KFij6w2Ev6PLwwEBne+W+1qQCYZ5BXZQnnqvI0rK
         3ARVg9a8a4/YtKS8BbsegnYOlxdStueTGJISiTcG1pCgU0cetoL9LYU9PcN/t/9gt+48
         l8GoEadlzYqN90Q2WX7mc8r8AZws+3ggIVG2suKhCbv8v4YWZPD5yx0uZlz/RR30E3k/
         akB/48M8RuI3GDRzS6C3nXitmEkWdRmKtz+nm8lkf+LaPxfEIZCb/tt1KEkS2ZyM/Kdg
         /Aaf3HwlMJpXhtb8CAvVhGrkKOTJQpJ7gXHZXMXXhtKwu/5mTTnRiDRZWlJ7zmpmVOOV
         2owQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831566; x=1708436366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHDbXR4j17Pd/YbFFL1AbFg1r61BHyv5j9CRgT9Z1iw=;
        b=RNsljmwKyh2I0luGrSDcapOZbb9W2xuNr8Q1fbTVT6ev4tjCAK6qenV9/nv8lwKuho
         k9e5aoy42/FO/Cg81MgoHrhr+Y1mCjLwdwHAsf2IP2/SMkE4LACtI4aP9+DYs86a8cid
         Psy1Wxm0A4tNqbmAgQOYgDSrA2imphMc001AeCQ/HFHeHJSQYhaoWTJcqzVw6dgUdpbj
         YT9xczm4Jg43CaRHb7MgtCZH1qVDCSJLXiCY9DRdK0PVi/7qlNsqx2TcReUvmMBtsDHc
         WwLLOZhBX2UEqleuAlrDZCH0K9ePTBcGZnZSDR7B0b/w7OAwZ41dLYVs+xbHzA2KMRPz
         h6lA==
X-Forwarded-Encrypted: i=1; AJvYcCVoBQD1Teg6EKB4ReBMUETLCPgwbxjfKJgrdTyzsfqVv26iuzX28FL3g6YsR8hkKiVK7sDEUtTsjdb1cP7hvDIRkvc3DAb1
X-Gm-Message-State: AOJu0YyXXYnWfqfHcuYW4L7VUZZAUdXLTwhpJrdKIgY8vdqT8ivmKTn4
	lkIjCQbkYCzGaxK7B/qiFnzW/mfqPkKXdDCGME3BeIPHHsN5vuyr
X-Google-Smtp-Source: AGHT+IGe4y8qFNBGqhNgEahYPGRyJ7Jvj7mb5qEcxt7W8WzKmpqmEQ1V9zIhyLzgJz1HauzbsgOYXw==
X-Received: by 2002:a17:906:f88c:b0:a3c:8770:3795 with SMTP id lg12-20020a170906f88c00b00a3c87703795mr4450122ejb.15.1707831566050;
        Tue, 13 Feb 2024 05:39:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXl10t/YBRDHmZV8lo3s4EtmgR3ZOzkFAJt4B04XO3DXEpV1ulcqUlRhN9i2aW4aJwcQ3u4Zah4mXzepG76x5SwB/S+oT/H
Received: from foxbook (acgn20.neoplus.adsl.tpnet.pl. [83.9.241.20])
        by smtp.gmail.com with ESMTPSA id tj13-20020a170907c24d00b00a38a705121csm1295366ejc.47.2024.02.13.05.39.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Feb 2024 05:39:25 -0800 (PST)
Date: Tue, 13 Feb 2024 14:39:21 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: <gregkh@linuxfoundation.org>
Cc: mathias.nyman@linux.intel.com, <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] xhci: handle isoc Babble and Buffer
 Overrun events properly" failed to apply to 5.10-stable tree
Message-ID: <20240213143921.25a6f291@foxbook>
In-Reply-To: <2024021308-hardness-undercook-6840@gregkh>
References: <2024021308-hardness-undercook-6840@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> The patch below does not apply to the 5.10-stable tree.
> [...]
> From 7c4650ded49e5b88929ecbbb631efb8b0838e811 Mon Sep 17 00:00:00 2001
> From: Michal Pecio <michal.pecio@gmail.com>
> Date: Thu, 25 Jan 2024 17:27:37 +0200
> Subject: [PATCH] xhci: handle isoc Babble and Buffer Overrun events

This patch depends on its parent 5372c65e1311 ("xhci: process isoc TD
properly when there was a transaction error mid TD.").

The parent commit appears to be missing from your 5.10 and earlier
queues for some reason, hence the breakage.

Regards,
Michal

