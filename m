Return-Path: <stable+bounces-58662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B1392B814
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFD11F20EE4
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E648D155333;
	Tue,  9 Jul 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aMmqEDda"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A563C34545;
	Tue,  9 Jul 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524618; cv=none; b=a1R9NAYRZeOT4G2HhYt3qFu1jMCroUAuY4iCB0GbYwi7pYDj9lTo7w7LXBlbR6v/T2sE9gJ7VBMtmtxGb+7d1MkAVDSc7N38OCt+CP5p/gvQ4C+RcwZ7czpA41AQwFWvbfTV4YpsFZ8vTqMxmuuoITJXKY9X4Ph945En3jUe8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524618; c=relaxed/simple;
	bh=QfuWPHNLhxLZ/eODkhTiz23pco7SpZGKmsaAdTbsE2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oF0QIvX2LX4zQqhy2TSD8U0Dgw0cNombnx3uYFjQC6ODQqekhbZvVZNnYerbi9MI/eMM8r7C0BIl8ucjwaxVd1Bik0rtPlpqYH+9075WBE5D6UQfe7qrsBoBAABtSq+CMF1VbJeKXGJnFWattWAfdWAD1h9bUG3Kds46CEzPwVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aMmqEDda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7446C3277B;
	Tue,  9 Jul 2024 11:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524618;
	bh=QfuWPHNLhxLZ/eODkhTiz23pco7SpZGKmsaAdTbsE2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMmqEDda/svLG2UPB7VmPqigymbqdOo/7EGrucUbzCocxU33/2mKZnA1nFpibOOgX
	 Jhx81cFvCIzbJBDsaf9dtdiI3JF0lDt+XVe3obFFpRUAoZAAYqaoW2v2uL2v6Oy5ZQ
	 EEu1vgTE/PBh4reczhYfhKcdtNlUDRMlpR+V2K4Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 043/102] tools/power turbostat: Remember global max_die_id
Date: Tue,  9 Jul 2024 13:10:06 +0200
Message-ID: <20240709110653.049579193@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>
References: <20240709110651.353707001@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Len Brown <len.brown@intel.com>

[ Upstream commit cda203388687aa075db6f8996c3c4549fa518ea8 ]

This is necessary to gracefully handle sparse die_id's.

no functional change

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a41bad8e653bb..66e31da942588 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -566,6 +566,7 @@ struct topo_params {
 	int num_cpus;
 	int num_cores;
 	int max_cpu_num;
+	int max_die_id;
 	int max_node_num;
 	int nodes_per_pkg;
 	int cores_per_node;
@@ -5864,7 +5865,6 @@ void topology_probe()
 	int i;
 	int max_core_id = 0;
 	int max_package_id = 0;
-	int max_die_id = 0;
 	int max_siblings = 0;
 
 	/* Initialize num_cpus, max_cpu_num */
@@ -5933,8 +5933,8 @@ void topology_probe()
 
 		/* get die information */
 		cpus[i].die_id = get_die_id(i);
-		if (cpus[i].die_id > max_die_id)
-			max_die_id = cpus[i].die_id;
+		if (cpus[i].die_id > topo.max_die_id)
+			topo.max_die_id = cpus[i].die_id;
 
 		/* get numa node information */
 		cpus[i].physical_node_id = get_physical_node_id(&cpus[i]);
@@ -5960,9 +5960,9 @@ void topology_probe()
 	if (!summary_only && topo.cores_per_node > 1)
 		BIC_PRESENT(BIC_Core);
 
-	topo.num_die = max_die_id + 1;
+	topo.num_die = topo.max_die_id + 1;
 	if (debug > 1)
-		fprintf(outf, "max_die_id %d, sizing for %d die\n", max_die_id, topo.num_die);
+		fprintf(outf, "max_die_id %d, sizing for %d die\n", topo.max_die_id, topo.num_die);
 	if (!summary_only && topo.num_die > 1)
 		BIC_PRESENT(BIC_Die);
 
-- 
2.43.0




