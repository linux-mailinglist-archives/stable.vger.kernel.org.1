Return-Path: <stable+bounces-63693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D049941A2C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70C51F22F7D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D85184535;
	Tue, 30 Jul 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xwYaVVZB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA31A6192;
	Tue, 30 Jul 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357652; cv=none; b=pWU4kOGt4bHzsUOnOmFFD6AnAnaZswi2eOt46ZlQfis5cVanQ+5DePMn3hTpuUUSvH9lEqhpRJAP9O8UVROpFL653k6yxjU1VimaJ6eJL3nsOtPyuSgUCBG61CbWK1CnxkWjs3crirvxMEe/w5o1SUByfmorbV393zbauI5+lsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357652; c=relaxed/simple;
	bh=+u2mx7wCEMX2F9jIIHIJJpGPvIaDYEV15JZFcL3D0NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgdYRdCAJ22NhL2e7a74juOrghKwOzPfegZPmtQL66+Hvy7NNTOPYfmh9wUYM80gAoDONWMKxfRfqCFqzZ3X6JFQpvpUmQdv4z3nAapp5UU6kd2n3xCes5yMayZsmsY2N5VfSFm8LbIZNcKWmXRw6f86+qYON+JwLn3qDXd5kqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xwYaVVZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30051C4AF0A;
	Tue, 30 Jul 2024 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357652;
	bh=+u2mx7wCEMX2F9jIIHIJJpGPvIaDYEV15JZFcL3D0NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xwYaVVZBiXoQQLqkCJQBP3y212dcOaTvHcViC2ey2/GbinsaY1EcFaCEqc0i+DFy2
	 X7BVD/rPOuQA6DubF84ltUDeZa2q9BeLg8ajmR1NhdKQHq9J+WNT7g1n5O7rEhicpY
	 xcNSmKXWH+cb2mlqIPS0Ungz0oUJJB5D8O4lDoBE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Rund <Christian.Rund@de.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 278/568] hwrng: core - Fix wrong quality calculation at hw rng registration
Date: Tue, 30 Jul 2024 17:46:25 +0200
Message-ID: <20240730151650.742974839@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit 95c0f5c3b8bb7acdc5c4f04bc6a7d3f40d319e9e ]

When there are rng sources registering at the hwrng core via
hwrng_register() a struct hwrng is delivered. There is a quality
field in there which is used to decide which of the registered
hw rng sources will be used by the hwrng core.

With commit 16bdbae39428 ("hwrng: core - treat default_quality as
a maximum and default to 1024") there came in a new default of
1024 in case this field is empty and all the known hw rng sources
at that time had been reworked to not fill this field and thus
use the default of 1024.

The code choosing the 'better' hw rng source during registration
of a new hw rng source has never been adapted to this and thus
used 0 if the hw rng implementation does not fill the quality field.
So when two rng sources register, one with 0 (meaning 1024) and
the other one with 999, the 999 hw rng will be chosen.

As the later invoked function hwrng_init() anyway adjusts the
quality field of the hw rng source, this adjustment is now done
during registration of this new hw rng source.

Tested on s390 with two hardware rng sources: crypto cards and
trng true random generator device driver.

Fixes: 16bdbae39428 ("hwrng: core - treat default_quality as a maximum and default to 1024")
Reported-by: Christian Rund <Christian.Rund@de.ibm.com>
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index a3bbdd6e60fca..a182fe794f985 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -174,7 +174,6 @@ static int hwrng_init(struct hwrng *rng)
 	reinit_completion(&rng->cleanup_done);
 
 skip_init:
-	rng->quality = min_t(u16, min_t(u16, default_quality, 1024), rng->quality ?: 1024);
 	current_quality = rng->quality; /* obsolete */
 
 	return 0;
@@ -563,6 +562,9 @@ int hwrng_register(struct hwrng *rng)
 	complete(&rng->cleanup_done);
 	init_completion(&rng->dying);
 
+	/* Adjust quality field to always have a proper value */
+	rng->quality = min_t(u16, min_t(u16, default_quality, 1024), rng->quality ?: 1024);
+
 	if (!current_rng ||
 	    (!cur_rng_set_by_user && rng->quality > current_rng->quality)) {
 		/*
-- 
2.43.0




