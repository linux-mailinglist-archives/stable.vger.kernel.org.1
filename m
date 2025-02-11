Return-Path: <stable+bounces-114791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FC8A30099
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013941883978
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8F21F7075;
	Tue, 11 Feb 2025 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPV/OpVK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD821F560D;
	Tue, 11 Feb 2025 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237507; cv=none; b=hQvDraOg9+i3Xg+nyfDCp5TPJBz50XQvnsP+LyBODGoKu/j+jfrRReZfEJ/OR1atWzAuHIuiQdXYSYBy9KyhJX3QYrwcqEm+eglJv6bC9vDX6zaJoR8tcLyRggVJCHfD+H+OJaWidl8Gp1TWUcJbQYUxoC0It+8tarbqTOaKYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237507; c=relaxed/simple;
	bh=n+osBj6Upb51Pt/VXXopU94SryNtIsoSq6/ehsPDblg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swU8d64H1WQ9HehKU+yOU6xtvbKeLXTSGKdyLSNXlzKOKJYZaONgcOFVkLXOR2sunF+N+sVuI0YYusq5s8L7gley30ykSvUPxEC1JpDCO9gcj9z8xRlb0+oitdrbgO7mM82bn1GUyWw59/h4HcO9n4XouEHu9iZmXex60Bw+1Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPV/OpVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00604C4CEDF;
	Tue, 11 Feb 2025 01:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237507;
	bh=n+osBj6Upb51Pt/VXXopU94SryNtIsoSq6/ehsPDblg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPV/OpVKZxMHRAR8Bv/ynWOceFZNDlXMQ5uOTXvTJ/JuCfedgsaVrKpsITbwbSDHa
	 FCbvid3utK5j8LJV8vjWf73EI9XV9oaaGh87ji0dGXc/rzk+HRiJza7+GyW0zqyDAV
	 xNkKXgssAh0X9i5iM03q+fbUK8/VilTUM3KZDA3z/iGEqzT4SulcHMXZY9IlK11mmm
	 AK3bKg3Igfp/7/FKgQyKI2z6HaocGIjMKi94g5xQcHMNbyh9TPG8vEOZaRuif0CoU6
	 ld+6ENK+smEnsZHmioYwyvBMPgNRE+tiWQN69F+gowHO4T3hBXBWZRe/eduizhdMBK
	 1OabJWxZgp7zA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/15] platform/x86/intel: pmc: fix ltr decode in pmc_core_ltr_show()
Date: Mon, 10 Feb 2025 20:31:27 -0500
Message-Id: <20250211013136.4098219-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013136.4098219-1-sashal@kernel.org>
References: <20250211013136.4098219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.76
Content-Transfer-Encoding: 8bit

From: Dmitry Kandybka <d.kandybka@gmail.com>

[ Upstream commit 583ef25bb2a094813351a727ddec38b35a15b9f8 ]

In pmc_core_ltr_show(), promote 'val' to 'u64' to avoid possible integer
overflow. Values (10 bit) are multiplied by the scale, the result of
expression is in a range from 1 to 34,326,183,936 which is bigger then
UINT32_MAX. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
Reviewed-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20250123220739.68087-1-d.kandybka@gmail.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/pmc/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 022afb97d531c..2fb73e924bd64 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -620,8 +620,8 @@ static u32 convert_ltr_scale(u32 val)
 static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	u64 decoded_snoop_ltr, decoded_non_snoop_ltr;
-	u32 ltr_raw_data, scale, val;
+	u64 decoded_snoop_ltr, decoded_non_snoop_ltr, val;
+	u32 ltr_raw_data, scale;
 	u16 snoop_ltr, nonsnoop_ltr;
 	int i, index, ltr_index = 0;
 
-- 
2.39.5


