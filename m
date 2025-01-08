Return-Path: <stable+bounces-107942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4B1A05180
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 04:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B6A1888AE0
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE6F198E6F;
	Wed,  8 Jan 2025 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VVzOqhhG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8D1369A8
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736306273; cv=none; b=cjl071KrIBHFnfC+7z89ffFYN97uo4tRA4r18VP5q+i9W2k82FFanhnIEFUajAySI5Oj+V+ApLXfWexu9DMIBlyr7/WphynY2nCt3gcL2WhiLQx51A5S2yQz7uq1BqFFvr5Y13wuVyQDCGUZ0Efb0uQf97cGtJ5qRJSqQEHif08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736306273; c=relaxed/simple;
	bh=/WbFgZXKGcjYXzcBET0f893gCnIQz5OzZWKXFdZzAuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YgiMRVO2gsGPR705SFVpXSpQTdq3nClf7+knRpW79uMYGr6ryPVrlJ57YIyCtuS1NxvWdulQmCStPD4SojZDZ9jDowgxMXgPB0pEreVC0W8spgseSDvpB3Jp7S1PHl5JzxBqMMQ+9t8OCx0dkosdJh+geqUTKXjcq8Cg4rbqUjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VVzOqhhG; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 65B3A3F86F
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 03:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1736306268;
	bh=4t/uOfc9VUNs921NK6Lx5J/n9gMhAHcagYHGPMIUcGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=VVzOqhhG6YlZKayOeFe+Dj6nTHCynEXRQ4vL/hlGEuxSqzdszMkcZG84YcbJ6Z3Pg
	 +orPHW1meHC9TmNWtpHCIjCA9tLCrv0jDKqylAEgwRopVj+JrY2shJ2lBn6z/PlAJf
	 1O69odF7tXLR+JBqBFM8s2oRGdy8R0yHEympT1+CyYFg0PKPKdhRhxZGJa8Nv2qBAT
	 pVtq/cArXlOzlkHCH6dZuhz6acUCFEQdrlN55LqostS3T4XgkIjosp5c8UXCHHbCwA
	 zhsW8ZQqYLKzHZae2/57Bg9MfUP0zlyJsJrp1cpngh+ujGK8XLc2+pIECWEN78yaEr
	 UH3ME+Gjo0UFw==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2161d185f04so173133415ad.3
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 19:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736306266; x=1736911066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4t/uOfc9VUNs921NK6Lx5J/n9gMhAHcagYHGPMIUcGA=;
        b=USAzZdQfnrvwL0Q53dmgpvlWN6P5vYOBZKCTkzDda27x4EkH/kXFwKJ8YcFguofu9F
         HOtBTXr3eG2Sij67+G3t0s87ZgB8s9iugnZ8ZWbpqwOllm8aSgSbzGr4Whx7qgPsZ5hn
         MdQm4SvUjtA1yYPZEdpgjElGSD4Nb1k7hFQnKp5PCnF0T+Bd6KO+5ei8KEJ7iQnwwo7s
         R3MLL/LHJdqPwHu4DNfpDsgql95aGmUQS9CyO2HQAmGPtJF80SuqDiPGNtNUVl8zoUBJ
         lqcZQi7NJV7tJ9pxPqlez67/lYJYc+HluHgPafElu40i0gBYYs3M0CcylAw+v5ODqpft
         dbWg==
X-Forwarded-Encrypted: i=1; AJvYcCUsPE7252JXPWWSmoDeLSutx452DwZbhe5YAb0NJdNnVayi4HYpeuFMa6W79G7vre5wiXLOof0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBPtwBHZENXLWY8FeBWztI8SQSTorIX9/SiCol02PyRHqnlhW
	yfnZtPJVKr6OaeTQkhonVJMSv6PN+rwhJCqQ0Di15SNd8v0fZEJDFIV1A5jI9DxOnfDzxIwsWjs
	+6YzdggYz4GaY49B8YzjnPK76jFBKdUKBTF1BR8HiFqCr853/UBi9iMXFeM/AHKuv/39Ibw==
X-Gm-Gg: ASbGncsFuR/hvVOWkM26BFpD8SXsqKdszQ+87tMK7QQb9G+mY9MurqsPX2w2sQOO3Q7
	JvXR70w3Pkcv2khf0S5pyVvd1H46Dc/2ebOrbZ6epzH66fpZtqMJjQNhNJ9eJqlyTqCIpuwMjnN
	9jhcLk28yFnbTz/cUAWWANXDatBXKw3cCjArdodgUM5rTfBpU/nnVenrE338OyljpSPuzeq1tRt
	Qh0UdJy8vpL76sm1D/kJxZ0fOJyLDRxXlM4ZSVVYaz93Ea6f01dzFu7sw==
X-Received: by 2002:a05:6a20:1589:b0:1e1:ae68:d8f5 with SMTP id adf61e73a8af0-1e88d12c15amr2416420637.26.1736306265850;
        Tue, 07 Jan 2025 19:17:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRthgxMACPB5dv1Q3iyN7OaE/oSTOZt5h3AhEAU6QH5njnVBnhmyxlJ3Xh1T89ACeeJqFHOw==
X-Received: by 2002:a05:6a20:1589:b0:1e1:ae68:d8f5 with SMTP id adf61e73a8af0-1e88d12c15amr2416400637.26.1736306265561;
        Tue, 07 Jan 2025 19:17:45 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:4e52:6214:fe82:b2d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbafesm34973926b3a.128.2025.01.07.19.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:17:45 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	zhengyejian1@huawei.com,
	hagarhem@amazon.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.4] ftrace: use preempt_enable/disable notrace macros to avoid double fault
Date: Wed,  8 Jan 2025 12:17:36 +0900
Message-ID: <20250108031736.3318120-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the backport commit eea46baf1451 ("ftrace: Fix possible
use-after-free issue in ftrace_location()") on linux-5.4.y branch, the
old ftrace_int3_handler()->ftrace_location() path has included
rcu_read_lock(), which has mcount location inside and leads to potential
double fault.

Replace rcu_read_lock/unlock with preempt_enable/disable notrace macros
so that the mcount location does not appear on the int3 handler path.

This fix is specific to linux-5.4.y branch, the only branch still using
ftrace_int3_handler with commit e60b613df8b6 ("ftrace: Fix possible
use-after-free issue in ftrace_location()") backported. It also avoids
the need to backport the code conversion to text_poke() on this branch.

Reported-by: Koichiro Den <koichiro.den@canonical.com>
Closes: https://lore.kernel.org/all/74gjhwxupvozwop7ndhrh7t5qeckomt7yqvkkbm5j2tlx6dkfk@rgv7sijvry2k
Fixes: eea46baf1451 ("ftrace: Fix possible use-after-free issue in ftrace_location()") # linux-5.4.y
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 380032a27f98..2eb1a8ec5755 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1554,7 +1554,7 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 	struct dyn_ftrace key;
 	unsigned long ip = 0;
 
-	rcu_read_lock();
+	preempt_disable_notrace();
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
@@ -1572,7 +1572,7 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 			break;
 		}
 	}
-	rcu_read_unlock();
+	preempt_enable_notrace();
 	return ip;
 }
 
-- 
2.43.0


