Return-Path: <stable+bounces-72780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DA3969739
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068382852DC
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B383A21C17E;
	Tue,  3 Sep 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IByCM5gE"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002621C160
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352546; cv=none; b=LFmFRDhD0Sdgj3qNv/a3SLVNL+vekIox8MaTCDaYip3KkJAK41tNW9BFqWEZ2N7jNmzVBrVS8rKPQ8M4hJ1ASPWEL905EaSVF7rIQbGgA/PYgGBGrOwI37SOqVmTlHqTgFsGWO0QCt4u0KzxwFK9ibj6cVr6FSrxJgRZuFNu5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352546; c=relaxed/simple;
	bh=ziUG70faR0quCW/2FgjfDs/hgpCgYjzxYf77513XEQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TvbxoVCMOz+2onWAFyBOBy06u1t3Id5CuQxPoYjhNCU6YWkDr5bwDXrpq8PZpa/otV3sixGupvnUOSHUG+lTo8s5hNCoTWozI4MBEIZsiVdzcaXR7MrLFiJfzIbkNlNRz8Z+jyeWrlPi+Rv9ex++0G9mIR4d87iHn/XBQbSABps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IByCM5gE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725352543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IomLyH4785d5OQRSi6Z9hL3WWNcAfSNhIiGUhUVIycc=;
	b=IByCM5gEBM2ghmGC/YpRXxfO1/+g/NQeXwJYd8ueq4Lf0uLdkjdJFNsjIUSl20hZrA8npq
	sn6csXD4Rz6nRbZv9ktABaMj0N+1hZAjX8t0PHR8XDui5yNYVR0mtjQ7fFkgXxm09gnkCB
	y5I7JzZizBec8saFheXB0sTls2oWCAA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-Z6A0bKYaPGWYnVQSK0hL6g-1; Tue,
 03 Sep 2024 04:35:42 -0400
X-MC-Unique: Z6A0bKYaPGWYnVQSK0hL6g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96D041955F06;
	Tue,  3 Sep 2024 08:35:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.239])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C0811956048;
	Tue,  3 Sep 2024 08:35:39 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	James Harmison <jharmison@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: panasonic-laptop: Check minimum SQTY value
Date: Tue,  3 Sep 2024 10:35:31 +0200
Message-ID: <20240903083533.9403-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The panasonic laptop code in various places uses the sinf array with index
values of 0 - SINF_CUR_BRIGHT(0x0d) without checking that the sinf array
is big enough.

Check for a minimum SQTY value of SINF_CUR_BRIGHT to avoid out of bounds
accesses of the sinf array.

Note SQTY returning SINF_CUR_BRIGHT is ok because the driver adds one extra
entry to the sinf array.

Fixes: e424fb8cc4e6 ("panasonic-laptop: avoid overflow in acpi_pcc_hotkey_add()")
Cc: stable@vger.kernel.org
Tested-by: James Harmison <jharmison@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/panasonic-laptop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index cf845ee1c7b1..d7f9017a5a13 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -963,8 +963,8 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 
 	num_sifr = acpi_pcc_get_sqty(device);
 
-	if (num_sifr < 0 || num_sifr > 255) {
-		pr_err("num_sifr out of range");
+	if (num_sifr < SINF_CUR_BRIGHT || num_sifr > 255) {
+		pr_err("num_sifr %d out of range %d - 255\n", num_sifr, SINF_CUR_BRIGHT);
 		return -ENODEV;
 	}
 
-- 
2.46.0


