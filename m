Return-Path: <stable+bounces-273925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HLO4LcAhVWpUkQAAu9opvQ
	(envelope-from <stable+bounces-273925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:34:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE174E0F4
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:34:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=UNRc07qe;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273925-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273925-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F334304508F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF7349CD9;
	Mon, 13 Jul 2026 17:33:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2F349CDC
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:33:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964004; cv=none; b=fNn2es0l7KCjjlyCwoepO5AEi/UwvdQ7E9xYDd3cIjdzI8bIH/jhDgw3M2IF2viFxsR89I0kDWBE70uwMHieWD2Z9RhzkJDvq0mpqt311aNeXzOEtOKE04wV5i6XOBZtNiiGKDh2Fbcn9In12heVx+8YJPfxrzvcyxpjFVGKeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964004; c=relaxed/simple;
	bh=DX4yD1fceAw1TE2YJq//fl5Ld5WZXHMoH7nz+I58P6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmRfQmTeBHKUjT6V+6At6oazUOQrYIBByzSD41OPWhRqjrAZ/GWD5O9NX0OGulrQIKfGvseobjDnl7hof4WLsOxwn9Zj9c7WJcOJMwbUXvko4jYfznBIaux5feWcdJ4h0Xg2yzqKI58//yDlIEaGb9Rwd5Jf9xqebOgdoa0U+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNRc07qe; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783964002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8qE4a9Od404gw/x9tLPMScB2hPPKwyyUE1M5NWdqvd4=;
	b=UNRc07qeKXNyWpa6zpkMeGYIXk4GZjjcB/L+arqZu/QqabCMrSK4dsKXkf7BT2JLXXBuin
	EnvefZ2F5Uqhob2JYG0/vtKSLB1ddshyvBBp4MiqGJn1Dk8WuZjp7Mp1c9/Q527W2kh1Dt
	Up++2YKP3REsz18+qd1Xe6mCuITVKR4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-zH5eTQK2Ns6yNU_X8H0m5g-1; Mon,
 13 Jul 2026 13:33:20 -0400
X-MC-Unique: zH5eTQK2Ns6yNU_X8H0m5g-1
X-Mimecast-MFC-AGG-ID: zH5eTQK2Ns6yNU_X8H0m5g_1783963999
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC408195609F;
	Mon, 13 Jul 2026 17:33:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.6.23.248])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17E661686;
	Mon, 13 Jul 2026 17:33:18 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	justin.tee@broadcom.com,
	sarah.catania@broadcom.com
Subject: [PATCH v2] drivers: base: Remove statistics group if encryption group not created
Date: Mon, 13 Jul 2026 13:33:18 -0400
Message-ID: <20260713173318.3060047-1-emilne@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[emilne@redhat.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:justin.tee@broadcom.com,m:sarah.catania@broadcom.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273925-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emilne@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24FE174E0F4

If transport_add_class_device() gets an error from sysfs_create_group() when
creating the encryption group, it does not remove the statistics group in
the error path.  Adjust the error path to do this properly.

v2: Only remove statistics group if tcont->statistics is non-NULL

Fixes: bd2bc528691e ("scsi: scsi_transport_fc: Introduce encryption group")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/base/transport_class.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/transport_class.c b/drivers/base/transport_class.c
index 416e9f819df5..351c3d3ce6a0 100644
--- a/drivers/base/transport_class.c
+++ b/drivers/base/transport_class.c
@@ -168,11 +168,14 @@ static int transport_add_class_device(struct attribute_container *cont,
 	if (tcont->encryption) {
 		error = sysfs_create_group(&classdev->kobj, tcont->encryption);
 		if (error)
-			goto err_del;
+			goto err_del_statistics;
 	}
 
 	return 0;
 
+err_del_statistics:
+	if (tcont->statistics)
+		sysfs_remove_group(&classdev->kobj, tcont->statistics);
 err_del:
 	attribute_container_class_device_del(classdev);
 err_remove:
-- 
2.52.0


