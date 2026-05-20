Return-Path: <stable+bounces-250094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMYJK84MDmo35wUAu9opvQ
	(envelope-from <stable+bounces-250094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:34:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB4F598720
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30BC3358AEEA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E391536405A;
	Wed, 20 May 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="01rTLCQQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841BD36494B;
	Wed, 20 May 2026 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294530; cv=none; b=IaMYsoRTn3dZIQehwWLvCcM7jfOLIBJvaUIsXiSToknFy8T0BxnQSc4OwavUW/B8tJPG0JiYT3y8kIxInwLOCDaUNCbp1G7ntuc7rV5IrkMYUr9xMM/zDfHtOcRRPGKxPfgoqjUvLZr5vLfx3nGhDQEu4FitwXr5ojid5ieizz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294530; c=relaxed/simple;
	bh=5ruxJZNlLWNhbeKiERSbII2S9PRxDqFJcvU+pFlUrbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBTJ80q69BY2NJwxch2fJbXBgd9xFmfDdL5usNhjqA+BRId8fsUzMDuD9zetns2iNL4hLIBIsGEYECPq2tOOx4DwnumJ9VPEOY3JgEdSDslTarHr+kdSuex6PEVZ1XTvph2TKGe0uL4Nr7TJJkfbCr5xioUs6DwIDefA6/V/CdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=01rTLCQQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798401F000E9;
	Wed, 20 May 2026 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294527;
	bh=IPaq1Mx/Duka+WnuRx4gNxaFpb6upoakUbIQGvWM3ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=01rTLCQQ6bzLaoaZEOQRWXjhaW9+7YSXST2xJJJi+ztFbRn2VjXvh1Rmx+DvZCp28
	 3ReFSDZ3DZ+YL+JiDAcCgxloGFdOUZXy3MOR2ZC77+O+eVif1rDb9VP4SDhbl3Kx7M
	 DOXuxUgPUtKtfQ6LoCLU4uV7PHS2jxCh7/cOFsSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Duoming Zhou <duoming@zju.edu.cn>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0072/1146] wifi: rtlwifi: pci: fix possible use-after-free caused by unfinished irq_prepare_bcn_tasklet
Date: Wed, 20 May 2026 18:05:22 +0200
Message-ID: <20260520162149.987582685@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250094-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,zju.edu.cn:email]
X-Rspamd-Queue-Id: 0BB4F598720
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 039cd522dc70151da13329a5e3ae19b1736f468a ]

The irq_prepare_bcn_tasklet is initialized in rtl_pci_init() and
scheduled when RTL_IMR_BCNINT interrupt is triggered by hardware.
But it is never killed in rtl_pci_deinit(). When the rtlwifi card
probe fails or is being detached, the ieee80211_hw is deallocated.
However, irq_prepare_bcn_tasklet may still be running or pending,
leading to use-after-free when the freed ieee80211_hw is accessed
in _rtl_pci_prepare_bcn_tasklet().

Similar to irq_tasklet, add tasklet_kill() in rtl_pci_deinit() to
ensure that irq_prepare_bcn_tasklet is properly terminated before
the ieee80211_hw is released.

The issue was identified through static analysis.

Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260223045522.48377-1-duoming@zju.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index d080469264cf8..f0010336e78c1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1674,6 +1674,7 @@ static void rtl_pci_deinit(struct ieee80211_hw *hw)
 
 	synchronize_irq(rtlpci->pdev->irq);
 	tasklet_kill(&rtlpriv->works.irq_tasklet);
+	tasklet_kill(&rtlpriv->works.irq_prepare_bcn_tasklet);
 	cancel_work_sync(&rtlpriv->works.lps_change_work);
 }
 
-- 
2.53.0




