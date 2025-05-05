Return-Path: <stable+bounces-140048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FF9AAA468
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B08188B19B
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383A02FECE9;
	Mon,  5 May 2025 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="endAcZGe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD92FE0B6;
	Mon,  5 May 2025 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483976; cv=none; b=nd+V4nHWbseXtra/cOpO7DfOpGIqnXWFVJoBCMyYhvgQIw9b6MMeK69pufi1zGakFqrqJc9eLMkZvgvQVVgZ7bnpmtrWFX+hmWsnKIv+5RwuhdF0gvPziXtMoMW9sg+7jy/h94vr7tAt5A1UbMHqA/N1/0HnQCs97XVoWzoG0sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483976; c=relaxed/simple;
	bh=lmgdJNjPYYyNRnKYpNKaN+CH2EZKvOAzJYEBiuhSIwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E4s7lqpnBtV3vaPe7lr7om7RC/ybTvrKoLrcWh9DGnICYPvR1H8rFxkqrRkZuKYQFZanwEndbWB0+Ugd+v9tvR7jQmyOQ1u/UTxbvbU+dXZIrehyFcD5ttiy4Pdj5/65BCSW2mUB98+dV8eBs9ulaZoqFMRyxEKlDZQqUbmWBqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=endAcZGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B424C4CEEF;
	Mon,  5 May 2025 22:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483975;
	bh=lmgdJNjPYYyNRnKYpNKaN+CH2EZKvOAzJYEBiuhSIwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=endAcZGe1d4xtLcY9GI9ScDZiAUeqBeB5qx53ZIpsR9QSUN8lX7nMdvUu/AcLi1Yq
	 qamNI7okXJwm+eM5KlVV4RxHat+/LPANWTHDuNSCZ4Zb7HKhLPZfAMzcujnswNlsvp
	 z6HlIqDmycJ4VzNIvO/szJE91VYIitkcs2YwJp/HLQOyfAQ7o1bGMrKKgf/nD2MkK0
	 XQpU3J55sdUCO53962UUY9UmG0NLibIq5cdN7sHLcOgD+Ibb+V2beurdB0dd8ZNPkw
	 pW7Jim8kkdj2z2efFXF+dzcSO/F61QdO1pv1qk0xnBEpNMaWDMNPALDBIQj4vQ6oJ3
	 hRutkV3htsQ0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kurt Borja <kuurtb@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 301/642] driver core: faux: only create the device if probe() succeeds
Date: Mon,  5 May 2025 18:08:37 -0400
Message-Id: <20250505221419.2672473-301-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 21b0dc55bed6d9b5dd5d1ad22b75d9d1c7426bbc ]

It's really hard to know if a faux device properly passes the callback
to probe() without having to poke around in the faux_device structure
and then clean up.  Instead of having to have every user of the api do
this logic, just do it in the faux device core itself.

This makes the use of a custom probe() callback for a faux device much
simpler overall.

Suggested-by: Kurt Borja <kuurtb@gmail.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/r/2025022545-unroasted-common-fa0e@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/faux.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 531e9d789ee04..407c1d1aad50b 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -102,7 +102,9 @@ static void faux_device_release(struct device *dev)
  *
  * Note, when this function is called, the functions specified in struct
  * faux_ops can be called before the function returns, so be prepared for
- * everything to be properly initialized before that point in time.
+ * everything to be properly initialized before that point in time.  If the
+ * probe callback (if one is present) does NOT succeed, the creation of the
+ * device will fail and NULL will be returned.
  *
  * Return:
  * * NULL if an error happened with creating the device
@@ -147,6 +149,17 @@ struct faux_device *faux_device_create_with_groups(const char *name,
 		return NULL;
 	}
 
+	/*
+	 * Verify that we did bind the driver to the device (i.e. probe worked),
+	 * if not, let's fail the creation as trying to guess if probe was
+	 * successful is almost impossible to determine by the caller.
+	 */
+	if (!dev->driver) {
+		dev_err(dev, "probe did not succeed, tearing down the device\n");
+		faux_device_destroy(faux_dev);
+		faux_dev = NULL;
+	}
+
 	return faux_dev;
 }
 EXPORT_SYMBOL_GPL(faux_device_create_with_groups);
-- 
2.39.5


