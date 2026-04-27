Return-Path: <stable+bounces-241444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIehOAzO72mBGQEAu9opvQ
	(envelope-from <stable+bounces-241444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:58:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBC647A6C3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1183072AA2
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5233F23A6;
	Mon, 27 Apr 2026 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci6npKBr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133303E63A7
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323229; cv=none; b=kcxDLBzkgpwbDS+TgZxmPmpZ/9jAZ+siZVJmOy1CtWdnwGy7Hq6lPPHwsK6uDbrCMzpy3BJsoRtyL11jtqM3IQpkRwHZ4MX3O5A3MQo+P1t6+egNdR6KXQ/o4egda0niFWGMPoaENkeRKStMPzY7bc8or1BjbfkTaJy9T1gO76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323229; c=relaxed/simple;
	bh=G3HIx9NAHWhkf1giXbO8VKTuicQDLLIJ0UxtRNkpEpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BFbe05kGtL7kF3Dqv/6pXQg+XlysZVUQ8XUvtR0BCDHe40zUnnKoEH1GgNB1AdGjSzsV0g/6HqtLombspn3HP2KNccaaFtpVwAisPOObAoKVY5y+Vxg/T0cK4zXBlV0py3rkbGM4iwIdykWFfExpsYSJHk0YEZJ/4GI3KIcbQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci6npKBr; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dccb8644c4so3880120a34.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777323221; x=1777928021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ox2yrimp2+WkOP8X6gIgjYGjEFjAiWcBl3nP9YlsZJs=;
        b=ci6npKBroQjlLbkanT1TpiVLOQd5cnExWIof/+2IqaoioMiVAsBgcqJF/jGzWlyzKA
         3rVPe33cef4ncGjM+g/6fMwlrHzos/ss2iWBQbb1c18v9HdzHRkQwotiEHcBoO2005K8
         ejDkaJexbzVdqDA6iiwe3hEqCOWsc0oRJfhrYNWKBbHQBdBsRN6x7yMAt114zAkcTinG
         C5iuOmuacsPMG+ZRTH0okZ6yvuGlAOyTzrzsdAms7YUQF45/737MJTJxvzT7EMPp4cqT
         eDNkQ1kaoijMe9NOj/XDuFolg+glJDIlz57VxNbQVCb/0IeepQK5UwL9pNdth9Xuj9o6
         ByXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777323221; x=1777928021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ox2yrimp2+WkOP8X6gIgjYGjEFjAiWcBl3nP9YlsZJs=;
        b=dZz5OSQEiyeiodMJEe2SoYm0x1C6NTtl3/fB0Y+uubI415t5RIwBwHtEZr4qBgtpWT
         7up/Q5PLEI0lquuB8NfugBLeERRYg9T5ikTec4sWo2CUH6uwyp/I6XAJ7ItUZydbdoNj
         HyVTibCijLkFyoCjBV/wQeQoMY4Z4FIL11ShSh8QaKTL8HFMSRb99zoquICfWe3vmwq6
         6kr5AKVbVwMxTPNSCwkgsTT63hXvsaUonjQSuXVwTGgRzqNTz+Bx9PGwPHLaDB7diyJ1
         JjkBkgBFusgH9HuflCPbdl00ftJzMCm85Wzhlxh9/Kd1+x7J8q6dBnBrsbsU5zpw3d+W
         n13g==
X-Gm-Message-State: AOJu0YyOL9fTVWDWy9hwVP9rZzb5hHXSJLDKz9qYlo9Qcu6ckDvupeoM
	4GuSKSbOq2YfTtfA4e0wpC2Af5JOZvDiWYUIft1etH81b2KIN0TGV8Q=
X-Gm-Gg: AeBDietNvXHaLqcbjtz+z48pB15hnYZ4FhIMXGkv0AdvCY2lmMJY81nwIBVVpMmpUii
	oPCb2656LsZh11G+QOR0njz+FuUY9sMnqN5kqILlTj4r7oiQ55m7dhE7tc5eg5brvaxFfn/8clM
	vU4sUBA7iuLQnXaSBBiELQ7u4BZ0ifP/P5HypU6JhPRVZ5i1td2ZtCOfpKZ0Jeqdmml4+OXQwLm
	PIkhcGbbcQm/nSeKakB7tliC4ftwkp9fncaAdy+UZ+iz/DlCDPfNAx5jowgYZsKdkh3BGFOBvPY
	C6QuRN198czn7eyBizAgPeP9mkUgEcA0oI3xlCp/bJ+71yKuzEE2bUSy0I101dtD8O0g9dtxRUl
	EJRqOaPBBSLicTFVbBvDLsR6T25tengblID5pWKy2Gwfdyg4u3Vrkk+MUup0Rg+Tco0O64izq60
	yEDpdFy9FEMqP6AyjNrB0+w/PhSLStatSDHVF2h6Am0RlEfvnOIXsCMjyLMHVGZ4Y7kaHKUp3sX
	GXBn0LMYNZUuHJLyN1AMvvBJdkfZOrlkvY=
X-Received: by 2002:a05:6820:f011:b0:694:86a6:3bae with SMTP id 006d021491bc7-6965ca78bcamr113605eaf.19.1777323220826;
        Mon, 27 Apr 2026 13:53:40 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-433efbf1b9asm348250fac.5.2026.04.27.13.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:53:40 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: stable@vger.kernel.org,
	"John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v3] drm/amdgpu: reject IB addresses with reserved byte-swap bits
Date: Mon, 27 Apr 2026 15:53:36 -0500
Message-ID: <20260427205336.25202-1-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4BBC647A6C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-241444-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbmoore61@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Reject IB GPU addresses with bits [1:0] set early in the CS parser,
before they reach ring emission callbacks. On legacy AMD hardware
(pre-amdgpu era), these two bits encoded byte-swap mode for IB memory
fetches. That feature was dropped on all hardware that amdgpu supports,
but the ring emission paths still contain BUG_ON(addr & 0x3) assertions
that crash the kernel if userspace submits a misaligned IB address.

Add an early check in amdgpu_cs_p2_ib() to reject such submissions
with -EINVAL before the IB is allocated.

Fixes: b0635e808290 ("drm/amdgpu: implement GFX 9.0 support (v2)")
Cc: stable@vger.kernel.org
Signed-off-by: John B. Moore <jbmoore61@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index f3b5bcdbf..c44692a2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -386,6 +386,14 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
 		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
 
+	/* Reject IB addresses with reserved byte-swap bits set.
+	 * On legacy HW (pre-amdgpu), bits [1:0] encoded byte-swap mode
+	 * for IB fetches. That feature is deprecated on all HW that
+	 * amdgpu supports, so these bits must be zero.
+	 */
+	if (chunk_ib->va_start & 0x3)
+		return -EINVAL;
+
 	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
 			   chunk_ib->ib_bytes : 0,
 			   AMDGPU_IB_POOL_DELAYED, ib);
-- 
2.43.0


