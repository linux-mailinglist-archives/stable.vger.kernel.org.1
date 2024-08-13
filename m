Return-Path: <stable+bounces-67510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8E29508C3
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3056B222F6
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 15:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06EA1A0715;
	Tue, 13 Aug 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gGkepzjd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AFB1A0711
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562271; cv=none; b=USTR8hVSJ4XSkiDoOlzyzxXF7UE05DkM+KIseVkfoMib60tJN7XZhcsjzM5RZm1na4qoQGt6Z8TLyo7KH/gL0kDRymVkxeJg4DQgQMKlZPBM7ckJEes9mvx8bs72VoqSAYxDpjusPdPYEg8H70Wi/al1iAS2ZZF0PxLSa1Ji0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562271; c=relaxed/simple;
	bh=9Chp8Kdbu6SYoSV/XqRtuBNB0Ulomj1BCqRJZlB19WI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzGR1xVtDFEkj6Q9IwSnxBtmasEt2te+PQsNzVIuyi1HOVBBe+zRsE3n8IstieHlzBmicJSnhwBx/146zau6i/nIs/1rjH2oSnfSCLYFh/g20ZbpeuZCAQC1lGgnm/8Ox0apQlZbfEljQOxOQon0zKF1A9zoHLQKPXBVbZXSh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gGkepzjd; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a103ac7be3so3430350a12.3
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723562268; x=1724167068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4KRY8X4IunmA74dEqtckpgjQWJ1kH7nl8/HPopsHUI=;
        b=gGkepzjdZ1ZhClkJZH45b5IBGm3WJbOVMk8F3+VHG3eNrsgYgQEK2LN8xqwVnk6Ppn
         srCICIYNNeyjcpVT2gcXQOuJGY+NWQX1QMfgaee0Bzj/C2utB8OO3jc7ZAAUfelV09dT
         xVTbFr7zQ8EMoG1BAWk1fRUitpewQXiKnM1Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562268; x=1724167068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4KRY8X4IunmA74dEqtckpgjQWJ1kH7nl8/HPopsHUI=;
        b=hL+dKT4jhAcyMmpNSpNF8hj7vmZVDQz9iGKJhl8izce+vblKwgwDEKAI31hNrwoILV
         8kZ4o24lj/az7ohsqW6w4FtGIjd+A6bGL1C7dN8yRZFTxuZgtqipqwAHIbFqfm7iiNWx
         Ks+L8qMuaQS+CkfIosYzpPclWUxuhM0RY8mlkcXTFkL8Jneb9dx3WeMdlSN1gW+zhsYE
         ST6gV0dtQEFu6eYfqzVNv0jMneCI8LEJKP+s1uik526b8H13u08FFCgMCUJFMKbTA8iJ
         L5uPpHNrceiEcTEdGxcMs4uPCZtVVugxO+g9OGfLujB0UN+baQs43u86tCrk2cVkP6on
         0Alw==
X-Forwarded-Encrypted: i=1; AJvYcCUguqg4lIUGUyp8GWq0mcFnnf83mPPAXsjcIbbv/KnsIdWBladDuV78aDsHwjaJVlEXe9NE5SFNSfzcaVI4pmTJuuVtjl45
X-Gm-Message-State: AOJu0YwWOmwqGOAKi/1QTSDAKHiF2O0Vt/m07bgldMw2ctoZn5ZlAihd
	nYJHB76guHJB4otfR/c/Zg8saHqdNEF3PfjvxXaKEfVe0Hz1pYE0PHIQLCpRgzC12ZlDmiJSG9U
	5GPw=
X-Google-Smtp-Source: AGHT+IHXm0x6rVFLg4sEMfOVNl/u+rp1s8fKEkxeX/qIQGEqM6BLnURVvMM4eI5C7/juC0jCPJ61ww==
X-Received: by 2002:a17:90a:cf08:b0:2c6:ee50:5af4 with SMTP id 98e67ed59e1d1-2d3924d8178mr4202148a91.6.1723562268440;
        Tue, 13 Aug 2024 08:17:48 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fce6cfc1sm7409649a91.6.2024.08.13.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:17:48 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: peterz@infradead.org,
	andrii@kernel.org,
	mhiramat@kernel.org,
	olsajiri@gmail.com,
	me@kylehuey.com,
	Kyle Huey <khuey@kylehuey.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] perf/bpf: Don't call bpf_overflow_handler() for tracing events
Date: Tue, 13 Aug 2024 15:17:27 +0000
Message-Id: <20240813151727.28797-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Huey <me@kylehuey.com>

The regressing commit is new in 6.10. It assumed that anytime event->prog
is set bpf_overflow_handler() should be invoked to execute the attached bpf
program. This assumption is false for tracing events, and as a result the
regressing commit broke bpftrace by invoking the bpf handler with garbage
inputs on overflow.

Prior to the regression the overflow handlers formed a chain (of length 0,
1, or 2) and perf_event_set_bpf_handler() (the !tracing case) added
bpf_overflow_handler() to that chain, while perf_event_attach_bpf_prog()
(the tracing case) did not. Both set event->prog. The chain of overflow
handlers was replaced by a single overflow handler slot and a fixed call to
bpf_overflow_handler() when appropriate. This modifies the condition there
to check event->prog->type == BPF_PROG_TYPE_PERF_EVENT, restoring the
previous behavior and fixing bpftrace.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Reported-by: Joe Damato <jdamato@fastly.com>
Closes: https://lore.kernel.org/lkml/ZpFfocvyF3KHaSzF@LQ3V64L9R2/
Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through overflow machinery")
Cc: stable@vger.kernel.org
Tested-by: Joe Damato <jdamato@fastly.com> # bpftrace
---
v2:
  - Update patch based on Andrii's suggestion
  - Update commit message

 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..c973e3c11e03 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9706,7 +9706,8 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
-	if (event->prog && !bpf_overflow_handler(event, data, regs))
+	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
+	    !bpf_overflow_handler(event, data, regs))
 		return ret;
 
 	/*
-- 
2.25.1


