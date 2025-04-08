Return-Path: <stable+bounces-131505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26930A80AB4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AC750359C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35626FD82;
	Tue,  8 Apr 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hxeHpFwv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFD2686BC;
	Tue,  8 Apr 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116581; cv=none; b=p6fwklB4hs4gdWOKAyDJKSgZkNO1DsszK12cYT9TovtK0yGRl6td/jOMsOTBkPxUmEEz5Hpq4sMOa6QfTnrEmhTQeQsnUEulsxtrTxJ5XFz5jG29Idxtbe8Gxv1wMKsz/U80Eny1DpQHIDdrEB3PXBtV0IVfxZ9DI5G2KLb4gN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116581; c=relaxed/simple;
	bh=jBQCJkKwhQw2c/xlxrWvge17MHDGMi1Hash+FRgXt4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhTnckKgtSvOb1AqFV1sPUXPTWhqwmQ6ZVwBFpzsMtcR3tJhxUx2vQLOVBEeZsxE4F+9LvCpKZqowyv7zLkzCtfZLJB/xlcoaCeOQPWZrmZhiitzJsW4HSxDaqQV/Fxk+COtWnccShzL/vGXUENLgCWcZPyrWk8RkqYuNUdXqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hxeHpFwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8C4C4CEE5;
	Tue,  8 Apr 2025 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116580;
	bh=jBQCJkKwhQw2c/xlxrWvge17MHDGMi1Hash+FRgXt4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hxeHpFwvAknPz7JW/HvjqaMe1dKL7JygBoK9fZM1Gp1GG9Bw4pzJGJPxyHwzGp+80
	 CplED0Vx/tkUsBwL48MXnjX1T2IkG/4H/+vgkrAIM0dXBo+Y6qeY0sIlkPHrcVfusy
	 A+tkqCQIMDY7dcOnA4oi16IEm9Mhe2Y1Q7VZPDaM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Howard Chu <howardchu95@gmail.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 193/423] perf debug: Avoid stack overflow in recursive error message
Date: Tue,  8 Apr 2025 12:48:39 +0200
Message-ID: <20250408104850.232559095@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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
index d633d15329fa0..e56330c85fe7e 100644
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




