Return-Path: <stable+bounces-225577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMV2NF0huGmdZQEAu9opvQ
	(envelope-from <stable+bounces-225577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:27:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5822229C51A
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D0DC305A5DA
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E61F3A257B;
	Mon, 16 Mar 2026 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnUZCDPh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32F13A2578
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674231; cv=none; b=ijXpp+VVmuoNamhmJz15jivr5Dk0oI2M6eVBxFh0y7nsFlRrxrx2qXgSIpkbVTG71W6qYb/hdGMqZrYP5sVygMYCg+xh1MXFLK4d5pKkBQkjMAJvOeWA7d5qLMgI1W6+/4ctygJpqYyMYKr6tCrEG+0SaV+Ff3X5tzox3Au4kBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674231; c=relaxed/simple;
	bh=CF8dVcK0i5VSJfiAs0rKeOJXSZxrmOvCSJ2k6JZBSDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFowGLDFBb7SA6hzrnThHOL1gbAAYsOeBzIF9DrO3x/KFZqUYyvmgyYs3NaNyvWhrgGXOtcXMIbu3H6dVpCQp+s2/vAaM4o5is9Y1RWqVQIt9dG2WPT1Mmu9ZN+9fSc5tLxYhXyeBvNHuXcjNhAkhtjtkvZcCubmNG6Kh7oo/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnUZCDPh; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c74029e07d3so498415a12.2
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674228; x=1774279028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdb4ugnvGEdVJJVzg3fQ08oXhRTpATrmKcYQ2XRYd1o=;
        b=PnUZCDPhAIzvqLDmb1bJij/7lQDrmzEHhH47jUSHyD91pEW9ldpCr+6KTivsMSuYdo
         oideuJqRzcpYt1aJ2i5JFqfdAcOAjHSa1pL/2ax+J4BVaYRBWHLlNcldEDFOXGAxLH16
         UEoTUUPVo6P3SsomTPMIMM7NDoEiQb4ObGREjnspHacQqKzeXTKQljwwiaF8UmyyglsB
         /HcR1EaLyEV7Q2v7QsMZn0HBKNuIV85eAiRgO5+aVeSrEfuqmW+gyq4ZxbjJCQP/ysjg
         Iid2Oxfv26lxAtbKVfI66TXjjo7BeIG1uoAAh+o4sFqjKAdZDrTu4kniyWbyGA1wHjab
         UZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674228; x=1774279028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdb4ugnvGEdVJJVzg3fQ08oXhRTpATrmKcYQ2XRYd1o=;
        b=sozKoR6faDP+bYcSn78rMZVB59G916Bn3eT/67JA8lBLb8GM9bD/oEby+6+jMrMzmx
         NK/WTG7EvrB8OIIP97x/bMhJAHzDs4+Bi1kZNFVjFlQeDjX0D0bRPbdYbgHv0Lk3KxFT
         PRPdfJaVNG0+pEoJ1i9MEhTJ2pwC953A+PXhtGAtHS/VQQprkNfImWNN7v51S8OxB5N6
         g2QDYnthRE3AAFE3iUF9bNlB7QW9vySeow8IDGpdurOphcTYxYZ1ZjZ0cmpml4ZIM7Y7
         DyIZgvepoIx/ZF5Rt1GJ6BjjWE8vJ/sSHxKEfpaXOOqNXyr/ihSIM413cpBS/tL+KcD8
         RnCg==
X-Gm-Message-State: AOJu0YwSgDdA+CK82nQCiAhIJzsx1hBVOyuTHkdT4d06arDVjZlG22ps
	5SEUsdYuNQ51+sD4qIMe2F7ACAwxVECGAmDu2q08eS9h3wquMnuVSUlqFSHQPXju
X-Gm-Gg: ATEYQzwqWEV3OrZNwfaN3CMZYNCfntq0VweAPa7UBj7SUWX0WXzE5bIwl0J1aBReig4
	ii1Sec6FnfVaIhBiAV/3uyaBb6zPkeDGCiHAV8UEJ3qxb6ehoK4d7rSrKqx68nhWgJ0XSpL4MIz
	LJLaZq8qG7icFVzeDyIKv+7kQixHsXgjj0yhyZZT+pRVf1z2KzEms6XqLpAgL29WhNLbLu8nzcy
	3VnMjAQTajWwodVw3SD5kCEya3OWvkgUZ2oyH4bxdFwP4p7bYrb85pngO6rbZ5Cka2O2uDH4im1
	dJmtBCfhRdk6G3EoHSH45YF++8DTMDDm/xV3Djvs3ZIAyqH/zwhuBwUJlnpggRnIu8uOUVJ6fit
	cB06vFUTlavurqIOx6sI/zzGPd4wF4ejqnfVp6gIaRCaggiB6qu6MnL8d8dLeZuM+4onvdmj+yk
	5X5eJrOrDwrMv7FxW7HONT2RbBDFkLixXYP6b+nhKWmAfj9l9y33oG
X-Received: by 2002:a17:903:3c46:b0:2ae:572a:9f19 with SMTP id d9443c01a7336-2aecaa387d2mr153209785ad.21.1773674227981;
        Mon, 16 Mar 2026 08:17:07 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:6521:1510:d053:7359])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece84084bsm105470395ad.82.2026.03.16.08.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:16:58 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: stable@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Remove redundant css_put() in scx_cgroup_init()
Date: Mon, 16 Mar 2026 23:15:28 +0800
Message-ID: <20260316151528.3141202-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2026031630-character-subsector-36b1@gregkh>
References: <2026031630-character-subsector-36b1@gregkh>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ccns.ncku.edu.tw,gmail.com,nvidia.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-225577-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 5822229C51A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The iterator css_for_each_descendant_pre() walks the cgroup hierarchy
under cgroup_lock(). It does not increment the reference counts on
yielded css structs.

According to the cgroup documentation, css_put() should only be used
to release a reference obtained via css_get() or css_tryget_online().
Since the iterator does not use either of these to acquire a reference,
calling css_put() in the error path of scx_cgroup_init() causes a
refcount underflow.

Remove the unbalanced css_put() to prevent a potential Use-After-Free
(UAF) vulnerability.

Fixes: 819513666966 ("sched_ext: Add cgroup support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 1336b579f6079fb8520be03624fcd9ba443c930b)
---
 kernel/sched/ext.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7e79f39c7bcf..da64e242ddbf 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4319,7 +4319,6 @@ static int scx_cgroup_init(void)
 		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
 				      css->cgroup, &args);
 		if (ret) {
-			css_put(css);
 			scx_ops_error("ops.cgroup_init() failed (%d)", ret);
 			return ret;
 		}
-- 
2.48.1


