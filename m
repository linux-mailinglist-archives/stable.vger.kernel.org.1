Return-Path: <stable+bounces-210016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC876D2F26B
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1A030940E6
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151A2239594;
	Fri, 16 Jan 2026 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv3/nlXf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9D12EBB90
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557479; cv=none; b=NBToKpHSCLLLMzkMP1qGn2s1FCd6+Kr2cCXrDYbaPDavP6ZMW1thgY7T4IPfns/AflI/I+TOnNKgtkQWQwWuqUmn6WT7fOCaGllP+2s/glKdrn4OdWw7exLwn5vXjJFNC5zIrtTbKb4wHfPyq/SvNOeywVYklyFN18CYi1EcTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557479; c=relaxed/simple;
	bh=zPajOeekjwnH1L2PhS0ee7WaYai94vHkoloTqOoAN40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m8oYg/qw36w5ydo227p9FRCbDR+GLQuo01jznpA0z3RNNmesJruWjVFYGcLOehuYQy2GmHXgqcZxX3P93j1M0UiKCm17wgXld552T1zoQC+6UhUipdu4NRpGnvMpuf3UfJDukj8STRf5Lg11E5SzayffTt/jPWtGZ8oJ9n1EILg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jv3/nlXf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81e821c3d4eso1576531b3a.3
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 01:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557477; x=1769162277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z9cPCZbEtZqLhkXtHvfyAqgg+9cdVAULaffu1JjYDN8=;
        b=Jv3/nlXfhvQFpiEurxigKUSHBU7WN0QprWzBMEaL/q7SL/hpZ/kFUjwcutb/ofL619
         Hc6pH/G/pxG2pOhqHCAT4mQFIAutJEOYcNDrWfbGJyDEDGa0jHo0zBQD4f7UXbb6LVMb
         V6oT/F+SsMQWoI9dWjkg7xtT1womNWd/go56zbFZ1cewaDokMElV+jBEKBM91vqIlkMI
         C1t4ehRsUElV8JpK/9Qw4PRdW9yX5nZc0IdQ7Op8ujtaB+EIRFW1YoNQ3VGR9qRAV+z3
         2ZVHLf/Pnr3S5Xlfw2vWQgAf0TSXMKfpoxuGTh5w4/1TjSmcCH8+IoUlBoVSPSG76f20
         ctzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557477; x=1769162277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9cPCZbEtZqLhkXtHvfyAqgg+9cdVAULaffu1JjYDN8=;
        b=nZrfM5a/k1blmLqncnmAyrZOS8D1e8D5lSw0gVN2ZtZpUXNRPbfj8h6fio4LW3o9E5
         64oDqi4lQrkOBHkISz4NjPpIzo0ql8G7ZI4Z+Pg90Ct7dDVNgrhcJldxNvQmnlBz5Hbc
         BxhQ2QWv6acv5fiBQUV0n6kEwpUa+g+RqpVpprFc0bFAEX65w7XyOgo/2G8ITl35Tc5t
         TduSp74L3/p7JMjOuohQLhDm1FqtllhdTsS+l4x2bkxcoZkWd26jmjUimOJLjhQMgdj/
         vwVFWF2pJpm+h2U4TQmF+wFkWCuWQvoFlbvny9rh1yTAiLq+kXO4m8AiXsEvWjXD+ZQ6
         FKUg==
X-Forwarded-Encrypted: i=1; AJvYcCULq9jrcjxz5nCNcHyuwt7MF1qb56nQ0gxWpE5vIierBA0+Fo9R4y6TXKdSq5HtdUoS1bu8E/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrlUQ2ZKmP2YtxRppkI8Jx7uCOt7EoqE8ofvHPM2ky+asBnbrZ
	pw00dYNRci3E9CIMDmCWKOm4Ltz7f3aJtGabjL7guyNDaYDJCpeWBU3Uu1JJBw==
X-Gm-Gg: AY/fxX5lO46ihnKo/4oFnb0GSCEsVAts9jAN3YHi0tg6EERfmjjWG0jINcKOhLzhOqI
	G9V1kZxbKUSivzKPQVhIpiNZSI8eRxZA20oNb4mjc6nqFNsBiiYxgf7U2F4EGjutT8wQ6q8GL9N
	M8N55XB5jIi7Z9uCUJv9jdB1HtDL6CXfqeTYb65ZKtCC+i7Kq7VX3ejsACuLHFArhUNJf9rVr31
	DHY21mX9yuRZmVzTNBTKB/WVSPPVIjMRqVhWFbczS+yeXKJSHURkNOiku2o03v/GaV9FsXbjo0I
	ePho95SZTqa71c52DI33YNwMdfxHldy47bRvA/+XO5k+gIYGiLPDTNwBDI+/vxZ1h9HZn1bXJhT
	YcVYetV4d5B99gcbvj0P/RXZlGORIHjMUicXKXzo06llynRFvUuBwb/ctWGMbZ+ab7WTEu6IRvP
	gLJWm3D8D9z3taJTQv8YnHdfPtHuFMzdllQPvbJrjIuV7X69iX06NLEDwIkSA/xF95c4/eeDlkB
	vNO//fPpqgEbVUesgzkmUG1TtGIwrLJ2IJ4QdRqVActBwc=
X-Received: by 2002:a05:6a00:4c86:b0:81f:4063:f1ef with SMTP id d2e1a72fcca58-81fa03a1fe2mr2502376b3a.54.1768557477372;
        Fri, 16 Jan 2026 01:57:57 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108b252sm1645230b3a.7.2026.01.16.01.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:57:56 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] video: of_display_timing: fix refcount leak in of_get_display_timings()
Date: Fri, 16 Jan 2026 09:57:51 +0000
Message-Id: <20260116095751.177055-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_parse_phandle() returns a device_node with refcount incremented,
which is stored in 'entry' and then copied to 'native_mode'. When the
error paths at lines 184 or 192 jump to 'entryfail', native_mode's
refcount is not decremented, causing a refcount leak.

Fix this by changing the goto target from 'entryfail' to 'timingfail',
which properly calls of_node_put(native_mode) before cleanup.

Fixes: cc3f414cf2e4 ("video: add of helper for display timings/videomode")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 drivers/video/of_display_timing.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index bebd371c6b93e..1940c9505dd3b 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -181,7 +181,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 	if (disp->num_timings == 0) {
 		/* should never happen, as entry was already found above */
 		pr_err("%pOF: no timings specified\n", np);
-		goto entryfail;
+		goto timingfail;
 	}
 
 	disp->timings = kcalloc(disp->num_timings,
@@ -189,7 +189,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 				GFP_KERNEL);
 	if (!disp->timings) {
 		pr_err("%pOF: could not allocate timings array\n", np);
-		goto entryfail;
+		goto timingfail;
 	}
 
 	disp->num_timings = 0;
-- 
2.34.1


