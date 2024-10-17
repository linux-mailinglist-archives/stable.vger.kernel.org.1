Return-Path: <stable+bounces-86580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1376F9A1BEF
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 09:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EEBF1C24CF8
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 07:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAD41D2B15;
	Thu, 17 Oct 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ctd/BtQ5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE11D26E8
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151230; cv=none; b=tS5iAonWRA/6xVgzgIlkAMosiCYGo7coUvZakzHwKFXdMFXzaEK1NW8TFWSEHDnTNUf80MphsksdXLt9OpZ00WukNYVEg/t1+3n8Fg7UK0oNKX3dnaX/I7P1G3NY9ZFT8qVEkmSE3zaQZiIwtJJiXvz6MNpTvYYmiqvtZV3xcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151230; c=relaxed/simple;
	bh=BciklybZy7CwsodV1J+FHbLak2bcBG+EA9zVeiHIUZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKBN6PGLeKuYkc9kNqlrF4eVE7Vt7izjyc///Fmzvsq6dZ4rapI/HLnzQ3+CBHO3/IKwq0SccbKAnocnB+jAI5I9fHPzwcyUdk4CmJLvMKCFcxydA8yFkydueJzjSj+b3wSDv3fRik53SEnDWgKUhb42KLlf6rbMSA6XKQTyFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ctd/BtQ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729151228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QvbMmE2srGF798/Jy+9JBC3NRkx6cG+PNhzrzhRPIPw=;
	b=Ctd/BtQ5KkEytMyfMWZEw3/7Iaje0CwS1r1/z76U1mT9RoD+9HJidw7vgUvo+NKOK9E8rG
	0QpFlKyM30fruzjrTl7ZimxSfooqACfzljv8Lxm82zacXGFNlWUBGKxl6fHqSVQrzfWLz5
	eH1+f/bMRtFeTmYoX5KuCOjY8GTuEnY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-l1Ymol9FNQqdY6Tsc_4KNw-1; Thu,
 17 Oct 2024 03:47:02 -0400
X-MC-Unique: l1Ymol9FNQqdY6Tsc_4KNw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DEB419560A5;
	Thu, 17 Oct 2024 07:47:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.60.16.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C0F630001A3;
	Thu, 17 Oct 2024 07:46:58 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jtornosm@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] wifi: ath12k: fix crash when unbinding
Date: Thu, 17 Oct 2024 09:46:31 +0200
Message-ID: <20241017074654.176678-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
v3:
  - Trim backtrace.
  - Fix typos.
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


