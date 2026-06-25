Return-Path: <stable+bounces-268569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5ktYL2g3PWoIzQgAu9opvQ
	(envelope-from <stable+bounces-268569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:12:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC406C676C
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:12:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eKFMUv7k;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268569-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268569-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EDFD3002327
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E868348883;
	Thu, 25 Jun 2026 14:12:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FBB1FBEA6
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:12:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396766; cv=none; b=Eh00MS7L518nGLegbZtG65b8FbR1RJdKvfmlqTvHXANQWug9stqAdto8rdFfU7vuLefIvKEJS15meUPP4Q7LQJuT0iP+aPUFld2s1WxOuDRy3wvMpFdO9d13qepUDbiHE5Z5nur9HlxmxcONzRsi1hnOyxpske3PjM1PvFzqVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396766; c=relaxed/simple;
	bh=Vrr1iG9Zqz34yHCA8PwngRTn8hJ+90K2+6Om0XiEXdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qxmw4Sg9K8PBYxuZsqlcoEkL0BTJZOM74uKBwm5chvwNeg1YjL9+1LwvzKWdpxagucHxNicDoLHKMCBiz6zqSfT+tZycTb2FLY+Cz/rCZDjVmud1AXcxhsIM9wtfHnx2huPTYL4Cy7lxOGvR3oBMhYZQ+nYycAtBqQHK8EeCACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKFMUv7k; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8422f395a4aso798632b3a.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782396764; x=1783001564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1agOcM108mYien5bPYKqYcmwOSbFBw2SAS45aRrQL3c=;
        b=eKFMUv7kj6dHWgGk7CTrHH2m/MNFoh+0gZZbTtfWC3rrJ0BRzFKWPsYvSmxR2tLRKG
         TgVnuB6hNEbhdcUV3mo3QTrn6NnwnL+FGeoCPzFPvWPqHhj9fGgNHaep0zYZwjm1nVVj
         veBQjgiLj18y4nC1+gaBbGPEezuTcD5XDVVsKe6Qm+ESNauVEwyrXVZxvAu1UZhNplNA
         X0HGdaIgfrqD79SOLrp+MmuykptBIFrvSjlfYcPLpLcPgcHVi90RaMHP5kzgBdh9BR1z
         Ra/Nuqu1q5hLFYgrcgBw70ZCtVkqDe8ll1Tyy4HERWbDhEat4QgTtxRlrL9FJU96m0rU
         HL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782396764; x=1783001564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1agOcM108mYien5bPYKqYcmwOSbFBw2SAS45aRrQL3c=;
        b=jUZ4+Dy/T9FHlGhyvqi5gJ28qpKmxsvGAZtUUtMsqZnD8FT/5erE2m7WCAhedkKGZ9
         IFQjshBiq3Q3C7r9qGiJemXNI725liRsSYNIjwsrJOP0qrc4Ex5VXde7OQuTB0Ecg/6S
         Y6rf0dK44Kor/JndsBBFutPYMxAb400jlUH5b4aTSRqpwgnw7LFiCuhqXfqeRdQbWsG1
         TKRflOOzMgPJeVJnqt7aHdTCwh8tzfCIjz+ZddVCCeq4ulqUd/uGtoFnRW9eXR8wIxtf
         PqxU+PKF5rlC0CXrm5oELcWssIVuY48ofrm3cMDngyTo//cKtKi6XrUrWAXd4W6BhgKf
         O2QA==
X-Forwarded-Encrypted: i=1; AFNElJ+jOtU0GIGUBKyMJigeaMpAYlA7h9YB+/Yuc6jECGYjXAxChvL9oY/VsKGzsFY5qGe/b7nuKSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiAA7uSv13VX9u2h5nVq8LC2EEaNomhB+jLVVJ2txwCkXo3gzM
	S4Mr+NHlRm1Iut93kHLyMZgzqOOSCKeGyX06KJIYDfSFlrqTu2zicS6Z
X-Gm-Gg: AfdE7clbVveen5j2mZN55Xnf56YNgXdlMore/whqBHuaXbuVBRjAMUqyla5sqVZPBA0
	nwRk/GlDrw8TAzqezuEIFe6HhArBd901Bbq6H0Hj+sghrt7ndkk0CmMhNi2wabqghdrNBnDWReB
	ISbJAiN+jLGLA4yD4MMMH5SUXabAP91bkFA7Ppr1IcYZzMmdLsnH/+WD9jtywNnkR80uAImDkbN
	9GTU6BZ2sL+WEaKGZU8442Rao46s+5xUUBfnhiioOFFiTVkMzVMMDk753NK34BTS9m1+g2nC1B7
	0yQv55ikO0RLk0yJK3C2wdL3kGnd23qgG/phJyk45u5Y+AaGF7nIkFsAYJDcR7RPm8fZ80aNfnx
	LxLaDO/CNxbrC8lTWy59SYNo8sjSQ5nqWiqnONpY3yASs2LTcR5yAiVc3HKwHMheK/6KM6nM0oy
	NuXsHcCpqFfjYDzZ94pJuobTGTB+kV
X-Received: by 2002:a05:6a00:10c7:b0:83f:250d:5a5 with SMTP id d2e1a72fcca58-845b44eb213mr2676677b3a.16.1782396764267;
        Thu, 25 Jun 2026 07:12:44 -0700 (PDT)
Received: from localhost.localdomain ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d23d7sm4838015b3a.30.2026.06.25.07.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 07:12:43 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>,
	Philipp Stanner <phasta@kernel.org>,
	Akash Goel <akash.goel@arm.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH] dma-fence: Fix dma_fence_timeline_name() to call get_timeline_name()
Date: Thu, 25 Jun 2026 22:12:27 +0800
Message-Id: <20260625141227.38931-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ursulin.net,kernel.org,arm.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268569-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:tursulin@ursulin.net,m:phasta@kernel.org,m:akash.goel@arm.com,m:linux-media@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linaro-mm-sig@lists.linaro.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shoubaineng@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shoubaineng@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shoubaineng@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DC406C676C

dma_fence_timeline_name() incorrectly invokes ops->get_driver_name()
instead of ops->get_timeline_name(), so every caller receives the
driver name where the timeline name was expected.

This is a copy-paste regression that has resurfaced twice. It was
originally introduced by commit 62918542b7bf ("dma-fence: Fix sparse
warnings due __rcu annotations") when adding the __rcu casts, fixed
by commit 033559473dd3 ("dma-fence: Fix safe access wrapper to call
timeline name method"), and then accidentally reintroduced by commit
e58b4dea9054 ("dma-buf/dma-fence: Add dma_fence_test_signaled_flag()")
when both wrappers were refactored to use the new helper.

Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/dma-buf/dma-fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index b3bfa6943a8e..5292d714419b 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1202,7 +1202,7 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
 	if (!dma_fence_test_signaled_flag(fence))
-		return (const char __rcu *)ops->get_driver_name(fence);
+		return (const char __rcu *)ops->get_timeline_name(fence);
 	else
 		return (const char __rcu *)"signaled-timeline";
 }
-- 
2.34.1


