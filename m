Return-Path: <stable+bounces-167265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 982F0B22F47
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBF21A2569E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D942FDC20;
	Tue, 12 Aug 2025 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w5exGu9h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630652FA0FD;
	Tue, 12 Aug 2025 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020237; cv=none; b=VZgLjGnvgdM+x3FCerwK5wqyzFllKsKBMpfEuQL3Yiq2idCt7kumq0b5jmYktYJgnNZ3fIYCu1cC4QGBNXtNdEFbMlwY28Vw6QXMHuMxW/1SZ3F4VrIhfh3sW2+xF2e7lA3vis6Re5272ImG1H2UF1gfBgsOFWgD1B3Zpv+l950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020237; c=relaxed/simple;
	bh=NGAcDRaf5w7d/uyJaLo+5mfoiM14gjwvDjYMXm1B2EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANvLc53/rDY4LIeoS/szP8bE+Y5l9ILEXm9ATk2L9m6IN1vwpLude1oHZ/24KFf8cwOlZNESnfHT7LrRZGFlfhCNOTyGtQ0LEqDekh37lLr/JK1TzOdUSnhHdYjFKtrOgYBQx3Q23P+/tC+p7BbDY0Qxkdgb7I2fD1XryQk+dd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w5exGu9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE95C4CEF0;
	Tue, 12 Aug 2025 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020236;
	bh=NGAcDRaf5w7d/uyJaLo+5mfoiM14gjwvDjYMXm1B2EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w5exGu9h1QqqggvZdM2w69YfIuc2ZrsiOozZOKjk3kaSH/nfc8nmZNKCMuxDsInR0
	 4zOyN6DcP3MkguPSgPK+udBO279DU2BHPIsymXugLc40J1H7xLsCTdt4/zHUsqnaIj
	 qgfq2iBRIkFy3ulRr3nImZ0SgrX6w3IwvHovZHDc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alessandro Carminati <acarmina@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 002/253] regulator: core: fix NULL dereference on unbind due to stale coupling data
Date: Tue, 12 Aug 2025 19:26:30 +0200
Message-ID: <20250812172948.786063157@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 29c9171e923a2..7e6ff7e72784b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5423,6 +5423,7 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 				 ERR_PTR(err));
 	}
 
+	rdev->coupling_desc.n_coupled = 0;
 	kfree(rdev->coupling_desc.coupled_rdevs);
 	rdev->coupling_desc.coupled_rdevs = NULL;
 }
-- 
2.39.5




