Return-Path: <stable+bounces-218525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOAfBJdSnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:38:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FD318F42E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8AE5309239F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1F242D9B;
	Wed, 25 Feb 2026 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WXIk0DW4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B818B0A;
	Wed, 25 Feb 2026 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983361; cv=none; b=VmkMlyNin1F5m/hpvLgnm9QBBOsZgswFZygIlrm1l61asn141kvn0lTWqdBs1H5v8Fdx1+bQw6uLI0R+PRsYKNItGL/wNHwHVS2aKJrwO/T7gWn8ieu5C90RrFB2CnU6gpGsZW3Ubj6QhaeDNYNmdBCKdneXm6gnRqSmZTdncpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983361; c=relaxed/simple;
	bh=sakwBSFzZRWbyBUIVi4PG5IErjGfCPyOOUXR3t9ZuUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAMQZqy8C1AumD/e9DBQtQHluDdS86PMlNZadB4kIhfisSbZasDCHIioy+0iet2skyk5em2oWy9U8GDTKixpBHOmvsg+r65sLNrlekxOpDfQCA58gOB9aNo3fCcKEu0XveOMdv89xXEgg4kPdPxQBO4nMo7hcr75uBzSya0Hqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WXIk0DW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B622C19423;
	Wed, 25 Feb 2026 01:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983361;
	bh=sakwBSFzZRWbyBUIVi4PG5IErjGfCPyOOUXR3t9ZuUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXIk0DW4VD04Ei0mZ4CM0KKeb6oDWTzxRJ5V9vb/IS+L1mv/DyKAOro/vy1OnR+CA
	 zTLWtOeLvoZzEpMVszzWU3Sww1OCKs/VaFV/1cGDGE3ycPypa/XXYHPE3PeMWwGPbb
	 vAwfcNp3YB7Ko/5wRauVDSt+SWBAW+S/eKS0Jxig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maher Sanalla <msanalla@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 445/781] RDMA/mlx5: Fix ucaps init error flow
Date: Tue, 24 Feb 2026 17:19:14 -0800
Message-ID: <20260225012410.622080646@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218525-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B8FD318F42E
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maher Sanalla <msanalla@nvidia.com>

[ Upstream commit 6dc78c53de99e4ed9868d4f0fc6da6e46f52fe4d ]

In mlx5_ib_stage_caps_init(), if mlx5_ib_init_ucaps() fails after
mlx5_ib_init_var_table() succeeds, the VAR bitmap is leaked since
the function returns without cleanup.

Thus, cleanup the var table bitmap in case of error of initializing
ucaps before exiting, preventing the leak above.

Fixes: cf7174e8982f ("RDMA/mlx5: Create UCAP char devices for supported device capabilities")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Link: https://patch.msgid.link/20260104-ib-core-misc-v1-3-00367f77f3a8@nvidia.com
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 40284bbb45d6d..8d515d266125e 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4466,12 +4466,16 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	    MLX5_HCA_CAP_2_GENERAL_OBJECT_TYPES_RDMA_CTRL) {
 		err = mlx5_ib_init_ucaps(dev);
 		if (err)
-			return err;
+			goto err_ucaps;
 	}
 
 	dev->ib_dev.use_cq_dim = true;
 
 	return 0;
+
+err_ucaps:
+	bitmap_free(dev->var_table.bitmap);
+	return err;
 }
 
 static const struct ib_device_ops mlx5_ib_dev_port_ops = {
-- 
2.51.0




