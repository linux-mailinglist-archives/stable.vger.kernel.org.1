Return-Path: <stable+bounces-243008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBmWM3iN+GkVwgIAu9opvQ
	(envelope-from <stable+bounces-243008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:13:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 707044BCC65
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0037730166CB
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6403B3CAE76;
	Mon,  4 May 2026 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFpyr0os"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027113B9600
	for <stable@vger.kernel.org>; Mon,  4 May 2026 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896820; cv=none; b=u9HTDAHG5o2IC7C1Fnoyx6lqoWBswOWOCz+rVTeYNyI30yCKc3/LgdtVDcINGtBySf3oZAZX3tPQy4RGcOT/2o6qfGKts/jZ3WCr5IzlbP/1UTFhx4mkLqM6Xy+6RxEX+P7p1vn67RGh445ltEI9bNLhCXIpa42TvRt+LFi1yRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896820; c=relaxed/simple;
	bh=eoFqV0cUKljCUasyMEcO8e3E2F1rKIvseDS8v5lylIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+7qIwTIirwxiln0j99a2yAh7b+YbPuEwL8Z9tq0gNajYg2VsNhw8bFcyhObHqcA/ofYBxBp5yk4Zi1H01GeS7LkjRYG8OBRM1shGDPgJh3YdldlYKy+qV5F8Q/YdlFamUMHpC3Bnx9z9aJshRhiZcSY4L6mu7j9UinIFre2wP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rFpyr0os; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a46ebe2beso35901557b3.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 05:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777896818; x=1778501618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/UJ2uvEr/DOGlLSCCMJfX3fenw9+ggqj8yJwATSV2Q=;
        b=rFpyr0osEA4XkXyFliRSz4mjI0NJiR6LMgbAs4GFvIesofPHtEVOK6obhjy/D1TVjw
         ep42/fYSGKT/ls06siKHNFx+5EHF94SO8gCNtgJSz/+MOb4wZd0J6dMMK3E4cNgL6DeM
         4wYtebWFAKk7BcbSLCD6+ebfIsWm+vyRe8wZQdHdNWVnmLyTI1Gej76q6RW5c++nVLEM
         plo2xMXS8ZQ01fpj0ihCRNXzplcTwgIs0HgeR7Q/8BxfC7qUrdG4Xaj5rxFxROhl3vlL
         /BxlMqIhjl7IyvMLP1oPRAQsf86xuR4Eantgnu3Oeo1OcjbPmP6gPoL0zoClFspqjIda
         8VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896818; x=1778501618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/UJ2uvEr/DOGlLSCCMJfX3fenw9+ggqj8yJwATSV2Q=;
        b=oWImAtSqUmB1AbZfwF4JzR2r+b+GKqRxRFCyIuIFdAGLiiY036lfTo0ZTBYvNI9VDS
         1R8cf9a7pOX9zp1a2LHRLW43VolBJAYukwYBJwiaMFyR34Kr5uVqnNHx3Vz3wjLf8ERU
         dFKOvJrAAWtgG/H01yTUpe2/BYEFPv1PI4sJ+6b79Ec9vwyYqb3q69uNq2EEAPWZlpnA
         GX4rizIHWICZnqI3uEid+/VWAQBXabJxXroUHg4Ge6oidL69xny7Q3GlyYcyAM+w2esH
         SjRp+j6jvB6q1si91BtteHA4K9eKnmht0Cwl5XywuKP9ama6DsVW1+HOIjukPYjEDRcF
         GoiA==
X-Forwarded-Encrypted: i=1; AFNElJ/ksvQW+rSwgpOUH7CHKbazSKJRqv8mET0VnK4xkp7TDQlWd1PJIVgEWMWHnwyhrM4Crrvgvno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/wBhwxDADr3S/SwEQ+96o1D8JWcmEWKD2YCoaltnbwc8mFy4
	SA5pEAsD/SL/xowkkGI61yTDZ8uSlFmzlL586d2dTNfKdiVXicUWO4/hU9dwpnb9
X-Gm-Gg: AeBDieu3g0bSwNktY1TgYXpqExrmyLuGm1Gkktmp0v/esmji+OZIP5wMCo8KauHVrNi
	Yor+T4yidRUZJ3af4CGHPHBjc1Lil8S4ryiuR6YKQNfOvgStPqyNIbadep+8KVlhZTQPvbbQW7R
	/MK/lNBSmeBZ/wHpbusOKZ4BsllKzFXFgF1KF3KYGG1je6LBXUinCWenLuTc1I+Boq4e+DYwumv
	R7suPFQ4eQAM9mt6DtSJkyi6i55plqmS3THkVxlqS2BnaHCKpfhAY813rV4Dn42+vD3l7APpNL7
	eGpjfj+cFftbQ3/5ipJIwCldIkA9D/4Clxy56hVx9t4pcHomt3XXVkkFzPK2m2oiYD1wCTAdJJ7
	bx1KrmSAwRn9lc64Oiy6/nbTi5oBz2Y6JrqYVqlnbo+TR4PTRypc68D6jneta5JVFApqi86Icxo
	NBjx7J2c7IhEgfBkTseRMulpUmuI3oTTK5tOuio5tmrR5EndlcmSQdkUD3tTugyx9KOg==
X-Received: by 2002:a05:690c:a00c:b0:7ba:ef98:9720 with SMTP id 00721157ae682-7bd76f80e2amr80290547b3.4.1777896818053;
        Mon, 04 May 2026 05:13:38 -0700 (PDT)
Received: from ubuntu-linux-2404.ts.net ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665464ccsm48417937b3.11.2026.05.04.05.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:13:37 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v5 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Date: Mon,  4 May 2026 06:13:30 -0600
Message-ID: <20260504121332.1053563-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 707044BCC65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-243008-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
Changes in v5:
  - Add blank line after the new bounds check.
    Suggested by Xu Yilun.
Changes in v4:
  - Resubmit as full series per maintainer request.
Changes in v2:
  - Use (size > max) instead of (size + DFHv1_PARAM_HDR > max).
    Suggested by Xu Yilun.
---
 drivers/fpga/dfl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 81d7a68..4c63c7c 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1134,6 +1134,7 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
 		size += next * sizeof(u64);
 		if (size > max)
 			return -EINVAL;
+
 		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
 			return size;
 	}
-- 
2.43.0


