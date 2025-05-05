Return-Path: <stable+bounces-140052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204D8AAA483
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3E43ABE37
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DAF33062;
	Mon,  5 May 2025 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtBz7ZL8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B92FF2BB;
	Mon,  5 May 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483985; cv=none; b=IWBoTj4Ch25USGIoJzyiJBU0+L6w/1G5bu2y0yUKw9MHFYTp3lxL6SxY03yuQschgA8qGIvp3ej9Olb0Kyzi/XHBUOe259nBK9Kt7/GJNcN/4GwhDPxQq9s7Di7DrPuOP4oBaduXhY+KmDYIwOh3ZJ/748+TF/C61eY9cezD+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483985; c=relaxed/simple;
	bh=uoqatsxnaznUHh7zR9Q6eQtHRh1oWtgPBgbDgbm5Xfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VvUnuQk01acM5ZUnZcz7z+C1Mxl9ZdMSLnctGiQL0zJ+9+COFa236XOg0C/zz6Lc+WiLEmn7eDOU7VZ7V92IhhDjKK0pXSptKrzcIQoVUwxNMS2n4mKQYq3p0u7rjt85/13A+wuVKyQvfx3OydJ1I/mkomECvfC8Mwc3fq1SfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtBz7ZL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048F4C4CEE4;
	Mon,  5 May 2025 22:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483985;
	bh=uoqatsxnaznUHh7zR9Q6eQtHRh1oWtgPBgbDgbm5Xfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EtBz7ZL8124glnJayWVbzeGeNTPY71qoUqHQlY9akSOk004bepFaKA/u4jSnqjrZT
	 3BofRfKJEpGcrU54R5wpDOtXWXt33L8gS8hvwUBc+KLcyHM0NRWi9EyAPgKQVNsMld
	 ByMr4g1UgghIF77xqve3DYWI6ugnKWKHo2Z9WF71Bi6wQ9DA/MV++qmWaR66aZhfOa
	 mHImREDDWX6FBHInlKWg7uEVtv+yvO4S6D1PaV3F0qauucHCGUoFUcKqznSpLnMyN4
	 ktP4mnFZcZ/z1tHKDXc5N3kMaDl02xgfv4QcJpYckFg1cetbEGTfxGNLHCyzCTOFeA
	 ph3u4cM9/ojKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 305/642] drm/xe: xe_gen_wa_oob: replace program_invocation_short_name
Date: Mon,  5 May 2025 18:08:41 -0400
Message-Id: <20250505221419.2672473-305-sashal@kernel.org>
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

From: Daniel Gomez <da.gomez@samsung.com>

[ Upstream commit 89eb42b5539f6ae6a0cabcb39e5b6fcc83c106a1 ]

program_invocation_short_name may not be available in other systems.
Instead, replace it with the argv[0] to pass the executable name.

Fixes build error when program_invocation_short_name is not available:

drivers/gpu/drm/xe/xe_gen_wa_oob.c:34:3: error: use of
undeclared identifier 'program_invocation_short_name'    34 |
program_invocation_short_name);       |                 ^ 1 error
generated.

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250224-macos-build-support-xe-v3-1-d2c9ed3a27cc@samsung.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gen_wa_oob.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gen_wa_oob.c b/drivers/gpu/drm/xe/xe_gen_wa_oob.c
index 904cf47925aa1..ed9183599e31c 100644
--- a/drivers/gpu/drm/xe/xe_gen_wa_oob.c
+++ b/drivers/gpu/drm/xe/xe_gen_wa_oob.c
@@ -28,10 +28,10 @@
 	"\n" \
 	"#endif\n"
 
-static void print_usage(FILE *f)
+static void print_usage(FILE *f, const char *progname)
 {
 	fprintf(f, "usage: %s <input-rule-file> <generated-c-source-file> <generated-c-header-file>\n",
-		program_invocation_short_name);
+		progname);
 }
 
 static void print_parse_error(const char *err_msg, const char *line,
@@ -144,7 +144,7 @@ int main(int argc, const char *argv[])
 
 	if (argc < 3) {
 		fprintf(stderr, "ERROR: wrong arguments\n");
-		print_usage(stderr);
+		print_usage(stderr, argv[0]);
 		return 1;
 	}
 
-- 
2.39.5


