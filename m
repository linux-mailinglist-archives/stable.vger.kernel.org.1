Return-Path: <stable+bounces-264457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uja6GpB3MWpKkAUAu9opvQ
	(envelope-from <stable+bounces-264457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:19:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4FE691EFF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:19:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=b8TThdCD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264457-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264457-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8086320A483
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0D44534B9;
	Tue, 16 Jun 2026 16:06:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08A93A8746;
	Tue, 16 Jun 2026 16:06:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625983; cv=none; b=pDS5jCISxv//UYcmf9/bB1ilxg+sJ81LiYlzTN3LQjgOFXj8yw2SJaeitUi/5Brv+2+E7u79x2G5timuV3eXpUW1uY0ru2z621V6fy/LDoKZgkEucqSPrivmKSjQMeV3hAIGCKz12OhzcsGiXORKLx/aNKFcgVKXF4bYooihxGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625983; c=relaxed/simple;
	bh=P9ELhxF3RMeAnxO+yUCltw6nQb2nFcLVx8mm32g0CiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehIGWHZCB6bFDXTXBIzpqUr2FMWb9vy87iKrfLPu61qH0E0rSKOjvCLFf452bMGcu7E4CNG9HdzIcGI640tUVoBOJq5v7MvtUssD2K9g6VkzkTikKT7UaHZQTQTLuGmUXklQQMzQjZBiYIGBoa3dfInYmnj8YtuJe5IRHcGLbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b8TThdCD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E155A1F000E9;
	Tue, 16 Jun 2026 16:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625982;
	bh=NHavHF3SUS+pXCvwrhfJqUAw4o9KiqGME+Z1nCYWXeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b8TThdCDxqPk5u7iYU2KkEP2/8xQMiskyQTfp2KkGjQ4ScixD3+Y8xkbyYNdF4Jc6
	 lsh8QPJeL6XPoisHfnGL8378IXvDoGq6MQm2o05QLtdoei7QReguihUvEtKjAZ/XbP
	 8vbgewoCfnecCUZ5TSbQLmC11joBoe1gRCWf70i4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 6.18 243/325] nvmem: core: fix use-after-free bugs in error paths
Date: Tue, 16 Jun 2026 20:30:39 +0530
Message-ID: <20260616145110.576479399@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264457-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:bartosz.golaszewski@oss.qualcomm.com,m:srini@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA4FE691EFF

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

commit 5b6b6fc491899d583eaa75344e094796ae9b530b upstream.

Fix several instances of error paths in which we call
__nvmem_device_put() - which may end up freeing the underlying memory
and other resources - and then keep on using the nvmem structure. Always
put the reference to the nvmem device as the last step before returning
the error code.

Cc: stable@vger.kernel.org
Fixes: 7ae6478b304b ("nvmem: core: rework nvmem cell instance creation")
Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204340.116743-3-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/core.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1472,18 +1472,16 @@ struct nvmem_cell *of_nvmem_cell_get(str
 	cell_entry = nvmem_find_cell_entry_by_node(nvmem, cell_np);
 	of_node_put(cell_np);
 	if (!cell_entry) {
-		__nvmem_device_put(nvmem);
 		nvmem_layout_module_put(nvmem);
-		if (nvmem->layout)
-			return ERR_PTR(-EPROBE_DEFER);
-		else
-			return ERR_PTR(-ENOENT);
+		ret = nvmem->layout ? -EPROBE_DEFER : -ENOENT;
+		__nvmem_device_put(nvmem);
+		return ERR_PTR(ret);
 	}
 
 	cell = nvmem_create_cell(cell_entry, id, cell_index);
 	if (IS_ERR(cell)) {
-		__nvmem_device_put(nvmem);
 		nvmem_layout_module_put(nvmem);
+		__nvmem_device_put(nvmem);
 	}
 
 	return cell;
@@ -1597,8 +1595,8 @@ void nvmem_cell_put(struct nvmem_cell *c
 		kfree_const(cell->id);
 
 	kfree(cell);
-	__nvmem_device_put(nvmem);
 	nvmem_layout_module_put(nvmem);
+	__nvmem_device_put(nvmem);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 



