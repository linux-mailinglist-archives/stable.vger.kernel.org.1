Return-Path: <stable+bounces-29144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8961F888357
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 01:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA31F1C2373F
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 00:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A2193876;
	Sun, 24 Mar 2024 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gugv2NKf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA6319386B;
	Sun, 24 Mar 2024 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320116; cv=none; b=ZFLbcgw82RgjnA1TgbgnDN+Pko391Fg5uNAWn96cgtRrcXgjI3T+nD9SxPYqYLJKfcAw+7atibCygW88EyH3E7pv6hKpw3o2XQyLXCX4vFG7Vyybosk7OdJbZmr+vek7rNP4Q5Cv8vmuYHh3FeuMHDUIVa/p8AtCNahJSoaROdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320116; c=relaxed/simple;
	bh=V4NVh05WyemHL5wZcJ0nlItQbZj2IaY9CQKDxk9qkGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBO2rwy9D9zRbVVoJAsxTcpxCH8VjvLXhaM1RtnL/VXt3Oon700gHSvr9BUtmPpU4X81efF3WrJXw3iXTAQ2bgzI0j32W+VY6oSaId2z7v1c4W3tlAaMvOs+tTgHc5jQ1Wkpu+TjdadJbzSnVuKsybidVClYsTi8qn0q0Yu+7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gugv2NKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0534BC43390;
	Sun, 24 Mar 2024 22:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320116;
	bh=V4NVh05WyemHL5wZcJ0nlItQbZj2IaY9CQKDxk9qkGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gugv2NKfq/P3OVxFqv7xVDC27l057Lgh1Kkm8jfdKBRiGpT5ASC0mPfVOYki+fTgK
	 gZ4wTN4YeI6hS7DvDoM/fVn0gEvdhPz9a3xt3JbsNyFh5+iTBNvjBMNxe4Xbovh/lT
	 jmSYDx24I2iT0vwC050pLd2BJsUHciUZTJ1w7nPWNnyRzosKmh3VWMorAb5JR9b3Kq
	 uH2jTdO1CE+h/f2rdXCGmvoYE6G+8wPEGWLWMfHMWS+L9H5gHJzIPqllM7m++/W/PA
	 PUy4YHxKIGjpgxPNnuRJ/XwcWDXzW6/sHBVIZhx+mqaK7gEe4PXRUZz0LEXxpDz3rE
	 Bva3zx1iHMAbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	James Clark <james.clark@arm.com>,
	Kaige Ye <ye@kaige.org>,
	John Garry <john.g.garry@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 424/715] perf expr: Fix "has_event" function for metric style events
Date: Sun, 24 Mar 2024 18:30:03 -0400
Message-ID: <20240324223455.1342824-425-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

[ Upstream commit 6dd76680b925228312756c13b9b983661b552a64 ]

Events in metrics cannot use '/' as a separator, it would be
recognized as a divide, so they use '@'. The '@' is recognized in the
metricgroups code and changed to '/', do the same in the has_event
function so that the parsing is only tried without the @s.

Fixes: 4a4a9bf9075f ("perf expr: Add has_event function")
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: James Clark <james.clark@arm.com>
Cc: Kaige Ye <ye@kaige.org>
Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240209204947.3873294-3-irogers@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/expr.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7be23b3ac0821..b8875aac8f870 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -500,7 +500,25 @@ double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const
 	tmp = evlist__new();
 	if (!tmp)
 		return NAN;
-	ret = parse_event(tmp, id) ? 0 : 1;
+
+	if (strchr(id, '@')) {
+		char *tmp_id, *p;
+
+		tmp_id = strdup(id);
+		if (!tmp_id) {
+			ret = NAN;
+			goto out;
+		}
+		p = strchr(tmp_id, '@');
+		*p = '/';
+		p = strrchr(tmp_id, '@');
+		*p = '/';
+		ret = parse_event(tmp, tmp_id) ? 0 : 1;
+		free(tmp_id);
+	} else {
+		ret = parse_event(tmp, id) ? 0 : 1;
+	}
+out:
 	evlist__delete(tmp);
 	return ret;
 }
-- 
2.43.0


