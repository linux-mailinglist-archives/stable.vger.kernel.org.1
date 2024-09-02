Return-Path: <stable+bounces-72710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13594968404
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 12:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B48BB2446A
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F8E17F394;
	Mon,  2 Sep 2024 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="W+ObnJhf"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16013D51C
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271366; cv=none; b=TT9ClONjT7YYlTWVIR3bZNZ0eBAwR8ZBKcBUOTeB5gdVzk+qcIOsdduDU25QBgTHiZkkJoYVArHh9qZoVQBdkFtIcTgvRgzJsqCn7rWw1BOjgdMD7CmeZZs/8ZuI4Qo4ijHMmlk0E7+x/Ga2QCKRX5EBRgzcgkLbuVAwPQC0kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271366; c=relaxed/simple;
	bh=yu05MG49Y96wNnlCUSqbQDKyaIQsanfK87VEISGQHk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjM3eqNZ13uZR7c7TJ67J5vY7sG7+Fz4bWaobfvrsTk4uY0cSY4IrRhM8J4MouUqhfFk8ai7TUtXfRsHl9mz+Nr60EV4Zar3YxF7GvrFW89zTsj9FRSH9fK5FAzjv0VKXq108bS+icGeSNAwMcD8x/N1KgfVHYKJUK+7nqERaSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=W+ObnJhf; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 97FB220113
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 10:02:42 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id 99035203E4;
	Mon,  2 Sep 2024 10:02:34 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 3785840096;
	Mon,  2 Sep 2024 10:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1725271354; bh=yu05MG49Y96wNnlCUSqbQDKyaIQsanfK87VEISGQHk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+ObnJhfIKWvb+1dMGalYrT5Vh3kRfxKBZNDWa7ZP91OWY/vPWOGoUDJzb0yW5YZf
	 6K+u7qqWuEDR9oHFznf3lciugjSm/iv+xD3g0C0pQN26AJt4zOBN8YU1XYlSH8x8BK
	 ugs/GMTWGyh+MA7/ItgyiA5l1dBXOZ6D4uv/k8LA=
Received: from localhost.localdomain (unknown [58.32.40.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id B44AD4107A;
	Mon,  2 Sep 2024 10:02:31 +0000 (UTC)
From: Kexy Biscuit <kexybiscuit@aosc.io>
To: gregkh@linuxfoundation.org
Cc: jarkko@kernel.org,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	stefanb@linux.ibm.com,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	kernel test robot <lkp@intel.com>,
	Mingcong Bai <jeffbai@aosc.io>
Subject: [PATCH v2] tpm: export tpm2_sessions_init() to fix ibmvtpm building
Date: Mon,  2 Sep 2024 17:58:36 +0800
Message-ID: <20240902095835.16925-2-kexybiscuit@aosc.io>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.780395041@linuxfoundation.org>
References: <20240901160817.780395041@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 3785840096
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[]

Commit 08d08e2e9f0a ("tpm: ibmvtpm: Call tpm2_sessions_init() to
initialize session support") adds call to tpm2_sessions_init() in ibmvtpm,
which could be built as a module. However, tpm2_sessions_init() wasn't
exported, causing libmvtpm to fail to build as a module:

ERROR: modpost: "tpm2_sessions_init" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!

Export tpm2_sessions_init() to resolve the issue.

Cc: stable@vger.kernel.org # v6.10+
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408051735.ZJkAPQ3b-lkp@intel.com/
Fixes: 08d08e2e9f0a ("tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support")
Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
V1 -> V2: Added Fixes tag and fixed email format

 drivers/char/tpm/tpm2-sessions.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d3521aadd43e..44f60730cff4 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1362,4 +1362,5 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 
 	return rc;
 }
+EXPORT_SYMBOL(tpm2_sessions_init);
 #endif /* CONFIG_TCG_TPM2_HMAC */
-- 
2.46.0


