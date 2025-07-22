Return-Path: <stable+bounces-164300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33640B0E5A8
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3E51C883E4
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF172868AC;
	Tue, 22 Jul 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4xLDyyK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5728688F
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220424; cv=none; b=JUVtCla1vK2orZZNVP41I/M+YvzpkzIRy+kFc9ZurtId01H59uy+XVp7p5YkYy4Z3FcGHIrVDcYEsf9qRtHsVCaR7G3EV8UJMqqO7qOakET6dEAHv1Ac2NSU1mlXc4dbbPHg97/QA0LlAmNix3maeA43OP5pGPgvz8vutFiUux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220424; c=relaxed/simple;
	bh=99He4ifu8JK0kRFJNfe3VPx6aQ2J9UCwg7Nh8tTYgsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7aH1wXVqFUxJCE7B0zn0pt+ixS03rnxY5ZG/fzw+97mJ08BYe8TTJg3OynYcyUp5+7xKybS/uDQXZvV+KcFTdGNx3NsrBEgOnzThZPZj17juZbsEKHXYgJVS2chF/v2md1XuqkTI4yCuwEKwIZhy2Fjbz0bIE8Cj61U8uypSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4xLDyyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A13BC4CEEB;
	Tue, 22 Jul 2025 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753220424;
	bh=99He4ifu8JK0kRFJNfe3VPx6aQ2J9UCwg7Nh8tTYgsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4xLDyyKmeclRY9T+Kqd3YvY4zSxDr6ctG4mK2Ki0NNgqrCTuyRCmUjU1ArLwhCbv
	 vNxiLvZVwqQ1t8tIs9gWoLFiMSIG9nhboolu4yVUIBKF4NdzjUl1FxVj6mUEmWCnLc
	 tcTg5icxUgAwOe0z84ieLpV50zWcpuQ7aSo/YefsJWswn8J4Ebs6MJvfRZZ4/lNK+I
	 1tk6NGTPG4nlAS/EoUdmQb0J60gDh5hyM/V7Py7jhR6r4mFs1trKoTYGCTHkBQmxQ8
	 P/aX1q8JRMBbmjOY/vY4F2wtD6eJz2EddGib5ihL6TWjbJsnnKo9EsSMRmZp6yPqae
	 K9p4AWvo2FFnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] comedi: comedi_test: Fix possible deletion of uninitialized timers
Date: Tue, 22 Jul 2025 17:40:20 -0400
Message-Id: <20250722214020.980645-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072154-unchain-champion-e3d6@gregkh>
References: <2025072154-unchain-champion-e3d6@gregkh>
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
[ replaced timer_delete_sync() with del_timer_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/comedi/drivers/comedi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 626d53bf9146a..aecb5f193be1b 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -788,7 +788,7 @@ static void waveform_detach(struct comedi_device *dev)
 {
 	struct waveform_private *devpriv = dev->private;
 
-	if (devpriv) {
+	if (devpriv && dev->n_subdevices) {
 		del_timer_sync(&devpriv->ai_timer);
 		del_timer_sync(&devpriv->ao_timer);
 	}
-- 
2.39.5


