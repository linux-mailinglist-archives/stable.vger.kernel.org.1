Return-Path: <stable+bounces-95876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EEA9DF1E0
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 16:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58525281860
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7381A0B15;
	Sat, 30 Nov 2024 15:58:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092119F121;
	Sat, 30 Nov 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732982320; cv=none; b=EVWy4abNa+oGTl7UjAJaz2cUvY2ltbaprFSzbwDW503rvC/TXS5madmHflNK2OGUWKv07FSMSGnwsaTNPmpmBOcwvzLNdYpIVyTfRYABs4CIqWqq1boYZv2J/JrdnffBxLrs4kpiXsftBrshpG+923qD+btAfXU63mZ/jsNvbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732982320; c=relaxed/simple;
	bh=QB2pgRiEozv5EyxJd4OxPbhE4bEoMNsWkZ36wINZSLw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K4av49kTu9JdYTZaEuCGSQH41IXsAtyHfpLS+IH135562cqckie5Q+JXa8C3Se/ulFg8IJTPD1Pf221N4m8ZM9Q6vxeX70LWPfwB5VQvvRx4zt3UhSCEm16BoU37fMZGBVQzwIMpOCU13TNO955MRdD6ci7Y7HsZcHpWiL0kzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sat, 30 Nov
 2024 18:58:33 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 30 Nov
 2024 18:58:33 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, <ntfs3@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 6.1.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Sat, 30 Nov 2024 07:58:25 -0800
Message-ID: <20241130155825.30829-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb ]

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
[Nikita: Fix for CVE-2024-27407 in 6.1.y. No changes were made
to get it to apply to older branch.]
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 fs/ntfs3/record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 7ab452710572..826a756669a3 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -273,7 +273,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		if (t16 > asize)
 			return NULL;
 
-		if (t16 + le32_to_cpu(attr->res.data_size) > asize)
+		if (le32_to_cpu(attr->res.data_size) > asize - t16)
 			return NULL;
 
 		if (attr->name_len &&
-- 
2.25.1


