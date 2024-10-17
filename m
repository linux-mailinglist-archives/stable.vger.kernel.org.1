Return-Path: <stable+bounces-86673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC79A2BCE
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7165B270C6
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 18:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EF11E0DE3;
	Thu, 17 Oct 2024 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpL3XeR1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4FE1E0085
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188635; cv=none; b=tB2u50tgW+P2PbBLvr0eSAYtg4NdQ7eyg5G+Y8xDjFwUe61G9GOSz1v4hn+5jNKFI+eEbKNE0y9LUfGuLOe4NCJS8HePME+G3jRlbebfLVAmecMDqWayQxkCcZwYRpAuDgQL97bDCyAA3T3a+aX8rLmmSfHq1akEncuWuBeiF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188635; c=relaxed/simple;
	bh=X8y7Fv4b6J/JXVU9Vq9ppReQ4Z4hZMrLILfZPGMDkCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYAY3xITJbyErNVGnTTkUDwBePBlCFVejUMVwISh4inW2B5ZkH7X8O6qKFA10hlJp9gWPATuhcXGLm2nEeGJED14td1Tk6WAZrp5TTU6xjIpoUr8xLFODsD1bHzlg9vvqsEHK7rHkbEUdID9sOzC68mh1XcZuWBN+DDxVSxDFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpL3XeR1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729188633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDNf5bi3twqEz+hgY2kMChRHbeH1tAYHf98OMmN/pYw=;
	b=bpL3XeR1ivo3qD+zW/QUUEhlV0KgguXmxmGjihKzYyQwqjQ8+8w2/LiVrCWBTB/L9tZh+4
	bnSkVmCJMVNtqO+DpwmWTv+OCUhgFyW/c235nwWO/yAGuv1T5LkvZl3Q0dgip9jNTPBzfE
	B0HraVt1BYdfUoI9zgQ5waM0TtIvbzg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-6bZPmiw7PDmBCipasXQD2Q-1; Thu,
 17 Oct 2024 14:10:31 -0400
X-MC-Unique: 6bZPmiw7PDmBCipasXQD2Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9C7C195609E;
	Thu, 17 Oct 2024 18:10:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.106])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 550101956086;
	Thu, 17 Oct 2024 18:10:27 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jtornosm@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] wifi: ath12k: fix crash when unbinding
Date: Thu, 17 Oct 2024 20:07:31 +0200
Message-ID: <20241017181004.199589-2-jtornosm@redhat.com>
In-Reply-To: <20241017181004.199589-1-jtornosm@redhat.com>
References: <20241017181004.199589-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

If there is an error during some initialization related to firmware,
the function ath12k_dp_cc_cleanup is called to release resources.
However this is released again when the device is unbinded (ath12k_pci),
and we get:
BUG: kernel NULL pointer dereference, address: 0000000000000020
at RIP: 0010:ath12k_dp_cc_cleanup.part.0+0xb6/0x500 [ath12k]
Call Trace:
ath12k_dp_cc_cleanup
ath12k_dp_free
ath12k_core_deinit
ath12k_pci_remove
...

The issue is always reproducible from a VM because the MSI addressing
initialization is failing.

In order to fix the issue, just set to NULL the released structure in
ath12k_dp_cc_cleanup at the end.

cc: stable@vger.kernel.org
Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v4:
  - Send with cover letter to get reference with 2/2
v3: https://lore.kernel.org/linux-wireless/20241017074654.176678-1-jtornosm@redhat.com/
v2: https://lore.kernel.org/linux-wireless/20241016123452.206671-1-jtornosm@redhat.com/
v1: https://lore.kernel.org/linux-wireless/20241010175102.207324-2-jtornosm@redhat.com/

 drivers/net/wireless/ath/ath12k/dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 61aa78d8bd8c..789d430e4455 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1241,6 +1241,7 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 	}
 
 	kfree(dp->spt_info);
+	dp->spt_info = NULL;
 }
 
 static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
-- 
2.46.2


