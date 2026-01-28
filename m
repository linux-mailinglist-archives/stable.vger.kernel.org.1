Return-Path: <stable+bounces-212129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOXuEWkuemnd3gEAu9opvQ
	(envelope-from <stable+bounces-212129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:42:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCEDA43D2
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBC95302ADAC
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C054F2C1586;
	Wed, 28 Jan 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ofc6PEUK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6282BE04C;
	Wed, 28 Jan 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614490; cv=none; b=dvmZ9dT32kaSLu/FSc35Vf2H9JcrIJzUgQyPJigZoQxZg+dJWIpN+xfGPBXYsI7o2WSBb7kfPhw9oAocTbcEbhcwDI3jbjcFTlCL3sdSsdrUf7JLQ7NZ+7b9f6dsA1nSfV/rrhzFL7ImihndFbe5dFXU6th4KJwB9Gth9V+bngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614490; c=relaxed/simple;
	bh=9XfhUg/dW/MC04Q5np7zNZh7qgI/UzUiwv+XbopQJd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hxx5Undr3gUzTw2E3SrVbXP0j3rpZTFf73D1kzQtOG+jvUcyuRVVTNFaTjCggllyTqtXBHS4Oqub9FVyukZi09HP0w7QO9y4gPUZ+IAPp6f47PPUgY0PgqtoH9jXks4dLPxBe0uYmRu85BPLI3tNoB1X4EvKkkPzPx5MNUaTa9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ofc6PEUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE6CC4CEF7;
	Wed, 28 Jan 2026 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614489;
	bh=9XfhUg/dW/MC04Q5np7zNZh7qgI/UzUiwv+XbopQJd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ofc6PEUKC16U743bpawNk6PHg35YsVS9ItsMkyhGQoVBg6E9tMGk7c/j5QpWy7Y6/
	 JrviFqCwyo+IArNg/+jeQ6zvbsREhbEAMN+lNOw/DO4i2cke1JfHvkJAyrLUMI+grI
	 yI3nZ37QCUGrUllRc1ZPVXWZA34nApJ2aq0cvVSo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Georgi Djakov <djakov@kernel.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 153/254] interconnect: debugfs: initialize src_node and dst_node to empty strings
Date: Wed, 28 Jan 2026 16:22:09 +0100
Message-ID: <20260128145350.317019193@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212129-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACCEDA43D2
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Georgi Djakov <djakov@kernel.org>

[ Upstream commit 8cc27f5c6dd17dd090f3a696683f04336c162ff5 ]

The debugfs_create_str() API assumes that the string pointer is either NULL
or points to valid kmalloc() memory. Leaving the pointer uninitialized can
cause problems.

Initialize src_node and dst_node to empty strings before creating the
debugfs entries to guarantee that reads and writes are safe.

Fixes: 770c69f037c1 ("interconnect: Add debugfs test client")
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Link: https://lore.kernel.org/r/20260109122523.125843-1-djakov@kernel.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/debugfs-client.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
index 778deeb4a7e8a..24d7b5a577945 100644
--- a/drivers/interconnect/debugfs-client.c
+++ b/drivers/interconnect/debugfs-client.c
@@ -150,6 +150,11 @@ int icc_debugfs_client_init(struct dentry *icc_dir)
 		return ret;
 	}
 
+	src_node = devm_kstrdup(&pdev->dev, "", GFP_KERNEL);
+	dst_node = devm_kstrdup(&pdev->dev, "", GFP_KERNEL);
+	if (!src_node || !dst_node)
+		return -ENOMEM;
+
 	client_dir = debugfs_create_dir("test_client", icc_dir);
 
 	debugfs_create_str("src_node", 0600, client_dir, &src_node);
-- 
2.51.0




