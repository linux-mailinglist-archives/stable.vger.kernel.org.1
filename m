Return-Path: <stable+bounces-183343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A4CBB8725
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 02:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C809B19E31DA
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 00:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE7F7483;
	Sat,  4 Oct 2025 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJhIfeGc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA734BA3C
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759537321; cv=none; b=jx6uQg7zb16r7mIrp8fOhhcBVRGADGTQuinuzKoMDoNnS8m+AcJAqnBVWsHftIRSE+CpFgkCwD/O9IDTthl7iZVF8MBLhH2wKUX+1xyqjASfQBperNbXZ2wVD48xXAkNS7AbW+fzna4fRavEy77zn9BmjW5N8AMXucrF9FyNQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759537321; c=relaxed/simple;
	bh=hF51D3+mOVx4or+38FUJ8pzrNs5XeCs3vLi1r7zW64w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buEAOgliTus8YFtSFE/JZVywPY6Hz3Pugw7QsTpE9vGVlto8zFsvWbWM40cgV980a7C3TKQPDj21W9qeEJlg9PuXB6O7h3YwM8J2SExryH/23emlknnUNvj57Hnc1LykUVjNA0R0dqVcx0ZCLtJYwuf6KYdSlPMGB6r0zAneQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJhIfeGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4956C4CEFB;
	Sat,  4 Oct 2025 00:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759537321;
	bh=hF51D3+mOVx4or+38FUJ8pzrNs5XeCs3vLi1r7zW64w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJhIfeGc9HC6NjI0ZOBifTvaJd9GkbvJ31+X198bW+rlL8u+4SPg+qXYTx0x7epaK
	 5PD2Dge+C+XUjdeyJkTC0YrlzbdB4VMaXrrlV1a2GfkjOf0cu/fJqyIiGzrTaGbsUV
	 qOGEkUHEWImtBaWm+jxzpBinkA6SeW8OiyhPAyzU4n4aqvVEA+NCytnf+T3wf8WvWq
	 vpfNLmiiCd1+AQ5z56diKP2qY3IP8+MdnpM4RKnVDSu3I/VNaRz7LkD5DIsZrZeqvq
	 u0V0em/s2VMbI5yvPaLYO9paiJ1rPKAYcVzh5Q309kbd3hKnBv0Iuyhlp1mCISfIzQ
	 D9dnpfA/SpkHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] media: tuner: xc5000: Fix use-after-free in xc5000_release
Date: Fri,  3 Oct 2025 20:21:57 -0400
Message-ID: <20251004002158.4023173-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004002158.4023173-1-sashal@kernel.org>
References: <2025100341-cobbler-alabaster-748a@gregkh>
 <20251004002158.4023173-1-sashal@kernel.org>
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


