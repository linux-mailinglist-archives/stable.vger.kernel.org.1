Return-Path: <stable+bounces-233307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLGyL22d0WlgLwcAu9opvQ
	(envelope-from <stable+bounces-233307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 01:23:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5E239CDC1
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 01:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0BF93008D26
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 23:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B54519D092;
	Sat,  4 Apr 2026 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjEAwxU/"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C762E091E
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775344996; cv=none; b=TF0aEg2IUDm0d5r6Dj1lCxUnyDsTE/H5rtGfxIKk/3HUSCNaoRXMgI4FVULqUbQaBOMxku389aUh+/mfssglk8qKAVJ1Jeph1ZvU3R3BBXvyNfz9qlh8aR/QDojZtyVSZxrEg45rDCcJnbZ4JzDlMXTe+DbahS+iAtjc0TbYa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775344996; c=relaxed/simple;
	bh=aHr247WZgADKTKUzBygaaf2YQeBar4PSJ17AIEQoyVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeLr2lzFnEjvTCR/NtXIX4JJruoOyAsje56MEmiYkRAQL3tGLZHzoZVE2Q933B3uh40wp8er36cijWvGxRjJ93LCAxWiv9XfqEwMdJotqPcFIfdOk3/o1ZxpzpCXy7f7Owq1aPdZqLPSHcUplcj4zIsATeCcDqYUwHqfbsNOzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjEAwxU/; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56a9076813bso1184879e0c.3
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775344993; x=1775949793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhxQ4oVxg7wwJH0gj6MCRdyLZTtveOYtZsme5m0GCsY=;
        b=qjEAwxU/+pMtqqG6yD8PaeToaNdEHO8Ss00cf8WGGVSDRu5H0sx3GCbNCALfduZ8WW
         RKreUQSFJNLA9Fyi2aWm4QUhpuqNFvI/AcmwiGhQjPMAH7mguN8CxheXEriit6jNsb4j
         rkqlk1h4xCXs6wCeWXZbRPjbpVy4CS+J/mCvB/RO//tk2bKhQHCBLhVb2bLS4mXrW/Yb
         1JJgbcxjGmP0et82y82Xu1jm3WCW7miViJRhBXKLqSXsR+XPvEKSYUZyuc5ivj0YMCCv
         XSvqHgIuW1Tl+1koD3bRw13AKdCvQCBB1dSMsrkGtsTWORMB2LG89gH6YSan37WAmYvc
         hehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775344993; x=1775949793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhxQ4oVxg7wwJH0gj6MCRdyLZTtveOYtZsme5m0GCsY=;
        b=BsyJENucjypMDPP8rKZ2UE/DZFtnAvkcWid7tKaXeYbO4M52Drk+5VxOibFiAql3mK
         JpmdqrXLnDvtGM0Gh7WOeJNAb0aWwyFfak5N0Wsv5Pk/PBRahvyMf0wZRA5f7nCe76wn
         jDccC3zuQIRsS+aOsw6ylKAFJiN2Omck5pDuN0JX7U3J6fJVnPZnEdGWlKNwg2YjIEAq
         9xjasoOJkyNtGVZ9IGPON6Ub0thPXGNk90pQp5WRuZ7N3Gm0pEoCR24cTY0Q/gtwRnei
         V9UvMj+QfIhq41m9gt5EpRG8c87mT2oarcxNpW0nuFEtgFVH0saB5f/wABDgwWgASs9+
         Dbwg==
X-Forwarded-Encrypted: i=1; AJvYcCWYt2vAMkch+GkZVHfPacBzTkIjX7o52Nk0YtgqLTSx7XqLf42EJUzPWE2GhKgYExRIvttDduU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwevZ7yqg0OZtHKhy2pvDOVWZsR1j9Ml4flPcA23Ui3m0xPlRqP
	6NdU03A0vAWJzdxeFlKREYmcpWK5VfZzKCVB7hOk6MADsLYB51g/YYT7
X-Gm-Gg: AeBDieuQ3DgqXEmDlHpCh8C8WxmCvsZUVQIYwSPYEd8DmiCgCYNDM+9KbZcV9xxzewq
	Ht80Suf+POPWTtug17cdDfV9AnZ2ekQ8AjbJsrEHBKvwMF/LFpxb+2dUMc7fYqGOBXjxUpGwsdL
	kpF1wQFqOGOxzrt/0VsHc+Bysule/TtK6O3Utru/rTyi8QrKf8WzkHRk9UqIo76wKNAaCJZK/qJ
	2eZfhJqX9qN8cktM4SzNErh97n22kHhV19Fi6ugLF+B1mvOg8a11ODK+/Me6/Lk6BihQGqeqcZg
	tq8MHHV0LoXuI2GbTcvqiNXcSEFjMhSQBmvEIwBrq+VgXmCJPbkrj9dbdHej0LKpUkw+Nyg8v6q
	1K0AWcVOfuvN4b+ihJw6G1CQwhMFeP4TM3e0RbkkQe1AcjMwECqm3hT7af1iy4HbHQLkddVDATI
	iS0XxKljnY30xbvRhIJKnVFwll84oZi83xDcY8yMp2
X-Received: by 2002:a05:6122:1d15:b0:56b:a673:27bb with SMTP id 71dfb90a1353d-56dab90d4f7mr2447140e0c.8.1775344993509;
        Sat, 04 Apr 2026 16:23:13 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bae1117sm11228422e0c.7.2026.04.04.16.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 16:23:13 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: greybus: fix size_t underflow in cap_get_ims_certificate()
Date: Sun,  5 Apr 2026 00:22:42 +0100
Message-ID: <20260404232242.68423-1-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233307-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B5E239CDC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In cap_get_ims_certificate(), the certificate size is computed as:

  *size = op->response->payload_size - sizeof(*response);

Both operands are size_t (unsigned), so if a malformed Greybus module
sends a response with payload_size smaller than sizeof(*response),
the subtraction wraps to a very large value. The subsequent memcpy()
then causes a heap buffer overflow.

Add a payload size validation before the subtraction to ensure the
response is large enough to contain the fixed-size response header.

Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
 drivers/staging/greybus/authentication.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/greybus/authentication.c b/drivers/staging/greybus/authentication.c
index 97b9937bb..1c14ad184 100644
--- a/drivers/staging/greybus/authentication.c
+++ b/drivers/staging/greybus/authentication.c
@@ -132,6 +132,12 @@ static int cap_get_ims_certificate(struct gb_cap *cap, u32 class, u32 id,
 
 	response = op->response->payload;
 	*result = response->result_code;
+
+	if (op->response->payload_size < sizeof(*response)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
 	*size = op->response->payload_size - sizeof(*response);
 	memcpy(certificate, response->certificate, *size);
 
-- 
2.43.0


