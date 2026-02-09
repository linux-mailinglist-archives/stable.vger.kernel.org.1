Return-Path: <stable+bounces-215186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCbOH/7xiWnyEgAAu9opvQ
	(envelope-from <stable+bounces-215186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:41:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B8110ABC
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1506304ABBE
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074E37E31E;
	Mon,  9 Feb 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GxLSMiED"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409A37E312;
	Mon,  9 Feb 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647961; cv=none; b=IDAIs50eOjXB0EuKYE643LOw3hfvfSHo9P6e3Pk0FbOt8XDJ/6yA/nXEXsOmN8p9jXi+hjx9QDU073tI/V/9QhjJWEqh3mF+8jOYcbf+vs7aFw0bqtCcpGd+Jkuif9ZrDUwvRpk0OmK7rXqtbaRGtbXfyHBfC4DYSa/lj5JtccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647961; c=relaxed/simple;
	bh=BVA/10uZBGkXQwm5cUsYaGNXU09jcatQipEKC83M+q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/kAnV8ALNZ26UGp3z3hKKx6KUmBtEZ7cG+TSqf41pyZ5VGy+kofJzDMN0R66cnJhzNaSV8sTKLSh2Bcbttg8UF2AixF+iPfygiMv9js2sjcjQyHy0z1dtOUJd/FKqJghnRS2+Tss7AME0IliWHjsRGq0xjp0ueStvTf+msUTmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GxLSMiED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAB6C116C6;
	Mon,  9 Feb 2026 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647961;
	bh=BVA/10uZBGkXQwm5cUsYaGNXU09jcatQipEKC83M+q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxLSMiEDpK+h5uLvNXflrZjbL5wMyThzvgqhs45VmLRjxr/tL+7S1bobjhHv22ZqH
	 OZ2x3mw/d0nLEsBmxE3E2jgasCu7Cpw3mZtL+Px5LkDcr2JJiPBAQXmTAz3ujv3CSf
	 t1MjIaYHYfYuoSBwIdag+/k/n0G4xEeXNoLOB6Fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 080/113] dpaa2-switch: prevent ZERO_SIZE_PTR dereference when num_ifs is zero
Date: Mon,  9 Feb 2026 15:23:49 +0100
Message-ID: <20260209142313.059125406@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215186-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,lunn.ch,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,lunn.ch:email,outlook.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 152B8110ABC
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junrui Luo <moonafterrain@outlook.com>

[ Upstream commit ed48a84a72fefb20a82dd90a7caa7807e90c6f66 ]

The driver allocates arrays for ports, FDBs, and filter blocks using
kcalloc() with ethsw->sw_attr.num_ifs as the element count. When the
device reports zero interfaces (either due to hardware configuration
or firmware issues), kcalloc(0, ...) returns ZERO_SIZE_PTR (0x10)
instead of NULL.

Later in dpaa2_switch_probe(), the NAPI initialization unconditionally
accesses ethsw->ports[0]->netdev, which attempts to dereference
ZERO_SIZE_PTR (address 0x10), resulting in a kernel panic.

Add a check to ensure num_ifs is greater than zero after retrieving
device attributes. This prevents the zero-sized allocations and
subsequent invalid pointer dereference.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 0b1b71370458 ("staging: dpaa2-switch: handle Rx path on control interface")
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/SYBPR01MB7881BEABA8DA896947962470AF91A@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 980daecab8ea3..84c7079d8672d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3023,6 +3023,12 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
 		goto err_close;
 	}
 
+	if (!ethsw->sw_attr.num_ifs) {
+		dev_err(dev, "DPSW device has no interfaces\n");
+		err = -ENODEV;
+		goto err_close;
+	}
+
 	err = dpsw_get_api_version(ethsw->mc_io, 0,
 				   &ethsw->major,
 				   &ethsw->minor);
-- 
2.51.0




