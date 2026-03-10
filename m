Return-Path: <stable+bounces-224208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1AXvDMH/r2moeQIAu9opvQ
	(envelope-from <stable+bounces-224208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:25:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC3324AACD
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CBBF305B02A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0DD38947F;
	Tue, 10 Mar 2026 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTzE9cov"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1A386C02;
	Tue, 10 Mar 2026 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141662; cv=none; b=IFPS34H58BxM1xTb7i3B62Tv3UbpnbL8UVyGpbM+0PIwH4xM8eKy4jSu9VAux6stitclKzIIms2pK7J4cc+684cUr5bgp5un2ABCGtLHoccZqpIIsg86JMC9VXky0JdoJ1/w89coiSjtmxUHyf4+/EExwYhQCh8Y1eIhg/F7+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141662; c=relaxed/simple;
	bh=C+eWog7JoMIEXV5o4imtsRWCvpVE3z/HqZkN7rheiCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0wuJ8YCHEMT/QnyXxi0HjjebRlmAt3F6SxVEaI0RWRkYLNM4okvsX7wZmutlX86Xv8h6zpHDmHIn/81Xh1EPB9YPbLLDDYq1L0mewf6dir+XEIVUiWHYkgKWKL0ery3fIh9WT+5uGRQ1MsOAumzMTFwxUCrcC1lPLvLi4gGfoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTzE9cov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85107C2BC9E;
	Tue, 10 Mar 2026 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141662;
	bh=C+eWog7JoMIEXV5o4imtsRWCvpVE3z/HqZkN7rheiCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UTzE9covShyotfRXRA+kvCkRFaxsH4IqUjw9tKTP5YWfxshKosyhE+LHPJRYSaT30
	 /adH+m+1ULOX4VlVmAhbGcBpeLpgub9wfNiZ3dRwVo30bpPkmmfcafQN+lvzMverSk
	 tuqjkuXaYRrgw5dq+jW7feVgDQdKPJNWWMhcUaSZ7M6IpyrWF/ncRpuPg84gQJVgIb
	 /21cJez7SLvmTielt2W/L1N/RyhuTYAqr4QmMj1s+6TtMfRnR4nSi0I18X6QhtdGtr
	 0MEigU5NSO4ywX7oY/BAUPaaZ8CAXJfYB3KIFrECSrAfG4I+xwQzOaq6c0YRtjU6sR
	 Dm3QYRuuJqpCg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 029/314] accel/amdxdna: Prevent ubuf size overflow
Date: Tue, 10 Mar 2026 07:14:48 -0400
Message-ID: <e6adbc28f1d395eaf9713f40d46c2197bce26bc7.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2DC3324AACD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224208-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit 03808abb1d868aed7478a11a82e5bb4b3f1ca6d6 ]

The ubuf size calculation may overflow, resulting in an undersized
allocation and possible memory corruption.

Use check_add_overflow() helpers to validate the size calculation before
allocation.

Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260217192815.1784689-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/amdxdna_ubuf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index 9e3b3b055caa8..62a478f6b45fb 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.c
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
@@ -7,6 +7,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_print.h>
 #include <linux/dma-buf.h>
+#include <linux/overflow.h>
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
 
@@ -176,7 +177,10 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 			goto free_ent;
 		}
 
-		exp_info.size += va_ent[i].len;
+		if (check_add_overflow(exp_info.size, va_ent[i].len, &exp_info.size)) {
+			ret = -EINVAL;
+			goto free_ent;
+		}
 	}
 
 	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
-- 
2.51.0


