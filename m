Return-Path: <stable+bounces-243984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC0SG0WH+Wmx9QIAu9opvQ
	(envelope-from <stable+bounces-243984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:59:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6906B4C70E5
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64DF730091EA
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51783BE64C;
	Tue,  5 May 2026 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYpJTvTv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99113A2549
	for <stable@vger.kernel.org>; Tue,  5 May 2026 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960765; cv=none; b=XV7n9mjWzSmWdJ/kqZfnAQPQPM8WKkE8hRH4BJdu6K1Uq4gNEYOW5UI/k5LaOQkX987+nGZQDIciwUGFIndGtpPaZBGQC5qJrjP5xIebQLXuttQxqAY+RCLeGtHRxfth2wUW2zgtd/TglM+YGeKEA0sLHfaV79BHu8n3YpgZ20E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960765; c=relaxed/simple;
	bh=X7Hii4Pvvatf3fOHQ50IuMX1l0/KGgE560+dqnTKkM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3+fq+eA8cPW8tH5r3GYntoDnINQrzzRs206zhj3bQlqOD9hW9Js3IM2P4JUIwyHzdD55zNZ6pKhz3aW1Gc9kB23pGan8ApH+lvxQ1fdC6bN8ImUAFjBmVbVJiuazlRh4jk102MI5pYfnCHNMWRmGWVSE27bJ3+UB4oB5lDuU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYpJTvTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAEBC2BCB4;
	Tue,  5 May 2026 05:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777960765;
	bh=X7Hii4Pvvatf3fOHQ50IuMX1l0/KGgE560+dqnTKkM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYpJTvTvVyh6J0lfyP+tqRKm5Y1Qspz90RgGc/Xxuyi8Kxo6xi9VHB0HNMZkxyNxB
	 8aUxfqRS2X9jm3RbRob5Sp0J9v+uL6qAdYsCud2KsViCBSiBccylOQxqpxbYOP0xum
	 RhRrlhqSkz4CefrydBItF7xLVEuTmoOXST35ZTAURKaZeTOldswKFSiQ41EAhDP/lg
	 iDLkAXfmGCyTv1NpRmSlG30ewgwn6qR3dkqI6HYnab1sq3yUOGO4/ouHn4bCycScA2
	 N5LUlw6IV+z8FOafuN7s16kAmUzsP4wFNxLzbQecB2SH1s7wdoV9o8j1qhlTPXxHaw
	 h9twofV4xWbsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] dma-mapping: drop unneeded includes from dma-mapping.h
Date: Tue,  5 May 2026 01:59:19 -0400
Message-ID: <20260505055921.224904-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050156-defendant-fretful-734b@gregkh>
References: <2026050156-defendant-fretful-734b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6906B4C70E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243984-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:email]

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit be164349e173a8e71cd76f17c7ed720813b8d69b ]

Back in the day a lot of logic was implemented inline in dma-mapping.h and
needed various includes.  Move of this has long been moved out of line,
so we can drop various includes to improve kernel rebuild times.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 3023c050af36 ("hwmon: (powerz) Avoid cacheline sharing for DMA buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/svm.c | 1 +
 include/linux/dma-mapping.h          | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 3b4045d508ec8..384c9dc1899ab 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -8,6 +8,7 @@
 
 #include <linux/mm.h>
 #include <linux/memblock.h>
+#include <linux/mem_encrypt.h>
 #include <linux/cc_platform.h>
 #include <asm/machdep.h>
 #include <asm/svm.h>
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ac7803e3fa613..7331be3cdb53d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -2,15 +2,11 @@
 #ifndef _LINUX_DMA_MAPPING_H
 #define _LINUX_DMA_MAPPING_H
 
-#include <linux/cache.h>
-#include <linux/sizes.h>
-#include <linux/string.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/bug.h>
-#include <linux/mem_encrypt.h>
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
-- 
2.53.0


