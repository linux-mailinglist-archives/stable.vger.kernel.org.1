Return-Path: <stable+bounces-219021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE+IFjVXnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-219021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:58:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD571904C1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6B0C30ED503
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A84427E1DC;
	Wed, 25 Feb 2026 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tL8xyyYa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31918DF80;
	Wed, 25 Feb 2026 01:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983934; cv=none; b=AADrWU7Jsfd+U4ETBYBYtsUt93kiyflZg6DixG2fm9b/Dhs0v9y+Bx0OUtQ1VILwVaHKfSFxrrvwe+xee0FyYUKxZWKuK3ZjwZ6gEQG9EPm7A0SPYrAtLStOkN2bJUKrw9RJq2/Xyyf2mqZeeNmGRqQ36ITK8iIW3iSC176kRG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983934; c=relaxed/simple;
	bh=Uns/O6IWuJ4ZECrPTIgfc8Vcy25TNyJ5x57B/a6n/bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPIIsU3VDom9+6r8YkkPDjZmsFmLWC+fmOZWPj96bpnpn1F1YiBRUrUwH88/q6JH/rNaiR1r84OMKTRO+liR26/wgfrJUsArDXUOPQTpHYnqtN5Zxz+Kb6QNKgoaxsTca5UuVWc4Sfy1rwJMEW3dYfyiWIfLFbv3xUqh2Ut9gms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tL8xyyYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6A2C116D0;
	Wed, 25 Feb 2026 01:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983934;
	bh=Uns/O6IWuJ4ZECrPTIgfc8Vcy25TNyJ5x57B/a6n/bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tL8xyyYaN4tDVFNP7WNe/J66iZTKmOTWm/WOel2+4/TnQAQUm8miCd/uEaH0S29B7
	 7VyTebro/hjOFUAzpe6WsJq2hY87uIw9zLnggDlgrrU/Zzpc416yA/lwzICiqU+Tem
	 uitJtBKeW2PrKstREPwRPdvXhhv8WK0PkdFobFWY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Minnekhanov <alexeymin@postmarketos.org>,
	Alexey Minnekhanov <alexeymin@minlexx.ru>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 199/641] drm/msm/dpu: fix CMD panels on DPU 1.x - 3.x
Date: Tue, 24 Feb 2026 17:18:45 -0800
Message-ID: <20260225012353.800596771@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219021-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,postmarketos.org:email,qualcomm.com:email,patchwork.freedesktop.org:url,minlexx.ru:email]
X-Rspamd-Queue-Id: AFD571904C1
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 59ca3d11f5311d9167015fe4f431701614ae0048 ]

DPU units before 4.x don't have a separate CTL_START IRQ to mark the
begin of the data transfer. In such a case, wait for the frame transfer
to complete rather than trying to wait for the CTL_START interrupt (and
obviously hitting the timeout).

Fixes: 050770cbbd26 ("drm/msm/dpu: Fix timeout issues on command mode panels")
Reported-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
Closes: https://lore.kernel.org/r/8e1d33ff-d902-4ae9-9162-e00d17a5e6d1@postmarketos.org
Patchwork: https://patchwork.freedesktop.org/patch/696490/
Link: https://lore.kernel.org/r/20251228-mdp5-drop-dpu3-v4-2-7497c3d39179@oss.qualcomm.com
Tested-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index 0ec6d67c7c70b..93db1484f6069 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -681,10 +681,11 @@ static int dpu_encoder_phys_cmd_wait_for_commit_done(
 	if (!dpu_encoder_phys_cmd_is_master(phys_enc))
 		return 0;
 
-	if (phys_enc->hw_ctl->ops.is_started(phys_enc->hw_ctl))
-		return dpu_encoder_phys_cmd_wait_for_tx_complete(phys_enc);
+	if (phys_enc->irq[INTR_IDX_CTL_START] &&
+	    !phys_enc->hw_ctl->ops.is_started(phys_enc->hw_ctl))
+		return _dpu_encoder_phys_cmd_wait_for_ctl_start(phys_enc);
 
-	return _dpu_encoder_phys_cmd_wait_for_ctl_start(phys_enc);
+	return dpu_encoder_phys_cmd_wait_for_tx_complete(phys_enc);
 }
 
 static void dpu_encoder_phys_cmd_handle_post_kickoff(
-- 
2.51.0




