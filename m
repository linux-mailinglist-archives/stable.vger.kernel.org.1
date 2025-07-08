Return-Path: <stable+bounces-161304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C26AFD4BA
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83288543DA3
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601982E6D03;
	Tue,  8 Jul 2025 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mwLuhXiu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD1E2E62D9;
	Tue,  8 Jul 2025 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994186; cv=none; b=uJqAzh+ZoYvwI9dbiQHWIUQjGXIAIS/LUGuC4eoxVI2cqyIil6eEnNOFrtW2e6e5ETIyJQ4DEgfgRLo3T+h5xOzhZRgiQJ8pg/vjoqmzAPlKhFejjPI8OC3/bbGzlSj3yrolQSeooWvo4HUsvtP+1D2nbXmx1cDn0Y/DoVPJ8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994186; c=relaxed/simple;
	bh=pBNVMiHu0LsrR/PcyF4ntwpKeNE32c7Jid2KmCpKaLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNcF9gZAAm9EVxqfH4SxR2ogJh1AoVVQ0gZMPkPSE4boKOgPTxCY4PnP1olWpB0r6NPzA/7IASyQXzBD5jjSWxtemXqgPz6zU1PAQe2PTbxYCykkH0MX+oTj57jQgk3cN0CfTZfp4DKFwp87RVzeMy1sfUUgr7GEAHlat3WWhh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mwLuhXiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96296C4CEED;
	Tue,  8 Jul 2025 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751994186;
	bh=pBNVMiHu0LsrR/PcyF4ntwpKeNE32c7Jid2KmCpKaLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mwLuhXiuSN1CONPfUwAoVg0trWwyGfXc5pmfcFcfaTu0/YR93lpRaK/Rxg/aMdve3
	 g1/JSiSoDFMLE/ko2dQwvgZqYQl8AfsheDe1kfbK5BUHaiC+gGHbDLglaW2Zoxi7CB
	 8Z6Jmhuwzao7Ij80+gw1jNiPQPbuymLSf+hGFmvA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 5.15 154/160] platform/x86: think-lmi: Create ksets consecutively
Date: Tue,  8 Jul 2025 18:23:11 +0200
Message-ID: <20250708162235.574003070@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
References: <20250708162231.503362020@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kurt Borja <kuurtb@gmail.com>

commit 8dab34ca77293b409c3223636dde915a22656748 upstream.

Avoid entering tlmi_release_attr() in error paths if both ksets are not
yet created.

This is accomplished by initializing them side by side.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250630-lmi-fix-v3-1-ce4f81c9c481@gmail.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/think-lmi.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -827,6 +827,14 @@ static int tlmi_sysfs_init(void)
 		goto fail_device_created;
 	}
 
+	tlmi_priv.authentication_kset = kset_create_and_add("authentication", NULL,
+							    &tlmi_priv.class_dev->kobj);
+	if (!tlmi_priv.authentication_kset) {
+		kset_unregister(tlmi_priv.attribute_kset);
+		ret = -ENOMEM;
+		goto fail_device_created;
+	}
+
 	for (i = 0; i < TLMI_SETTINGS_COUNT; i++) {
 		/* Check if index is a valid setting - skip if it isn't */
 		if (!tlmi_priv.setting[i])
@@ -863,12 +871,6 @@ static int tlmi_sysfs_init(void)
 			goto fail_create_attr;
 	}
 	/* Create authentication entries */
-	tlmi_priv.authentication_kset = kset_create_and_add("authentication", NULL,
-								&tlmi_priv.class_dev->kobj);
-	if (!tlmi_priv.authentication_kset) {
-		ret = -ENOMEM;
-		goto fail_create_attr;
-	}
 	tlmi_priv.pwd_admin->kobj.kset = tlmi_priv.authentication_kset;
 	ret = kobject_add(&tlmi_priv.pwd_admin->kobj, NULL, "%s", "Admin");
 	if (ret)



