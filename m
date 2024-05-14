Return-Path: <stable+bounces-44903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F3A8C54E3
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4871C23CD3
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E419A762D0;
	Tue, 14 May 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="brz9f7K3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18457581B;
	Tue, 14 May 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687511; cv=none; b=Tzfeq/p0oh+FiUA8NzxEIIV6MjFWuCTwQYPygtiP8GdHwIDCV+e9v4Fs4WVd1xeekzS1/ZDKGmRiobh7nzc9yKBAHFdzCWL6KkxkjuHSOVesZ8SHSPNkos23OY7/HQs7EjiOZ+IB8ITpi2/C+5/FmT040ZGxk4VoND6CdycRJx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687511; c=relaxed/simple;
	bh=jEIOkfiIfATJcO8x1smFtocCpBflwQNEasOKwYBHbW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcbL7PNZfEjqdilExDQXm7UVhBBUcY6RyAlhF+0iISXs7nK2L3/O2aqP6nVAIazspUtS6xoDjgvscZs5xRiR4gQbEmWgID0yONT2HtCZb/yCVdZ/aDJOonEPp46ARY8apgTicmywGXBj+a5CpLIDsaGorHmOtdS6m6CZfYengPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=brz9f7K3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF9DC32782;
	Tue, 14 May 2024 11:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687511;
	bh=jEIOkfiIfATJcO8x1smFtocCpBflwQNEasOKwYBHbW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brz9f7K3PRx6t/QcXWXvxl2eqNnYKd157ju66wP3ngzkfaO8Lv4S6SFOZ1FVyvto+
	 CWQp/dC8+/blZX1VzarvvvU3vbiqrleDdSnQEpHc6ke9Ai0DC1x13RIM5rL8e2YPAp
	 K7sKXcErkEPFG8OxYSjfStQ3v3BE4Yadea6io+mI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	karthikeyan <karthikeyan@linumiz.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 002/168] dmaengine: Revert "dmaengine: pl330: issue_pending waits until WFP state"
Date: Tue, 14 May 2024 12:18:20 +0200
Message-ID: <20240514101006.776312619@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinod Koul <vkoul@kernel.org>

[ Upstream commit afc89870ea677bd5a44516eb981f7a259b74280c ]

This reverts commit 22a9d9585812 ("dmaengine: pl330: issue_pending waits
until WFP state") as it seems to cause regression in pl330 driver.
Note the issue now exists in mainline so a fix to be done.

Cc: stable@vger.kernel.org
Reported-by: karthikeyan <karthikeyan@linumiz.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/pl330.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index ba152a0024201..ec8a1565630b6 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1053,9 +1053,6 @@ static bool _trigger(struct pl330_thread *thrd)
 
 	thrd->req_running = idx;
 
-	if (desc->rqtype == DMA_MEM_TO_DEV || desc->rqtype == DMA_DEV_TO_MEM)
-		UNTIL(thrd, PL330_STATE_WFP);
-
 	return true;
 }
 
-- 
2.43.0




