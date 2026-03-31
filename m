Return-Path: <stable+bounces-231898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENvcAMABzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-231898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:17:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 644D736E70A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F3C731DBA35
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2F8425CC5;
	Tue, 31 Mar 2026 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oreYUXuA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F03F7A8B;
	Tue, 31 Mar 2026 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975352; cv=none; b=UHm3cneD9FXKnuXpW7B/VU7krsH32We1NkhEgi+4+yd29RYD3aIQOuklPsgE0yA5qQKgY8Gxi3ELxUw5AeRpTzzPddagcOhcQ3NQxuSytXqfhFRQ6iKY5bsrc96A2GxKyr4+yRJzaM4NB3NLexu0f2jmkL8NVgXTy0mHvfJDLIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975352; c=relaxed/simple;
	bh=TC1lTNW4Oa0Icq/qlBnUCer0tNL2Bj7kX5VhyY9ZN6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBIK5J3qSdTzuTnuUEuI2wF7JWnSlNDaBLpOBuqiJoWcdPFjzNLMD36bAH3w53eIZEhTmqTHhUNFZF8oducIwkA7rtB/cwhcTqAY5iOnIk/pxJf4KEwWPhDlYGxw773IMpkxHr7mrn3KAW9hDArUNI6LWNQlVUdEH0XjSR29A54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oreYUXuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC18FC19423;
	Tue, 31 Mar 2026 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975352;
	bh=TC1lTNW4Oa0Icq/qlBnUCer0tNL2Bj7kX5VhyY9ZN6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oreYUXuAC2r+Y1Vuv3QOtSYDGWOL9RzIN0jywV5c4oJ+hutAiCyYvBgm4zbUvhMR1
	 Httz9ym9DgTKnJg1Oyt/wzWqsL10tjbgiWJBDTNtWny+LeQXMMytfZGYygAuIBiF+s
	 gLPTzXjPa0yo5H5B/xQGmFXZ+DQ5N5RrPkRsKwMA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Renato Marziano <renato@marziano.top>,
	Leon Romanovsky <leonro@nvidia.com>,
	Alex Williamson <alex.williamson@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH 6.19 234/342] vfio/pci: Fix double free in dma-buf feature
Date: Tue, 31 Mar 2026 18:21:07 +0200
Message-ID: <20260331161807.576928135@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231898-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 644D736E70A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Williamson <alex.williamson@nvidia.com>

commit e98137f0a874ab36d0946de4707aa48cb7137d1c upstream.

The error path through vfio_pci_core_feature_dma_buf() ignores its
own advice to only use dma_buf_put() after dma_buf_export(), instead
falling through the entire unwind chain.  In the unlikely event that
we encounter file descriptor exhaustion, this can result in an
unbalanced refcount on the vfio device and double free of allocated
objects.

Avoid this by moving the "put" directly into the error path and return
the errno rather than entering the unwind chain.

Reported-by: Renato Marziano <renato@marziano.top>
Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
Cc: stable@vger.kernel.org
Acked-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Link: https://lore.kernel.org/r/20260323215659.2108191-3-alex.williamson@nvidia.com
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -302,11 +302,10 @@ int vfio_pci_core_feature_dma_buf(struct
 	 */
 	ret = dma_buf_fd(priv->dmabuf, get_dma_buf.open_flags);
 	if (ret < 0)
-		goto err_dma_buf;
+		dma_buf_put(priv->dmabuf);
+
 	return ret;
 
-err_dma_buf:
-	dma_buf_put(priv->dmabuf);
 err_dev_put:
 	vfio_device_put_registration(&vdev->vdev);
 err_free_phys:



