Return-Path: <stable+bounces-78819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E43CF98D520
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA5CB2106C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479BD1D043D;
	Wed,  2 Oct 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lQWYtrY4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD31CF28B;
	Wed,  2 Oct 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875623; cv=none; b=BEFHldWEkozdjrIcMSPB3CpzsHC3uK21hn/ULes7DTRFqMJw4CjEmGv9O5mso2xsyqnB8xwURMaIxD4g0pEIHGJqfTqslr200Vy9WQOgALSj0d2AjdZzcBeV8t94gFyTpxsTNxte1It3L/8h1wLlVJD2zCCvB+sJ8mgFRHO+fhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875623; c=relaxed/simple;
	bh=46UbYPEyaBgOlqnhARdVUoNiAY+rETeza/+gtp8ZkOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrt5BOH5DHLtStRCZsgHzgpR2NerqSq+kcWCRrdx7Whm4uQWijphkLGFoRXz3mcwESa3UBbi3oKBS2hVQsFxmT3RHb2YIBM5oXm6cdtYKclY0O5BCyHYQBPsb9tqX4XKj9yH9T8Jz1Rf0QMUmlphYmTbLS47zB8vfZZz+zFtMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lQWYtrY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813F0C4CEC5;
	Wed,  2 Oct 2024 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875622;
	bh=46UbYPEyaBgOlqnhARdVUoNiAY+rETeza/+gtp8ZkOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lQWYtrY4NV3ehUzhbsXAUyjpToz681EG6teN+Ji9t8vsYL9mV9loJnjCmFstLxkPF
	 CVWGk1W9VJVMA7i733cmEP5fZjM8jpZWvlTq80MdC1vB5rItNwW2ZF+QtYzBDlhXxV
	 5+GAHMNAjwSH9fOE64FE8v+968S606guMJy2hlSk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 165/695] selftests/ftrace: Add required dependency for kprobe tests
Date: Wed,  2 Oct 2024 14:52:43 +0200
Message-ID: <20241002125829.061662292@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[ Upstream commit 41f37c852ac3fbfd072a00281b60dc7ba056be8c ]

kprobe_args_{char,string}.tc are using available_filter_functions file
which is provided by function tracer. Thus if function tracer is disabled,
these tests are failed on recent kernels because tracefs_create_dir is
not raised events by adding a dynamic event.
Add available_filter_functions to requires line.

Fixes: 7c1130ea5cae ("test: ftrace: Fix kprobe test for eventfs")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc  | 2 +-
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
index e21c9c27ece47..77f4c07cdcb89 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event char type argument
-# requires: kprobe_events
+# requires: kprobe_events available_filter_functions
 
 case `uname -m` in
 x86_64)
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index 93217d4595563..39001073f7ed5 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Kprobe event string type argument
-# requires: kprobe_events
+# requires: kprobe_events available_filter_functions
 
 case `uname -m` in
 x86_64)
-- 
2.43.0




