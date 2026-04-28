Return-Path: <stable+bounces-241533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE3bG82I8GloUgEAu9opvQ
	(envelope-from <stable+bounces-241533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:15:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08508482681
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E620B307B856
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9DE3E63A4;
	Tue, 28 Apr 2026 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KifHIICp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675126B756
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371129; cv=none; b=IltRQJzkSPz93sm3ag30pTE3ILqvMHTBY6nDMTPfb8i4Ulxxg73OE03Pbv2JgPxsPi7jnlUiI8zF7sYRk+F/as6V7gcWdAVUoaWjRLe3xi+T+Xy7KTqaFhRD7u1gRvHg9xt7aHevc9OQeSIoPP2Sryrmi9C03LxrgKAxWAhqdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371129; c=relaxed/simple;
	bh=yXn6EkhJ7qO+eQk0eM4/L2B7SbEhNT8pJs06jY0YNbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGmn4tiNRv3QWAm+teQpkdv51fEN0m/R/1c/sbbavX8vtMY/QOGv4bcED07Vgq4y0ynaTd9UMzhxYm8zgUWXRqkxv4dpW13r6B0kScJblEHfVig8IH7rG2jfnOuJMYvM//bmdoRgriN50Gb9rO0wRFGSdDfiX6Y7GliIWfb5zSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KifHIICp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7578C2BCB5;
	Tue, 28 Apr 2026 10:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777371128;
	bh=yXn6EkhJ7qO+eQk0eM4/L2B7SbEhNT8pJs06jY0YNbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KifHIICpD2dBOJLCKM7HHylQRMgXHE96OI5CeIbd7jqxAb64viavjH5STMxfOyuDD
	 XaMCans7gTBmruT6aK/vL5oKbTHMF2WdcG4RlmZEMhhsKLT/uCRl3ifcw93otQGHNV
	 Cz3rip6XkS0qCe/Pm2pp0nk6LII5yjaLZDuB1FdN2cFc9aF8x1rm2ED5fGIUE2L41o
	 kGkkztdakNx8E+oSWR4XeWefgkhW9aUy3Rx021c10J4U9jzRxhuBHgazKrH/wEZpyC
	 L0tCHt0G0AZbr1yBCNmzfsggxKl7/LifNvnoagGOwJKmGb4SCx+MR+jkidZvFpEMYv
	 wpaAjCadCR3Xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	stable <stable@kernel.org>,
	Tomas Winkler <tomasw@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] mei: me: add nova lake point H DID
Date: Tue, 28 Apr 2026 06:12:05 -0400
Message-ID: <20260428101205.2778177-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428101205.2778177-1-sashal@kernel.org>
References: <2026042701-singular-disaster-12a5@gregkh>
 <20260428101205.2778177-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08508482681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,gmail.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241533-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]

From: Alexander Usyskin <alexander.usyskin@intel.com>

[ Upstream commit a5a1804332afc7035d5c5b880548262e81d796bc ]

Add Nova Lake H device id.

Cc: stable <stable@kernel.org>
Co-developed-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Link: https://patch.msgid.link/20260405141758.1634556-1-alexander.usyskin@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/hw-me-regs.h | 1 +
 drivers/misc/mei/pci-me.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 840e1fd2714c4..5967f95891a1f 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -123,6 +123,7 @@
 #define PCI_DEVICE_ID_INTEL_MEI_WCL_P      0x4D70  /* Wildcat Lake P */
 
 #define PCI_DEVICE_ID_INTEL_MEI_NVL_S      0x6E68  /* Nova Lake Point S */
+#define PCI_DEVICE_ID_INTEL_MEI_NVL_H      0xD370  /* Nova Lake Point H */
 
 /*
  * MEI HW Section
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index fe5d5aee074cd..5b6aaa4d3a1cb 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -130,6 +130,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{PCI_DEVICE_DATA(INTEL, MEI_WCL_P, MEI_ME_PCH15_CFG)},
 
 	{PCI_DEVICE_DATA(INTEL, MEI_NVL_S, MEI_ME_PCH15_CFG)},
+	{PCI_DEVICE_DATA(INTEL, MEI_NVL_H, MEI_ME_PCH15_CFG)},
 
 	/* required last entry */
 	{0, }
-- 
2.53.0


