Return-Path: <stable+bounces-218482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHqeBTJUnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:45:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B01F18FC1A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8635B308F83D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925324677D;
	Wed, 25 Feb 2026 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ivORkHBV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95D18B0A;
	Wed, 25 Feb 2026 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983311; cv=none; b=YNY5w6Kd6YNKnE3ZjjTsOvTAyQYlxfw8wRV+NS9EhMvdN9o22UgTVz7oY+IP3qtYHFISu3Bql5acmbsuAcd6tfggjyKK5Px2v4VHofNbIAIm2Bx/3DaOirGvglwoD50zgIUhxdYDdhcKo3svqwHH6dZ1Rs4kNG8pHd/uLSI9oOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983311; c=relaxed/simple;
	bh=irDwe8yRMji4YwO6LAsWlipahdLhe5e/ZsQnEBK4dyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsSmdI+Xknmeiv5ZpIJN0XnzeNPmVi4wCDwqjHrcOwaNU/c6mpReQv/wlpkD2ADbJjM0uQguv/zBoCUiTtZxHzwllQq2ZvG6za763wz6cGWPnId9GVBVvlS1kqrDoyHdtsbW8wVwEey5eTCSaf0qWq+S0Iv74mIXPkUWnLbe6Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ivORkHBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDCBC116D0;
	Wed, 25 Feb 2026 01:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983310;
	bh=irDwe8yRMji4YwO6LAsWlipahdLhe5e/ZsQnEBK4dyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivORkHBVkrLGk8a1Am74ad8BwpYHs9wl7P5IAIAWEssmVvFUJ1exLdZ8lSSTAaKLW
	 kN+XSi2DQtjkFWOLMRie7bsVPvPg7p7Jl2b0qqKP87dIwsYKfCXSRIGD2u+MIwrMfk
	 wOJfI4Z44xQiUdxy/6rV6XKPRAfQv2zPMq8l/Gnk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hariprasad Kelam <hkelam@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 437/781] octeontx2-pf: Unregister devlink on probe failure
Date: Tue, 24 Feb 2026 17:19:06 -0800
Message-ID: <20260225012410.421027569@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218482-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,marvell.com:email]
X-Rspamd-Queue-Id: 5B01F18FC1A
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit 943f3b8bfbf297cf74392b50a7108ce1fe4cbd8c ]

When probe fails after devlink registration, the missing devlink unregister
call causing a memory leak.

Fixes: 2da489432747 ("octeontx2-pf: devlink params support to set mcam entry count")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Link: https://patch.msgid.link/20260206182645.4032737-1-hkelam@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 6b2d8559f0eb1..444bb67494ab7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3315,6 +3315,7 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_sriov_cleannup:
 	otx2_sriov_vfcfg_cleanup(pf);
 err_pf_sriov_init:
+	otx2_unregister_dl(pf);
 	otx2_shutdown_tc(pf);
 err_mcam_flow_del:
 	otx2_mcam_flow_del(pf);
-- 
2.51.0




