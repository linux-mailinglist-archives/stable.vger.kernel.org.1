Return-Path: <stable+bounces-163572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26759B0C3A1
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7697A3AB498
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46802BF007;
	Mon, 21 Jul 2025 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="a+icuq2t"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAE29E0E3
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098562; cv=none; b=hGYa3P5H4ksMKu4v0waQkcFg8IBHypPICzE9+sjbjnYUeZyMNFFXF0rhSSzIuoS3Di4+xVxFdwYs1We0Jp3Y5FXKuO/8LJVVNuiu/VYdOP/561y8rRcvB88aedxatplM9fEIo7QzallsqaZVGpB4Jb0qY5LyrZckObxh6CNDvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098562; c=relaxed/simple;
	bh=Ncp6ChV4tAlV3aaVglSEugwBoVCiKl/KYW53hqeoMbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D73tTDi+oSLJq0inDQciPB+FL63FUe+//zBq2Zcc9+alqsKx+dyPKYoemLyRF5y0Dhisrq9P+xIJJ3sHTGCkE5TC5e3dRmGE5LlEkydy+7Wsxot+yIY6SGm31XJo50Y+FY3AhFZgqPSw+24oFFhSrsoKMhoCVV1FiTWjH6PFEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=a+icuq2t; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-75494e544ecso222201b3a.2
        for <stable@vger.kernel.org>; Mon, 21 Jul 2025 04:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753098559; x=1753703359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A0Qulvm534at7wjI1OMKk6tkUpAtZASogifC9Vv5D/Y=;
        b=a+icuq2t0/u12XAbsefniSanYgwZS//t/+7SyMD1w0BhGK4YZc2cBxFIZvGCXtPDHd
         uwmi314C5KODW6OPJa9SxMoXov+GyknHGLMVnQ8aZzACRfOSnAsNpaWxHtQLBxJcC8dv
         JL9K9xuRJz9KbOMC9dV7ybCZJX3k3pJMNYofI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098559; x=1753703359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0Qulvm534at7wjI1OMKk6tkUpAtZASogifC9Vv5D/Y=;
        b=HPrfJG+lUXPl7BI+Zgjwp8wz2pK5Hux+Yn0+Z7ZOk4Q2Ynbskj/ubSbF9PkmDODUWN
         r6CXWyHZtb5BardBo1NOaSEiMGzHqgSoopqZLQSzd01xdXqXuBJHAKHGx6d8B4U+r/QI
         ohv6ahkUctafND5UTrwgKqgb7YSLjfmOl4+eAMN+fjjFlvTBQRhOno6R1w4ys2l+hUMj
         EZxmc+9Fi9cHpeV0amfrRzGAclNvD159nhr2L+0FdwMUXUllCdKaMCQ3YhhyMF3yfvcW
         yEXtlGSx3dp5sYhavVa4l68RKWZgofil10EjxhlzxxG2JHY5MDROtExmntnj6rZ1lHrd
         BkQA==
X-Gm-Message-State: AOJu0Ywk/jwc7VPaRHXf5zLHnXT1bqDaycgTYSqSGQLCghRdOYBRYrCE
	dmWCzVwzsQXXIS2Z0Cg5YSi2aZZw4s7hjgy06uOGgAfvOGjFTEpWJ0PhVn8KHCeMelCp6tNKQjz
	mS3NdZN4=
X-Gm-Gg: ASbGncsIHHX2bCKq2/Z1Vw2pyCsFd+Q2W9a0NQy0IL0L+2t9cJdiX8PqPdyyVQ6ZiSN
	q9IyDuq98GpQxzaNtMFn8CGHmBTfypZkzBfT6lT+yT7WF1pUy86uaB8FUB54IY3nD5MP5/Vf0TW
	/HlULkTunufGcJY6mURCe6w8HOjP7OA/oe2J9F13NPVM/w9yp05qDsIWEc8TNTcLN2oUVWVzjAX
	+OqCMQcLN8FZ7A5FMAW17iEZv7Sy9vxuZJKRCq3T7ZlQNWoQwd33Wl6SZkdXb1hcwy0Wbp/CnAH
	x1+o8+WziJ73RGc0r7i62N8Opxa14nI6vVyw8GxZcA0viQ1RJKzidPP4DMs2gDEYLPnuk1Nm86T
	smG/M1lKoKKBFP/+Yckc9i+JzCdu9MGzIBQ==
X-Google-Smtp-Source: AGHT+IHQU90f84b2bHRVyhQ0Zl5qRdB4BKZ2khROu9Tye8xCZJ1BgXsG2zOdLaCm5eFg3/Kuvsqnlw==
X-Received: by 2002:a05:6a00:21c9:b0:730:9989:d2d4 with SMTP id d2e1a72fcca58-756ea1d3290mr12500737b3a.3.1753098559125;
        Mon, 21 Jul 2025 04:49:19 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d5d8sm5572140b3a.112.2025.07.21.04.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:49:18 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 0/3] Backport CVE-2023-33288 fix to stable kernel v5.4.y
Date: Mon, 21 Jul 2025 17:18:43 +0530
Message-Id: <20250721114846.1360952-1-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shubham Kulkarni <skulkarni@mvista.com>

Hi Greg/All,

This patch series backports the fix for CVE-2023-33288 along with its 2 dependency commits to 5.4 stable kernel.
These patches are already part of stable kernel v5.10.y and I have referred to those commits to generate
this series for v5.4.

[CVE-2023-33288 - kernel: use-after-free in bq24190_remove in drivers/power/supply/bq24190_charger.c]

Patch 1: Dependency Patch #1 - mainline commit 1a37a0397116 (v5.9-rc1)
Patch 2: Dependency Patch #2 -  v5.10.y commit 18359b8e30c4 (v5.10.177)
Patch 3: CVE-2023-33288 fix  -  v5.10.y commit 2b346876b931 (v5.10.177)

---

Dinghao Liu (1):
  power: supply: bq24190_charger: Fix runtime PM imbalance on error

Minghao Chi (1):
  power: supply: bq24190_charger: using pm_runtime_resume_and_get
    instead of pm_runtime_get_sync

Zheng Wang (1):
  power: supply: bq24190: Fix use after free bug in bq24190_remove due
    to race condition

 drivers/power/supply/bq24190_charger.c | 60 +++++++++-----------------
 1 file changed, 21 insertions(+), 39 deletions(-)

-- 
2.25.1


