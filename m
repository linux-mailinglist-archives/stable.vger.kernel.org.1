Return-Path: <stable+bounces-235916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oES8NpCQ3GkmTAkAu9opvQ
	(envelope-from <stable+bounces-235916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D2C3E7DE3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6887630074D9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B5A382281;
	Mon, 13 Apr 2026 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="UUCywKE8"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4A3921E0
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062594; cv=none; b=GY483cf1v1UtdiVfe3/47OXHwtV2X6A0DcERbfLY8AZD/fV2U2Ee8LOIU6mpZjGgoXAYs0kNMfzFEoHkJOF6ZaHDPlJZLckW3K14qFE0kmZN3ouvA87FyQBDi8CHxfPbO+ZDVuZt7q1p9f6NJwNn6aAf4fdXtwSoCqcWpT7qzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062594; c=relaxed/simple;
	bh=W/lF5VQZT9tL6v4pJ8VDntAf7mSQxHrTBsauhfxuofY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5gncI4RoYsQ38oduwNYsO7XqTzUA3Dx03rp+9RWWHS1Yvehrwrv87XvmjlmKWHGuQV+hCCNBKbRPETsh1/cJjJEAjpGMcRmaWby1YcNAeRUQPPBaUS988acri8ciSbFDoOg/PRhR4SAE++VtH40RAUpSCDUUfHojGGvdohVB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=UUCywKE8; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8A07E3F213
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062586;
	bh=zAYHKGhirSK5eRXuasDUrzZs2+1Sygbizja9VR+yfN0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=UUCywKE8PFYFseDW0qsJR7GYaMXS/LYKnQIiFaSXwqHvpmS7nxohffeIJ4X5OYtwy
	 4TnNd4nMk1iw8mHsjyJeAyIyUzn1CR9f7xDmmsuk2pynpFFZ592OMr4F1T40lcpcv5
	 V9HFUH6Vo5hfqQPspbzLlzVHjZ3EvPIpsqwGfmtfNs8udpZP9TN7cGCcYd11YbOFpz
	 3UcFMHmseJkUv9Jj39L21SBI20sysRd7wTez3J2cBdg0RS7MoN9CpW4/VIwqPe2Qyw
	 ND0N75ghaT2LBjrMZO57dxzIGlnzs+/vXzjU5sIq/xCywFKkwA4Khu3CHVXRR6g/Ei
	 NLmP5XVipstXBRo63bEukxmv5DnyuXnUufjE6j6trBUL+suEkXPOiORSst2iJPTC77
	 9bxm8zZPXYBczEKm04zHk+j+Js6MIx0qezXjgL/Nq18jcves7JQIahkXRVEYKybzVZ
	 T2+YcOw4AgiCNRWl5y8DcB9k1R4NbY/fg6IOcOLT0TUAMLFSsKJPuWFp3XazZait0K
	 isozEcFlm7L2XBzsCB2ksML0bWgeDinvZYln9V2E4BfTREfiHa1jYe8v39ij/4zV0I
	 O40ew6XQcvF7HECj3WD/JCoOt+jvgygyaroNa4wKji+/z3SlecwUpZkg+pdaM2whL0
	 Xe0ffvTTTZ6j37B85hU1T6fw=
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24e9b4d82so32267125ad.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062585; x=1776667385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zAYHKGhirSK5eRXuasDUrzZs2+1Sygbizja9VR+yfN0=;
        b=Zcxv0tStklI0J9XZdDJU/n35kx7zB/oyw6yUXr7i5KjZFqSHi4szinb4/jH6q1sQh0
         EXjd1BrNldF58Uyac4EVSkQJeShUpo7RnUEf3S6AzTyh7aG+PIaFK9MyAw4OE6mpOpCL
         yuP80nVWeV5gYva+PmhAAXBe+9NbmJwq8I85W7B0P9qD8nXeOtwJizv1mQI2uMn7Ytf9
         dZrMs1XFLe/x84Rg3j/YhgG6/9iCsETvMWE64fJREFMK15dxp1MlvKHe4R611baaoTLK
         ah79dZWfMbOMyf0wcIn2Q1sOjuoGyNeg0He7j2i0ZxoKSmoBAX3Wzg+Fd/2c0OZ4DfDE
         YXag==
X-Gm-Message-State: AOJu0YwpluHsWGCig7qdQzvYmnpORJy2dwiJ/QBoNWI1P1i+RKEYhWvg
	FeraiRa+K37fTpD/H1gH1T07t+EEcyErvM5dmkS7zViSgNizm6eOGIKzRMJz5phvpZc93OJoeLU
	uS/jSgvH5EoykgGdCHxRtncGspLpIlrNI5K++i2HC5dm8aJBTtHP6l2brWo0LgcWU3IpUGMMDMw
	xH+sM6Zw==
X-Gm-Gg: AeBDietqE1WUXu3r8cQPSWktRjgF7M0zgOcPGBjNBg6Gi+QleP0QvHLS/vjgAWyKbur
	+zqazwhzEZ+uXL4jxvz5av5beu/JgqoJRo8U1IoLcLJgzKMKeddmLgPodJLSWhVUXqtxnWwG0jG
	EEKkpU6uGrtBVWfRLpXvvlgG0l7b7SppkqXcI3wj6TsS48fczqQfws4kfy9Wtb6iZkDL77ULeH/
	zUOhYtPfgXJBEPcF1e3bbBkE3d+QVLnz2V+s0XcsGRGrmwSiLBy3AevoR5LyjCU3O+mKzZjpuJz
	1AqysGLBBISyHk4gsD6f3XH06mC3ryY7mC9jYDEHBkpn7ppf92Zvzod1bCH9iUN7q1SAxQ5OesD
	Zp+BZtt7wj6us3AGaqobm9hKbDCg=
X-Received: by 2002:a17:902:ffd0:b0:2b0:4f16:22f7 with SMTP id d9443c01a7336-2b2c73474b0mr139652705ad.16.1776062585240;
        Sun, 12 Apr 2026 23:43:05 -0700 (PDT)
X-Received: by 2002:a17:902:ffd0:b0:2b0:4f16:22f7 with SMTP id d9443c01a7336-2b2c73474b0mr139652535ad.16.1776062584899;
        Sun, 12 Apr 2026 23:43:04 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d9443c01a7336-2b2d4f3b299sm125198865ad.73.2026.04.12.23.43.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:43:04 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 04/11] apparmor: fix: limit the number of levels of policy namespaces
Date: Sun, 12 Apr 2026 23:39:13 -0700
Message-ID: <20260413064256.1578919-5-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064256.1578919-1-john.johansen@canonical.com>
References: <20260413064256.1578919-1-john.johansen@canonical.com>
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
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235916-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[john.johansen@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20D2C3E7DE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 306039414932c80f8420695a24d4fe10c84ccfb2 upstream.

Currently the number of policy namespaces is not bounded relying on
the user namespace limit. However policy namespaces aren't strictly
tied to user namespaces and it is possible to create them and nest
them arbitrarily deep which can be used to exhaust system resource.

Hard cap policy namespaces to the same depth as user namespaces.

Fixes: c88d4c7b049e8 ("AppArmor: core policy routines")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Reviewed-by: Ryan Lee <ryan.lee@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/include/policy_ns.h | 2 ++
 security/apparmor/policy_ns.c         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/security/apparmor/include/policy_ns.h b/security/apparmor/include/policy_ns.h
index 33d665516fc1..dabb69bc87e0 100644
--- a/security/apparmor/include/policy_ns.h
+++ b/security/apparmor/include/policy_ns.h
@@ -18,6 +18,8 @@
 #include "label.h"
 #include "policy.h"
 
+/* Match max depth of user namespaces */
+#define MAX_NS_DEPTH 32
 
 /* struct aa_ns_acct - accounting of profiles in namespace
  * @max_size: maximum space allowed for all profiles in namespace
diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index 78700d94b453..b7d9d5376aac 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -262,6 +262,8 @@ static struct aa_ns *__aa_create_ns(struct aa_ns *parent, const char *name,
 	AA_BUG(!name);
 	AA_BUG(!mutex_is_locked(&parent->lock));
 
+	if (parent->level > MAX_NS_DEPTH)
+		return ERR_PTR(-ENOSPC);
 	ns = alloc_ns(parent->base.hname, name);
 	if (!ns)
 		return ERR_PTR(-ENOMEM);
-- 
2.51.0


