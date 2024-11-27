Return-Path: <stable+bounces-95654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7015B9DAE5D
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 21:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F5628177B
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 20:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061EF202F98;
	Wed, 27 Nov 2024 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdBdYGYt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C71202F7B;
	Wed, 27 Nov 2024 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732738248; cv=none; b=WfTNOVS/YxNEnIExXK79+h7nZBBu2DYxlSITu+H/yTYjF2+xT4DmK//4RtjhN3vs3OQNOhvyDAttvnmy/dbjJUzxRM9AfvtHCd/ucTS8/ClBMTUkO2GCP9LCgxQBYN6YlruHMJ5OtBrbetCkyEyxXXQnM91fzX4gN/+109UAxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732738248; c=relaxed/simple;
	bh=iFknynaxVSWi7l7OEEZ0/tMzkRAiqgHR7fjOJFyhRfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ub312ZLhDx8vi/F3kd4NzpRJhdM1tWU+wv0yNOPppVXT3muxhe34AuoM5X1+tBuhmY9W0ZSwb9/M4rkm3G4qvoZTRbUT7XEFC7bP6CHi+rRmCWe/bQuQnKt4Ai4hsiurZqUCOjjWCwNJipAjuvnVj9ExS0oFGugzdSm65j9DwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdBdYGYt; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-466943679bfso1420711cf.0;
        Wed, 27 Nov 2024 12:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732738246; x=1733343046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mblefla9njkVPYJmF7+4lumH+f/65iphlvMfUcC2UiM=;
        b=JdBdYGYtIdaUVwVCtoU72DfWIKVDXxJ1hfyyxIqOHGkwy1LRpsR6D+RR5baNzn831L
         N957F1pCZylIrwnR9oMW6CWA1NjHT/vpUOlD5lZcSqhMuKsFMkXNY/oV0mS1+XGHxM7M
         Q4QBQgcom0ZASI5aJeC9TanmVFd7LZqSRtJBNGCWxA2TNPUjqXV2Z+knMbrfikdrrQTB
         E+Seir1qdsdpqG2cdy2/SRB2Wr01XwrgH8wvuRXY5Wj65vBQeAhh19PwyO7+JCLyb5yq
         PUYn/OlghBb4CQr4QgktOkLMwf+ot52iDPCQgZMVUnCfqnJOUpk66MceSZzRaMhl2gLy
         Hnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732738246; x=1733343046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mblefla9njkVPYJmF7+4lumH+f/65iphlvMfUcC2UiM=;
        b=q0bN0+qZkMLSqqIOqOA4KPaBPpxLfijQUrVB39n/PmUi5FV/5EwDFHre3NTxJLxQz9
         T/4CjemqyvWyJ5TJnPki171aE+Ubl/5hAXhtYSJAGyEPpsEvONqJanfwM7olMCke6LZT
         nadkDjaamaCRm0wjcTe1088VwcnHI/+S0bbdt07qnlYcSKmRb8PNoFHMWWRqZtQvmUuK
         PjeA40lGnitSfC5kR2DoTAW5KBn21ntxaQo4TWaP+jO1K2PTiaNToDLeaxtfOj60jRb3
         +oEWOTvUpaCTvyYwDOi41QmwFChiW1pMl22/D7sc1c0/Y905DssVsKXSor05xhAKtm9d
         oGAA==
X-Forwarded-Encrypted: i=1; AJvYcCUEIdrZb4ilqQmYy7nwr0TTk/lEKlvmmiqPf8661waji9EwHsJLmp46DdKorE9q5y1jLB3zPlqbOHTizhk=@vger.kernel.org, AJvYcCWT7+sKjiyhugFshS6M1jK/ztpz7SWGfwZ/jJe70ASYLs4dz7eShGFwwAGiTnQPiMepow3336UU@vger.kernel.org
X-Gm-Message-State: AOJu0YysGbK9x3XiQAbeYupGaCDsJ6DVDcAB7g5Wsm5C7o2E2KD/h6ki
	O9XY2vMZfRida2q1tCtSE2unmX+EmYjJCwDN/eZrdukzlZRkXGeU
X-Gm-Gg: ASbGnctE7YpNTg+HJtG6tq0yiX/4s5tCIJrdY0Ys5hjzLYUi3APK0iuzLFTUKCUcqj+
	JvpW67GWl7/dJKxo5WV3SCb3onnmdNNkeYzK2eH0Hc2qjJTX+uiQMUe/jHJ3OmUXwLij4detjS+
	d4W0YIhv9bIqnvNenir5UIckfElHBmmFNwwzBqMSH0ZdG8vWmLcc9SMePiRrNsJwz+ry1R6x9q/
	jRFJPZ7/zNfzMwBHyHzdzfOjEYcRV80t9ShdGkuObOG9H0g1FP3TtgWD47m7YL717e+b2Bz
X-Google-Smtp-Source: AGHT+IGXO3DPEwrzdtMEulE3VhY7JlQ+MgBKS5s1oo9cMdxXkiSfRsPCWUfk8wMsJreCYQsvHzy5tQ==
X-Received: by 2002:ac8:5987:0:b0:461:9d9:15c2 with SMTP id d75a77b69052e-466b3554a2amr73534731cf.1.1732738246079;
        Wed, 27 Nov 2024 12:10:46 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b679c8d982sm138536285a.14.2024.11.27.12.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 12:10:45 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: nirmoy.das@linux.intel.com
Cc: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch,
	chris@chris-wilson.co.uk,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@outlook.com>,
	stable@vger.kernel.org,
	Nirmoy Das <nirmoy.das@intel.com>
Subject: [PATCH RESEND v2] drm/i915: Fix memory leak by correcting cache object name in error handler
Date: Wed, 27 Nov 2024 20:10:42 +0000
Message-Id: <20241127201042.29620-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiasheng Jiang <jiashengjiangcool@outlook.com>

Replace "slab_priorities" with "slab_dependencies" in the error handler
to avoid memory leak.

Fixes: 32eb6bcfdda9 ("drm/i915: Make request allocation caches global")
Cc: <stable@vger.kernel.org> # v5.2+
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@outlook.com>
---
Changelog:

v1 -> v2:

1. Alter the subject.
---
 drivers/gpu/drm/i915/i915_scheduler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_scheduler.c b/drivers/gpu/drm/i915/i915_scheduler.c
index 762127dd56c5..70a854557e6e 100644
--- a/drivers/gpu/drm/i915/i915_scheduler.c
+++ b/drivers/gpu/drm/i915/i915_scheduler.c
@@ -506,6 +506,6 @@ int __init i915_scheduler_module_init(void)
 	return 0;
 
 err_priorities:
-	kmem_cache_destroy(slab_priorities);
+	kmem_cache_destroy(slab_dependencies);
 	return -ENOMEM;
 }
-- 
2.25.1


