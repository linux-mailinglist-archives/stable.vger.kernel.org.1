Return-Path: <stable+bounces-98560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FC99E45FC
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F2F285DB9
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A818F2EA;
	Wed,  4 Dec 2024 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZCxFF99"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575521531E8
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733344972; cv=none; b=shu9/xQG5ZrtwE3k3f1gzXl52uUn2EHanIODBmAHqgC/g/NT3c/ET4ZGGz929KeOLUaWZ6hnOO5I+oCmaWb4GPtYJH2DCW01G2KQIzMcg8+p9m2gkG1qHz7ASUJL0T/CekZElGoy/n1S9oleuQ1hpz6ndZSnnBAJcvB7H8tNh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733344972; c=relaxed/simple;
	bh=b0KUq2hBq2h1yRarubIm7P/LyMXZy+MJlXP7Voz62/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7KAU2DNBSCOHV+QdresI79PEwq06ltoDC5UR+rYZsZis9QS/ULVXl3XPuVz9F/KmF20FSVNmo848mGnq4qwC23k21r4vQpiUI8JD+gX4TlM6Lfls+EanmPbDjFSA3/6FafZAWBmOqKr0crkIV1HmnNIn2056C7ArkE6zgSdip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZCxFF99; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733344970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iE1za9z1DJw81fVOgnOIV9q0IUu9vwpwBBEeucKo+zA=;
	b=fZCxFF99onaNGHU+GFpnG2eQTe6x3Uv5NRZvv7nmHcCwIXWJ87oTCNudZrvu80c8Kx19KJ
	Kc3Y2yl9989ahNCboIZ/BG70T1/ws6GgAKSKdhWLsMZGoqBJGYS7t5qUi7iOVVD7ZV32BZ
	deQyNnboPa5jDWtXOvLk/mSu6N08Kb8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-xbSKEkjvN0S4-JhjleNyAg-1; Wed,
 04 Dec 2024 15:42:46 -0500
X-MC-Unique: xbSKEkjvN0S4-JhjleNyAg-1
X-Mimecast-MFC-AGG-ID: xbSKEkjvN0S4-JhjleNyAg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7792019560A2;
	Wed,  4 Dec 2024 20:42:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.11])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E18DC1956094;
	Wed,  4 Dec 2024 20:42:42 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/8] platform/x86: serdev_helpers: Check for serial_ctrl_uid == NULL
Date: Wed,  4 Dec 2024 21:42:14 +0100
Message-ID: <20241204204227.95757-4-hdegoede@redhat.com>
In-Reply-To: <20241204204227.95757-1-hdegoede@redhat.com>
References: <20241204204227.95757-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

dell_uart_bl_pdev_probe() calls get_serdev_controller() with the
serial_ctrl_uid parameter set to NULL.

In case of errors this NULL parameter then gets passed to pr_err()
as argument matching a "%s" conversion specification. This leads to
compiler warnings when building with "make W=1".

Check serial_ctrl_uid before passing it to pr_err() to avoid these.

Fixes: dc5afd720f84 ("platform/x86: Add new get_serdev_controller() helper")
Cc: stable@vger.kernel.org
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/serdev_helpers.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/serdev_helpers.h b/drivers/platform/x86/serdev_helpers.h
index bcf3a0c356ea..3bc7fd8e1e19 100644
--- a/drivers/platform/x86/serdev_helpers.h
+++ b/drivers/platform/x86/serdev_helpers.h
@@ -35,7 +35,7 @@ get_serdev_controller(const char *serial_ctrl_hid,
 	ctrl_adev = acpi_dev_get_first_match_dev(serial_ctrl_hid, serial_ctrl_uid, -1);
 	if (!ctrl_adev) {
 		pr_err("error could not get %s/%s serial-ctrl adev\n",
-		       serial_ctrl_hid, serial_ctrl_uid);
+		       serial_ctrl_hid, serial_ctrl_uid ?: "*");
 		return ERR_PTR(-ENODEV);
 	}
 
@@ -43,7 +43,7 @@ get_serdev_controller(const char *serial_ctrl_hid,
 	ctrl_dev = get_device(acpi_get_first_physical_node(ctrl_adev));
 	if (!ctrl_dev) {
 		pr_err("error could not get %s/%s serial-ctrl physical node\n",
-		       serial_ctrl_hid, serial_ctrl_uid);
+		       serial_ctrl_hid, serial_ctrl_uid ?: "*");
 		ctrl_dev = ERR_PTR(-ENODEV);
 		goto put_ctrl_adev;
 	}
-- 
2.47.0


