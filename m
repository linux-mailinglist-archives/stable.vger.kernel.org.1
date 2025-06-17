Return-Path: <stable+bounces-152946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0408ADD1A1
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B067ABCB4
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D202EBDC0;
	Tue, 17 Jun 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R5ogBuHf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3A2ECD18;
	Tue, 17 Jun 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174352; cv=none; b=o99jhrT1yZySLgxr5ac1P9KQdBdC7uVkAGINYqjWedph/K3Eg2vhD58PMYpQf3j4BIzAQ38BPCiBiDGXrGZmLovxT229/aqWwYWlOwSMQZI2XOwv7IliqbNHNps+XXN3gRQHrWWQIENtFLRdx3INpmQBwrpnrJZ9EjNlb293Ens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174352; c=relaxed/simple;
	bh=wJtbFZQuB2fkewZi8aN+9cLBGHhu2FnrhliG2LdRzMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgTIDzoLAeUmiqCsDshn/7WrB1pOfZrzdERSP2RYkIpmPN7EvMj5qbB/FafHYuguSA/zn99GDx41toTXty/PYdmNNffDzoK2cb9QzJmLawbNt2c8fn378icJYxCe1svX4kZrhlR78RakfYwh+1T6UZEvw0CSfoQ2pbdMwd7bbtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R5ogBuHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90224C4CEE3;
	Tue, 17 Jun 2025 15:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174352;
	bh=wJtbFZQuB2fkewZi8aN+9cLBGHhu2FnrhliG2LdRzMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5ogBuHfSgbOGJ8q/9JPYEMa/zBfz2qW0Lzo3PpNx8cEQhPfL9MLKn5Hef781QZ1W
	 T7x8S7tHjkcoY+9Cv8UDHxBnlzvujFsIisqBbYusbItj3YcHZb2YkCc7wo2sY9koyE
	 8wJVVsucIruPQErMczaLWVB80Ez/L0uxsF48/LNA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sandipan Das <sandipan.das@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 005/512] perf/x86/amd/uncore: Remove unused struct amd_uncore_ctx::node member
Date: Tue, 17 Jun 2025 17:19:31 +0200
Message-ID: <20250617152419.744206037@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandipan Das <sandipan.das@amd.com>

[ Upstream commit 4f81cc2d1bf91a49d33eb6578b58db2518deef01 ]

Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/30f9254c2de6c4318dd0809ef85a1677f68eef10.1744906694.git.sandipan.das@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/uncore.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 0bfde2ea5cb8c..675250598c324 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -38,7 +38,6 @@ struct amd_uncore_ctx {
 	int refcnt;
 	int cpu;
 	struct perf_event **events;
-	struct hlist_node node;
 };
 
 struct amd_uncore_pmu {
-- 
2.39.5




