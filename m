Return-Path: <stable+bounces-165223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B198B15C1A
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F44816A88C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067C28469A;
	Wed, 30 Jul 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="syf3zmws"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32126C396;
	Wed, 30 Jul 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868283; cv=none; b=NEk7FNp3UdfFwI8gVnNhC9UwAfEsPcqd/9+szc+qvT1nM6q/IOmfr8ByHiRUjCFCYcwM1ipQ7YQod29ajixQGUyWwuG5Nrvf3E/IZGtRtn9VSEavhQcVSSSho9a+OueS8vZSSaaJSjHQ+gTNQTcW6yYLQAusdvNTIWXvX43SdUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868283; c=relaxed/simple;
	bh=R0C7QC088vFjnsmiOQnYVb2XYL71UagoWVFoh11vkG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7uEwPzrIfEvEnKCYsyzYI7ScErEmIXMnW+LerAytXc8rTbpt7BCE95hVEtjoXXipzDK2lPi28PGFTApZqRkMJc1JAY5P4e2bFExUeiDbkpwk9yDpE7rnlc5MQV8SNh9A9TUa2jOc3iKVfLuSv8DkP3WnYDRprWijXK98Bigq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=syf3zmws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A38C4CEE7;
	Wed, 30 Jul 2025 09:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868283;
	bh=R0C7QC088vFjnsmiOQnYVb2XYL71UagoWVFoh11vkG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=syf3zmwsinR+joR72b8xoHSEIa7yp3Gl2y8soIY778vsXnprpnTJBD9dtCFPlCy5G
	 XRkt1PEcxK8waNXnb3JApkcDrFfQOGRprV8kd5MoMplF/Dp5SG/J8bUec4WtE0N4CS
	 tWmNgrfYK0z008ie3nG0BT99VNyV7h2e04PFwxUY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alessandro Carminati <acarmina@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 03/76] regulator: core: fix NULL dereference on unbind due to stale coupling data
Date: Wed, 30 Jul 2025 11:34:56 +0200
Message-ID: <20250730093226.991355236@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
References: <20250730093226.854413920@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Alessandro Carminati <acarmina@redhat.com>

[ Upstream commit ca46946a482238b0cdea459fb82fc837fb36260e ]

Failing to reset coupling_desc.n_coupled after freeing coupled_rdevs can
lead to NULL pointer dereference when regulators are accessed post-unbind.

This can happen during runtime PM or other regulator operations that rely
on coupling metadata.

For example, on ridesx4, unbinding the 'reg-dummy' platform device triggers
a panic in regulator_lock_recursive() due to stale coupling state.

Ensure n_coupled is set to 0 to prevent access to invalid pointers.

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Link: https://patch.msgid.link/20250626083809.314842-1-acarmina@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d2e21dc61dd7d..1d49612eeb7e5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5422,6 +5422,7 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 				 ERR_PTR(err));
 	}
 
+	rdev->coupling_desc.n_coupled = 0;
 	kfree(rdev->coupling_desc.coupled_rdevs);
 	rdev->coupling_desc.coupled_rdevs = NULL;
 }
-- 
2.39.5




