Return-Path: <stable+bounces-72649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E9B967DAA
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 04:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259251F213FE
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 02:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD92E26AE4;
	Mon,  2 Sep 2024 02:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="Kp5o5Ok5"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D61804A
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 02:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725242725; cv=none; b=oXeY2X0+V9JDbJn7S2JqimPdvsdcutnZG6fx53UODjws8kYawnSK3QzieFDwmlsVRCqcd4Huvkx008+ir1rM2661ak3yw/M9d3Ojlo+idqpPPKujUNJDkL4NRcLoD74FRpRZl6o3zIVrHvcSLLZP7luB04mz0dt8lptag4b5QZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725242725; c=relaxed/simple;
	bh=3bsjVY8bldJihatLeQZqJT5FdnEmepoai4xFY/QtUX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/7Y90p3y/zPuM4Anx68yMHnk/skthMtcfE1m7PP/45EWuU9WfMImMfwJ5QFGGpe9qC6KU+qcLmX4OtB5NSNYUBtHeq7H0YHAID77aL0BaQHzle+mr7l/6B9yvcX7SP17b/mnAcpOx7dxYYf5XbxG2B27BGjkCmwNSfDoyvA0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=Kp5o5Ok5; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 236D12619F
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 02:05:22 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id CC8773E970;
	Mon,  2 Sep 2024 04:05:13 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 6683C4007A;
	Mon,  2 Sep 2024 02:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1725242713; bh=3bsjVY8bldJihatLeQZqJT5FdnEmepoai4xFY/QtUX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kp5o5Ok5i7dVrIej6wXKyGoX7aS+s0Nn5AmAMKPutY2YEFNhZQg2x8CTQsAynre0I
	 lSaUVFfHbxnrpr/PQbI68IiwWU/ppR3j/U7h67/VjQO+g01OlCjnNLPN6u8MpzAOxv
	 hYP5reQbGNbagU5F6RKf+LfWBPIF5xLb4/bqUxGQ=
Received: from localhost.localdomain (unknown [58.32.40.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 05E57406F1;
	Mon,  2 Sep 2024 02:05:10 +0000 (UTC)
From: Kexy Biscuit <kexybiscuit@aosc.io>
To: gregkh@linuxfoundation.org
Cc: jarkko@kernel.org,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	stefanb@linux.ibm.com,
	kernel test robot <lkp@intel.com>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Mingcong Bai <jeffbai@aosc.io>
Subject: [PATCH] tpm: export tpm2_sessions_init() to fix ibmvtpm building
Date: Mon,  2 Sep 2024 09:59:13 +0800
Message-ID: <20240902015912.56377-2-kexybiscuit@aosc.io>
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
X-Rspamd-Queue-Id: 6683C4007A
X-Rspamd-Server: nf1.mymailcheap.com
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
X-Rspamd-Action: no action

"tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support"
breaks ibmvtpm to be built as a module, since tpm2_sessions_init isn't
an exported symbol. Proposing the following patch to resolve the issue.

Also, please disregard for the previous incorrectly formatted email.
---

From 3e43cfa3466178ec7f4309031647e93565bc70bf Mon Sep 17 00:00:00 2001
From: Kexy Biscuit <kexybiscuit@aosc.io>
Date: Mon, 2 Sep 2024 08:26:38 +0800
Subject: [PATCH] tpm: export tpm2_sessions_init() to fix ibmvtpm building

Commit 08d08e2e9f0a ("tpm: ibmvtpm: Call tpm2_sessions_init() to
initialize session support") adds call to tpm2_sessions_init() in ibmvtpm,
which could be built as a module. However, tpm2_sessions_init() wasn't
exported, causing libmvtpm to fail to build as a module:

ERROR: modpost: "tpm2_sessions_init" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!

Export tpm2_sessions_init() to resolve the issue.

Cc: stable@vger.kernel.org # v6.10+
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408051735.ZJkAPQ3b-lkp@intel.com/
Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 drivers/char/tpm/tpm2-sessions.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d3521aadd43ee..44f60730cff44 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1362,4 +1362,5 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 
 	return rc;
 }
+EXPORT_SYMBOL(tpm2_sessions_init);
 #endif /* CONFIG_TCG_TPM2_HMAC */
-- 
2.46.0


