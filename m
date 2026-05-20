Return-Path: <stable+bounces-253204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAeNLOkuDmoK7wUAu9opvQ
	(envelope-from <stable+bounces-253204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:00:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDEA59B928
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712C63979A83
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69DF40961E;
	Wed, 20 May 2026 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vR9BtaNv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE6E3FD147;
	Wed, 20 May 2026 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302673; cv=none; b=P/B99RLWTjhph3Euo36DeHP3TfFF0qNXapjohxGuAFGwEcGaaYhjOREfTiFdS8+GEIwptox5UXA5yGs7qmpnMv+RvvUVpIF8v75vj6A2VyCZU9JbSv8NWe9z14CJVzLTvNqt4IPqiSo3Utwn+G+5HDpZHxvpnVQKZX4d9Rpx0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302673; c=relaxed/simple;
	bh=2j8sE05NPC3V6DgOFk1yq/1DpmIF9rYLoUVI6mJo7wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcBQ2FgVE+HPs7nu+HnvM8oyNMAJUki5EjxKKGXKRFYyHtGK7SUVw3nzyPHEekQwXmuG+5SNjxqVT0n5Zir3AvvNz7ui5WZEsKFLVSOMung1PqFSScBiQlGfsb/8hnPr2t3yn2zfe+GzdRSZErO1a/krxbBmgWSdhNDkAmD/3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vR9BtaNv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ADC1F000E9;
	Wed, 20 May 2026 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302672;
	bh=sKTScCBgWsMdJ8tumms2yoeNTlz/LKQ5Nwj11mWcpOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vR9BtaNv1WN0CDt3k43Ps6LM2g0Yso6SBuY3mnbqcQ+hA46QOC34mGPchxgXgBBot
	 GLHl+NP7k1eo8KZOfbhWwb1aJ+KcEhCx+5Zl0rVDLDQNhzqwmrR80q3y/Ev+ktOLbK
	 vR32caFnl/ubyM9S2Dw6rS2euE0cCDpHX51kYN5E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Taegyu Kim <tmk5904@psu.edu>,
	Yuho Choi <dbgh9129@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 357/508] fbdev: offb: fix PCI device reference leak on probe failure
Date: Wed, 20 May 2026 18:23:00 +0200
Message-ID: <20260520162106.367669869@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-253204-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,psu.edu,gmx.de,kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,gmx.de:email,psu.edu:email]
X-Rspamd-Queue-Id: 1FDEA59B928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuho Choi <dbgh9129@gmail.com>

[ Upstream commit 869b93ba04088713596e68453c1146f52f713290 ]

offb_init_nodriver() gets a referenced PCI device with pci_get_device().
If pci_enable_device() fails, the function returns without dropping that
reference.

Release the PCI device reference before returning from the
pci_enable_device() failure path.

Fixes: 5bda8f7b5468 ("video: fbdev: offb: Call pci_enable_device() before using the PCI VGA device")
Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/offb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index dcb1b81d35db5..0e81d68378935 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -643,8 +643,13 @@ static void offb_init_nodriver(struct platform_device *parent, struct device_nod
 			vid = be32_to_cpup(vidp);
 			did = be32_to_cpup(didp);
 			pdev = pci_get_device(vid, did, NULL);
-			if (!pdev || pci_enable_device(pdev))
+			if (!pdev)
 				return;
+
+			if (pci_enable_device(pdev)) {
+				pci_dev_put(pdev);
+				return;
+			}
 		}
 #endif
 		/* kludge for valkyrie */
-- 
2.53.0




