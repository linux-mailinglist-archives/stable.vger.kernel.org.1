Return-Path: <stable+bounces-6758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCC08139AC
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 19:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540631F21D68
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8D667E95;
	Thu, 14 Dec 2023 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkUShv3X"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50982CF
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:15:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5e283ef6299so7017047b3.1
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702577709; x=1703182509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wl7T/jeRwqz5jndbzZx/IZjkwxSRrJ6MPs4A3t3nRHg=;
        b=OkUShv3Xv+zNqtQwm8f+L9Yguqf/cA2NZ4RRRWtDzZlRLZgJ2yF+8AbngD+VsL4qMJ
         tdRTbecZkdBJ7AWr3VZRnUBKkvG2so0dFz43if1TZQlk8GN7aGKNvR6EBQUXCSRRfgVl
         5nkFwgDaFsiEEt9/txD4i6BI7Xy7k2j2xrod44WhfYjnm2R2uZPIMTRlAm4uMBEAAMF0
         3sgxIgw1LNLeJC1km3RYa9C1DSePiRHGU8xaBUjO6MifCkz7bdac20EJwwhIacIcKkDL
         3EiLOKXqTeYDsU90g0NKeV+k6giGMlyZlAydaRCHnTa8sY/La7yvMJ2YQfzq0+SGejNp
         2aZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577709; x=1703182509;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wl7T/jeRwqz5jndbzZx/IZjkwxSRrJ6MPs4A3t3nRHg=;
        b=ErBQY8sPbsB7CIPg75BjjENM9MaAfSd3vZcAsvgi4HMGeAbizt2MCZxrv95gyDp319
         W0s69YStg/A170Jj+TKV40BDe8KojHSB+LUERcvXiMixj/PG79ZroZlhsgosNaiCFeXZ
         5iGfjJ7s0rYF1oYPPS2HLkJLTQTPFJ4QJVZdBjxj/Jl4FVCjkE6vtdoG1+cZrGTORGJ+
         NDkmoCzKw8Jd3UAxnpY7Hr7SVXrefmv4BwisEB8Z0t+aDw7i3OnDj+oYnc73P6rd0yu6
         u+EU90a9rE8G1zPqSSlFKIZ9iY+0JYCltl//37hw/pgmK5slZab4U4pmcGeup1wSaSbv
         8GmA==
X-Gm-Message-State: AOJu0YwaPb7pao75X/RHuWRK2w6ukRal+3aYux65Au1uEPJ0MZ7Ly/Vz
	grnmI7r9Q495U2jqpnhgRsk3HlirGwsvuO1ECBGJUsaAxUjXRtZNO/QjcJdhrb7RBzSjJv7j/2D
	eY8FLuw4c/gSCUOrIhLOazB/4R5WNiz1cZG2XWJEyIOu8luoC9DddojATdRfsUqk1nTY=
X-Google-Smtp-Source: AGHT+IFO0RFyAT/x4SWN4ch0E0RAdzAwA8I9VsokX+wtTePhgRe3uACY2EvEqkdXLTTRsIe4nozHr6LO/lmqlw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a81:af65:0:b0:5e3:9c82:9d02 with SMTP id
 x37-20020a81af65000000b005e39c829d02mr30462ywj.4.1702577709440; Thu, 14 Dec
 2023 10:15:09 -0800 (PST)
Date: Thu, 14 Dec 2023 18:15:02 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214181505.2780546-1-cmllamas@google.com>
Subject: [PATCH 5.10 0/2] checkpatch: fix repeated word annoyance
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"

The checkpatch.pl in v5.10.y still triggers lots of false positives for
REPEATED_WORD warnings, particularly for commit logs. Can we please
backport these two fixes?

Aditya Srivastava (1):
  checkpatch: fix false positives in REPEATED_WORD warning

Dwaipayan Ray (1):
  checkpatch: add new exception to repeated word check

 scripts/checkpatch.pl | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)


base-commit: b50306f77190155d2c14a72be5d2e02254d17dbd
-- 
2.43.0.472.g3155946c3a-goog


