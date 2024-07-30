Return-Path: <stable+bounces-62797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD3B941268
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15321C22C79
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8E81A0708;
	Tue, 30 Jul 2024 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq/AK2rq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4719E83F;
	Tue, 30 Jul 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343593; cv=none; b=rBSyexAc89SnC29vusQSRL+qVw/AAEbXRYzQhPwwwjyhWaXuoQzL4ekOhiwaMLIP8NutFkG2dnkhe7tCM4PdmiC7PsUEQA2aLMMaT+Ci7ifOTDxQ5HrGdv69nNQsRg5PWex7sWP2dA7pBJKVrX/z7zjaG4OsSGzqf0rY2yi9rWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343593; c=relaxed/simple;
	bh=RPQyjpsn1jZBc0xGAxnY+G73V00IlrVFuP7x0p1MRAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uZVS5zSdB1OF9SHGnTMJJZZEEoAKWI8S9R7fqUShzqwmYtuzxH8kNVY0WbOv9jWXMSs51wqaGOcn3AQ40r/CiaFYxrSRhtpJxG2ckr7j6cRx7duEE6FVsN76TzsjsW3iYkRD168IbwTBqkxJcTuziAUeNQyaEmaeiY/34mRAsT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq/AK2rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89578C32782;
	Tue, 30 Jul 2024 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343591;
	bh=RPQyjpsn1jZBc0xGAxnY+G73V00IlrVFuP7x0p1MRAo=;
	h=From:To:Cc:Subject:Date:From;
	b=fq/AK2rqbyCtbqxwFvMXAHSOia57kTP7uCRDJCfA8CvfJWhm56rCbJLNQ+U5d8TGn
	 KDtY1xmPpQ5+YRj/0m9cFO3nt6DqsWGJPwMD1IIs4uqFDteEdUPmoRZW334yFsUlGO
	 ovJcjCvo3V3ooz2grfhBTdCX0odrSDjrbP3bJPec0WH4XQi2RUK6C4g+ZpP+ineuYD
	 pO1CvRq7wmi9zDD98bGRmMHwFCKPknfpYYdYq1rYr9lilDE/KCdRjhaIHuwFqu43UU
	 XXzvvgDo/UUGT7s3VuYcVOqr4nP3ZwybNVn3jHPxskvZ+7cisPKoJkcMGlgqoLlxil
	 KiMC1mUVa3TlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 1/3] driver core: Make dev_err_probe() silent for -ENOMEM
Date: Tue, 30 Jul 2024 08:46:23 -0400
Message-ID: <20240730124629.3098598-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit 2f3cfd2f4b7cf3026fe6b9b2a5320cc18f4c184e ]

For an out-of-memory error there should be no additional output. Adapt
dev_err_probe() to not emit the error message when err is -ENOMEM.
This simplifies handling errors that might among others be -ENOMEM.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/3d1e308d45cddf67749522ca42d83f5b4f0b9634.1718311756.git.u.kleine-koenig@baylibre.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b13a60de5a863..006c048646158 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4314,11 +4314,22 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (err != -EPROBE_DEFER) {
-		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
-	} else {
+	switch (err) {
+	case -EPROBE_DEFER:
 		device_set_deferred_probe_reason(dev, &vaf);
 		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
+
+	case -ENOMEM:
+		/*
+		 * We don't print anything on -ENOMEM, there is already enough
+		 * output.
+		 */
+		break;
+
+	default:
+		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
 	}
 
 	va_end(args);
-- 
2.43.0


