Return-Path: <stable+bounces-57006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4CA925A24
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 12:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C001F22296
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE5418412D;
	Wed,  3 Jul 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="klFmncZO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4017B4FF;
	Wed,  3 Jul 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003553; cv=none; b=Z++MTKfEHU8JarI9ap+72e/8pdjSdvSELVGM6Qe7AZXvM+vQiVN8R4xcdltW4ywVJfqN0TlyjgGhpCh1BP+ucalw/gayZm0xvwaWzB8eJHp/4WHybk84wi1jzfw1tgfWPyEye4mUG1ziA8lPjE3ovw3+HchLC8BKaDRt5ubxJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003553; c=relaxed/simple;
	bh=sWwCTQvoyAkGuxtdxZFjBa37WxQA/mdRzqIwjIuHwiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3u2PwczidFEWtxZMITL97oLnTBwwMjAeiMQCKzN0pz10To2FttBwua1qTubsH2r3ngFntuPBYr6KEyL/5yFIGDurARSbYJ22KuquAMFtHQkCRNKGq4Ulxa/7Gl5rll6RdbtG5Nw6fo9fKAGmpts3j25U40ntRw8kfFeAdRkSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=klFmncZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3799C4AF0A;
	Wed,  3 Jul 2024 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003553;
	bh=sWwCTQvoyAkGuxtdxZFjBa37WxQA/mdRzqIwjIuHwiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=klFmncZOBdlFf3SFWRWJCgtX3oD6V0PpK2fAWlL+1fvkKkw+Hj/lnVY5vEZkEI8jj
	 nj8UVfQcNuRyhALHAUbBHyrcwIeAbga+TYJWfsEsbShGwVAC7ZHF1FCG0/oHTah8Y/
	 5YDBtH9a9Z+HrqN9eK8YBzSmBLDkjrtc5T2MdDgk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	"Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 085/139] selftests/ftrace: Fix checkbashisms errors
Date: Wed,  3 Jul 2024 12:39:42 +0200
Message-ID: <20240703102833.649650861@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102830.432293640@linuxfoundation.org>
References: <20240703102830.432293640@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 72ce3daf92ba4f5bae6e91095d40e67b367c6b2f ]

Fix a test case to make checkbashisms clean.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
index 6748e8cb42d0f..6bf7ac7f035bc 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
@@ -47,10 +47,10 @@ test_trace() {
 	fi
 	echo "testing $line for >$x<"
 	match=`echo $line | sed -e "s/>$x<//"`
-	if [ "$line" == "$match" ]; then
+	if [ "$line" = "$match" ]; then
 	    fail "$line does not have >$x< in it"
 	fi
-	let x=$x+2
+	x=$((x+2))
     done
 }
 
-- 
2.43.0




