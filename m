Return-Path: <stable+bounces-56541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DAE9244D7
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE89A1F21DBE
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4191BE226;
	Tue,  2 Jul 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tBZNW2XO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D57916B394;
	Tue,  2 Jul 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940527; cv=none; b=UXCFB0LYwiZNIsaOfcLsVmXgPV5DJfMBXU6Ozou2QoiEh8eKSV24zEFTWS0cn5n4hj/YH2TRGRM0Su6x7bFiTcGl3OxQA8MLxc+wjXVC58KltTAPX9Cg5OM3Qwohfx18NMmW5ljNoo+ipYeM7DlN3R8sRJGVV5V14/ZtRRMwuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940527; c=relaxed/simple;
	bh=Ih5igsKj8qtpviTm/GKzqRyBb0hGetvz/nkwqvFhpzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aD9ynThJopPIKnXd73uharIffNuk8jzAJ2ug+5x9bb9eaUsoB13m9NU2dqUejon3HnBNgTvwRIrecgvw6pnNFs3/g974R142C5vY4q5S9nGzyPc99Ne0raPmZpfx3/eRCvCDyq+u72jDL4HIEEyFpj+3cj+cSMM8rTKsO3MKrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tBZNW2XO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89235C116B1;
	Tue,  2 Jul 2024 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940527;
	bh=Ih5igsKj8qtpviTm/GKzqRyBb0hGetvz/nkwqvFhpzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tBZNW2XOwv04KBCJEbTexuGZhqJdN1bY5NYIoomEDlmtPwSHd4mZUq1kNRnM8T0et
	 w5tUSIJKkY/jhJwk/IawoWB57znwnSj0vy180CfWukX2IP5QmJ+1M4TChC/21mqcfe
	 vQaXLeQrWJP1skkh7bofh2E8iWk1pob4wozTDJqk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Lyude Paul <lyude@redhat.com>
Subject: [PATCH 6.9 180/222] drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_ld_modes
Date: Tue,  2 Jul 2024 19:03:38 +0200
Message-ID: <20240702170250.856321059@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 66edf3fb331b6c55439b10f9862987b0916b3726 upstream.

In nv17_tv_get_ld_modes(), the return value of drm_mode_duplicate() is
assigned to mode, which will lead to a possible NULL pointer dereference
on failure of drm_mode_duplicate(). Add a check to avoid npd.

Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240625081828.2620794-1-make24@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -209,6 +209,8 @@ static int nv17_tv_get_ld_modes(struct d
 		struct drm_display_mode *mode;
 
 		mode = drm_mode_duplicate(encoder->dev, tv_mode);
+		if (!mode)
+			continue;
 
 		mode->clock = tv_norm->tv_enc_mode.vrefresh *
 			mode->htotal / 1000 *



