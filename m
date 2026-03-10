Return-Path: <stable+bounces-223952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANOiL/L8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F524A2AD
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AE4831769CB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B6A313537;
	Tue, 10 Mar 2026 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvMmSskN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE102D978B;
	Tue, 10 Mar 2026 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141086; cv=none; b=OH9qSaKu+kr07EJfNlZrf7KJv8zLXNqN2mUEgLER48lbWMuFj162Ob/BhYw/CGCcjN6RgXBUm0Z0w1tyYzfAr/AYEmIv7UXQHw624xNHVJH5bKs2YHYE5VCyT3iubQaAvmbaxp7olScevB6tSCCiSwbkgpnR7ynBIpZ3kMX1GEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141086; c=relaxed/simple;
	bh=9cTbszbNTmobe6sGX07QqlkpMVKMrWg5Gxj4fCva3vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RejsDFZThmoKsey5NdbenbAQJvUlrS0S1ddt0gNhPDJBuZbPrOF5R6lsxCm8+eQFZAVUqoqNh/QjxH197GcR/bJnducvIXteZ9xBPreLfjeexFDWOcsoikmOVRJ6zTcMJvMkv9NtcAFgNtpVH1kywa9QKpyliYobXQJ12rcLy0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvMmSskN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1CDC19423;
	Tue, 10 Mar 2026 11:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141086;
	bh=9cTbszbNTmobe6sGX07QqlkpMVKMrWg5Gxj4fCva3vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NvMmSskNR7jynyAIh/T9siA4FgBIdXqvCO0CBH52JjBEEDgoBMLMrk1NkRioWpxBD
	 emdulxUPBNoMRCBQrqN7xp06aeUIqXV04E3FHJRTbFGf/lFw5JDDNrtUg9fZLvxaLc
	 zfNyGcqQnC6+1EmWewFatqFwY4eMP3FTOl3TVtqx2tGflFih92ierSP4q2Z739Kq0y
	 k7mU24o5gDufAS+zBdQVy6Tyi9VLiOMDC6NPAknZlKw3tZ+Y/cTtGbq8c3/MZL9cZc
	 x44u2GCNLUjrqf0Mc1i94rRhZfiVpqPTzHr6b4h+r+40LtLc3nUEe5w+8wPq36M2Oo
	 vr5/2SJOq4VKg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 087/311] PCI: Correct PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 value
Date: Tue, 10 Mar 2026 07:02:14 -0400
Message-ID: <0616c042bd7fd441ee8ae10fd6de3a9a9bb072dc.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 217F524A2AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223952-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tkos.co.il:email]
X-Rspamd-Action: no action

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 39195990e4c093c9eecf88f29811c6de29265214 ]

fb82437fdd8c ("PCI: Change capability register offsets to hex") incorrectly
converted the PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 value from decimal 52 to hex
0x32:

  -#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 52      /* v2 endpoints with link end here */
  +#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 0x32    /* end of v2 EPs w/ link */

This broke PCI capabilities in a VMM because subsequent ones weren't
DWORD-aligned.

Change PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 to the correct value of 0x34.

fb82437fdd8c was from Baruch Siach <baruch@tkos.co.il>, but this was not
Baruch's fault; it's a mistake I made when applying the patch.

Fixes: fb82437fdd8c ("PCI: Change capability register offsets to hex")
Reported-by: David Woodhouse <dwmw2@infradead.org>
Closes: https://lore.kernel.org/all/3ae392a0158e9d9ab09a1d42150429dd8ca42791.camel@infradead.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/pci_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3add74ae25948..48b0616ddbbbd 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -707,7 +707,7 @@
 #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
 #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
 #define  PCI_EXP_LNKSTA2_FLIT		0x0400 /* Flit Mode Status */
-#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
+#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x34	/* end of v2 EPs w/ link */
 #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
 #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
 #define PCI_EXP_SLTCTL2		0x38	/* Slot Control 2 */
-- 
2.51.0


