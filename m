Return-Path: <stable+bounces-225716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJuhEt+OuGm2fwEAu9opvQ
	(envelope-from <stable+bounces-225716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 00:14:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE432A1DD4
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 00:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5C81300538D
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 23:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8247377EDC;
	Mon, 16 Mar 2026 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx5KLEXA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45837756D
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702874; cv=none; b=K5G0dFZmXxIN0KcmI1M54UZQ85UirPa5wZ06QzaY/dbhBiuUprqNAHrHCyUJyubqzzkeFoTx3JJYWVeVWkwfi7Yr3rVkIJ/BMLSc7XQAYrmuOE/z/+EkpO/KCGbt77iIkSlPhQVY67hUihTwR5K2qA5NMTQuhJrClq1C1zs6sD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702874; c=relaxed/simple;
	bh=bU0l8rf6KOLOmdQVbkBsFqG6+1tWT8qNfQRY1O8Fhc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYgyl/z2JXbn+u7AAArGnOyYO/45uCm3HrQDU3CF+Svqt2uk1keCpwnUT22F7meyuhnDIjoy5xsdqSk3desS8Jgm18ODx97u0IwpgCOeHEQWlXLhuemV7pxpndEpuyaj5UU75hITfEt427bZ7PhfILgUDXc0Syh3kaRS1D/wy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx5KLEXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D23DC19421;
	Mon, 16 Mar 2026 23:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773702874;
	bh=bU0l8rf6KOLOmdQVbkBsFqG6+1tWT8qNfQRY1O8Fhc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yx5KLEXAWb1Pgbp104ev5tUpNG/+Ske5jb6DUUV+e6JGKttla+wgGEtfCbIiU9Kf/
	 dbssJLfAo56CjujSSbNYOUJAlYsAv1bM9+bIC0XK/7a/gLQjTTt70i1MY8/l5VPIWV
	 hGY8Qf2Z4njuEjS0clv29aeqvkZPaQAOaEpSs7BiX6kRgxvsi/lwNYQqB1ZN8xKG9Z
	 Kc8zD2Kn3NBugK3pmHkaSN7jXwOSGoYutr+kM/3IRVfroDNNwMyJn0jJsLuC3Hi0Ms
	 HTq11QF96BlUEU+8NREEXqCkxfkwgjnKFIT4lle7DxDaXJsU6ZS4ix56B929YemJzh
	 iS6J/78ez+aeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] cleanup: Provide retain_and_null_ptr()
Date: Mon, 16 Mar 2026 19:14:30 -0400
Message-ID: <20260316231431.1445981-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031645-manger-gratitude-6c61@gregkh>
References: <2026031645-manger-gratitude-6c61@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225716-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAE432A1DD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 092d00ead733563f6d278295e0b5c5f97558b726 ]

In cases where an allocation is consumed by another function, the
allocation needs to be retained on success or freed on failure. The code
pattern is usually:

	struct foo *f = kzalloc(sizeof(*f), GFP_KERNEL);
	struct bar *b;

	,,,
	// Initialize f
	...
	if (ret)
		goto free;
        ...
	bar = bar_create(f);
	if (!bar) {
		ret = -ENOMEM;
	   	goto free;
	}
	...
	return 0;
free:
	kfree(f);
	return ret;

This prevents using __free(kfree) on @f because there is no canonical way
to tell the cleanup code that the allocation should not be freed.

Abusing no_free_ptr() by force ignoring the return value is not really a
sensible option either.

Provide an explicit macro retain_and_null_ptr(), which NULLs the cleanup
pointer. That makes it easy to analyze and reason about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Link: https://lore.kernel.org/all/20250319105506.083538907@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cleanup.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 0cc66f8d28e7b..c1b7ec5244642 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -216,6 +216,25 @@ const volatile void * __must_check_fn(const volatile void *val)
 
 #define return_ptr(p)	return no_free_ptr(p)
 
+/*
+ * Only for situations where an allocation is handed in to another function
+ * and consumed by that function on success.
+ *
+ *	struct foo *f __free(kfree) = kzalloc(sizeof(*f), GFP_KERNEL);
+ *
+ *	setup(f);
+ *	if (some_condition)
+ *		return -EINVAL;
+ *	....
+ *	ret = bar(f);
+ *	if (!ret)
+ *		retain_and_null_ptr(f);
+ *	return ret;
+ *
+ * After retain_and_null_ptr(f) the variable f is NULL and cannot be
+ * dereferenced anymore.
+ */
+#define retain_and_null_ptr(p)		((void)__get_and_null(p, NULL))
 
 /*
  * DEFINE_CLASS(name, type, exit, init, init_args...):
-- 
2.51.0


