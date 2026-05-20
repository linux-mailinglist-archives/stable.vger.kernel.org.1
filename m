Return-Path: <stable+bounces-253228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJsxCQ8vDmoK7wUAu9opvQ
	(envelope-from <stable+bounces-253228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:00:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E39859B960
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5451287C25
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35AE3BA237;
	Wed, 20 May 2026 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OtLYl+EE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF13FDC00;
	Wed, 20 May 2026 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302731; cv=none; b=X1DzRgJBXwRLEmWcCyKTqvM3hGC5ve2DdpE4IfmR1TMCpZssqomMVWG8mewuWgPPbvzEqwZBZMKsGF7gq/2Uj76QOApcyFkiVbSG1m8w8Lw/Bpj/b8t/ZunU5EvvlnPAMxtqz/qZKtwKb1NrRR3A8Kbxd0hkL2PrbdbW9JN7SOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302731; c=relaxed/simple;
	bh=+9YcZJea2W+9Rbs4PYU9s6I/seQESznPIJdanjEUDiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgC8rv2n5Mco8p0J4cuQX/AxfkE6+II72uIC9Hyud/t9l00tyg8QZALAS1QlN5pyRPIEb+/H3uZ1uXB87l1g7mLxXCHuJCGVaGexZT7tWn6LygeYCyUtFzUObSE5b3csYgh1PUWq4Y9vYMSPqLvNxh2fCXL1rsmmDBs9o8Drkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OtLYl+EE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7071F000E9;
	Wed, 20 May 2026 18:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302730;
	bh=J0uronvOI1w9kxUHKGPBUI03epUmaGC/HO4MNXDgdjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OtLYl+EEa/l17ERu0MX+70lzkqeDlQouwtCJyHlflsrNMtTmZYp0PAB2VctmotM59
	 dzQIpqboaqFruZc6ULRwEeQRA3UGPxv/WsHd/HFGLRn6XOaztG8pJTMvxZt5TlMUfn
	 BI9Mfdyzq2PRk9S35N19NRTOFM8l4Rqgt/TBIyI0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Taegyu Kim <tmk5904@psu.edu>,
	Yuho Choi <dbgh9129@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 377/508] drm/sysfb: ofdrm: fix PCI device reference leaks
Date: Wed, 20 May 2026 18:23:20 +0200
Message-ID: <20260520162106.791230846@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253228-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,psu.edu,suse.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,psu.edu:email,msgid.link:url]
X-Rspamd-Queue-Id: 8E39859B960
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuho Choi <dbgh9129@gmail.com>

[ Upstream commit 4aa8110000b0d215deef8eed283565dd0c1def88 ]

display_get_pci_dev_of() gets a referenced PCI device via
pci_get_device(). Drop that reference when pci_enable_device() fails and
release it during the managed teardown path after pci_disable_device().

Without that, ofdrm leaks the pci_dev reference on both the error path
and the normal cleanup path.

Fixes: c8a17756c425 ("drm/ofdrm: Add ofdrm for Open Firmware framebuffers")
Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patch.msgid.link/20260420002513.216-1-dbgh9129@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/ofdrm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
index 2d999a0facdee..fe2d3b7c61258 100644
--- a/drivers/gpu/drm/tiny/ofdrm.c
+++ b/drivers/gpu/drm/tiny/ofdrm.c
@@ -351,6 +351,7 @@ static void ofdrm_pci_release(void *data)
 	struct pci_dev *pcidev = data;
 
 	pci_disable_device(pcidev);
+	pci_dev_put(pcidev);
 }
 
 static int ofdrm_device_init_pci(struct ofdrm_device *odev)
@@ -376,6 +377,7 @@ static int ofdrm_device_init_pci(struct ofdrm_device *odev)
 	if (ret) {
 		drm_err(dev, "pci_enable_device(%s) failed: %d\n",
 			dev_name(&pcidev->dev), ret);
+		pci_dev_put(pcidev);
 		return ret;
 	}
 	ret = devm_add_action_or_reset(&pdev->dev, ofdrm_pci_release, pcidev);
-- 
2.53.0




