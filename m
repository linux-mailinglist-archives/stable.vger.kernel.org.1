Return-Path: <stable+bounces-227789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0cafC9fzvmkslwMAu9opvQ
	(envelope-from <stable+bounces-227789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 20:39:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956B2E707E
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 20:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9321301691F
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 19:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67992318EDA;
	Sat, 21 Mar 2026 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGiIgvmH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC522DF128
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121938; cv=none; b=CkUu0A4NvIXVrbuugEw4hqDCZb1JLyt1xMTf+YtCw+K9iXeuC9Ig3SBjdAzf0JdlNTZISOuyaVjZiTZbezCtvsgIcQnvUkOdeTNLPuA0KzPDHgAkwsHr0m7dJAcTAykEf7N1La56mIFd0HW4zrObk4YLdEVkMfMBxm6602I/XJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121938; c=relaxed/simple;
	bh=g+xuNNpmeuXJ/PEeDw0wcga3QA4cOcyYh6zKDcERByo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaeK+d7bcn8xMjEEl4hGdIa6rgDbmWNz9kte88Fb1vIbmZpnp8XO8fLOxvnDkzHAnJV8vpTSTKFOWMhEwidmzqJsf45qjjMyImu/6ARSR8yZFLFSx8kwN2VMLuafbbKjgC2TxJML5qVyLN24tCa1NfagU4xC/ix4Qwt8pV6Xjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGiIgvmH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82418b0178cso1520347b3a.1
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774121936; x=1774726736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1f4+EJu9B3fRQLa14bMdkg9jwqnbe4vxaY7bPQ92Ejs=;
        b=RGiIgvmHNoLhQEqv1HnxpLgGScuk+BK0sVEOztJzsca2flLuKNEqorO5rhGM4o3IwL
         zRoVFNxaSiW78jCm9/6wWcKamt1SqnV9e8jiu917QbIXPPsOBYPr2novurxvUq4A+5B3
         U28sA+iZMlLXLhBJqiskkb9UMLNRokijZRV4xYnt//aUfbu/NtUfieEpr52plWpWVzTC
         uC3LjpvRNYJpu5Bepvvlb928KDHrG1fM3DbALEmgABiSREhLQKZ1eV72sixQxVeDEv9N
         gpemz1ES1tXsavK7ohHUlgRZko4e7HWbT9LyM3QEt98TGmYqRqc9hSETfCjTiQqm3oS4
         1DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774121936; x=1774726736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1f4+EJu9B3fRQLa14bMdkg9jwqnbe4vxaY7bPQ92Ejs=;
        b=Uag5pKKscyIEqMepvhreXs5N91bVkDCOSvnPfJ6YG9RmZYR45yDZW0AnqwJMGexlGV
         1YMwyG1CcnYAu1JcEdgu2BjsYcaLJwHKkRVX6xkf0p2jpVgAe9BN1KtXxIKYmHgMV52b
         dzPIgwqEl1prG6W8+ZqaXBdGs6w+Hvw8YtFeRAsPFnzncIiVNeksztkqjsKHAwH0RAQi
         AJb/knOarEOXDHciXJ4rlYuj70bniQtD2q8VBY/nemZ/1HrxO9RgDwcG3iH1XWN0GPVL
         j35cB+Pym7gBnALW0RYCdYTpHwdBxe4GRr6jmeSn+iJ7M7gAW2uxheYhM2JhRW5XTOKJ
         x/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxcMYW54nq/m94pDhf9DnL0/1gciYWxHspWmBWg75G7URHQITLsUItfDHAmMQ7C6GQs/vSeVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtEOBSb+RIAMC0NpG8w2AL4EIj8mc60zkL8xzCGxRvWEcrCj2
	3QnvbiGd7jjhQI4z0CxAnXUCMm1D26amXCd6NZzdB/w9rIA9Ed8pYWVZ
X-Gm-Gg: ATEYQzxY5kYEzfA9UjG0i9MGYxVIVTKf4PC7TPRO8ESCPOlDd/OL1TN8l+x/h1UeJdo
	fJ3soixIk/pxDYWIDD5QorysDhnkjwMN0UrEkC20JP1TzZqf6bHZHyLh4aVZG3qMDs6lWTsYvsT
	YSNOsViK3sA1Ptk89kSOlILs/whmrJlLY86/HQmHFyHuKJxyjjJwHwJ7smUvApH8JEP/xao+P+k
	La2/FUM//48glYXlv6E5AbZvBlD6CKWvu8O/k2Uvx2PU4uWYMUdU67Ij0jaa7Ui3OEsvajinbPE
	x13Y0kShg90GbUORIlZBiwJKOaifWv3CGXTO9cZrBHySi9OHbFJWCbOjC2mlDQAEsnC/hkuI7mF
	xITV4yo3YszkwKyF+YpX7v1aCHGeIaqNMTH/zPFanYH+bSgcJk+QEO23I7HwmIkDA8Aa9Dsx/2a
	bZm8h3Qu57lwBgE0yNrNzxd4Qsjnxg3uIbu6a/e3JuVnWcDyDxiPlC
X-Received: by 2002:a05:6a00:38c4:b0:82c:2445:bd48 with SMTP id d2e1a72fcca58-82c2445c9f8mr2459665b3a.1.1774121935599;
        Sat, 21 Mar 2026 12:38:55 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:e49f:fa98:a4ba:8111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b04222f42sm6220375b3a.61.2026.03.21.12.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 12:38:55 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: yphbchou0911@gmail.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	chia7712@gmail.com,
	jserv@ccns.ncku.edu.tw,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	stable@vger.kernel.org
Subject: [PATCH v2] sched_ext: Fix inconsistent NUMA node lookup in scx_select_cpu_dfl()
Date: Sun, 22 Mar 2026 03:38:41 +0800
Message-ID: <20260321193841.905994-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260321105503.869337-1-yphbchou0911@gmail.com>
References: <20260321105503.869337-1-yphbchou0911@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227789-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,igalia.com,gmail.com,ccns.ncku.edu.tw,lists.linux.dev,kernel.org,manifault.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 7956B2E707E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the WAKE_SYNC path of scx_select_cpu_dfl(), waker_node was computed
with cpu_to_node(), while node (for prev_cpu) was computed with
scx_cpu_node_if_enabled(). When scx_builtin_idle_per_node is disabled,
idle_cpumask(waker_node) is called with a real node ID even though
per-node idle tracking is disabled, resulting in undefined behavior.

Fix by using scx_cpu_node_if_enabled() for waker_node as well, ensuring
both variables are computed consistently.

Fixes: 48849271e6611 ("sched_ext: idle: Per-node idle cpumasks")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
- Update commit message to drop the incorrect short-circuiting claim
  (Andrea Righi)
- Link to v1:
  https://lore.kernel.org/all/20260321105503.869337-1-yphbchou0911@gmail.com/

 kernel/sched/ext_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index c7e405262697..8436c7df0a56 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -543,7 +543,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		waker_node = cpu_to_node(cpu);
+		waker_node = scx_cpu_node_if_enabled(cpu);
 		if (!(current->flags & PF_EXITING) &&
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
-- 
2.48.1


