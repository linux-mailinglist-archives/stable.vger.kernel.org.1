Return-Path: <stable+bounces-183320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 797FABB7FBE
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 21:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05B394EED55
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB7E21C194;
	Fri,  3 Oct 2025 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw62yZbV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2949378F26
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759519952; cv=none; b=F99lyLbq1jnWHKnNcbrHZm4RxPB5V+62wdlbP+KMowEmH5VmE2BnR5WN3v1Bt990oM7aBlDeTD2s8tlAYLZraEySm1+33wYB3IgkP6fK6jidoxHeNxIGpEemH5OlGP3yYDQniudk0Y8hT8DFd8WJVW+W3nX/4F1sdITPjiH7E4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759519952; c=relaxed/simple;
	bh=hF51D3+mOVx4or+38FUJ8pzrNs5XeCs3vLi1r7zW64w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIp2W4vxbJ07Fq+95xp+ESUAKyTZsLcgEvo0zfzh7LdZQxfQZiyhtqcZ9KYtpKqixMuabv6EGas9mK2VxHzRkrq+hV8CaPusjb5ksSRlLoSvv6yTXw2iR5zzOlpYIRp0GuFW7gQ79uBFtf3sLxT3kkIROH8wbBJnCzpA8hLdZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw62yZbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316B5C4CEF9;
	Fri,  3 Oct 2025 19:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759519951;
	bh=hF51D3+mOVx4or+38FUJ8pzrNs5XeCs3vLi1r7zW64w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nw62yZbVisUePBWNMvXxP6yaDtZGa6Y31wIxqPpDA6+WgSr1O1XAK2jgU7AaNegiy
	 JZ4q7gCZ14v1/OSDD7Bmvs8sjhiLKYMKv8RbXcCeGpujstuybuogaSROTxrhcf4AGW
	 dTqIhmOTEhlrAMTdu1F1xbBWuMU3EWUUBBkZbS01pmLJcSjyC/nclPCVBUUMX5+jzo
	 PApPul+IxzzdqS9PF4RSEemDkBjDJt+qPKZeui6Wc1vs8DwqTUb+SiUBmlpJiDX6vL
	 mbdXsyuk9oCLv3/8c4PC7VKHAVZBrX7vZ6U2c8NYGY4rY7GtMM8MvG7lkDNz9CeCpw
	 PVD7PGKwCQtRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] media: tuner: xc5000: Fix use-after-free in xc5000_release
Date: Fri,  3 Oct 2025 15:32:28 -0400
Message-ID: <20251003193228.3339889-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003193228.3339889-1-sashal@kernel.org>
References: <2025100338-ambulance-swaddling-4b2b@gregkh>
 <20251003193228.3339889-1-sashal@kernel.org>
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


