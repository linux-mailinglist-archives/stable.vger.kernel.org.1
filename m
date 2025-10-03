Return-Path: <stable+bounces-183328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2903BB8208
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 22:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6DF19E3695
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB80F246BA7;
	Fri,  3 Oct 2025 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPvdNFaI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBAF2459C6
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524210; cv=none; b=Sd7fyZhAdDa19Med1SuK0N9atd0sIn7g3+/M7pu0WrYs7VPLPUFweLPTmuZQL5jAf2lIxwYE4A8YlzrF+2T1Ci1fZlOBBnA1ivw4aBrRqe0oK+RpXcV4b9fjdndo8M6RcBv4J6KJAt+StBohwdTYigHcUTscidih2Yft0PrErBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524210; c=relaxed/simple;
	bh=hF51D3+mOVx4or+38FUJ8pzrNs5XeCs3vLi1r7zW64w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCsgRl6SyHmL9ukKx0abEqL9ThxTO+jI6MOIJOXE8LBnrbwmMa7jJGQ2XIn4YACmAyb2TIegDORo/J3u39rmb9gNcPo0r5zN0H831YIyzHKykM/iJcbxXDlOIwUrS1V+VD/RAHidFEJ8vosIWz6S0poBaWgFMSvlth54nqH079Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPvdNFaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0996FC4CEFA;
	Fri,  3 Oct 2025 20:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759524210;
	bh=hF51D3+mOVx4or+38FUJ8pzrNs5XeCs3vLi1r7zW64w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPvdNFaIMZNBnkEmQb+VY7GvKYik6C9m8zBGq8Ff59gmK46D1U2uP0KvS7r72JuXq
	 rHcp5WxcDg/4EDHvOYlD99XUccbmet9GL5YaSDQuhuazwpI2Hiov1rz+KQ+KCiq16w
	 cbEISkK9U7Ju9BeLD0Nce4IcAO0SOquygBR2E/yUnYXUjfKBGID7bklyi8Fw9xVoQt
	 DyyiZLV89tp9kj8idFSa46XrXwjyhXV7lK7+epDuxxGpnHoiKNAAjeLJLr+/kEoexT
	 J1Iu8krOqDS9Uy/tuXc6V0lu1EPQ+j+W77Hn1UU3e9BQfqBZR/YX41AXlx+Sa8laBa
	 cVgus4RDmdOLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] media: tuner: xc5000: Fix use-after-free in xc5000_release
Date: Fri,  3 Oct 2025 16:43:26 -0400
Message-ID: <20251003204327.3377848-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003204327.3377848-1-sashal@kernel.org>
References: <2025100339-scarring-buffoon-fbc5@gregkh>
 <20251003204327.3377848-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 40b7a19f321e65789612ebaca966472055dab48c ]

The original code uses cancel_delayed_work() in xc5000_release(), which
does not guarantee that the delayed work item timer_sleep has fully
completed if it was already running. This leads to use-after-free scenarios
where xc5000_release() may free the xc5000_priv while timer_sleep is still
active and attempts to dereference the xc5000_priv.

A typical race condition is illustrated below:

CPU 0 (release thread)                 | CPU 1 (delayed work callback)
xc5000_release()                       | xc5000_do_timer_sleep()
  cancel_delayed_work()                |
  hybrid_tuner_release_state(priv)     |
    kfree(priv)                        |
                                       |   priv = container_of() // UAF

Replace cancel_delayed_work() with cancel_delayed_work_sync() to ensure
that the timer_sleep is properly canceled before the xc5000_priv memory
is deallocated.

A deadlock concern was considered: xc5000_release() is called in a process
context and is not holding any locks that the timer_sleep work item might
also need. Therefore, the use of the _sync() variant is safe here.

This bug was initially identified through static analysis.

Fixes: f7a27ff1fb77 ("[media] xc5000: delay tuner sleep to 5 seconds")
Cc: stable@vger.kernel.org
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[hverkuil: fix typo in Subject: tunner -> tuner]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/tuners/xc5000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/tuners/xc5000.c b/drivers/media/tuners/xc5000.c
index 30aa4ee958bde..ec9a3cd4784e1 100644
--- a/drivers/media/tuners/xc5000.c
+++ b/drivers/media/tuners/xc5000.c
@@ -1304,7 +1304,7 @@ static void xc5000_release(struct dvb_frontend *fe)
 	mutex_lock(&xc5000_list_mutex);
 
 	if (priv) {
-		cancel_delayed_work(&priv->timer_sleep);
+		cancel_delayed_work_sync(&priv->timer_sleep);
 		hybrid_tuner_release_state(priv);
 	}
 
-- 
2.51.0


