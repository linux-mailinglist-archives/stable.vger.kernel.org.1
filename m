Return-Path: <stable+bounces-175193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F658B36702
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BD38E26A4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A1345758;
	Tue, 26 Aug 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t42UOjyP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD20A350845;
	Tue, 26 Aug 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216386; cv=none; b=UpvsBIPj7aBZ1ZAtAMXVKFVyaAFq7JbuxqiZSeDijDNZ5Nck/DaT3wqBV0AL2ccfo5rRYaHQ4FaNsICLQs8DmdH5GzwuIzZMk0wGVg5MJlQ+1A5Fj2vROF6v3UoVLgWic/ca1oIu67hKDovPl0LzCythh7imEJj0c8F9ZhR6dCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216386; c=relaxed/simple;
	bh=lqDitbajTS+g2KovjbqsVK5HiXWRmWNkozmNdSlqUrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oytQGFePMzU6BYP8yKZ0KeGDuHKVApAhtrKWuZdBnE8aGCnXREfMl6dlkNVOuSnN57rmsKJZkhFnK7H9+QnGoLlMiC8CDF9ipMZgPP+zWY/Jev67JfCfyLM0rKMDqyWToItGR9W4JVwEd5QfthmvPJIiuxc7vXaOHZgfZLGI/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t42UOjyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4F1C4CEF1;
	Tue, 26 Aug 2025 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216386;
	bh=lqDitbajTS+g2KovjbqsVK5HiXWRmWNkozmNdSlqUrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t42UOjyPrfBSx8R4DcfBKkB13bmr9SjmRhjAwJCVHaTJyF9n/HCJfvWvCKScClZ5t
	 aWR6MX0qsSBHDdA3nMYTvOEem9Nvn35Ggh0Ng8Pd20gtD6eSSaqgwGdDGiXkIeAkBH
	 f52lqDgOGpE1U60H2U6Gvp9026kkbhdkTHi1Wwjc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shiji Yang <yangshiji66@outlook.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 390/644] MIPS: vpe-mt: add missing prototypes for vpe_{alloc,start,stop,free}
Date: Tue, 26 Aug 2025 13:08:01 +0200
Message-ID: <20250826110956.106184827@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shiji Yang <yangshiji66@outlook.com>

[ Upstream commit 844615dd0f2d95c018ec66b943e08af22b62aff3 ]

These functions are exported but their prototypes are not defined.
This patch adds the missing function prototypes to fix the following
compilation warnings:

arch/mips/kernel/vpe-mt.c:180:7: error: no previous prototype for 'vpe_alloc' [-Werror=missing-prototypes]
  180 | void *vpe_alloc(void)
      |       ^~~~~~~~~
arch/mips/kernel/vpe-mt.c:198:5: error: no previous prototype for 'vpe_start' [-Werror=missing-prototypes]
  198 | int vpe_start(void *vpe, unsigned long start)
      |     ^~~~~~~~~
arch/mips/kernel/vpe-mt.c:208:5: error: no previous prototype for 'vpe_stop' [-Werror=missing-prototypes]
  208 | int vpe_stop(void *vpe)
      |     ^~~~~~~~
arch/mips/kernel/vpe-mt.c:229:5: error: no previous prototype for 'vpe_free' [-Werror=missing-prototypes]
  229 | int vpe_free(void *vpe)
      |     ^~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/vpe.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
index ef7e07829607..0094709b617d 100644
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -123,4 +123,12 @@ void cleanup_tc(struct tc *tc);
 
 int __init vpe_module_init(void);
 void __exit vpe_module_exit(void);
+
+#ifdef CONFIG_MIPS_VPE_LOADER_MT
+void *vpe_alloc(void);
+int vpe_start(void *vpe, unsigned long start);
+int vpe_stop(void *vpe);
+int vpe_free(void *vpe);
+#endif /* CONFIG_MIPS_VPE_LOADER_MT */
+
 #endif /* _ASM_VPE_H */
-- 
2.39.5




