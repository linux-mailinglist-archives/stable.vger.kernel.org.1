Return-Path: <stable+bounces-135057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663A8A960EA
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 10:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759F63BBCDF
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999E81EFFA6;
	Tue, 22 Apr 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="W/8gag7Z"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC521EF37A;
	Tue, 22 Apr 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745310117; cv=none; b=lwBR1jXPPWiu3jOnrJ3hiVIHue/gKmi9pqoNelPFyzqTl8dFOTkPo3QmhvOba3iFScRuj6IWqAtpsNA4cU/y9tyDrxE6pBmDUiXqEUzPwTHTVcm+/7evfe+4Hbrn2pvwa0CJR0B/TgR7IkF08yiV8jz6afftA/Kv//YtBYeQGv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745310117; c=relaxed/simple;
	bh=7hcHPGUjHgIqJWh8JfloOCfacNCsHEB3EZKSoBFwgoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iw07yDGF9KhgOWCACIm4ooNU/6dTexPddo7mzO7sexegBAB5fNASTjl8jhIj50vJ86hL5CrRDQp4/CgupM59V33ada/NU60M69/++ow3rhdvssuNaLdCcMAoQlkKbdCdQFiGn0Kd/7I4ZhMLJL+3K6oMEH5i1hsZM1kWihVAEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=W/8gag7Z; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1745310052;
	bh=JdsM9Qm5wZLMP/iGrG0PmmBZq7+rJ6WyAgG/IfufPuA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=W/8gag7ZfpcG9PrbC0TExEa6hiLwOqegZlBlXkWFuUTuCtMojjcH60oYNu910IMEE
	 FIY6/nl+peraUQc0sNSyUmjIGN953yk1vhU7NN7LPw5zhJSOObSihvQlDQyZy1V3z/
	 +CQQrl9fR8Hu/w7S/YgtjbcEjgBT+6VizNzGUXW0=
X-QQ-mid: zesmtpip2t1745310034t45cb9d0f
X-QQ-Originating-IP: /StdUmGbCyVKdK8oWoJJaynvgvySgpQ6RdugyU4ivcI=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Apr 2025 16:20:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17761032627602379019
EX-QQ-RecipientCnt: 10
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: chenhuacai@kernel.org,
	kernel@xen0n.name,
	wangyuli@uniontech.com,
	maobibo@loongson.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.1/6.6/6.12] LoongArch: Eliminate superfluous get_numa_distances_cnt()
Date: Tue, 22 Apr 2025 16:20:06 +0800
Message-ID: <BE39E39147C04E96+20250422082006.89643-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MyhNtuNETreeP8VLAhGlnYq1zn/+boQYvT84hWcM1khhfMesoKoJHeay
	OoO08Sb1a/D4O9Cs7+mbXPr7C+34RT56ZGSONcryEpk5cegxBcVFzsm/IDGJ0q+zTOzuNgF
	AKYtgj+2KYq1AKIsCTBKZqMryak2wmnZlIOtUpQ0P/iT3Cl1fa6EmGMnfCLMIYW+SlvOrjG
	knxLiRI+0PDc92XtqheOhUldK3Uj5GJIwrL4wmx67rHI+abrSVdUPX0E9r2DEv9TfKHODzq
	0x/YCbrAI1AHI02lztDRB3pMSFLwzjQhhC/CfDr9vJ4/zYQiC+VY0hw8Ab6iJqwiuKHYdyg
	bAxamuoxxznYvJV5EOeKVfJOyKtoZdL7oIHOYQ3ZRaSiDLlYMw80NsWjrvMqypAZrjxBIj8
	aX/bj5ATd44GPNIzFZLcc3+5huLj7hUIecPg6IDhr7faV7STBTz9C2oiTrqXlWJIgsF3NpY
	BhFeH5zEK+eZ34QbuMF9dfo7qZFLhSTtflYEx4DfXSkM3HjgxCy0w36y7hJP++HovIvbdAM
	qQoH6PtsdB8JK3DMhIE8Jr1dT57z3hRaIN8axYhNU7f/t8rThWifRFPCA3toSVqIHGGCKIf
	2QTLjh8sjVio6yaeMvg8ZewVbc1hMN5hC7HuVUb/j+PesLqCphTNbOazEWLZxzIeprauUzk
	DmyBdwpeIPXdAC1oUMh1C/5PAdTtij1ZJgaNl8Wt5WmDCvaxepcgEzUbixQaKWkwYKHYaMI
	EyktMf8vjOLyEFugOVIUUTL8ZxAEWwN+vUx5h+TBD2vTtznO3VxBJAlT+eaMArAJrIn9kgp
	GRG0/vtbO1fra6H5vHTBr1qwBJhMkEAaNMzTAsAF0rLOLfDbVQQfU+69BWQ5TXbyYs+eGhZ
	v6sl7og5poAFNc46HK7JQzGeCD5Klpu+PNlyQt8Evq12Z+Z8KEkpTWKhbkiyf6cY4Nj//ZA
	eo0NufC4zCzWJMLiXHix3AYUBTFj/WyFt43IuQLowhR30bvP/iunqakXPjEJb9jpKzxY=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

From: Yuli Wang <wangyuli@uniontech.com>

[ Upstream commit a0d3c8bcb9206ac207c7ad3182027c6b0a1319bb ]

In LoongArch, get_numa_distances_cnt() isn't in use, resulting in a
compiler warning.

Fix follow errors with clang-18 when W=1e:

arch/loongarch/kernel/acpi.c:259:28: error: unused function 'get_numa_distances_cnt' [-Werror,-Wunused-function]
  259 | static inline unsigned int get_numa_distances_cnt(struct acpi_table_slit *slit)
      |                            ^~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Link: https://lore.kernel.org/all/Z7bHPVUH4lAezk0E@kernel.org/
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/acpi.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 382a09a7152c..1120ac2824f6 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -249,18 +249,6 @@ static __init int setup_node(int pxm)
 	return acpi_map_pxm_to_node(pxm);
 }
 
-/*
- * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
- * I/O localities since SRAT does not list them.  I/O localities are
- * not supported at this point.
- */
-unsigned int numa_distance_cnt;
-
-static inline unsigned int get_numa_distances_cnt(struct acpi_table_slit *slit)
-{
-	return slit->locality_count;
-}
-
 void __init numa_set_distance(int from, int to, int distance)
 {
 	if ((u8)distance != distance || (from == to && distance != LOCAL_DISTANCE)) {
-- 
2.49.0


