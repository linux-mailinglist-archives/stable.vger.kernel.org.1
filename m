Return-Path: <stable+bounces-152765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAB6ADC82D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 12:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50E77AAA17
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C53B7262B;
	Tue, 17 Jun 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4Tu15w9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25C7293C64;
	Tue, 17 Jun 2025 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156014; cv=none; b=Q4rV1ZCcOUsrz+cI1E5RuzT4B54E9qKq2OLN18f2CKU9FBM8lhRaJHKTC1FGE5rNYHzkl5X6/X2fCU+h3nz3wotpPe2HMTaXqvGbVu0jGCaiagnxJVJlUYQPmoPDig5R+9m9YhY2WSXkDdWQGwAWcUqP2z0OWNt1HBN2mGG4d5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156014; c=relaxed/simple;
	bh=c7SJ8S5i0EZ71+KLteXSUyF3nQXE2e502C4Rl9OAeiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwXVCrI9wCiUg9s3ArKXyByr8m+gIKKPnUXf4fwLmBqXdBNzU+ZXn0LTQuq1ouspEzdV4ouLGxd68zl9LJxoU18zYKtIXxDbn/Co7LAZf1MOWOPrcfE1Jd2n3EzbRV9jKrC5ip1NevEuouORz3mXuUicAxJJPIDvYtZ6r8zQ0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4Tu15w9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3137c20213cso6608848a91.3;
        Tue, 17 Jun 2025 03:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750156012; x=1750760812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZz6MHsNO6dIlJ6aj/tvnzfPrgOsbHqDiUlqtB5Es+k=;
        b=d4Tu15w9mPe4I9AiESzvjNTZjHcABRB9mYznpgNwxg5Q7X50dgIh1rtJbz6FlJYpjr
         NhPKvR6/fdai0yvtB9+akEOR31ya4rwvykY9xyhaKMRnhv9RAJX9GS4tLTeThRQoVXA2
         9+uQLUT5AGBB+jYqopFx2BcA1b6hB/njt1+5yCph9vW8p+wsJbfUq0Asb3/EUKyv66rw
         kiWn9Dzr0SFZtrCacWckNAGGx+rXlOWQT7bGp9NvPGkZLhhU9Vxxy6xoc/QeONois+fN
         48skoBSTBDXb3CXkCTi8h+JLPijXL2+OM0XH0df8D3LQMs0FCaP/+LqV0Sqw8qbqqtbd
         JfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750156012; x=1750760812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZz6MHsNO6dIlJ6aj/tvnzfPrgOsbHqDiUlqtB5Es+k=;
        b=qUPnxNVHp7OHLBDgvTSu6bCEsaKiH9qpX8s+X29ZOVxVX7yWyot0rcM7y1UjVnkB5o
         MqMSxXy8FO6FR2oNXZhFEDcEvJrFcEOj97ZrTsU/5wEFEGkGG3ATyLrcX6V/RdHa385J
         PgyuXUETEbo/63PXYzO4+eQ7t+Z06rc42O/4ubjDhPPB2yoVr4IEhVb9BC0N46slsC/m
         Yz7EAPgP+SG4BGWGfqj/pkzYydK0Sun3S0gsPHUjTq0bR125m09F6FWOknMy/UNSMXzI
         FPDyn/psUdwyswRSgkPyxp8QjO4H9fkd5IHmhF94vuR/IciAT4k8iyYhhhWU4sXFt1MI
         PRkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeiUGY4iIjjDG0QRm+aeUZN2yNmouG5BMlIbGMEOdjMAx1qKgt6UlmJx7XbfLaXt1phgtpn5A9ZEG9GlQIOsVCr/F69w==@vger.kernel.org, AJvYcCUosPFmW9rQTgd2vfQFZRvjzHoS+J3hKolfPzmog+ro7l3TnlY4xHEoXK/KRHYrapvTlk1zXfz6+5RMmdw=@vger.kernel.org, AJvYcCVTmodj5cCTX4HV2RSiiMW2C/WVfVK4M99XfG5pBDFlohSFqeWWzVy2qZBCKxseoaHCfraDGGff@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2/sU+QuvvM/90LTrjiX9MjPpSRdojfeJXKy+j9EQmG7cXEHb
	aH0mAHmi95lJK7mvxkkA6XqGFQ6xYxb7il+B3xtVtZ6GfkJtpAOZKZ0f
X-Gm-Gg: ASbGncvC+/HZMXPOrrrps2X072qdEK2as66Y+g0WmYjMmmnMHEzhZvCuc/J42ul/ErV
	wiq/bOnFajcnhkFkk/icQ4RRkHuxvDANReH+FskDqeUtrBDpCiYeJ0VRMMXXuNZEmzvFx0XpuO4
	u0Y6RGOhLrcED+3XANcrurSBVRQensBWxMAjcCsGaFHvUGK8viLCh5RoBrtF2NbwM/sZ8PJZFib
	l6/A8ARPKxKTS9iMFWJ8E74pKmjYAqEe8JkzXdE1rwI/3QRdxNUo3sgEJMfSUBgDHAVUFCKhJJP
	nnSM1EeJCJqCd+0fnEQHVk1GnOoPcZCTSy+XputnuRW5EkOWEtS9ASy68dwyzzjlfYBCtrjCJY/
	riIXb
X-Google-Smtp-Source: AGHT+IEvpo0maN0m+gyRmMErklVTxeyTK+JnMtREA8aMyFe7PwoLhFvswRDMfRFhsxdH7wrvpIfxhw==
X-Received: by 2002:a17:90b:274d:b0:312:959:dc4d with SMTP id 98e67ed59e1d1-313f1beafdcmr21027180a91.7.1750156011965;
        Tue, 17 Jun 2025 03:26:51 -0700 (PDT)
Received: from localhost.localdomain ([104.28.254.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88bf0esm76165935ad.31.2025.06.17.03.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 03:26:51 -0700 (PDT)
From: Hai Tran <hoanghaivn0406@gmail.com>
To: i@rong.moe
Cc: hdegoede@redhat.com,
	i@hack3r.moe,
	ikepanhc@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	stable@vger.kernel.org,
	Hai Tran <hoanghaivn0406@gmail.com>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: use usleep_range() for EC polling
Date: Tue, 17 Jun 2025 17:25:22 +0700
Message-ID: <20250617102522.2524-1-hoanghaivn0406@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525201833.37939-1-i@rong.moe>
References: <20250525201833.37939-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested on my ThinkBook 16 G6+ AHP and everything is working fine now with:
- Fn+F5/F6 inputs to change brightness are not shutdown unexpectedly anymore.
- Sleep is working after closing the lid or via power button.

Tested-by: Hai Tran <hoanghaivn0406@gmail.com> 

