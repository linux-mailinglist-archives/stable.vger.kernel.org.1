Return-Path: <stable+bounces-54052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CA090EC71
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FACB211BB
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7871442F1;
	Wed, 19 Jun 2024 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1L+oGw2r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92212FB31;
	Wed, 19 Jun 2024 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802450; cv=none; b=TUfPcKl75OqCooYule5Q9r9y8PCtiQA51/5UFvx9AMG8VijWE++lWDs7NAFbs4ymDDscw0bxU6Oyt9acxVvZ6RQ0IKoanpqCviy4MXjtZDE/g/bQLjQdARGAyiV9nNNw2hXUoLFuIAXKjuknbvSapA8iUjp+NGtFboikDinCKiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802450; c=relaxed/simple;
	bh=RqEeq6YmTjd3QUiU4aKggw3vP7hHtMcDrL6pq3m9eEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUbDUyCG840bStkKkQE2eUgrMGE/eMHgCGSa/wHShcDPsnlXTcQ+tDNJySgkEgViyR06XugKfAoPnSEjIG1dkkMqxWQ80wdCRewxr8uPskIR2r7scb3xrQSt/ove4jcG28Aw3XKRYGr8/s8qGk0cnCm04ysh6Tk2z/g045E5EaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1L+oGw2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5748C2BBFC;
	Wed, 19 Jun 2024 13:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802450;
	bh=RqEeq6YmTjd3QUiU4aKggw3vP7hHtMcDrL6pq3m9eEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1L+oGw2rv16L3blx+YigJrZFPBOiYBcao3PZSiY73phVWQ4WXkY1Jpo3G6Qv2kZDr
	 8oVIrjbjNH34inlwbDWuBASBqAzmtqn+Z0ea8a173VKVWV3wET0O1XWSM0sk7k79mk
	 QVuLsSxqIvw94HrQdL8IAtYWByowXZPrDAmjn++g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vamshi Gajjela <vamshigajjela@google.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 6.6 201/267] spmi: hisi-spmi-controller: Do not override device identifier
Date: Wed, 19 Jun 2024 14:55:52 +0200
Message-ID: <20240619125614.047124160@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vamshi Gajjela <vamshigajjela@google.com>

commit eda4923d78d634482227c0b189d9b7ca18824146 upstream.

'nr' member of struct spmi_controller, which serves as an identifier
for the controller/bus. This value is a dynamic ID assigned in
spmi_controller_alloc, and overriding it from the driver results in an
ida_free error "ida_free called for id=xx which is not allocated".

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
Fixes: 70f59c90c819 ("staging: spmi: add Hikey 970 SPMI controller driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240228185116.1269-1-vamshigajjela@google.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20240507210809.3479953-5-sboyd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spmi/hisi-spmi-controller.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -303,7 +303,6 @@ static int spmi_controller_probe(struct
 
 	spin_lock_init(&spmi_controller->lock);
 
-	ctrl->nr = spmi_controller->channel;
 	ctrl->dev.parent = pdev->dev.parent;
 	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
 



