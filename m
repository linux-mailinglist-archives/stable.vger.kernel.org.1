Return-Path: <stable+bounces-220380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DHmLsk0o2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3721C5EDE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E68CD30C7A40
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB0A3A5A04;
	Sat, 28 Feb 2026 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOZnsK2K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894343A59FB;
	Sat, 28 Feb 2026 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300274; cv=none; b=pV9j3/1b77FqK3JO/cpAGED/h/4hY3ml/pTINzTJNiW5VZ5HZxSjqROqA429pf/jLy/YW0T37yYFH0gXrzRm5/y9+VlfWS+05oLQiahxzRK1uFPMGf6s4xLEKt3+OndnDqkGJZ63CY2XU8DjqVmqeGjsWaoYC8mB3fS/WbkxHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300274; c=relaxed/simple;
	bh=e3ZXd0XXxi0wpZ4x26jBB6Oe3mMb01vU4qY4HNeryYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQXZ+35vDowg2Bjv3z4g5otkQ4GkWBAiOwr5XPjPk9ThFWOIML/20AA/auBeTgIISn/pMj5ufOB/Ui+ZTA8G5ENPDwttHDgTfSxAL9VNonwlfRWKrrOo7NIl7nla+tLqmTflcVaZ/AQbQ0r/9WEv62u7nLWmYWaWrHCXcCt6800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOZnsK2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C340FC19423;
	Sat, 28 Feb 2026 17:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300274;
	bh=e3ZXd0XXxi0wpZ4x26jBB6Oe3mMb01vU4qY4HNeryYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOZnsK2KCTG9UN79TBPdr2xG4oY8ZL1EmKK02mXiDVJ4BDaoMTwnV7TKWu1fQQorN
	 NqScjvAhjscD48lYOR4rWeBJ9hT4URfeHZ1OAfntg0x1Y0pqSiWcGSyeUhDIiS39Gn
	 tEUoO7PI/wcvhK5vS9D3vdUMuO0IKRRaA9Fl94tbd9tsyfrHsCksXmj/PGY6iNGIJU
	 T3mUisSEld1hfVVKBZtQIHtGAthYv4/0Pk4oBjGl+I4cMLl+uBRPcPMFYKDK5WSav0
	 qD7+8Cbl1TQtwS1HKCvVCBwpCsU29V/8tFn6l7A0b8nN28IL7D3jiN0N5Xiam/xRKF
	 w7MNCja5LR7Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gui-Dong Han <hanguidong02@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 301/844] driver core: faux: stop using static struct device
Date: Sat, 28 Feb 2026 12:23:34 -0500
Message-ID: <20260228173244.1509663-302-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220380-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5E3721C5EDE
X-Rspamd-Action: no action

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 61b76d07d2b46a86ea91267d36449fc78f8a1f6e ]

faux_bus_root should not have been a static struct device, but rather a
dynamically created structure so that lockdep and other testing tools do
not trip over it (as well as being the right thing overall to do.)  Fix
this up by making it properly dynamic.

Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
Closes: https://lore.kernel.org/lkml/CALbr=LYKJsj6cbrDLA07qioKhWJcRj+gW8=bq5=4ZvpEe2c4Yg@mail.gmail.com/
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patch.msgid.link/2026012145-lapping-countless-ef81@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/faux.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 21dd02124231a..23d7258172325 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -29,9 +29,7 @@ struct faux_object {
 };
 #define to_faux_object(dev) container_of_const(dev, struct faux_object, faux_dev.dev)
 
-static struct device faux_bus_root = {
-	.init_name	= "faux",
-};
+static struct device *faux_bus_root;
 
 static int faux_match(struct device *dev, const struct device_driver *drv)
 {
@@ -152,7 +150,7 @@ struct faux_device *faux_device_create_with_groups(const char *name,
 	if (parent)
 		dev->parent = parent;
 	else
-		dev->parent = &faux_bus_root;
+		dev->parent = faux_bus_root;
 	dev->bus = &faux_bus_type;
 	dev_set_name(dev, "%s", name);
 	device_set_pm_not_required(dev);
@@ -236,9 +234,15 @@ int __init faux_bus_init(void)
 {
 	int ret;
 
-	ret = device_register(&faux_bus_root);
+	faux_bus_root = kzalloc(sizeof(*faux_bus_root), GFP_KERNEL);
+	if (!faux_bus_root)
+		return -ENOMEM;
+
+	dev_set_name(faux_bus_root, "faux");
+
+	ret = device_register(faux_bus_root);
 	if (ret) {
-		put_device(&faux_bus_root);
+		put_device(faux_bus_root);
 		return ret;
 	}
 
@@ -256,6 +260,6 @@ int __init faux_bus_init(void)
 	bus_unregister(&faux_bus_type);
 
 error_bus:
-	device_unregister(&faux_bus_root);
+	device_unregister(faux_bus_root);
 	return ret;
 }
-- 
2.51.0


