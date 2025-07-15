Return-Path: <stable+bounces-162545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B26BB05EB5
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85DD1C43AE0
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D562E49B7;
	Tue, 15 Jul 2025 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PbGWInKs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710A2E3AEA;
	Tue, 15 Jul 2025 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586838; cv=none; b=XHUjplF0g/IN2XJrjpFfidcAlLoSkMfQAVtqgcF+pDoAVRXWC16+TOepFedLcMHJpRJW24TLHztoNrtgeuOkvGiN8nDFVBIffvdslXaN3SGRpUELqiQQDYrIqQpEKRZVmHDi600o1glNRcngVzlQszvr/e4Dy51KAOOQCMv7xGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586838; c=relaxed/simple;
	bh=Jo328c2a7s3k8khT/HWvuHCRHSJQ2yt7KLqjI2+7UWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYLIZ2YklcyBu6o8WRDgVJIThjHKH/od8tznyYd0Ng6dZ7kcGoV4myU7QDUjjYh7KBa83IrPgeP4uvdCnrAdEQRot1vfBRu8uKAiTGBSxyca6D1rh5QOb8zgGKrsVEde2mz4WjfO4Dq/oCKOgvKfYwcIVpjjG9jCqwjmvUq5/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PbGWInKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB14C4CEE3;
	Tue, 15 Jul 2025 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586838;
	bh=Jo328c2a7s3k8khT/HWvuHCRHSJQ2yt7KLqjI2+7UWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PbGWInKsXTrq6bpeKzN5zpT6MZ6nxetu1HBPhPAI2gSi6MXjzmMQGp0Ec9OvkbjtO
	 j2IUE0XhIfIHoqpvfaoD6gUtNbmw6WNW9ECHqdyrCNoZv3hSp9KMbg7lQk5wpZPAKu
	 8G8HFaCexN6sNmmJHOJPh/AGNtL19HGcXsPogxAg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <haoxiang_li2024@163.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.15 068/192] net: ethernet: rtsn: Fix a null pointer dereference in rtsn_probe()
Date: Tue, 15 Jul 2025 15:12:43 +0200
Message-ID: <20250715130817.667584469@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <haoxiang_li2024@163.com>

commit 95a234f6affbf51f06338383537ab80d637bb785 upstream.

Add check for the return value of rcar_gen4_ptp_alloc()
to prevent potential null pointer dereference.

Fixes: b0d3969d2b4d ("net: ethernet: rtsn: Add support for Renesas Ethernet-TSN")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://patch.msgid.link/20250703100109.2541018-1-haoxiang_li2024@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/renesas/rtsn.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/renesas/rtsn.c
+++ b/drivers/net/ethernet/renesas/rtsn.c
@@ -1259,7 +1259,12 @@ static int rtsn_probe(struct platform_de
 	priv = netdev_priv(ndev);
 	priv->pdev = pdev;
 	priv->ndev = ndev;
+
 	priv->ptp_priv = rcar_gen4_ptp_alloc(pdev);
+	if (!priv->ptp_priv) {
+		ret = -ENOMEM;
+		goto error_free;
+	}
 
 	spin_lock_init(&priv->lock);
 	platform_set_drvdata(pdev, priv);



