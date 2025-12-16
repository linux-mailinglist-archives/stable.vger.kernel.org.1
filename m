Return-Path: <stable+bounces-202408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA55CC2AF5
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37B8230146DB
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA93328639;
	Tue, 16 Dec 2025 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xxjG73a/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C83644C3;
	Tue, 16 Dec 2025 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887799; cv=none; b=I1cUUhAG9rMeSi3pAs1iaC6SbXi92hLC3v2j7U18nUqRyTc6eS/KAkleVdPgAZPDCeNce/2p2oXlMXsYh5YlWlVw0DtIK/mmiRoDrpc79X/9XCSGCabSD+/wJ5n+YJHr5HwVBvMe8PlKI5JQtyxyWdGLQvMWMr7d+A6ouiBMktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887799; c=relaxed/simple;
	bh=BSrf4JH46TCHVxPCVfuDx8Z45juhcCK2nSjV6XofSJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKY6Qo0mc6tbx83cVshET/UhuZZhcxvQafUEwZOqVaLkq5G5eWF0dkThBk/9uueHuIsbLrloF1BgCdc+RFb03iG1adPbM2GNf00Io29K4be55Gnq3UA20cvhOFeaPKq4uYPPGWSYAdM3CdZKKnHaK2sMET7muuIWSABFcAH6WNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xxjG73a/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A5FC4CEF1;
	Tue, 16 Dec 2025 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765887798;
	bh=BSrf4JH46TCHVxPCVfuDx8Z45juhcCK2nSjV6XofSJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xxjG73a/c4RlGl8J0gTKop0p0uIgH5fUIRueZ+syL3T+X54Z5LyyXW8Cur8rNTe2X
	 DVzPteN9JCkNR/vE6EV/smH39tabvGD94o+69YebwC0jjpQL14N+DsOFnhd8jxouOu
	 hJSzBFcOjl89T7qy8T8sFouxSTwomR3nf9Rt6onY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuntao Wang <yuntao.wang@linux.dev>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 340/614] of/fdt: Fix the len check in early_init_dt_check_for_elfcorehdr()
Date: Tue, 16 Dec 2025 12:11:47 +0100
Message-ID: <20251216111413.682796530@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuntao Wang <yuntao.wang@linux.dev>

[ Upstream commit bec5f6092bc1328895992ff02b862ba34b45a0b7 ]

The len value is in bytes, while `dt_root_addr_cells + dt_root_size_cells`
is in cells (4 bytes per cell). Comparing them directly is incorrect.

Use a helper function to simplify the code and address this issue.

Fixes: f7e7ce93aac1 ("of: fdt: Add generic support for handling elf core headers property")
Fixes: e62aaeac426ab1dd ("arm64: kdump: provide /proc/vmcore file")
Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
Link: https://patch.msgid.link/20251115134753.179931-3-yuntao.wang@linux.dev
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/fdt.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 0c18bdefbbeea..b45f60dccd7cf 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -853,21 +853,15 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
  */
 static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
 {
-	const __be32 *prop;
-	int len;
-
 	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
 		return;
 
 	pr_debug("Looking for elfcorehdr property... ");
 
-	prop = of_get_flat_dt_prop(node, "linux,elfcorehdr", &len);
-	if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
+	if (!of_flat_dt_get_addr_size(node, "linux,elfcorehdr",
+				      &elfcorehdr_addr, &elfcorehdr_size))
 		return;
 
-	elfcorehdr_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
-	elfcorehdr_size = dt_mem_next_cell(dt_root_size_cells, &prop);
-
 	pr_debug("elfcorehdr_start=0x%llx elfcorehdr_size=0x%llx\n",
 		 elfcorehdr_addr, elfcorehdr_size);
 }
-- 
2.51.0




