Return-Path: <stable+bounces-130839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2847DA806F5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE31423B5F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD426E168;
	Tue,  8 Apr 2025 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w06+jGqP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248EE26E164;
	Tue,  8 Apr 2025 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114792; cv=none; b=qIF78xA3xgnAmsRDNpuM+rW4HIDXonwz3DATGuGmFupZXOJh1WG9Ro6vyiXM9SUaOz9b1cbttFa+NLiFujjucaG7OCZJJrOl4FCS8hLJQTxjNg3GmAKT4w487UNEa23MKPPNuFJyD9nAJqmU1yANanwF46uiAt3Z0mnfd5EpRZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114792; c=relaxed/simple;
	bh=UvfLl2zxegCfklrO+PfXeAnEchqHCRNickkm8tSBo7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKi9L64y5konPVl7NiWCTdbOP3nDdvfhBhTM5VdCcOeXJpwxSRN5WgUgDRBhKig6Ez/HT1VXlSpHls7Ud/RDL/8AfcmUPDI7708Pe+o84eGDuYKjRpGQh4fxqgNjrnGzl5YBj4PeMfDb41XB2FqpeQ2YNraH839Ft2a565vXqBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w06+jGqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA4DC4CEE5;
	Tue,  8 Apr 2025 12:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114791;
	bh=UvfLl2zxegCfklrO+PfXeAnEchqHCRNickkm8tSBo7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w06+jGqP7EehPPxQXT2IdTG68XWrG7QSpli1lfxCRbIHI3/uAE/i3lxJuYUvbyWX/
	 ww6WG+GsAkYfoSMLOldNS3cT1lRviPZHpG+qVwU8g1k+LX3Z16aX2kxErnw7/w5vkD
	 29opMk/8Yzfew8esGRkbfHDnMaTLETcwPGwGYh34=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Howard Chu <howardchu95@gmail.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 236/499] perf debug: Avoid stack overflow in recursive error message
Date: Tue,  8 Apr 2025 12:47:28 +0200
Message-ID: <20250408104857.101176958@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit bda840191d2aae3b7cadc3ac21835dcf29487191 ]

In debug_file, pr_warning_once is called on error. As that function
calls debug_file the function will yield a stack overflow. Switch the
location of the call so the recursion is avoided.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lore.kernel.org/r/20250228222308.626803-2-irogers@google.com
Fixes: ec49230cf6dda704 ("perf debug: Expose debug file")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 995f6bb05b5f8..f9ef7d045c92e 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -46,8 +46,8 @@ int debug_type_profile;
 FILE *debug_file(void)
 {
 	if (!_debug_file) {
-		pr_warning_once("debug_file not set");
 		debug_set_file(stderr);
+		pr_warning_once("debug_file not set");
 	}
 	return _debug_file;
 }
-- 
2.39.5




