Return-Path: <stable+bounces-220193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPtuJNQto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:03:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 227EF1C55D9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E64F30EF37E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278304C9014;
	Sat, 28 Feb 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef2TWQx6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0714C77DF;
	Sat, 28 Feb 2026 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300099; cv=none; b=VGxd4+/fLyHf7jU2OcZp6HfWvb8FklYyLBVzI2RVFMIk/14MNmFUGYg/IhiHsBMEufnJhNt8EIiIxqej/VePli+3n7QwLgECuonjH/xKP0mq8P8wkXJmjT1Rdpb5TNuUTtx8sVfzhh4dL/OA8GfYseVAcHkaVo1n+uAkd9LmC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300099; c=relaxed/simple;
	bh=S5fQ+sckVXoHsbrEtarJTHKqAYCpXhdtcT3vfSIfn1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfEY3kp2OMtSYErjzNMtt6pwsrJXTcy0ftAPidz91lQLYWo7wQpor0HfkLvi2YjpjKftn7KmwVoRlqV8DkfAT68LOy+u2aPG8w8mdy8cKh6kIpUpym7mKIi1FeqsH0ti3h07QtmmRUSQb56+Um0igIPNHgCBdbGeOsUVKJ/u94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef2TWQx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA218C116D0;
	Sat, 28 Feb 2026 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300099;
	bh=S5fQ+sckVXoHsbrEtarJTHKqAYCpXhdtcT3vfSIfn1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ef2TWQx63pHu7NwxEqp8AASz6qTmimYv9+18tyekFTO28KyNqAoxeX6nl2n3k/vHk
	 eQRex0GFxzZYWzdHNCqUcJ3UjcDhiw/hC73gQcai44VfWTcL+quZe2Mb7A7ff0Hzzr
	 s+e+0ZAn6PjUF1yg2FL2/5nYBVD5CcYyGTMiPHhLX05PUlVTImmZHuQlTwG9e4K/1b
	 Ep75syQPPqLpgDKmuXwHCKCRKJSBIQToSeFJrp2XIVH2mzMHgVAs5UDBZeYc9jXfM0
	 +A0h0Fr4tH5wjxgNoTkd3p3zfmn4KCDQ9QcuUz1tBmtvVO8uu867WCDo6TlqZD/bI+
	 fpYYJ+Nvyujmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lili Li <lili.li@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 115/844] EDAC/igen6: Add more Intel Panther Lake-H SoCs support
Date: Sat, 28 Feb 2026 12:20:28 -0500
Message-ID: <20260228173244.1509663-116-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220193-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 227EF1C55D9
X-Rspamd-Action: no action

From: Lili Li <lili.li@intel.com>

[ Upstream commit 4c36e6106997b6ad8f4a279b4bdbca3ed6f53c6c ]

Add more Intel Panther Lake-H SoC compute die IDs for EDAC support.

Signed-off-by: Lili Li <lili.li@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://patch.msgid.link/20251124131537.3633983-1-qiuxu.zhuo@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/igen6_edac.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 553c31a2d9226..839b6dd3629e9 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -274,6 +274,16 @@ static struct work_struct ecclog_work;
 #define DID_PTL_H_SKU1	0xb000
 #define DID_PTL_H_SKU2	0xb001
 #define DID_PTL_H_SKU3	0xb002
+#define DID_PTL_H_SKU4	0xb003
+#define DID_PTL_H_SKU5	0xb004
+#define DID_PTL_H_SKU6	0xb005
+#define DID_PTL_H_SKU7	0xb008
+#define DID_PTL_H_SKU8	0xb011
+#define DID_PTL_H_SKU9	0xb014
+#define DID_PTL_H_SKU10	0xb015
+#define DID_PTL_H_SKU11	0xb028
+#define DID_PTL_H_SKU12	0xb029
+#define DID_PTL_H_SKU13	0xb02a
 
 /* Compute die IDs for Wildcat Lake with IBECC */
 #define DID_WCL_SKU1	0xfd00
@@ -636,6 +646,16 @@ static struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU1), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU2), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU3), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU4), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU5), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU6), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU7), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU8), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU9), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU10), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU11), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU12), (kernel_ulong_t)&mtl_p_cfg },
+	{ PCI_VDEVICE(INTEL, DID_PTL_H_SKU13), (kernel_ulong_t)&mtl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_WCL_SKU1), (kernel_ulong_t)&wcl_cfg },
 	{ },
 };
-- 
2.51.0


