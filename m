Return-Path: <stable+bounces-51374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8924F907010
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E11B2868F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9557C1442F6;
	Thu, 13 Jun 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ABQShQcf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC01422B4;
	Thu, 13 Jun 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281110; cv=none; b=geMow+vUq9trzG7HrynqZmv/uFQG/889TpQexqDVYQW7PTkUdPfucP9+OMZgRo6BZIfvIZSl+HFIdeJBnfhGfAhVXsFMq2B1yXwDdCECzGME4WeHVxJ/AJ73La8Kp5ChahnCCdiOHQRP4x6H5od/+ZCyy1iZv7apMYv6UdFTEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281110; c=relaxed/simple;
	bh=5zPnBQAakq4Mpowl0jyqiX0PzBE7sPuJMWC3lB/Dd/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK9jzFLVRS6pv2er6ceP4pyDOvyLBwFngGHj6DLvy9YMms2a1iAGqp7wd2Qfy6Q0+OSEMgYmMniLnWUaj5lBdSs8xFtxSkjTbHjdejvFWKD3x5+qckxC1x1UWzEuEYIP8qMl3qD4bzOT85l2Ho4Cl9bzs8dGcnpXSzuTFWn4nO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ABQShQcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE639C2BBFC;
	Thu, 13 Jun 2024 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281110;
	bh=5zPnBQAakq4Mpowl0jyqiX0PzBE7sPuJMWC3lB/Dd/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABQShQcf//3edvAOYzYnIgp0CR79L7A/1xfs7pxCNQF8kIuIgEkEaCSeycM1NJIXO
	 Ti68OVRrd91XoVkQnKyoi5ZATCewfXk6xmOWQVHE3MOZMBkaaY/NYK/DaJm+edsLY3
	 RjmHKujebghFvLdYZsomonyWOvpeQK8qgO7GB5GI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Jean Delvare <jdelvare@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 144/317] firmware: dmi-id: add a release callback function
Date: Thu, 13 Jun 2024 13:32:42 +0200
Message-ID: <20240613113253.139418138@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit cf770af5645a41a753c55a053fa1237105b0964a ]

dmi_class uses kfree() as the .release function, but that now causes
a warning with clang-16 as it violates control flow integrity (KCFI)
rules:

drivers/firmware/dmi-id.c:174:17: error: cast from 'void (*)(const void *)' to 'void (*)(struct device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  174 |         .dev_release = (void(*)(struct device *)) kfree,

Add an explicit function to call kfree() instead.

Fixes: 4f5c791a850e ("DMI-based module autoloading")
Link: https://lore.kernel.org/lkml/20240213100238.456912-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/dmi-id.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 86d71b0212b1b..0cfc60cc267d4 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -164,9 +164,14 @@ static int dmi_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static void dmi_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
 static struct class dmi_class = {
 	.name = "dmi",
-	.dev_release = (void(*)(struct device *)) kfree,
+	.dev_release = dmi_dev_release,
 	.dev_uevent = dmi_dev_uevent,
 };
 
-- 
2.43.0




