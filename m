Return-Path: <stable+bounces-164305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB2B0E5BA
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE12E5679FC
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5205C220F54;
	Tue, 22 Jul 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxJC9d/e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7081607A4
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220861; cv=none; b=ry9gIZ5w3tS8mds1eK3vQCkijm/6Fd/jGHvlkaT8suq0WkB/n5CBamzWSOfZ8eU6ahAIZcn4casIctuH3mhxxsVV4cTnVhbcC9YpVbiBqKkBoSx6bE0Vb3OhH4L3M8UeYYDVeY2dkuXRaeDUh02r+wscAbOobpwOpp/HL2IfmWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220861; c=relaxed/simple;
	bh=zpgDCJ+XwKOPpvUJW7NhIfVbEG0BpSxr96WyhtOatpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BVbWUKSy9jRSgIs9GYCpr67K70rxEhnMI5SIsxMdInixRMjJC1RDN2ZrR/yL940VPseH2msuxOtaXJJRp76YgHTQSVm+iUI7w9lc04keZsBTtiq8mRteYZY0pfeMckUjmNr7Sm2Yl+GJuAfRPL6i4D5ZWNBHVdnRH/R0fxMS3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxJC9d/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B345FC4CEF5;
	Tue, 22 Jul 2025 21:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753220860;
	bh=zpgDCJ+XwKOPpvUJW7NhIfVbEG0BpSxr96WyhtOatpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SxJC9d/eCbDqiqG8Pb1ZktdCCCFrqriyjKqlPegcr8OegeM4dvzZY4WJ5JwJLJIpE
	 ap0x4IqF6rx2Mwer7MAoEMdUA19cpoa7vadne2FYXD/QhG8zLKFayr1Ux9NySI25RQ
	 BiubqPwGYoCZT2cIGrO1Ek+qzR3wF/W+2U8il8oct13Yc8whfK2c6Dm+TDUmy00Cn+
	 OVgnZaLK+0hdXCOQ5yX3IscreHg3uiTN4cpSWMCWtANydsw/xJzZFD7Pq3DD9IVxau
	 UTZ/Io52+KC/LIMtzG5xAz1qpJpsNrssQKCEJizqOg0KefXkcIlNjlE2EjPqRvs2hP
	 ufWNdCZTFiVeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] comedi: comedi_test: Fix possible deletion of uninitialized timers
Date: Tue, 22 Jul 2025 17:47:36 -0400
Message-Id: <20250722214736.981287-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072156-salt-despair-a696@gregkh>
References: <2025072156-salt-despair-a696@gregkh>
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
[ file location from drivers/comedi to drivers/staging/comedi and timer_delete_sync() to del_timer_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/comedi/drivers/comedi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/comedi_test.c b/drivers/staging/comedi/drivers/comedi_test.c
index 9e60d2a0edc1d..7397495de4d62 100644
--- a/drivers/staging/comedi/drivers/comedi_test.c
+++ b/drivers/staging/comedi/drivers/comedi_test.c
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


