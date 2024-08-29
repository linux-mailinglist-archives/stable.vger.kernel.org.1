Return-Path: <stable+bounces-71493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89182964726
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 15:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B626E1C22D39
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E316C1AD9FA;
	Thu, 29 Aug 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IX5x5UA/"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDECE18A6BA
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939268; cv=none; b=IH9OjZwsHs23Mk5rlFqT9Wo3OvDLapNqwTZfbM41qnIzjLEHJi0abl1Pp+8LUaSzEf/KRbfb0zhkpgOv+HLikZmTJw+fvkrO58uU9vZ5dE18x2U+cDQlXm8KrHtQ82Oj0ewhRnPnpdi2cNHCxr2RIwGPov7QP856zPkNofzm+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939268; c=relaxed/simple;
	bh=9/qsUPlO5K7yrofGhntGQI96D0VJzEdc1WdXal/vsZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dHnE5ICEqomkT2yiFrhux4w/YBlwzUeSrO0skuWEU68xHtmZcL4jafhoG1Vw9WOjb9WlMTXgN/mDmeg/GYFTCBZL/pmWnqnxs6arJLshGV4FmMiqtC+uTWGrNVVvemLfhgk8u/2YltxIAES7NEnbLmzZovOT/CvfVUN36Yzuugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IX5x5UA/; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Bz7l7
	NslpcIAwMXFVMWDIfaHQI4+rHosu7GgZej/Hnw=; b=IX5x5UA/FuosMb4ZsBlvf
	LwE4sQviZ4wB0a1EhxaQ+mLCKlHRpRGGAx1n/degzj9NJ9EQ9pVFd5rDPuKY97uW
	//a2Y8EjVwk8jgvlLbZm8kMqJezrzfPFn9f4LCjkkoqljmAAWBuPdN3wxzzTBpCR
	VsYjqe/yXwPZQsbTZAcQWU=
Received: from iZbp1asjb3cy8ks0srf007Z.. (unknown [120.26.85.94])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wDn75Xje9BmnN+kAg--.15540S2;
	Thu, 29 Aug 2024 21:47:16 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: qianqiangliu@hotmail.com
Cc: Stefan Berger <stefanb@linux.ibm.com>,
	stable@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support
Date: Thu, 29 Aug 2024 21:47:11 +0800
Message-Id: <20240829134711.247179-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn75Xje9BmnN+kAg--.15540S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XF43ArWxAryDuw1xKrWxWFg_yoW8JrWfpw
	4kWas8Cr4rXr48J39rJw1vkF9Igas5KFW7KrZrA3sruw1qkas09FyxCryxuFyDtrW8GF4r
	ZaykKr1UuFyUZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jME__UUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYAlKamV4I4WdKAAAsH

From: Stefan Berger <stefanb@linux.ibm.com>

Commit d2add27cf2b8 ("tpm: Add NULL primary creation") introduced
CONFIG_TCG_TPM2_HMAC. When this option is enabled on ppc64 then the
following message appears in the kernel log due to a missing call to
tpm2_sessions_init().

[    2.654549] tpm tpm0: auth session is not active

Add the missing call to tpm2_session_init() to the ibmvtpm driver to
resolve this issue.

Cc: stable@vger.kernel.org # v6.10+
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index d3989b257f42..1e5b107d1f3b 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -698,6 +698,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 		rc = tpm2_get_cc_attrs_tbl(chip);
 		if (rc)
 			goto init_irq_cleanup;
+
+		rc = tpm2_sessions_init(chip);
+		if (rc)
+			goto init_irq_cleanup;
 	}
 
 	return tpm_chip_register(chip);
-- 
2.39.2


