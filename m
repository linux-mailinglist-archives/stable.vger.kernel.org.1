Return-Path: <stable+bounces-34383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB3B893F1E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495932834D0
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7F4778E;
	Mon,  1 Apr 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShuwzNwX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF527446AC;
	Mon,  1 Apr 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987936; cv=none; b=n22M7bqxglMZi29wJAPP03FoclIgXB/Yo8gi/ZXl5rYTz8VevpRpNsn+ZzCOCRjzna7C0d4bMI/niYM8GQ/kkUxG/+PJBmeM8GDrU7iaW20BkJY7+m165MPXZhHXGKUIZ4GJP8eJa0ieMSE3CERW+NE2hJqsntjT5nNV+cVgRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987936; c=relaxed/simple;
	bh=zDBrwmfMjga5jS64xfICvJobJSqiXi88e2eFx6Yt4fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyf+NgPflX8dKzr1J7j327m8JrGOXet+pPBL++Y2B6NOSF9sYw1GFpoVFs4IREDUfMQZxpA8dZPmSPSeqMgVxlu2ox/NTwdseTVBMgjF99vpBMU9QAfXY/xhmBMlzmiM6cCx9IlucXcj0MLRG9oH3UhLI0RNUcS/7LH/LOkJFJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShuwzNwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C908EC433F1;
	Mon,  1 Apr 2024 16:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987936;
	bh=zDBrwmfMjga5jS64xfICvJobJSqiXi88e2eFx6Yt4fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShuwzNwXvRL0Uct125/n0aR3QEdu4QuzWiFOJneUjEgfQmEQkDVPwZWZl+dBEcNEF
	 RrGHW2oTkV151qCIQYmd/PdX6zYG/eeMhIvanTwlHMpwZdggiGHWToxrHf9S29rHbs
	 87LGXz4VZ0vQVO+H7LYGPomIAmOMp6a590fsXlno=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 035/432] powercap: intel_rapl_tpmi: Fix System Domain probing
Date: Mon,  1 Apr 2024 17:40:22 +0200
Message-ID: <20240401152554.179804452@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit 903eb9fb85e32810f376a2858aad77c9298f9488 ]

Only domain root packages can enumerate System (Psys) domain.
Whether a package is domain root or not is described in the Bit 0 of the
Domain Info register.

Add support for Domain Info register and fix the System domain probing
accordingly.

Fixes: 9eef7f9da928 ("powercap: intel_rapl: Introduce RAPL TPMI interface driver")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Cc: 6.5+ <stable@vger.kernel.org> # 6.5+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_tpmi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index f1c734ac3c349..f6b7f085977ce 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -131,6 +131,12 @@ static void trp_release(struct tpmi_rapl_package *trp)
 	mutex_unlock(&tpmi_rapl_lock);
 }
 
+/*
+ * Bit 0 of TPMI_RAPL_REG_DOMAIN_INFO indicates if the current package is a domain
+ * root or not. Only domain root packages can enumerate System (Psys) Domain.
+ */
+#define TPMI_RAPL_DOMAIN_ROOT	BIT(0)
+
 static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 {
 	u8 tpmi_domain_version;
@@ -140,6 +146,7 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 	enum rapl_domain_reg_id reg_id;
 	int tpmi_domain_size, tpmi_domain_flags;
 	u64 tpmi_domain_header = readq(trp->base + offset);
+	u64 tpmi_domain_info;
 
 	/* Domain Parent bits are ignored for now */
 	tpmi_domain_version = tpmi_domain_header & 0xff;
@@ -170,6 +177,13 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 		domain_type = RAPL_DOMAIN_PACKAGE;
 		break;
 	case TPMI_RAPL_DOMAIN_SYSTEM:
+		if (!(tpmi_domain_flags & BIT(TPMI_RAPL_REG_DOMAIN_INFO))) {
+			pr_warn(FW_BUG "System domain must support Domain Info register\n");
+			return -ENODEV;
+		}
+		tpmi_domain_info = readq(trp->base + offset + TPMI_RAPL_REG_DOMAIN_INFO);
+		if (!(tpmi_domain_info & TPMI_RAPL_DOMAIN_ROOT))
+			return 0;
 		domain_type = RAPL_DOMAIN_PLATFORM;
 		break;
 	case TPMI_RAPL_DOMAIN_MEMORY:
-- 
2.43.0




