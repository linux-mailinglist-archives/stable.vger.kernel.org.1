Return-Path: <stable+bounces-241525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJxeKDKA8GlSUAEAu9opvQ
	(envelope-from <stable+bounces-241525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:38:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FC2481A32
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE51F301286F
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175DC3D47A9;
	Tue, 28 Apr 2026 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrMadvMe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5283D34A8
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369052; cv=none; b=UweQ3PPUz70XkpgOriJFbLAYfPekdBM6iuOS5RvT02+psNiopb5ApYRDEap8psqPZStppVfBgZt1j4aGqhZahoNPwEnWJH6lYdkG3cG1RzlPigfQ6y7L7ZZTxBp/5PXsh29xKdjBO9S/iFlrUUCFfKG9JTVD2V+k9YPba6sBB5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369052; c=relaxed/simple;
	bh=yXn6EkhJ7qO+eQk0eM4/L2B7SbEhNT8pJs06jY0YNbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEnoLjn5806qn9sr4Ob0OY/hPae9AA4fj38FkUPOkwKIAgrCJYYH9+Ayq0fKc6212cV1/foufzZVVDEwklNC8qd2hzC/o3t6EyJkliHUtfm+qw4ySL8SChlvMXnLrVqCkiLLaNz6KvjOGHc21Uhr7WHNz22R6zkJSfuWLn4vOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrMadvMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BECBC2BCB7;
	Tue, 28 Apr 2026 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777369052;
	bh=yXn6EkhJ7qO+eQk0eM4/L2B7SbEhNT8pJs06jY0YNbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nrMadvMepTPLLspEg/Vp8UKLGDuJqU2GmPR+EILgAXNQOyQ7OaQcUky18wSB0EcsQ
	 RxxLtJ6HncO1G1LZenqwUOog8zFjjUrxf5Q6wF9Il7C2ZExj/I9S9tLsc5oZListmN
	 aDOTOpDtMP+UWvTUIH1WyaKh1sfJs2PibpB8HqPaLf6jfqHGpenLp6Y/vP97aGGRqv
	 TCK4IIw5q11WHAbzax3bBT3GPJLyfWJXhANQCJCLRrwbTBVj+H65RluqUN+2HJj3Ww
	 eAI63cEpSXa8HS7tVvpp/eedgT+fo3iXmlZ7yctWq6GoaKy4rHc75vJWeWMj95KVek
	 3K2chNhGHcWGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	stable <stable@kernel.org>,
	Tomas Winkler <tomasw@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/2] mei: me: add nova lake point H DID
Date: Tue, 28 Apr 2026 05:37:29 -0400
Message-ID: <20260428093729.2692325-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428093729.2692325-1-sashal@kernel.org>
References: <2026042701-alumni-disfigure-b344@gregkh>
 <20260428093729.2692325-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66FC2481A32
X-Rspamd-Action: no action
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
	FREEMAIL_CC(0.00)[intel.com,kernel.org,gmail.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241525-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,intel.com:email]

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


