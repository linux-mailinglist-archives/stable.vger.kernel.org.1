Return-Path: <stable+bounces-210015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A56D2F233
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4113F3047127
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 09:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C173587AB;
	Fri, 16 Jan 2026 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6pNdZRf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EFF35E553
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557434; cv=none; b=rJneY+I84vIn+JbYgxIAqgw/tl1tLbLpdVMKmqO7Fk7cT0AOykSep6P7kP02kOILpexyZlJA3y+sDaYXmY8FzEPa4myDcq5rpE6U8ZW5UCM+BE5j+4IUuRLol6tkJUjVJG/Fw2vxD4rHx235LrZ1ZP5nqBi+e8bXkai22A83Nmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557434; c=relaxed/simple;
	bh=zPajOeekjwnH1L2PhS0ee7WaYai94vHkoloTqOoAN40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lZiuepNc28EfkOkXeNPdrd/sDtJRoRaXvIS9WRvTaaEDbDyosspf5U7hhtrbTENT3prLcV8s2w/ufZMrB5bog5GGeUAu7KU6t3PvMH81mvQe+OytLEpv+mE4AvvLWsU1LwgG5Iqn9TZvvo46hqnBRuiUDENtbFvoN0LOF61h4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6pNdZRf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0d67f1877so12500095ad.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 01:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557430; x=1769162230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z9cPCZbEtZqLhkXtHvfyAqgg+9cdVAULaffu1JjYDN8=;
        b=j6pNdZRfV+Zod1I7idHwiaJ8GuiPrGRzhr2BOG4DuzE34HEUXD3VE+JHxsdTljtqv2
         CAmDKFgNvoBPSf0SzD5Kq2C/Nf0yBpUgJeq7FPmMH6T7GmREMwQ+sMv8Q3Tq9ZvRhKW2
         layk8tRS/maX1kh5g4+KfcRNxZoymsygq11SWf6TGPllVhinH7p3dAyd3Haei2b8Mecc
         EN6qMtG8RUDwlvUBV9cwGot4YYvp4PREzrVuRJip9CNGkjRz3hNSqWwLTuB8nZN9NJmp
         5T0WNMC7qIBI3N/hmmznfELhTwVvQFeYLCL67hjCLHtbrbGK0i4GKTrjaKOev0fBw+iW
         YUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557430; x=1769162230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9cPCZbEtZqLhkXtHvfyAqgg+9cdVAULaffu1JjYDN8=;
        b=rxzPgN+23nTndDYpUhRaPXfLCplg+JOZqvcIQlhI890YzQV2WBOUek26ZIChiIltHR
         kQDuP1Thj5SDwRTQAXjbX0xbb7kZsnRaFbtUgOFVNvJmX+x3HXnnzFkf31sgwus0E/lW
         mz3ABZigp7qXg/Gr9ZC2I+Mj2ym7+MyrNZN3NizzyiabR1fraNuCk+7QMI9PLRqZl/V0
         JYz8qyHwfJdDXMjgg12EWMHnzeeiw3/aEa03YvlfnAgGeHixIEqfbsHt9QHRlghqiTOs
         3o94P9Brp2MgVsm0rziHo5Xjoa6slfLi//OY/HGAMpOngvgTQm6rS4Y1EO50eXV6Wzeu
         s5gg==
X-Gm-Message-State: AOJu0YwGJQeDySCoobXsDQfKL4jeMKgL0pxvpcsKUaz4YNg8Am1DbHi6
	25QZuPUUvXhdVIa32cmTo9LgAOF3gNiOiUu7hnGhtLNz+4lATyYl/5IHU+EPyQ==
X-Gm-Gg: AY/fxX7atW+4EyQrRGhy06Do3EcoZcVmTqKHClcI+r9ZQ1SrEDtSX4JYrLTnOdJ0R/W
	jImuLN/W1KdtsUuV3PH0PYHMsjc3OpiW8ff+lEdfk8L2mt8RpeYRYyXoQz69mhf9XOzyx0Iczxm
	Tf0vNkrNrHO8wrbpWj7ehKx5XjSXP22QbG0MNu9UPm2IsvOpkhV0wenqyfSBlUhDWwZVxKWMBWP
	Gp74nI/24hKQKssvkJWxNFBMLDe9AZZ0eYoa4bc91k4PJXAfBwP3wmwnTIRq82jmJeb6C1nCNVu
	RptI+NG1sR581t+FT1MLZRfKGnXOeH1c50L4UHGAKWWwNgB0mGY0+h3xnAohcAu1EM8fqxCRzt7
	eHy6nIDC8mQtbHavvAmEANCkSy8AcK6hCgpLds4oLWGgwMTFS28Wvb8SHrnaF730pPOSgV1ocP3
	bAArkmLb89oNsGLFqImSMp+4lF1gftIbrqU3HD5M81i8uBS2XbY5+FXpVq59wPL/3wGDJE0FeYS
	enDy5ltBSFqf843jD5IVL1HQ3USks9MoIpjy2gd4rXenH8=
X-Received: by 2002:a17:902:e952:b0:2a0:bb3b:4199 with SMTP id d9443c01a7336-2a71888b462mr27051195ad.2.1768557430385;
        Fri, 16 Jan 2026 01:57:10 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dcd00sm17110785ad.65.2026.01.16.01.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:57:10 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: geoffreyhe2@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] video: of_display_timing: fix refcount leak in of_get_display_timings()
Date: Fri, 16 Jan 2026 09:57:05 +0000
Message-Id: <20260116095705.176490-1-geoffreyhe2@gmail.com>
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


