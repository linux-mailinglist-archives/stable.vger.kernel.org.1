Return-Path: <stable+bounces-183331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ADABB8268
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 22:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F8504EEE06
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 20:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C502257853;
	Fri,  3 Oct 2025 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZ60dvUh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A53257836
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524891; cv=none; b=WyT/T7XD4Slh+7oVePYgYrlRrN9wjpWwq8cbBBsPVfDZVuH0I9q2FA1prKEAd+U58sjS2/JTmQNMDyaJie54vPGhesGzbAIZf4OiBHs9NLytB+qgGTTCKvvyPvlW/yb+lIOI6ItP0QqPH5KSunWGQ9YtzKqDAjJllWTnN/YRcec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524891; c=relaxed/simple;
	bh=hF51D3+mOVx4or+38FUJ8pzrNs5XeCs3vLi1r7zW64w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI5k9G4K0IOo4dxH2iQeosLZqk3x3vi/ZheSLru/7ZeBTnwouiS2WRmQ5XVGk0U2+/Qa2/AK4P5rDQmkR9uORuNtid/UDkRXc+BxRZYk6qnGjvPFtOg4ExBtXbFYwIHPHiSyq9damEkN7AoddZbDMn8cBADwQohZ8ei8quUFS5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZ60dvUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17464C4CEFD;
	Fri,  3 Oct 2025 20:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759524891;
	bh=hF51D3+mOVx4or+38FUJ8pzrNs5XeCs3vLi1r7zW64w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZ60dvUhbvrY8dd/sPtC9eJM13X932EsxI1hM2/H3pOdkSNMUSfGWGk47/JnzcMXy
	 YwlszPcYdUPEn0KL+biC9SMKnza7KWPjkMLuGRrgdIgUgAdGRSr+8Q3dxUSnbF03c7
	 Wis2KvoufQO1qcPRfx8bJeznhvYvL8OoOod4aJzYpsaWwi2WyaC+RI61qaTvaqmXZH
	 JiZOYIBTgnVJxxFcYZLejPpa/2sc2/2jTWG70wnuMF4aK+RyhCVw6wIAu65jVB/nkj
	 ls5fXoIAmcjtU36LzMbtlF70EjPwSiI+0o9vDYOTf1KGuxTNs61vDIzqXMykH9xvla
	 Lm3a/LW8pGEig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] media: tuner: xc5000: Fix use-after-free in xc5000_release
Date: Fri,  3 Oct 2025 16:54:47 -0400
Message-ID: <20251003205447.3385896-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003205447.3385896-1-sashal@kernel.org>
References: <2025100340-pleat-amusable-e5dc@gregkh>
 <20251003205447.3385896-1-sashal@kernel.org>
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


