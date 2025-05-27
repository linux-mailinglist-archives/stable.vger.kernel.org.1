Return-Path: <stable+bounces-146738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B96DAC5457
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C279D1898326
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F827FB37;
	Tue, 27 May 2025 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uO7SENcf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33E2CCC0;
	Tue, 27 May 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365159; cv=none; b=D/+s59yMOX56/iDdFtBxtkWeNQxR7N4crlCtHwItTK4Q8ZRcvbbLjkFZYS44VOrn9Kzjw2y5bEZVyoAViefZrUKXG15+srdqmK1uzrMK2JTafQjqEPgdJCLQAz31f1MooomulI/OcsSyefu29s7T8IlkmZuuRVeh9Hz3NipwjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365159; c=relaxed/simple;
	bh=XzlyRz9UFZFUAYVGs48l65ceAILZwvup1odr6A0aVEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0l6aoBa9S4Ea+/UbYkEHx8jVMXtDX3LAmmVjPW+L3C1z6LBv3Yjrtw8PFRv9a9F5cfR7vTk1kxEVObA9E7nhaLxpgOsArOT0kirvoJp5uRMjohIaDSn5rf9A1k38tcXzKJXToUo+EeWdd9KHUCNJfqRzOU8oSdVmDA9h3u6pAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uO7SENcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FB7C4CEE9;
	Tue, 27 May 2025 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365155;
	bh=XzlyRz9UFZFUAYVGs48l65ceAILZwvup1odr6A0aVEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uO7SENcfb/NM6WY1iAEek5iejnmMA7JYlkC60bJf2axeQr4fyi0PQDGYuja616AyD
	 XZ0wCQ68QKmGRFHntIcHBuiUIqGr6lhh4LaQEyfCVe7nBvsb9Dv8CshKsWXqVHti2w
	 pjm2nGXs4I/zpPN9jeeF+2Xnnb4C5IWrHx0lpni8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 277/626] drm/xe: xe_gen_wa_oob: replace program_invocation_short_name
Date: Tue, 27 May 2025 18:22:50 +0200
Message-ID: <20250527162456.280551642@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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




