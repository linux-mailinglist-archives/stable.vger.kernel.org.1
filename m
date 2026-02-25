Return-Path: <stable+bounces-218365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKxTORpTnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A64C18F6CD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A42830B0920
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FB81D5ABA;
	Wed, 25 Feb 2026 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B7+P7hsR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EE71E2834;
	Wed, 25 Feb 2026 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983175; cv=none; b=qHFEDL0luDPaFnWqn3TpCQizKYtZw+AyoZPFCXztToEqonsqtPyMSSBJ44kWl525oIBQRUXrcyExBc0XvjGmP103JdkDAYuBFEU5GGsqzqJpiJXSKYHNxeEeWry38ENUHt3lfyU/dIIKTiX8h3C+sNGLOuRSr3VSHgr3iDLGCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983175; c=relaxed/simple;
	bh=yy3/pnt8Nd6nl/naPdnDOBQLvqZ58i3hiHDZhDCZRpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIlD98+zLh58fjwNaJQhOmM3cRpK8N1ZlhKjeAm97EWgVI1E4Cb7otPGafNL3ua8TXTgCUGLEujmY1mJjI2IaHDOTeYcuH8ww2r+0W3k6TMjQLqn3HsoMFrxEMc2RjW/rbf8sB7JNNnuacSFLubuET0hIHo4HMqhhiipiISfYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B7+P7hsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007E6C116D0;
	Wed, 25 Feb 2026 01:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983175;
	bh=yy3/pnt8Nd6nl/naPdnDOBQLvqZ58i3hiHDZhDCZRpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7+P7hsRnW9KEjF4K1y9ZBhTkhrq7c5SDSU8Hx53O70IgghqPl1NyziXAgaNmhydy
	 hRym+tEAMs6FA5K0cpVK3fmPJnpXGTB/vaN3/Q5596ysOiYXEIqrZMkqK5GM6RzTz+
	 0ke2jHZtDhgqXjrOKE1ew7xtOAY5FstWM7+JbxHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 327/781] PCI: Do not attempt to set ExtTag for VFs
Date: Tue, 24 Feb 2026 17:17:16 -0800
Message-ID: <20260225012407.725153674@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218365-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,oracle.com:email,linux.dev:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1A64C18F6CD
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Håkon Bugge <haakon.bugge@oracle.com>

[ Upstream commit 73711730a1128d91ebca1a6994ceeb18f36cb0cd ]

The bit for enabling extended tags is Reserved and Preserved (RsvdP) for
VFs, according to PCIe r7.0 section 7.5.3.4 table 7.21.  Hence, bail out
early from pci_configure_extended_tags() if the device is a VF.

Otherwise, we may see incorrect log messages such as:

  kernel: pci 0000:af:00.2: enabling Extended Tags

(af:00.2 is a VF)

Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://patch.msgid.link/20251112095442.1913258-1-haakon.bugge@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d9..86665658d7047 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2270,7 +2270,8 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 	u16 ctl;
 	int ret;
 
-	if (!pci_is_pcie(dev))
+	/* PCI_EXP_DEVCTL_EXT_TAG is RsvdP in VFs */
+	if (!pci_is_pcie(dev) || dev->is_virtfn)
 		return 0;
 
 	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
-- 
2.51.0




