Return-Path: <stable+bounces-164304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C61BFB0E5B8
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC82D1C2271D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893B21607A4;
	Tue, 22 Jul 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhobZqUL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB93C47B
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220780; cv=none; b=EW/O2JS4oUmdixpEsYUcVShLW2meIS+Z5LjCteOu0Bk4iT8NUtLU3E2V1WmpP3Bvx2tP8ReaXejHFGbE1vTxaAXqQ3w8fxrPWU1NZUOt1Cxg8iGdwKRBfosJCvVIoyGb0ZAzqCfD1h0IGYcmd325lFbvkuViCJUmn6lipbXWFzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220780; c=relaxed/simple;
	bh=b67kSSEKMxeNtlW+zqTKtszmtkQ9YSVQeHWPl1zO8C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/9cp4Z/iebu3QhdbUNRkCyz4RZpoXX28mVgzdvcz23cS2CYG7EdfJi/CrmvBuachUNJJnwmvOLNClgDZ7UKCLKpRrP89CWWcUNga6ljhjR8207hIP8UOBH1wsAFk0PC9eDJaT3u97tq0y6qeoXCmlbynpjUmnpOtyHzvFZuleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhobZqUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF35C4CEEB;
	Tue, 22 Jul 2025 21:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753220777;
	bh=b67kSSEKMxeNtlW+zqTKtszmtkQ9YSVQeHWPl1zO8C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhobZqULaUecg9VlEjuxBEjvqwQS84o2Fgh3YNxw2HpzqrY6DeyeTXwsKr0WPtSGL
	 ThBwUniTr2NX5xatWJaatP4mAmsJTtqOGdTIWFCmxhjiP9vbjzJEz7+CMTbOooIzn0
	 8WL4et5gMCuJmF2HSVGjQ1aunJJcVyLoKU4pA4/Vk9BhVDJqNcpNlNNBUwVljRM0AV
	 GAeJXwDwbes26FyI/pj6o7klc60RJfrYzZzYmAuRYim915308ObeXNxDS3s3uXFxaR
	 Nd5AtjtCxvimt5ksZ+zTRorLuGHX84Pc5kFexwHDlnwp4kH0yvFGUvAXg92DGIag4V
	 rJ9xOcBfe9cpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] comedi: comedi_test: Fix possible deletion of uninitialized timers
Date: Tue, 22 Jul 2025 17:46:13 -0400
Message-Id: <20250722214613.981170-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072155-viper-viewer-98bd@gregkh>
References: <2025072155-viper-viewer-98bd@gregkh>
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
index bea9a3adf08c8..f5199474c0e93 100644
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


