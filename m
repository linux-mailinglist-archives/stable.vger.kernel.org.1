Return-Path: <stable+bounces-152252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312DAAD2C43
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 05:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B90C16FBCC
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 03:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3C4188580;
	Tue, 10 Jun 2025 03:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MNBq6k6T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5525D204
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 03:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749527336; cv=none; b=ATG4c38rwPcxEA/BP+r9lrywG2VgnFAIs+Eg1K7+xBccyBu1+d4q7c3rpnxM2eMtA9z3L2zpdlDuiYBaXHCvEdiP5Sn5f7AMYMAMZtwf/+1ocPWDbpKTpfq/y9i8OKuPxWwplwlltVHg1qJkMr2TJoQQt5di3zHGOqwYuFSKemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749527336; c=relaxed/simple;
	bh=LfDKku90Dd3qk/Tpjpfg+vTZqQ5m61fR/4fkUTRneyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EL6A2VxUgTM0OrJl+WZ9MUXZdE2SJfVTpyRGxyWnAiROp6HO0/ZvPnFo20m3B1WlS8E85554djKQONb9SdNsUu1MgUB8dBhu12Lo/RzFON37IpUzZjdTlJ1m2V8a8wz0/4ASf+zIuaTX5puwZxMcAMWTCY0Cx1VoJPOWiBTjjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MNBq6k6T; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c46611b6so6273657b3a.1
        for <stable@vger.kernel.org>; Mon, 09 Jun 2025 20:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749527333; x=1750132133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfDKku90Dd3qk/Tpjpfg+vTZqQ5m61fR/4fkUTRneyg=;
        b=MNBq6k6TwDVb4eytjTBYfIBTtKcrmhehoA3eHH9jWz0kbDrJJLJCS/3c/YH09GK3bH
         A6u8Gnc+/m2x5GZtiN1z1DSuhLEU7Da8EvLuWBLdzCLEyY9Dq6dRWYkP6hhtTqgrgDV7
         HpO9Zey9CuNy1HaJGoPJ2zHIAQijYYwPzN1ppITeCA3ZmEbllYDzNXAUa7lAy/H2aCal
         oU9dQF8cS1BdaOjtidwWwEkytpK0M1atuxaHOu/GXp30R8E7rgVf7pU9RC2VE0bJI2g3
         TtMsJmeZ5v8kD4hOyH1OjKxtctmra3hvibFmeOMk8zTlow5DZaAIBvF49mZt4FObU379
         QquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749527333; x=1750132133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfDKku90Dd3qk/Tpjpfg+vTZqQ5m61fR/4fkUTRneyg=;
        b=CyxhTgUldXLVf7XxhqaapSN6Pj7VGUsVyRDxR4+NEPNjonjei5ydw60CIeCdGfnFdu
         9NeOOd8lQwSA+eqK6GcyRjYmbQCQwkeqpRi+VbPfW0s+aYMXOH9FIreDcjfSOP+TBeyb
         8GDBzRuUvA7BuuUbrnc7lvgd5mbIt5QGXnsbWILpK4aAL+HMvFsRba/8WSmiZDvOp27J
         LOO+eAmG+6Zo4blnsPFzZ4R3gC8n8rxXX6ghH5vxcKaVE0WwKD0xj6NtayLYIN3Se01R
         g/s3KD5uee3R0nDwp8BRDfs3TEyTlZlt/Z5yRQYNNTU9rbtrdo++FqP6+UV0EXPc4NLK
         g1pw==
X-Forwarded-Encrypted: i=1; AJvYcCWDXBgf3QWgcoRsUJJz1sKXMDLfekVPLp8JZktH3CMdZ5yt+7cx4SV1z88XYN1YqePM/T2z8co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0CeoiCiTwZWJ5JCDf0R+aQFP6lTdNIIz/3Ueo5KzrctKHKTjX
	vsEzxGlC28ZZ2tbaEX/4+mJjpaExt8kMqz+ScWm1GqV/8allw1Ku5TayjLHUpLNmOnU=
X-Gm-Gg: ASbGnctvlOPLzlxzxDE9vI4K5OYopCMifOki2wyneCEWoS1eqaBfZB7VdB/g86Zpjpk
	xU+a3jMK/SntnFHJK6jESVhCalvr6jA0+5QUjutKrsU86dciJ789K737xhZBOaAEZb9FcJ1ymiJ
	cbXgU3v5YruG/Ad6ejGkd1AF1XIQYFmvRKKnZlOyANODtx8A7dkeAFhLMxKurKioY9Vq1pswvip
	DVnF8yhwNKifvuhCawhnVAlEiF0n5U0eyOVGAMbP9mnC3bmWrzwoXXYuoxOYrCloiReUAw9uBjm
	NJx0AziTf/ZVC2PrnR6z4Gp8iKyv0g2sdWG7Gn0H2bYyvt5lSxpdKDDJI/utH8ESnmaCx+WgmYV
	xb6NHTHPSdVS+zO0XqiU=
X-Google-Smtp-Source: AGHT+IG1ix41IRlPEDG1HenvHY+yF8PR1xemRzGkkLgVLLnz1RDwPTZbUhRrHTkZMMX4Gu1C+XxPvg==
X-Received: by 2002:a05:6a00:2343:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-74827f159afmr18347886b3a.15.1749527332612;
        Mon, 09 Jun 2025 20:48:52 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b083b03sm6488081b3a.83.2025.06.09.20.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 20:48:51 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: lionelcons1972@gmail.com
Cc: patches@lists.linux.dev,
	stable@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Han Young <hanyang.tony@bytedance.com>
Subject: Re: [PATCH AUTOSEL 6.1 3/9] NFSv4: Always set NLINK even if the server doesn't support it
Date: Tue, 10 Jun 2025 11:48:40 +0800
Message-ID: <20250610034840.36099-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.49.0.654.g845c48a16a.dirty
In-Reply-To: <CAPJSo4XSoTNVvH8MpZWD4W50u=U4bw6YBCnNeiJZpe2LT-YNYg@mail.gmail.com>
References: <CAPJSo4XSoTNVvH8MpZWD4W50u=U4bw6YBCnNeiJZpe2LT-YNYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 9 Jun 2025 at 09:12, Lionel Cons <lionelcons1972@gmail.com> wrote:
> How can an application then test whether a filesystem supports hard
> links, or not?

I think link will fail with EPERM on those systems. However, this patch
doesn't break existing things though, since filesystems don't support
hard links cannot be mounted by NFS (before).

Thanks.

