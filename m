Return-Path: <stable+bounces-77079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E73E985344
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 08:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE311F24C44
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 06:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF18155C98;
	Wed, 25 Sep 2024 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P5PCAtDu"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0715575B
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247217; cv=none; b=VJdJ30KEeEy+WhMbJMha4UAS5uc7p6Vx+j8dwo00W9pp2IUk6gZJTJ9bPrmu9Ivgy0imFOJYvmtRw0LvX6vaVEQ/yJ7ohe9yFTkOMt3P/aKw3Yxhx/TrTM9JC1aMtRUf06bXIplhX+GopZpItVsuGS5LATT0mp9JHpV78LGzc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247217; c=relaxed/simple;
	bh=r9kf0qnXwSSLeWJNN9IRx8zdyaGKS9+VO6ORyI7NPGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HdgMP+JRAgMxIdUJe6FascXiqIPcUMH24WDDflJks/Ys67Mv5EE0XuIBZRa31v+2nJV+b3gaV0GcOtfcyN5wPeOWtR+jm1lVnkLXIzG2LYD93RPNTpKww/ur3yyci5SDu6hVabuzC/QF6zecjC5LUT+nyWtjMyeIDaWSjYssWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P5PCAtDu; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5e1baf0f764so1923331eaf.1
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727247214; x=1727852014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/PmnBcy5yJpNGNWEKH0ddst5UIranDsBHIcPf5w/S+c=;
        b=P5PCAtDuOMNlVX7HU2r+e+juYe5XW3BCoEqJDW9BPg6ZTlWFZxp1Tpz7bLI5lkq9QD
         sPdWjaddlJL0cY0fSwRX3XbzwpfMb5HvOFFlVQNOl2wYdeTLBdF/FizLZvTSikXtqt6F
         E7b0YaNJXpfAAQnLWHFqOfF+eQ6sTFtKB4fJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727247214; x=1727852014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PmnBcy5yJpNGNWEKH0ddst5UIranDsBHIcPf5w/S+c=;
        b=MZlDgE8uYNp/EkXKxISnQOYKEw9fO82LlnIvQi1PenscGrRo3GTSMeB9Ht68HO4qa+
         1dip85azu34RwIgoBfRGH6ktiszWIIhyj6P1Obv7ZHjd9X88OqyNEeUF/lyRSkoOZ4bq
         uMPbYuR801blrzPM3QHHG7F6hH2kk59R4k1Kxgqph94weD0S+N8ppsIdCHzsEKQvReU1
         xvnOe1OeqnUIILwS6+LpgR1GpWYUgoF7uLUELbyfi+Sdy8wvuQiUCK9ebs0QXUFBC/mV
         d9/YIYZFjyfYuYsksG8Y2fMwyeLGV2HW+AD0Slyj2SHecS48r/6oE8e30QeHknPe0PVu
         BDjw==
X-Gm-Message-State: AOJu0Ywrs+oTp+U6Je1ibaykSuG8aHRuvaCKksy3Z8Yq9Ml6vzH4bK4X
	kFJu0WS8bS/MJHS5JUKGm1uem6n1WobDkW6JHqgwHkIbU18H+iE6WHtarOji/liKeRUkxzTcaZI
	gELLqsZVnl59+APMFdF7oNHL2HHxSjSAxlqKVLrqNQTaw68/jBwFi4lRRYZfM409m/VC/c7P5VN
	9y4t9BLnP2sGq594Wu/q8UKPPwaLfvHjh/MkeMDjKmxdpHEFQ=
X-Google-Smtp-Source: AGHT+IHaAKW1G7G4hKmqrze6WNPhBVr8M5JmwpNcogPuxjcL+2zikfRrYl0d2dAryi2RUaSlQRjsGg==
X-Received: by 2002:a05:6870:14d0:b0:277:c113:5b26 with SMTP id 586e51a60fabf-286e12b8902mr1438664fac.7.1727247214307;
        Tue, 24 Sep 2024 23:53:34 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97b623sm2147203b3a.169.2024.09.24.23.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 23:53:33 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	jpoimboe@redhat.com,
	sashal@kernel.org,
	Shivani Agarwal <shivania2@vmware.com>
Subject: [PATCH 0/2 v5.10] Fix CVE-2024-38588
Date: Tue, 24 Sep 2024 23:53:22 -0700
Message-Id: <20240925065324.121176-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shivani Agarwal <shivania2@vmware.com>

Hi,

 To Fix CVE-2024-38588 e60b613df8b6 is required, but it has a dependency
 on aebfd12521d9. Therefore backported both patches for v5.10.

Thanks,
Shivani

Shivani Agarwal (2):
  x86/ibt,ftrace: Search for __fentry__ location
  ftrace: Fix possible use-after-free issue in  ftrace_location()

 arch/x86/kernel/kprobes/core.c | 11 +-----
 kernel/bpf/trampoline.c        | 20 ++--------
 kernel/kprobes.c               |  8 +---
 kernel/trace/ftrace.c          | 71 ++++++++++++++++++++++++++--------
 4 files changed, 63 insertions(+), 47 deletions(-)

-- 
2.39.4


