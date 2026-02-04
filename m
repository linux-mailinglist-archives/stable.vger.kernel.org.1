Return-Path: <stable+bounces-214223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA34ESNpg2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:43:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD00E9378
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F35C3313EC1C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE662D978A;
	Wed,  4 Feb 2026 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ArGscxhH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620272D5950;
	Wed,  4 Feb 2026 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218974; cv=none; b=nXW/jItQ4GkLV4M4cZyZvjnaSpT06vYM/GQDtNH0GgOyH+0gQfY+MOjnu/XTRNADlp/ntxy7eGGP1GYtbpHWg7UOwdlwwyhEvDxXhqsw/Fi3UN/lmYpHn4MImDO71wHiwFfCC6NfXLG5y5wJ1E3Thn5xMVzgIUbpn6jvtz6o2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218974; c=relaxed/simple;
	bh=C3mJhrfBAdXP3aKo5AD+UZ8IYXMTBYx3DWjMb/rsg6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWMIy42BmSev6xi242yiYCcZcACNQ30PIFLPGNj1SD4Ya0M7PdO3E3gT3oluQwuhzySClzAJsD9eqNMISU5lRTkJ1VOUMYqYKe6aijq6UN2QjLWOM24QzDilo4QADs5CSsYtrcVZgf9L5OPq4K2TXrHvuF7Zm39C+QtGQkmcaJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ArGscxhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7B3C4CEF7;
	Wed,  4 Feb 2026 15:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218974;
	bh=C3mJhrfBAdXP3aKo5AD+UZ8IYXMTBYx3DWjMb/rsg6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ArGscxhHFfEuXvCi4drPt7zrZLlJu6ZLPzqkk2YFNKxAW3mbxN2uW1pyg8moHlwBY
	 n+pYA9Hyaeim+rs4E2aHoICbL9EL1Vlq4rnTZo2ciDSDaRYj+BkWrCUghdTru/QVYJ
	 fVwHH2WxFUv1BMwYfFkZYLuWCeW0qZaWnT7RKXQU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Kohei Enju <enjuk@amazon.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 022/122] ixgbe: dont initialize aci lock in ixgbe_recovery_probe()
Date: Wed,  4 Feb 2026 15:40:04 +0100
Message-ID: <20260204143852.664275663@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214223-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: ADD00E9378
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kohei Enju <enjuk@amazon.com>

[ Upstream commit 100cf7b4ca6ed770ec4287f3789b1da2e340a05a ]

hw->aci.lock is already initialized in ixgbe_sw_init(), so
ixgbe_recovery_probe() doesn't need to initialize the lock. This
function is also not responsible for destroying the lock on failures.

Additionally, change the name of label in accordance with this change.

Fixes: 29cb3b8d95c7 ("ixgbe: add E610 implementation of FW recovery mode")
Reported-by: Simon Horman <horms@kernel.org>
Closes: https://lore.kernel.org/intel-wired-lan/aTcFhoH-z2btEKT-@horms.kernel.org/
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ee1007e9b6355..3edebca958307 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11476,10 +11476,9 @@ static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
 		return err;
 
 	ixgbe_get_hw_control(adapter);
-	mutex_init(&hw->aci.lock);
 	err = ixgbe_get_flash_data(&adapter->hw);
 	if (err)
-		goto shutdown_aci;
+		goto err_release_hw_control;
 
 	timer_setup(&adapter->service_timer, ixgbe_service_timer, 0);
 	INIT_WORK(&adapter->service_task, ixgbe_recovery_service_task);
@@ -11502,8 +11501,7 @@ static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
 	devl_unlock(adapter->devlink);
 
 	return 0;
-shutdown_aci:
-	mutex_destroy(&adapter->hw.aci.lock);
+err_release_hw_control:
 	ixgbe_release_hw_control(adapter);
 	return err;
 }
-- 
2.51.0




