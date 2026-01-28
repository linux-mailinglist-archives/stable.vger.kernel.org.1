Return-Path: <stable+bounces-212511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFNXAEw5eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:29:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A3A5B09
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86A5030D9006
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF5B304968;
	Wed, 28 Jan 2026 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0GIDuZh2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C21D6AA;
	Wed, 28 Jan 2026 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615762; cv=none; b=axdeokV24DvZ/uoR40+nTGzgPvEuqHomdOvqHyDCjC8rNyQoKHlkczSFgL1JJ7BbH2dqJm+U577z3oDyZy+jAvO+aac77Q4JFmB5Z0g35JauAgsuOGYxHnRkVM66hzXamrAVNtVXvJqcJSusxer4KHza32Sd+oB5Ed2jXk3Dy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615762; c=relaxed/simple;
	bh=ilH5ktigD/fqM5H6RQuAD0zhPjo9H9ZHtzSh1cKzKho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioj7YW1ihqGbke5AtKEBpjprVuu8MOeleqBTNy4LlsihMTUJ9OgRGfu+xdoy1TWHhoMwVHeBNDsekeZ+G5i5LL0CBDJ9Ug9blRgu14VDN3fAprw0uPVCf8hQ/qdkEjO7HUweVdbN/j0QWw302bJWn30+8KQBx52W+h3SzhvLJqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0GIDuZh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEABC116C6;
	Wed, 28 Jan 2026 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615762;
	bh=ilH5ktigD/fqM5H6RQuAD0zhPjo9H9ZHtzSh1cKzKho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0GIDuZh2Nzu1oDRm0yGrXWVndAV1ZMQDlm5y8BHYTTNgprn3M9CmKvSTy4zvKyYZI
	 oBf8oiPQZLheovsXxjwuaDehGsrFZe0j19ZCB6HBzzen+UHzEK3/T3ikGVKM3GaWVT
	 WOkU4xcOKBjSjq7UGNFT/tBlCKscZlHEx00Kg5vQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	lrizzo@google.com,
	namangulati@google.com,
	willemb@google.com,
	intel-wired-lan@lists.osuosl.org,
	milena.olech@intel.com,
	jacob.e.keller@intel.com,
	Shachar Raindel <shacharr@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 107/227] idpf: read lower clock bits inside the time sandwich
Date: Wed, 28 Jan 2026 16:22:32 +0100
Message-ID: <20260128145348.320547320@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212511-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A46A3A5B09
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mina Almasry <almasrymina@google.com>

[ Upstream commit bdfc7b55adcd04834ccc1b6b13e55e3fd7eaa789 ]

PCIe reads need to be done inside the time sandwich because PCIe
writes may get buffered in the PCIe fabric and posted to the device
after the _postts completes. Doing the PCIe read inside the time
sandwich guarantees that the write gets flushed before the _postts
timestamp is taken.

Cc: lrizzo@google.com
Cc: namangulati@google.com
Cc: willemb@google.com
Cc: intel-wired-lan@lists.osuosl.org
Cc: milena.olech@intel.com
Cc: jacob.e.keller@intel.com

Fixes: 5cb8805d2366 ("idpf: negotiate PTP capabilities and get PTP clock")
Suggested-by: Shachar Raindel <shacharr@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 3e1052d070cfd..0a8b50350b860 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -108,11 +108,11 @@ static u64 idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter,
 	ptp_read_system_prets(sts);
 
 	idpf_ptp_enable_shtime(adapter);
+	lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
 
 	/* Read the system timestamp post PHC read */
 	ptp_read_system_postts(sts);
 
-	lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
 	hi = readl(ptp->dev_clk_regs.dev_clk_ns_h);
 
 	spin_unlock(&ptp->read_dev_clk_lock);
-- 
2.51.0




