Return-Path: <stable+bounces-175741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 124A2B369E1
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875E21C42856
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE67D34DCDA;
	Tue, 26 Aug 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qrxW8oPE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA962F49EA;
	Tue, 26 Aug 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217847; cv=none; b=iwIycntL99LQXpUsm829FEUZ8s37gOmbu5747EZUoEzjXgHTyajA0iV+PtDxmGB0m3tGhcvniANegg8tJBlLLd8QPSeBhWXZN1yW1JLXaSt73lgxbAdGK7UeJYcPybe1cvuNFjmQU3MoD+0oGZGAJ4uu6jHlImkN7ZUBagEEWZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217847; c=relaxed/simple;
	bh=afsK6eidVQpEyg4co3W1Al3/2yq3VZ5Bysz3JnCvNTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJFoatZfBZNgXndOnJdgAcpjzns6eygKqE3Zk1CUYNiticSAmLCTI5dUyepVP57neg/UhpbfjxNXaI2vBQqqhhhm7x5ec/QBKolaDfqUep891TGbKQ92ehlqQWUmNneinNfWh7jSvOmLmjSRMwun5206tehQp6Te9BBWuBMbqyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qrxW8oPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11058C4CEF1;
	Tue, 26 Aug 2025 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217847;
	bh=afsK6eidVQpEyg4co3W1Al3/2yq3VZ5Bysz3JnCvNTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrxW8oPEnFMJxXNVvfL3jCMpyvzSvhsnd+opZgc+E6FYnZ7NIk9Ipci4uXlWt4GiQ
	 ci/6xUe08DUYPeRcxV1rPPkpVrlSk3ab0/h6aXBAjcVw/zm+h/6wl7/mc+0S6LjRyu
	 mjayJEI+Z1lStP5xFwviupMFt30noZmSOQTjogtY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shiji Yang <yangshiji66@outlook.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 296/523] MIPS: vpe-mt: add missing prototypes for vpe_{alloc,start,stop,free}
Date: Tue, 26 Aug 2025 13:08:26 +0200
Message-ID: <20250826110931.750152283@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 012731546cf6..3de6b0ff1627 100644
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -126,4 +126,12 @@ void cleanup_tc(struct tc *tc);
 
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




