Return-Path: <stable+bounces-238193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFwOICXg32kzZwAAu9opvQ
	(envelope-from <stable+bounces-238193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:59:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB28D4073E4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59E44311F18F
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45713195E4;
	Wed, 15 Apr 2026 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMBNwEmg"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71301246BD5
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279343; cv=none; b=gR0s35zi9tiUoEbIQMM0NztPlc69Ybl1Wti7oBl+8WJEf9OI64XjPlJzxX22uNmrBHsrukcocI/L27Rk6VXMjyEycvtbW/50l+SWmV1LlFlEm8LpyU0wHflhZugseAyW+e48OEgiDkuvvAlADBaWbIxU9AkPfRvRTk40hy/3TLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279343; c=relaxed/simple;
	bh=kee6pbbq1bKjVuBAwdRzjCmNWCqmGfS5nrlDM8rV3Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSeH/pZNapH7Z0PjWoHC7ea2uZTkOYESvPxMh7eyuql7fgKKWcGVALNENn60QFhfrVy6HiStZ7TNwhB7s3poPgSUvGqR+lipAl5XBfqzDa+pbR2dG0ykv+dukk8hMU89fZUJELGW8nye0o1I0h5dqgxBbAMgCDFsH3vWKuHYVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMBNwEmg; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56d93355337so4850700e0c.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776279341; x=1776884141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+PR/aM2xSbHpLOL6UFAg/lfaAMBhnbURgd6cWiN+HY=;
        b=nMBNwEmgX+B6iIhJYr0vsyE/CoMMNMHVYwtdDzq3fDO+RvXJjs2+D2tJcv2nDag7RB
         WzZTuB3PeD6+nQYND6IhnxPQr5ewSapbLdSOI4akB1CThGbLv1yZ+aygixnHec4/0occ
         9bva7s91+Pnaimy/omRLBZUH2CiBvh5KUehB41+SnYDA0yFX63gNuA4vfwrRhit1p+rO
         WQUHVD/twYspFjnAa2vBVq3SN76bjVFz14Mi6r8C0IR5IlMgjVKhnX6O1JG0DoSfAV5K
         /tJKvvRCJ5S53HV8wO5EphPB3hUoz95dh+4pZ9GD/Shd+GBV+7QKLOFkgGAg9fkH9ILC
         1Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776279341; x=1776884141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T+PR/aM2xSbHpLOL6UFAg/lfaAMBhnbURgd6cWiN+HY=;
        b=ToL6O3KTI6H2m9Whaw8wJOxnvFATHxfY0vdtl2b+dqGx0oNX8CYzmkiyh37ZUMkZk6
         5yC3ResHsyMs6FDAXbrpx2TGHgmYYGZnw+g32krrGATYRvlDq+IAE6lFdroXrCLH6jBB
         Q4WLK56p4FJwvCSsHlSIQbSYiFU4OXYNYSEBGpfXkIe76X3m4TZrBxpittnqHxArKs0I
         ogwQvoeJhSfRNs+Nurt1kRNisIlB4OnQ0mer7N7XunrLIO9XlbMOmbunXwiFJ+ahJ9pz
         CkMvmp3QwbUAZxs/zmkJqLGNbJCRoSwdOI9w4H4G+M8OzuppJ30icCL7Jba+qRxLG0zm
         p+3A==
X-Forwarded-Encrypted: i=1; AFNElJ9J+f+UCDsWsEErpHRVqAu4MPj9DpgAGiO7d+ljqlt/fNMfbdjOOzt546eGAywDQn38CyzGK8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/kEcKdq2cSegTzrj8eXipm8iyE9M+wVDNkpTJHcdrPc7x8zM
	5lxIHRQNrZm1pPmv7JqyYYCXqV4wypw6aj51tYbPXNcMttKsrqSMWlSH
X-Gm-Gg: AeBDietGN2qmw3VFk45B9sdQdsMdo84oMuaRj5Kc4d0QMhAoyVO5E1ErWumbk8lMh9s
	ckVzlp2nY2oOBuZ75R6JxVHlOy3vjuTpXtnLt8JZN12m2jIBhNN8m0Q/itStKxyLn1KBelYfe8j
	etJkOw3916qA7bkdpCf6bdj0DSKBCNxdx2+nmPKNmKp8uPWsmW/I9eRivOu6ae3tZy1pDyyMEik
	e45DeGr8ujOBZVHDgbBj0/BoAayBH9bPXGWXJlpQExJgBlCp0MD5UZ/TPaDxD/qMzVQK+QpRQBr
	f040JIxn1OMio36grNgWEBIx9D8Hzsmpy+3cvigw/KbDkOVSci10hkv4/wxXcmll4Yg/McMgtKu
	zPa0YPCKOso65RYBCjNRNV9QSpmbgdJA9k+4mLo3+22T8wcE6AlegeVAyB6n0HV4zFqsJQBUYnb
	RtkwTZpGhPGyjvMKmpgg2s0Uynm7TWM8Yz1lBUYzTgNL/8negVJW3S
X-Received: by 2002:a05:6122:1b8c:b0:56f:1f3a:a7c8 with SMTP id 71dfb90a1353d-56f3b9eac7dmr11469912e0c.0.1776279341518;
        Wed, 15 Apr 2026 11:55:41 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f89feb56esm1647484e0c.15.2026.04.15.11.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:55:41 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v4 2/5] staging: rtl8723bs: fix integer underflow in TKIP MIC verification
Date: Wed, 15 Apr 2026 19:54:58 +0100
Message-ID: <20260415185501.440492-3-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415185501.440492-1-delenetchior1@gmail.com>
References: <20260415185501.440492-1-delenetchior1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238193-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,get_maintainer.pl:url]
X-Rspamd-Queue-Id: CB28D4073E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In recvframe_chkmic(), the payload length is computed as:

    datalen = precvframe->u.hdr.len - prxattrib->hdrlen
              - prxattrib->iv_len - prxattrib->icv_len - 8;

All operands are unsigned. If the receive frame is shorter than the
sum of the header, IV, ICV and MIC sizes, this subtraction wraps
around and datalen becomes a huge unsigned value. That value is then
passed to rtw_secmicappend(), which reads past the end of the
receive buffer and can leak kernel memory or trigger a crash.

An attacker within WiFi radio range can exploit this by sending a
crafted short TKIP-encrypted frame. No authentication is required.

Validate that the frame is large enough for the TKIP MIC
computation before the subtraction.

Found by reviewing length arithmetic in the TKIP receive path.
Not tested on hardware.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
v4: add Fixes: tag and Cc: stable (Dan Carpenter); carry Luka Gejak's
    Reviewed-by.
v3: rebased on staging-next; sent as numbered series with proper
    Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and did not
    apply).

 drivers/staging/rtl8723bs/core/rtw_recv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index a739c2bada2a1..00b69571bbb83 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -390,6 +390,13 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 				mickey = &stainfo->dot11tkiprxmickey.skey[0];
 			}
 
+			/* Ensure the frame is large enough for TKIP MIC verification */
+			if (precvframe->u.hdr.len <= prxattrib->hdrlen +
+			    prxattrib->iv_len + prxattrib->icv_len + 8) {
+				res = _FAIL;
+				goto exit;
+			}
+
 			datalen = precvframe->u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len - prxattrib->icv_len - 8;/* icv_len included the mic code */
 			pframe = precvframe->u.hdr.rx_data;
 			payload = pframe + prxattrib->hdrlen + prxattrib->iv_len;
-- 
2.43.0


