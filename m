Return-Path: <stable+bounces-164303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB369B0E5B7
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E481C2239D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C323C47B;
	Tue, 22 Jul 2025 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfSBq7qo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17428688A
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220707; cv=none; b=EloUBv/YWhx+9ZA3POYivykQsv3qgijaHO53FYUbU4LDRdAnocpUGPWCz95oaDmY40ieuiqwMhQszOwsOb25WfbMyEvQm6N8CAcHMUpJqaBD1PbueDSPbw6HQ+1wmLfEyF0NfwupzINwAz7hboS9inMvSoKlk6Lt0Q2a8iaFOL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220707; c=relaxed/simple;
	bh=zbNk8C/UQcIDtO8uLawdB2ZCHiTKynSjS+BM5kU29sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fq4R+f5y1wvnvg6nSxbN+Y0FQ/FGBvrZaxJrvVBT7BEc0ScsGg6MU/ArkS2SCOncMtKF3ajKBLy/uGlWtODZRE4/te790kem6frN3GLqz8K+Thy/p0jGbxSsGUaMLiRlX30hQ1XuwvIioYLu9Q47kvDuun5BTMXSp9XFW2oT7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfSBq7qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D58DC4CEEB;
	Tue, 22 Jul 2025 21:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753220706;
	bh=zbNk8C/UQcIDtO8uLawdB2ZCHiTKynSjS+BM5kU29sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfSBq7qouHw3m4FG7OAdoZBvzWSDEcKfhHMeyGzR1ZG1E/IEsEh31Qgn60Dpt7KPa
	 x/8IhhbbnfGqmK8Qz+XUPYtimbQuXJWE2LzCzMgrdPFM+GELo8SsEP4Mg15njVrrby
	 8t7OdmkNf1ZWdhyZCmom3LGI2OA7zkwKHVv/E2sCWZ/Ek0uaUcwwF5nH84QaaoHwjT
	 XrFJVclXQP4JmWtUQCt49PVqsxq1Jk69L4qERxAfOAIKKmf7Y0U5iIDa39way4np1L
	 rQOWqbgE+5ryLDmS72SDRdH7qgG6V+acf5r0IE/TANmwpsE7XFrHmA91odPkjf7NLP
	 QAHupfvtz0DiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] comedi: comedi_test: Fix possible deletion of uninitialized timers
Date: Tue, 22 Jul 2025 17:45:01 -0400
Message-Id: <20250722214501.981060-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072155-catering-series-cf00@gregkh>
References: <2025072155-catering-series-cf00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Abbott <abbotti@mev.co.uk>

[ Upstream commit 1b98304c09a0192598d0767f1eb8c83d7e793091 ]

In `waveform_common_attach()`, the two timers `&devpriv->ai_timer` and
`&devpriv->ao_timer` are initialized after the allocation of the device
private data by `comedi_alloc_devpriv()` and the subdevices by
`comedi_alloc_subdevices()`.  The function may return with an error
between those function calls.  In that case, `waveform_detach()` will be
called by the Comedi core to clean up.  The check that
`waveform_detach()` uses to decide whether to delete the timers is
incorrect.  It only checks that the device private data was allocated,
but that does not guarantee that the timers were initialized.  It also
needs to check that the subdevices were allocated.  Fix it.

Fixes: 73e0e4dfed4c ("staging: comedi: comedi_test: fix timer lock-up")
Cc: stable@vger.kernel.org # 6.15+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250708130627.21743-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ changed del_timer_sync() calls to timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/comedi/drivers/comedi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index bea9a3adf08c8..f5199474c0e93 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -790,7 +790,7 @@ static void waveform_detach(struct comedi_device *dev)
 {
 	struct waveform_private *devpriv = dev->private;
 
-	if (devpriv) {
+	if (devpriv && dev->n_subdevices) {
 		del_timer_sync(&devpriv->ai_timer);
 		del_timer_sync(&devpriv->ao_timer);
 	}
-- 
2.39.5


