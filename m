Return-Path: <stable+bounces-164299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2484AB0E5A1
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4003B7A17A6
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A75D28468B;
	Tue, 22 Jul 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUpbrkUp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8AC27EC7C
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220332; cv=none; b=pX34Ih0ExSJ8EBnNOaawLpVm6d+DtCwhEMKtH5mhTkESFksQGg5GEjgxiIMDgv8YKg5dmA56+TT6zNK65HAqvH3Zbjxzpc+13YDrd18cGlwpkzGfcjKEipJv94OQOPrTXuDeOacMsVtqvvUj0PiG9jSRbwmKSlDltdi0mwhDGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220332; c=relaxed/simple;
	bh=gzmMZfFpWe8lkiBRR8CrkmYNnde3frrODYs7XZSN0rE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M6FTBk1QG4PFpqVFfh9trqNmcJAkXwiE0Q90vbWsTAk1OdJrHaapq7VJ4iaFNvEX5KPXRvH5tz/n7ux5Uhwx4apsOBFmghIqWk5Rfn9ewdDWBkHsFqTkwELYWFMXpQZal8gEPtZ9ugDYafBM/RTO7HgC9/w+fzU4APfhB6Ek69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUpbrkUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDD1C4CEEB;
	Tue, 22 Jul 2025 21:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753220331;
	bh=gzmMZfFpWe8lkiBRR8CrkmYNnde3frrODYs7XZSN0rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUpbrkUpDRYOq7+/DWghhuz2ClDoW/xTQe8cTiwO/q2BfS5j0yVdEMgUTnCf48Oss
	 bUI+FgchIcC31diKSyV37KJCwQafTZQ1x6OcNkKGJzIC78EXNgEQEiA5LNlx1LZuAF
	 OyKx7w0nVgxXFAQPkuSIur5oj72yzBku8jHJX1E70gQN2x6ECOPGXNGsh7nuTTF6Ri
	 qSFGk2z/fwQ3VfSAwwWIn0IzsoUtIcwVDmiQ0tdTtUj8HeUSNte3+3YK4RDUUkpTGP
	 mWU8lObmQE0GclfzzbEWWwmH9WxoGYKEF+zuSZLirERgDXRvY6oEDXhG3T3Xudy0sC
	 4MXRpnDfkrRqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] comedi: comedi_test: Fix possible deletion of uninitialized timers
Date: Tue, 22 Jul 2025 17:38:46 -0400
Message-Id: <20250722213846.980515-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072153-clerical-autograph-74d4@gregkh>
References: <2025072153-clerical-autograph-74d4@gregkh>
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
[ changed timer_delete_sync() to del_timer_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/comedi/drivers/comedi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 05ae9122823f8..e713ef611434d 100644
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


