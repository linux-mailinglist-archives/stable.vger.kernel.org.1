Return-Path: <stable+bounces-246852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLW8FsV8BGpCKwIAu9opvQ
	(envelope-from <stable+bounces-246852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:29:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76853413F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3CEF31CC9E5
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A022868AB;
	Wed, 13 May 2026 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IurQqxZO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421E27A133
	for <stable@vger.kernel.org>; Wed, 13 May 2026 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677876; cv=none; b=fJgfH0uzsH3nZxINX5NQMrHvabJAWGWSk7o/lf1cc1xEeQ8nu2Xn70QbsJhT1ywZLaN81tZMyekxykJyeowN80v75INaXe3bfbn+BNx/HuBn3jMfA7fwNtQRp7+x/yk2wsOugwcOj1gAlb67APZCqVoKhbJ+hWIY+uVdEuVotn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677876; c=relaxed/simple;
	bh=/Fums9AIsXB5WN+kbao42/1zaVWUibjkfF3BnxWlcBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhuBrxqmOTcZJ9PmOK89DAcw1h5fqjipXJ12+SxOuhB07qrW1JIScRSDOJwLmt1xKdkUM0LdVPJCL5JGLzlhNJwayJc8Hk5qLzubyzY4eHTBem/UHcW+taiTJru25hIToUSLipARhhbC/KWwQ33j4bMMA4tbXXkZIITHQUBhpEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IurQqxZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89CBC32781;
	Wed, 13 May 2026 13:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778677876;
	bh=/Fums9AIsXB5WN+kbao42/1zaVWUibjkfF3BnxWlcBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IurQqxZOumPRtLDlH0tMbxIFW/33B1vr9z1oSHwFMX4NJ/x0IXFK4aRueiLmZYGAY
	 6JGcns2Sjr5SmvgsbRwPsSBl96rCBW5N/e9vx/bfGCt4bu0MI9ktmbwLJKyFixJZwl
	 7FQ2lsQ0G533c1EQ75ciqHq9H7NSpQw0cimGovXneq17zVAkw/yOS/30HVT9rFv0Lh
	 8WuLz64tyVIyU5s/WrwYYlD91L15Z7FwRqWGcW0pQY+/swL/9yd5Xh1Frbql2ykK0Q
	 nEYZZAVB7htZyGfJK9jpr9HgcUwMGD2Gpq7q+GOfMp55u+TPbilTSGPE/NddvL9kIK
	 XTWVLiBKQ4sDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task
Date: Wed, 13 May 2026 09:11:14 -0400
Message-ID: <20260513131114.3723069-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051207-posing-gauze-27af@gregkh>
References: <2026051207-posing-gauze-27af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DA76853413F
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
	TAGGED_FROM(0.00)[bounces-246852-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,msgid.link:url,intel.com:email,broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit c623b63580880cc742255eaed3d79804c1b91143 ]

Watchdog task might end between send_sig() and kthread_stop() calls, what
results in the use-after-free issue. Fix this by increasing watchdog task
reference count before calling send_sig() and dropping it by switching to
kthread_stop_put().

Cc: stable@vger.kernel.org
Fixes: 373c83a801f1 ("brcmfmac: stop watchdog before detach and free everything")
Fixes: a9ffda88be74 ("brcm80211: fmac: abstract bus_stop interface function pointer")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260416093339.2066829-1-m.szyprowski@samsung.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ replaced kthread_stop_put() with open-coded kthread_stop() + put_task_struct() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 5006aa8317513..76b2953725c2d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -2474,8 +2474,10 @@ static void brcmf_sdio_bus_stop(struct device *dev)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	if (bus->watchdog_tsk) {
+		get_task_struct(bus->watchdog_tsk);
 		send_sig(SIGTERM, bus->watchdog_tsk, 1);
 		kthread_stop(bus->watchdog_tsk);
+		put_task_struct(bus->watchdog_tsk);
 		bus->watchdog_tsk = NULL;
 	}
 
@@ -4549,8 +4551,10 @@ void brcmf_sdio_remove(struct brcmf_sdio *bus)
 	if (bus) {
 		/* Stop watchdog task */
 		if (bus->watchdog_tsk) {
+			get_task_struct(bus->watchdog_tsk);
 			send_sig(SIGTERM, bus->watchdog_tsk, 1);
 			kthread_stop(bus->watchdog_tsk);
+			put_task_struct(bus->watchdog_tsk);
 			bus->watchdog_tsk = NULL;
 		}
 
-- 
2.53.0


