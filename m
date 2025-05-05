Return-Path: <stable+bounces-141132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12CAAAB647
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6A63A9D8C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18CF29ACE8;
	Tue,  6 May 2025 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhw2t/A8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E437532D;
	Mon,  5 May 2025 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485266; cv=none; b=lzIpxGdiqslj46OG9jZR7johHhIS0P+xH+tZgeSteyfFeCKW8qr7lITPczO5iS/FrgXnyyMV70xgFxVBS6PFTUDq4FhxObFfpMWeKLQjsAjldoPK/f/zQ33cjknoS7rFVWnEPilEDm6LOrhhuk868kI0eCZE1bQth1HTK82xyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485266; c=relaxed/simple;
	bh=uoqatsxnaznUHh7zR9Q6eQtHRh1oWtgPBgbDgbm5Xfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHL2hQI+bJwg3Iez0XT1mpqYkzhM5ntJ4ZiqwR8ze8bVVCrK/zsVl5PL4iFeiqdAM0u9YOMHNDhcvOVwHImzbraTQoqZEw5sSEImn1fWrl+3qPBdyLoPBCCrVheFC7XLlEtn2zb5NlVWNCOXOVqYWQLAGlAsyQAAD4PdkODuoFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhw2t/A8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97982C4CEED;
	Mon,  5 May 2025 22:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485264;
	bh=uoqatsxnaznUHh7zR9Q6eQtHRh1oWtgPBgbDgbm5Xfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhw2t/A8hsTBGfqj5YyTPYzRb0pX3OTKU3rTc4nrraALssGPZPdPm5RQPBG75OfFc
	 Sk6lfUknIXg0ioVtkircDlqLJN5EfxwP6sv9RqwR+Hn4vWjF1e5PqT230PwR8vMhsa
	 5Fe21a3KdA+SeTgTNCJYgudIWFxMXguCCxplRjjPLS3ZNHOHUyfdJpvvt0Z1xqMF7j
	 6e3xClefsl4eUv3fIZi260KOYwG6/f8IR0wz1fp7pvjNjuhRV0/Zvn8ZpMzOSWX8ZE
	 yXeZo+j2xAhRmy/MbS0WHl0ep0F/pE4tv+IPyQA408SOYpGxakVafU7hiZLliNew0M
	 PHBMzcrS/k5jA==
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
Subject: [PATCH AUTOSEL 6.12 242/486] drm/xe: xe_gen_wa_oob: replace program_invocation_short_name
Date: Mon,  5 May 2025 18:35:18 -0400
Message-Id: <20250505223922.2682012-242-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


