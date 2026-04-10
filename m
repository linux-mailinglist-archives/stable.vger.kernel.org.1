Return-Path: <stable+bounces-235564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMnQDh6A2GlSeAgAu9opvQ
	(envelope-from <stable+bounces-235564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:44:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9673F3D2239
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8790302A6A2
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 04:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31CF331A5B;
	Fri, 10 Apr 2026 04:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsPnTz0F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1333260F
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796202; cv=none; b=ZgBaPp1FOEye7i0vInOUOCZkTKTY26Kb6Ne81PTziqKD8+hfIK3CNa6pH9w5p5HGb9OHe7vySEoiQYotg67x2fe9kwsf5ORdaO/Nep7SHHu0sYhf/kKUcMZYBvfboAOSIEM6QTdfjpCfSdP6v7lPaE6b3aXYzqeTj5C0zYx8clY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796202; c=relaxed/simple;
	bh=kJqUbQL6/TR+xDiCCdSMw1cpOUwZW7TEhS4gAM+clUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYl8Zbb6CN0emSSZJQGaid73qV5XHrVfT8x+WMIuuCr6QR726igqleURYkiZUEWOE+6T8dEmuBWfA3X/vr34VXV5uwZAxK+031+Gb9XtZkr6mhGSrdzidlMnO1EfSIEYCrvkTxbqTUZMSgi8PKWLJqZos4xlU8qJijPJJkrRxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsPnTz0F; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-824c9da9928so1479959b3a.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 21:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775796200; x=1776401000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shK6Y8ANhI6+xigEaYbBRBX53EjdBBu/dLtteAqBvF4=;
        b=nsPnTz0FROnFBomTJ+lr6xB4l50037t1+34bqAWPIyHmxBHa7N0XPciE5G+1Y7iXWv
         dM+4OyW8yOGAiDchSnd5ZC2FZQSAdBRpNiafVveydO9Hf8/zJDA/yL7/jRfBPfM4tyHK
         R/nkfbi9xju/PJaJdHDLEeNx7khQZC0ciiohOr1dMgmgTAN2y0OFW/Dc9bMSfCSu7m6X
         aKhjW+Tc3idN17kbN1S/HMdEvWMlNoa0bw+uma1VDeMR+iQkr6AeiTn4BeOsFhMuQVK2
         vvwvJ36tXvUKrEC7IUMmJ96lopxgr8QG5TC5SVZxr8jX+y3rNJaTjV4YN8hlFYqhxJ8n
         3IWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775796200; x=1776401000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=shK6Y8ANhI6+xigEaYbBRBX53EjdBBu/dLtteAqBvF4=;
        b=kP5L77g1qmYRM4q2yXOYeqAl/BbNRaEYo060iOmREXhqdO0i+MSVkhTubQREiPd+jU
         +LN2lwQAJobz1XwcmFjV3NsMA/U9vwo9xPebhCkYgCKl0UBHh1h22ogoE8BBhx+8Ajhn
         AeiQWCV1CcdPmOjdYSaSn1ruZpm/y7sWceBQtBslctPFeozTH37mHWeVjrDSWyQ7W1IK
         mCqBh7e5WY6puf/jGfAPC6oRVUxTmP0T5NHMHdtsmw9/wW4V8W0fgUdKe4eIPToD5uI5
         Qm9esqY3gEGmtp6dDaUPEb20DB0bkX8i1qJmDXkkZEJPek0brlWf6nhDDY6tiNhGUhn0
         5j3A==
X-Forwarded-Encrypted: i=1; AJvYcCXogmLmOcCSbEYloGZMJUbbIADPaA21+ROVSc9byeY7MH8Gvp5N4vRXQQUw681CBHyTWxYq5oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkjzXS905jsrFZ2+ohRx3ssYcLbaTMQuvW+V8zzGwvR6LdqNcO
	DWPpKG9jbZq9ADY70rpCh20uU6ezvCOqyFSiwdTZJ6TwI0A8AVePKN+YBy+tkQ==
X-Gm-Gg: AeBDiesMS5SgHHzOoxE1nkqwA6BrYYB/4M9IwsgFzyXWpJB+fHgmdigGZc6/o15lB5f
	rejIy4HNJybMw7vMxLSVrscwNd70/XRLg5MmczlHiSXDLuNLiQ0alVKpLWEQZSt2zSn+pYw8r0g
	jUsB4HRN2fz9roiXy5Xg0QKmTpbO9BDmeowG0J2X/0InsygRqwNIY08Kj/bHjajgvTYHIeyUcgp
	ScAt0rCjqwiysZNXrzpYNnaMEVpkgwWknQK3ambLFzpcLex9uX8Mzcr6tDeMNH3frHxBU2Ae5lh
	6gDnrencl7/xSq1f1UzAwNcBX3au3o+1zH4GmOolfs9OdrgTLGNnq0gd822pM+haHxTlJKj5XRv
	OXqWeWoPN8Wzbi/r5d+pHV2odsG0ilfwjAl9rZJDoS4XoHDJ71t/pS5iSwcHXYjfp+KKs4+EPEa
	ujzRgcUq2MgWhLchzFzeIjhLlcf6E=
X-Received: by 2002:a05:6a00:170c:b0:82c:ddbb:7db3 with SMTP id d2e1a72fcca58-82f0c21d396mr1954892b3a.25.1775796200399;
        Thu, 09 Apr 2026 21:43:20 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30e7besm1200109b3a.5.2026.04.09.21.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 21:43:20 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 12:42:59 +0800
Message-ID: <20260410044259.95877-3-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410044259.95877-1-aethernet65535@gmail.com>
References: <20260410044259.95877-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[huawei.com,lists.linux.dev,kvack.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235564-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aethernet65535@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9673F3D2239
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Problem
=======
When a user sets an invalid 'addr_unit' (e.g., 3) via
DAMON_RECLAIM, 'min_region_sz' becomes a non-power-of-2
value. This value eventually reaches damon_commit_ctx(), which does:

    dst->maybe_corrupted = true;
    if (!is_power_of_2(src->min_region_sz))
        return -EINVAL;

Although -EINVAL is returned, 'maybe_corrupted' is already set. The
running kdamond observers this flag and terminates unexpectedly.

"Unexpected termination" here means the kdamond exits without any user
request (e.g., not by writing 'N' to 'enabled').

User Impact
===========
Once kdamond terminates this way, it cannot be restarted via sysfs
because:

1. DAMON_RECLAIM is built into the kernel, so it cannot be unloaded and
   reloaded at runtime.
2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
   Writing 'Y' does nothing, as 'enabled' is already Y.

Reproduction
============
1. Enable DAMON_RECLAIM
2. Set addr_unit=3
3. Commit inputs via 'commit_inputs'
4. Observe kdamond termination

Solution
========
Add an early validation in damon_reclaim_apply_parameters() to check
'min_region_sz' before any state change occurs. If it is non-power-of-2,
return -EINVAL immediately, preventing 'maybe_corrupted' from being set.

Fixes: 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/reclaim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..2747eef5919d 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -204,6 +204,11 @@ static int damon_reclaim_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.53.0


