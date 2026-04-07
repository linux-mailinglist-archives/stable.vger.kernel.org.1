Return-Path: <stable+bounces-233700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEOqNm491WlY3AcAu9opvQ
	(envelope-from <stable+bounces-233700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:22:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F6B3B24D2
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E2163033228
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32C133B6C6;
	Tue,  7 Apr 2026 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myoeg0Re"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CBE33262F
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582572; cv=none; b=vDHOeLOZpSETfujrd5y1ZLN25K3gjWp47c/WM/BgmyevDoCn4AgVQmmi9jbHAUW8hSYZkZVZ8lKEiIZSuJH4Oos8KFPkubo3VWkPSNjPJf13qDsvAYPJIjNqsV3dHdTd+zQRJbw3usuF9xG0POzxkVt9Omv4wGR4Zk5M0ZNB0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582572; c=relaxed/simple;
	bh=KDi1v7Zhzb9QhyQMTyCHXbSMRyCApqaprJEc69q0tV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqQD3a5aEJ8nO5vDaPX6ndiroWRokZ/b8/BAUoFbv3IKyxVI+ogAqsZnLEHw2eZWwgnTieTY1JiDAwWJu/m0ojrx/V9AVq+eTe7cghA0E4ornaMqBb/NK32d7Y4HSsJ2X1t2dyP8yz06sB3F94n+z3GNzAoHN2A4Uo3DCgeJmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myoeg0Re; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56d857af2a3so1957450e0c.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775582570; x=1776187370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pAd2OPO7eQX4lVfc/O2yYYdNpinA6DdggEH+CtV5kkM=;
        b=myoeg0ReWyyjhfb5sVXnHimvpbELSS5ZH7N1eC9Fe0ej1I78xK5/SPVjH7fpknfLKc
         x/gJ68CxXNJpN94N1qAr2NmpK0sE9k7+9u1EE0y3L5yWTyq/ucVOVXvOe+H4U6pSGK0h
         Ig+SNg9XN5qEJpKzUS/2QCpiTjTzBUVU2bHPk/BVMadIBXYsIHIgp5EL24jQi5Jf+a0r
         k3hwyxoS5Xb24lRhmYE43Td6B4lpjMR5KfMucbL77yGIfN+jhjmxkXt+8taPeCDFLy4v
         OI5dwZ30dBT3vFizXN7MyFWzKbhCyqj3zpiBtxLc2ztgveZEUEfhNIrkzqEXHcR1e+34
         3PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775582570; x=1776187370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAd2OPO7eQX4lVfc/O2yYYdNpinA6DdggEH+CtV5kkM=;
        b=Ygd66MWkwXzWaQv+0kgeOc4CuQYz5GgDB7DBsKW9VDPP5rmJ+vHja6ued/PYyJJYin
         KZ2bcUSeVch5RUnWZzHrji2aRTe5RSPRqGxdJhitM+1zu3q/b7f/L/AfsGFJnuUNb0n1
         IEmUAPVadVwabAf1pTqLJnp1ZYgT8Lyb5HpcKCtaikgTttXvL+P4MYdXeIkJ1Akzy4vQ
         6w91GXmP40DFrhgGhA7Tm3X7Udf2aE+FHOMa8zce0kji8OtJvr/J+AnyNjat6GyrG/OS
         gf++Rl6gQFWyVJTY2N6E8aBzjpyi5ezH5Xhd7rCRDQP3yA8kCKcJ0PTMxr4SBx/CnGiq
         mi9A==
X-Forwarded-Encrypted: i=1; AJvYcCXMCOX6wyocEom5ddMy3dckEhX3OsX9xPDepDTSBWFjAGDFdT2ZjjokfTy4p7jwtZfnfQxdy44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBppFNnoHeH0OR5LtmRGpexZ+41RFbK47gO+fe80QpQICLRpc
	EIzDkjIikXa5eBPVG8wx7DNs145gv0tmnxXKnPz7FPvgsfqFUgDEhfdr
X-Gm-Gg: AeBDiesfKUlEp105bg1ayPRdcy6jTPU66cNsH8J0D8YsLimOishoA2aN0loPLTGnAQt
	DOu4a7VPeQ7mwbF7WomlV3/tCeyech+81gL8yu39AqXT1BHU3Rp6zMjiVCwhgHz1eq/8bfkrKJ7
	OopvcxP3zr67DK/FDAdXuUafczZVos/zzowQFhgE12GsIemM6pRGubRpjfHME4gwz9SVaXWXCJ5
	+qfni8j31XpnW3Ov/chdlHm3zCQW+9r/XKtEv2PNsc8VajQIit5fjW4+YG8631t70n06N2wITKn
	33XUEWZ8RNhzzDiiGJ57abQlauO+U1BEoxxZ5n5Y4Q0FquI3fGTdYA47HHuSrrzHLBcqs/T8LH4
	b3a5qbujkHqieqH554KDt9FrZFKJXZU+stRR8xAlGpWm08wVycP7M16hoqs/eqUH5TIiBqcQAtM
	nryzVFDUs9EUQNKF3RJUkEjiMV
X-Received: by 2002:a05:6122:7c8:b0:56a:9841:9f81 with SMTP id 71dfb90a1353d-56dab8e9fd0mr6192497e0c.6.1775582569504;
        Tue, 07 Apr 2026 10:22:49 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d74:aa::11:155])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bae1117sm18878435e0c.7.2026.04.07.10.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:22:48 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v4 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Date: Tue,  7 Apr 2026 11:22:15 -0600
Message-ID: <20260407172230.40775-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233700-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59F6B3B24D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dfh_get_param_size() can return a parameter size larger than the feature
region because the loop bounds check is evaluated before incrementing
size. If the EOP (End of Parameters) bit is set in the same iteration,
the inflated size is returned without re-validation against max.

This can cause create_feature_instance() to call memcpy_fromio() with a
size exceeding the ioremap'd region when a malicious FPGA device provides
crafted DFHv1 parameter headers.

Add a bounds check after the size increment to ensure the accumulated
size never exceeds the feature boundary.

Fixes: a80a4b2b2e4f ("fpga: dfl: add support for DFHv1")
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v4:
  - Resubmit as full series per maintainer request.
Changes in v2:
  - Use (size > max) instead of (size + DFHv1_PARAM_HDR > max).
    The previous check unnecessarily guarded against the next parameter
    header, which is not relevant at this point in the loop.
    Suggested by Xu Yilun.
---
 drivers/fpga/dfl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 4087a36..81d7a68 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1132,7 +1132,8 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
 			return -EINVAL;
 
 		size += next * sizeof(u64);
-
+		if (size > max)
+			return -EINVAL;
 		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
 			return size;
 	}
-- 
2.43.0


