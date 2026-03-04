Return-Path: <stable+bounces-223041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eESWKjggqGlQoQAAu9opvQ
	(envelope-from <stable+bounces-223041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 13:06:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AECF11FF795
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 13:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3B013013A75
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F16370D55;
	Wed,  4 Mar 2026 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="QS7Nu2qM"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190E3451AE
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625973; cv=none; b=cEWwZohpQ7G919hZ1skMAsACbXSw/wO4/enSOu6l0zXWzCG11irEq1XVefBuA3GTn6CaxfFFTHPkoETbRMUz20E+noWFx/SFR4gnk6drry75ckB+MsP0vdiTq7ia6Qa4y89u3zplc6wcGxU961HHqn7IrXd9lIHnBu5+4Lf71xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625973; c=relaxed/simple;
	bh=fumAVzxhrnSEgYexlRNryunbBFAVIASoVovZ/2zYq+0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=uZp/tqhCKWdGJfE6FILDBP7COw+i7nCtKatXipcmJ4BamszBpAWygHkMPeglJG4eevFRyurNBI6RORp85QRo5XsZyEwlatUrCHJ1uwVXLkbFiWIBhSALNcpdjMfvFUnKx/XrtKE9cMcAaAPEQMC9eH+MSAyFSL/iGOV7kbbpXRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=QS7Nu2qM; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1772625964;
	bh=OLY8ElLq4VyWrVQREZEq5CaGEJmQufLpfX5MZNqiz80=;
	h=From:To:Cc:Subject:Date;
	b=QS7Nu2qM0aoralEoBsj9JDhdtPleKGxO5RAr8A9cNLY0+YJW4iBaJ5s01x5Ars2hY
	 2aEM9AIF8GvLb/0Qawr7j5F0I+syTuxlCzpGXb350lW/BAaCGW0ulbEn7Ek/852SHk
	 mtEA8DxIz8ahP9dD9jVdftsXJSbODQwm2q1pgjXE=
Received: from China-team ([120.244.194.69])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 181B3C4B; Wed, 04 Mar 2026 20:06:01 +0800
X-QQ-mid: xmsmtpt1772625961t4sinoi71
Message-ID: <tencent_809270D680389230500DD8B455354E1F1408@qq.com>
X-QQ-XMAILINFO: MOnz+xTS1+9iXei/C3nfZS6x31MwM/gZ6rg5A8g5TndphAncO0YnOqXNTJZt9i
	 QIQHnT3dzBalC4KOv/vSEL3biTJNgBRPyzMJ2rRheomBleIo+vfFbD9PxU2cWryXzAEm9flsR2f7
	 b28Uj2ROlwGMaKgS3uHr6BITY/D/rfgpIhjrpAzMmXmxsd9U6F4WcDz5RR+jecrk7DHK3VGOWOIt
	 HawlYuhcW//KoKNw8mgLbWnc7GU1D22jwH/2l9WxIyoBnTBrjPruIVmPpCMiGV++MQwaAtFMvwB4
	 sij9NCYAbgVf7xFBSUCI0JrNChByMQ6BmBqP+WeiQzZ3UzTaP3aZI4cSPNi5+3EfmCoekC9xIpU/
	 EF1+csmheJ6VlAJBBK/W+eNCuwQA+JJs/XH5ZDepXVwtmNCsW2NVCBczaKx0NWOIjx82zcP1mZjd
	 bE7ig5jhlfDaeLEdHdiwB5wAuKPVDTjNjcC1UD3oeiJO+gIGph7QoYYJz/hFUJVL8GgU1C4SRe6C
	 Vd9EYCUPNQg16zWH63Ktp3Ji17paaOyek2rHcaarkUWzu6WN6lpR7Ol2NRiYXl9BGPCXUKW0CfyI
	 6cQzK5XPNQafqFuj00rBHsTkB4ZRz34InqvLS09YvD+Olow2eKfifGHQ77vOMw/HtyK+CR97Ozga
	 FdevJIUUNRIe5gmvH5sCqyoWiZzZoxxBqYLy39tODLfqUTtDOHGj/BRoHST1DKvNhN2yUqasAKmb
	 xjuo5caAZ/uHQhzcxAfv4TVbd+xbb1qxtCL+SX4gKYpv5EVTw4EIphdy49ixI5w3P9HG5XXFJdzL
	 e9NFK+35vuN7oj7V/gSYee1lG1HGjFKNkLDFemgFKLjhmpAEcz5Jh8w8H45ppoROnxhmqYQgTUEQ
	 qAjH4b4Ux6O0/t7fYnaGJcGuLdg+pO9nPalcVsrUoGZooBLJG5U8CI6djQAkp6m9/QxOtudNOZ7V
	 8DQaVpR+Z6Ho+ZokOmlcBAjeSYtAVMcuhyaDwiuncACWgh4ID8iI4+WOvbEBeunN0/OwMhmBpifd
	 2DH9uofAjLFCA+7C6+hWGlUsC2IejNvlLn7C3Dhta0giEf425y8J8bqnaNuDSCfXgpGOPKA3msL2
	 tIWenI0XO6DoQ97oUdtNPXSdhoVYo/YUwt5Be3
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	Lin Ma <linma@zju.edu.cn>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.15.y] vdpa: Add max vqp attr to vdpa_nl_policy for nlattr length check
Date: Wed,  4 Mar 2026 20:05:20 +0800
X-OQ-MSGID: <20260304120520.4674-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AECF11FF795
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223041-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,zju.edu.cn,foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:dkim,foxmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,qq.com:mid,zju.edu.cn:email]
X-Rspamd-Action: no action

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 5d6ba607d6cb5c58a4ddf33381e18c83dbb4098f ]

The vdpa_nl_policy structure is used to validate the nlattr when parsing
the incoming nlmsg. It will ensure the attribute being described produces
a valid nlattr pointer in info->attrs before entering into each handler
in vdpa_nl_ops.

That is to say, the missing part in vdpa_nl_policy may lead to illegal
nlattr after parsing, which could lead to OOB read just like CVE-2023-3773.

This patch adds the missing nla_policy for vdpa max vqp attr to avoid
such bugs.

Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Cc: stable@vger.kernel.org
Message-Id: <20230727175757.73988-7-dtatulea@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[ Minor context conflict resolved. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/vdpa/vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 58eb448bf5b0..acd93af0ee20 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -847,6 +847,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
 	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
+	[VDPA_ATTR_DEV_NET_CFG_MAX_VQP] = { .type = NLA_U16 },
 };
 
 static const struct genl_ops vdpa_nl_ops[] = {
-- 
2.43.0


