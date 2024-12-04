Return-Path: <stable+bounces-98371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2879E40A9
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD24B46279
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB0320E028;
	Wed,  4 Dec 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOejymQN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B9120D507;
	Wed,  4 Dec 2024 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331581; cv=none; b=Q6LN9S/z4xS+tUsLoxs5BqqCjTWTMm5n1eh9mPYXmZ40tDX3LzskPhVhc4qHW34s46rfYRYQkzzGjT/2G8ZLEt2HIMAsAkz/pQpLd5TPVpJoZa5XKKyTeux5AwwawPgnTiGQOHpbzu7Sug6L1sVlPIr57HhmhlJSY2kWyXz5gpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331581; c=relaxed/simple;
	bh=06pVRQZvF7Hv8LSrodVzxmE+a9EeBGCKKwPeWagF/ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHqKZryAwo7osrPDlpbc9Xe1nUhNowANRIFiNEuDtVhydlNYKa4bW++cXYcIin3fV6mG9cmUTjPfZgbeGtpYNizDDlHK/sn4ALeoLpkVHnUqSuYkBN5kIJNRwCpokgvxS66IKHXziuTt/M9d/Jo5qIx7tCcIHk6Xym4qrzrfUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOejymQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94778C4CECD;
	Wed,  4 Dec 2024 16:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331581;
	bh=06pVRQZvF7Hv8LSrodVzxmE+a9EeBGCKKwPeWagF/ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOejymQNhR6ajowoT3FvIEydJRHEnzV2mzQULQAxb5lcDuJUZHdHI1KDQ3TKNAn2g
	 1Fv6J2olXKlalxlJXYDq/eII+rXMrqRtFv5i/FspNhI9MKkA/q3+RvdIn9C+ESCUSV
	 8MiccR9dA/GymhvgUYkhMyVz9S5ANK6EKGlD24Tq6qrBAQ8P4e68cDG1G3Pv3d20yx
	 wAnPCOIUmvwzB+41fWXQcoyiV2scVVKYVV11K8sGIwGw+mkJA9KRgqe33G1+1C868G
	 6LbQheN1thikd7klucHDW2HYj3i09Y0yy9uAAAujsoFBRUImMb4bneJdQPEthi/M5Z
	 WhN4tfVndkFRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	bristot@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 02/33] rtla: Fix consistency in getopt_long for timerlat_hist
Date: Wed,  4 Dec 2024 10:47:15 -0500
Message-ID: <20241204154817.2212455-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154817.2212455-1-sashal@kernel.org>
References: <20241204154817.2212455-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Gabriele Monaco <gmonaco@redhat.com>

[ Upstream commit cfb1ea216c1656a4112becbc4bf757891933b902 ]

Commit e9a4062e1527 ("rtla: Add --trace-buffer-size option") adds a new
long option to rtla utilities, but among all affected files,
timerlat_hist misses a trailing `:` in the corresponding short option
inside the getopt string (e.g. `\3:`). This patch propagates the `:`.

Although this change is not functionally required, it improves
consistency and slightly reduces the likelihood a future change would
introduce a problem.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>
Link: https://lore.kernel.org/20240926143417.54039-1-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a3907c390d67a..1f9137c592f45 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -778,7 +778,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
-- 
2.43.0


