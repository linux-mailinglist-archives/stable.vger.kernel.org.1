Return-Path: <stable+bounces-229496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCTrEe9fwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:44:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F5C2F6D24
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B74BD30FD483
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAA13BF671;
	Mon, 23 Mar 2026 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZnFLEnZ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410793BF664;
	Mon, 23 Mar 2026 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279419; cv=none; b=l0kQSdQ0rDg+49OCONq4NGJDcttyNorNBG120HlvuJ3uiatPfQuPhDsNI9HZoBO+XQUtaNhD3xF0CoGMQ/ZFolJ5j7wjzZfIhraGLb1Vg6+i5I+bM1Sk0q8cg6iE2+j7ZAfsJ7sKcJJ9lG9lu4+ee7bX5S7IlrG7o4AsCm3uxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279419; c=relaxed/simple;
	bh=Kgy9DIQZRBZ1mWxT8l6VdDq9wlRGNwhzhYzybtKL8go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSu7gXrbPU3P6k41ec24YDoPrug1xOUcA13wXKPUMqrUED9yFOxH/M3Y3Cj4EW+K3QxvTYoONrsup1g9gK12p2AO8R6ks1H0hp1bdEYJNNiBX3Sk9yk5ZwoIPoUU1BlOjHb/DhSncIatTbGf+gjKdu5HtVCjd1FG0r/uEHwny8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZnFLEnZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B49C4CEF7;
	Mon, 23 Mar 2026 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279419;
	bh=Kgy9DIQZRBZ1mWxT8l6VdDq9wlRGNwhzhYzybtKL8go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnFLEnZ5+aqCi21Y4DtwFJumno+87a7whcLLQkZ8oVc36aZKEf9utzXPDJAhcXKi4
	 t20j5D6NdssUCCD2nikBJ0IQepb9NYEb83/EU6KFOBW68O6106w1JLTw412Jtz18RD
	 5KXBDdIE+uV5BZy+FbXr2h+k2yVg2SQAWm90wsYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 021/481] PCI: Fix printk field formatting
Date: Mon, 23 Mar 2026 14:40:03 +0100
Message-ID: <20260323134525.764409737@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229496-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: F3F5C2F6D24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 62008578b73f16e274070a232b939ba5933bb8ba ]

Previously we used "%#08x" to print a 32-bit value.  This fills an
8-character field with "0x...", but of course many 32-bit values require a
10-character field "0x12345678" for this format.  Fix the formats to avoid
confusion.

Link: https://lore.kernel.org/r/20230824193712.542167-5-helgaas@kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 11721c45a826 ("PCI: Use resource_set_range() that correctly sets ->end")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-res.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 967f9a7589239..ceaa69491f5ef 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -104,7 +104,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	pci_read_config_dword(dev, reg, &check);
 
 	if ((new ^ check) & mask) {
-		pci_err(dev, "BAR %d: error updating (%#08x != %#08x)\n",
+		pci_err(dev, "BAR %d: error updating (%#010x != %#010x)\n",
 			resno, new, check);
 	}
 
@@ -113,7 +113,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 		pci_write_config_dword(dev, reg + 4, new);
 		pci_read_config_dword(dev, reg + 4, &check);
 		if (check != new) {
-			pci_err(dev, "BAR %d: error updating (high %#08x != %#08x)\n",
+			pci_err(dev, "BAR %d: error updating (high %#010x != %#010x)\n",
 				resno, new, check);
 		}
 	}
-- 
2.51.0




