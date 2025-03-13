Return-Path: <stable+bounces-124338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDFFA5FB23
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 17:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481ED7A1523
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92CF267F77;
	Thu, 13 Mar 2025 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QXmDySli"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149472E3392
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882648; cv=none; b=hdQHXqlLp9G1o9fStGohXS+Puw6yyvQ2f4GonfX8uUEhQlTUrwPgGX6Pjt4GR5y7mSUjy0Vnctjti08iIlS8yXV/6r6vX7o4Cwv/Imc0wmbB4lJt92Y5g5wsv6fCR1Fsaavnok5vYU02ZD1YxD043m2RXEphLDrnx9mOyJWVvQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882648; c=relaxed/simple;
	bh=gBTsSnCw5aiSnXbci4tqxzjS0QLazuMCsdhg6NDAVGE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TFrq7Kv37bsLcYlWv1AAXLySzxZSZO1ra4pnaGDEiOhXF3ZIXdxFz8OSlKu6hf57dQj7irVT8oXlFtug+DGUjTU6igHJCdCgFSBWijN0fM+8ZAPnLH5daf0e5mg3pskWXNYlF3fie0mpiTvWfjy5RaRHM9mGKIfTygyebN/vDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QXmDySli; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741882647; x=1773418647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wo0O/mtSBhHwtwsSpWzLsxT6ph7/MWem1t9/3tK+oic=;
  b=QXmDySlio450cceH7PKW33QOj7u6UGyEIGLTDZ58Y28IWypqDjRub9EO
   2p3cDoB+9K83cGHOmVkMQg4BGE3YnUVOXPzcXCSLmuTtc2CzoIxkuSE9z
   fFJnPTlNBLba6MsmjK48+RwI+qe1ab7VWMp5jRnDnO29uV3gBZpwAHvxx
   w=;
X-IronPort-AV: E=Sophos;i="6.14,245,1736812800"; 
   d="scan'208";a="1010152"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 16:17:14 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:6301]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.47:2525] with esmtp (Farcaster)
 id ca8e1e1c-5102-4197-9dd8-f399aa084cc6; Thu, 13 Mar 2025 16:17:13 +0000 (UTC)
X-Farcaster-Flow-ID: ca8e1e1c-5102-4197-9dd8-f399aa084cc6
Received: from EX19D016EUA004.ant.amazon.com (10.252.50.4) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 16:17:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D016EUA004.ant.amazon.com (10.252.50.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 16:17:12 +0000
Received: from email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 16:17:12 +0000
Received: from dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com (dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com [10.13.243.223])
	by email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com (Postfix) with ESMTPS id 0D3CAC0535;
	Thu, 13 Mar 2025 16:17:10 +0000 (UTC)
From: Abdelkareem Abdelsaamad <kareemem@amazon.com>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>, "Richard
 Cochran" <richardcochran@gmail.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Abdelkareem Abdelsaamad
	<kareemem@amazon.com>
Subject: [PATCH 5.10.y 5.15.y] ptp: Ensure info->enable callback is always set
Date: Thu, 13 Mar 2025 16:17:02 +0000
Message-ID: <20250313161702.74223-1-kareemem@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

commit fd53aa40e65f518453115b6f56183b0c201db26b upstream.

The ioctl and sysfs handlers unconditionally call the ->enable callback.
Not all drivers implement that callback, leading to NULL dereferences.
Example of affected drivers: ptp_s390.c, ptp_vclock.c and ptp_mock.c.

Instead use a dummy callback if no better was specified by the driver.

Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Link: https://patch.msgid.link/20250123-ptp-enable-v1-1-b015834d3a47@weissschuh.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Conflict due to
42704b26b0f1 ("ptp: Add cycles support for virtual clocks")
not in the tree]
Signed-off-by: Abdelkareem Abdelsaamad <kareemem@amazon.com>
---
 drivers/ptp/ptp_clock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 4d775cd8ee3c..c895e26b1f17 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -188,6 +188,11 @@ static void ptp_clock_release(struct device *dev)
 	kfree(ptp);
 }
 
+static int ptp_enable(struct ptp_clock_info *ptp, struct ptp_clock_request *request, int on)
+{
+	return -EOPNOTSUPP;
+}
+
 static void ptp_aux_kworker(struct kthread_work *work)
 {
 	struct ptp_clock *ptp = container_of(work, struct ptp_clock,
@@ -233,6 +238,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	mutex_init(&ptp->pincfg_mux);
 	init_waitqueue_head(&ptp->tsev_wq);
 
+	if (!ptp->info->enable)
+		ptp->info->enable = ptp_enable;
+
 	if (ptp->info->do_aux_work) {
 		kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
 		ptp->kworker = kthread_create_worker(0, "ptp%d", ptp->index);
-- 
2.47.1


