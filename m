Return-Path: <stable+bounces-167105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C19B21F76
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 09:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C482A50673F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57E32DEA62;
	Tue, 12 Aug 2025 07:25:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334892DE709;
	Tue, 12 Aug 2025 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983526; cv=none; b=FMiR+P+ALeHrPp9Sjpqr5vyngFvMWHz43URjK+KQomA9HsxoRA3gRYEBxjGaG9eu+oDtLyd+B+VxUOpxyHupq0TrNcM+W8v6mzByA1KhZqaTbss6wBQnLZfIj1vLTMbmw25rKVWgtysCBXS0VRtJucAXTdFEHfoQum9PgWMn1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983526; c=relaxed/simple;
	bh=oxBpnBaSb18ZCmhI9DN1neCWkluARg45MSJPHMp2Pm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mMIY/9mvRxRLI+ZE7jvDQxoRhUj5J3iT3uZMDnJ0+q2YwoNNm6JXlRLadNHOPqH28l+N8wEEMyvKNG6m6+sXCTiKxQsCe/aIJSFmtERONLp69dLSgvTCOmaTVah4c+I1ISYPOiWY42+bzv8xChhV5sRZdF5XArV+OuJf6bFYG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [211.71.28.34])
	by APP-03 (Coremail) with SMTP id rQCowAD3hnhW7Jpowe4mCw--.10002S2;
	Tue, 12 Aug 2025 15:25:21 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: linux@dominikbrodowski.net,
	make24@iscas.ac.cn
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] pcmcia: Fix a NULL pointer dereference in __iodyn_find_io_region()
Date: Tue, 12 Aug 2025 15:25:09 +0800
Message-Id: <20250812072509.472061-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3hnhW7Jpowe4mCw--.10002S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1fXw17Kr17GrWDKrWDtwb_yoWDArc_WF
	10gr97Gr4jqr4Ikw42yrsakr9a9rn3ur1xWFn3ta4fur9Fvw13uF1fJryDXw1xJrn3JF1k
	AF9rJr13u3ZF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUaiihUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In __iodyn_find_io_region(), pcmcia_make_resource() is assigned to
res and used in pci_bus_alloc_resource(). There is a dereference of res
in pci_bus_alloc_resource(), which could lead to a NULL pointer
dereference on failure of pcmcia_make_resource().

Fix this bug by adding a check of res.

Found by code review, complie tested only.

Cc: stable@vger.kernel.org
Fixes: 49b1153adfe1 ("pcmcia: move all pcmcia_resource_ops providers into one module")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/pcmcia/rsrc_iodyn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pcmcia/rsrc_iodyn.c b/drivers/pcmcia/rsrc_iodyn.c
index b04b16496b0c..2677b577c1f8 100644
--- a/drivers/pcmcia/rsrc_iodyn.c
+++ b/drivers/pcmcia/rsrc_iodyn.c
@@ -62,6 +62,9 @@ static struct resource *__iodyn_find_io_region(struct pcmcia_socket *s,
 	unsigned long min = base;
 	int ret;
 
+	if (!res)
+		return NULL;
+
 	data.mask = align - 1;
 	data.offset = base & data.mask;
 
-- 
2.25.1


