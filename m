Return-Path: <stable+bounces-220453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M0MKYE3o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B81C6348
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D72C932BE6A4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1816E3BA22C;
	Sat, 28 Feb 2026 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNosKOzX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A93B8925;
	Sat, 28 Feb 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300341; cv=none; b=Oy1ZG//jcF/cz1awE/jaJrbDVPDU1CGpJdBSOQQfQ9r+JOrGQIsKMZuSvrzYebeBEmoCfGniWFYTpZDJNbEkxXbZQZCS5xcjmz3n9eAI0tEtmwnYOWjFg4vEj1P5MVWpYJb24bZeH367MrZP04zKrkZInVIlZP0zont83nTjQ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300341; c=relaxed/simple;
	bh=QlgXHxLPUtH2sx/OHkgS6SP38Ze9WrPDAlWUKD10jUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5E5sNJBWpSUrpT50faGBBlao6qu5e3OX58YAxS5j0qRowmUQBqJHjftODleiVtthUxKqRdJd4Kn1eM9pVwgVYkLSjdCvGSzcaEs3zN/V7KFxjcs/qGggOTyQQAbcBsoIwnqPn6Wvb8FSJ/XITmxLsirO08jme43/K5DmchZ0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNosKOzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AA6C116D0;
	Sat, 28 Feb 2026 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300341;
	bh=QlgXHxLPUtH2sx/OHkgS6SP38Ze9WrPDAlWUKD10jUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sNosKOzXBgEjre7oc9ioOnDiL8TzThBdddSPGUV/ufkMqOFsOvuoGXBMUXSXXHkSB
	 VNLoTfnZTPM1TTHv0qKCnm6Eg5l4DKmt8vQpRNG/iNC0g/oyyJgSOLPTAbIdnJUHaN
	 m3+LIm9syJOUAzlJmX6KWkLH/OeeSPlGMaibYndyqc+ZjApl73W6qdW2s3D/8pxaHI
	 xkdS91uBVYykm2Awawtkvakgi1qcQrVUIxWzHDzXSrB5rv1aBLsOh8trgPPmJFsM8c
	 4nF2h9NlJBeKzYz1U7y+ofQIz5i8jzVg6S1umEhGrLqQN0pxBx1l7LJOkAoZKMgT5n
	 RKivWedo9bAFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Navaneeth K <knavaneeth786@gmail.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 374/844] most: core: fix resource leak in most_register_interface error paths
Date: Sat, 28 Feb 2026 12:24:47 -0500
Message-ID: <20260228173244.1509663-375-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linaro.org,linuxfoundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-220453-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 086B81C6348
X-Rspamd-Action: no action

From: Navaneeth K <knavaneeth786@gmail.com>

[ Upstream commit 1f4c9d8a1021281750c6cda126d6f8a40cc24e71 ]

The function most_register_interface() did not correctly release resources
if it failed early (before registering the device). In these cases, it
returned an error code immediately, leaking the memory allocated for the
interface.

Fix this by initializing the device early via device_initialize() and
calling put_device() on all error paths.

The most_register_interface() is expected to call put_device() on
error which frees the resources allocated in the caller. The
put_device() either calls release_mdev() or dim2_release(),
depending on the caller.

Switch to using device_add() instead of device_register() to handle
the split initialization.

Acked-by: Abdun Nihaal <abdun.nihaal@gmail.com>
Signed-off-by: Navaneeth K <knavaneeth786@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/20251127165337.19172-1-knavaneeth786@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/most/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index da319d108ea1d..6277e6702ca8c 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -1286,15 +1286,19 @@ int most_register_interface(struct most_interface *iface)
 	    !iface->poison_channel || (iface->num_channels > MAX_CHANNELS))
 		return -EINVAL;
 
+	device_initialize(iface->dev);
+
 	id = ida_alloc(&mdev_id, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(iface->dev, "Failed to allocate device ID\n");
+		put_device(iface->dev);
 		return id;
 	}
 
 	iface->p = kzalloc(sizeof(*iface->p), GFP_KERNEL);
 	if (!iface->p) {
 		ida_free(&mdev_id, id);
+		put_device(iface->dev);
 		return -ENOMEM;
 	}
 
@@ -1304,7 +1308,7 @@ int most_register_interface(struct most_interface *iface)
 	iface->dev->bus = &mostbus;
 	iface->dev->groups = interface_attr_groups;
 	dev_set_drvdata(iface->dev, iface);
-	if (device_register(iface->dev)) {
+	if (device_add(iface->dev)) {
 		dev_err(iface->dev, "Failed to register interface device\n");
 		kfree(iface->p);
 		put_device(iface->dev);
-- 
2.51.0


