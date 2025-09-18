Return-Path: <stable+bounces-167375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED79B22FDC
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90C71897B1A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED97F2FDC2E;
	Tue, 12 Aug 2025 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2K4JgZhU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94BD2F7461;
	Tue, 12 Aug 2025 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020606; cv=none; b=JOKjXljFqAAhIx3I9j9wZ7bOiwAtxT+uJ0lr0yLnO3+eoJeeyrqKl0ikBQM53P/R+0fx8AUqX8SIgDip+9FUmnhS694MI2QqWnw1UU4IYTwr/uvBI146Zp3XeFH69Ne6LoBm/dg4/l0AhumACgBFKMxj0lclNtfDbXx0VwJevRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020606; c=relaxed/simple;
	bh=R56aCXlkcUjxJvIwE/tjwzgqZhiM+iUtfYX1CroICPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gA/U0VNIRv7AyC6Q+eWGP/b0vCbz2uHPF8dtwgzFIx/E3f5NPCJGs7FRQALqY6s8SvZPbMJRihYSaHEtsHVChQ98yyI5EM+0ZyP97Y6HfyEgt6hDV6XrR/LoFQLshU/i1f1zs3fRUG0RYPFNqJwrJbzGwsBXE216/qF+IybfNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2K4JgZhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BB7C4CEF0;
	Tue, 12 Aug 2025 17:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020606;
	bh=R56aCXlkcUjxJvIwE/tjwzgqZhiM+iUtfYX1CroICPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2K4JgZhUh401cJslgGlfdCCkiD2poQb3nFjeM5FyXS807QBVRlpyHExsXN1IhXbbU
	 wXfTxDnH/gC+ZBQ4qNIGX/NeQouJFhfJUPzCZaa6vuslB8tYl3BAHJFosDWjKoh54v
	 QenpSkI9yYpy+PLf6tYbP2OQmnd8A11n6i0X1+fg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 096/253] selftests/tracing: Fix false failure of subsystem event test
Date: Tue, 12 Aug 2025 19:28:04 +0200
Message-ID: <20250812172952.817926549@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 213879061a9c60200ba971330dbefec6df3b4a30 ]

The subsystem event test enables all "sched" events and makes sure there's
at least 3 different events in the output. It used to cat the entire trace
file to | wc -l, but on slow machines, that could last a very long time.
To solve that, it was changed to just read the first 100 lines of the
trace file. This can cause false failures as some events repeat so often,
that the 100 lines that are examined could possibly be of only one event.

Instead, create an awk script that looks for 3 different events and will
exit out after it finds them. This will find the 3 events the test looks
for (eventually if it works), and still exit out after the test is
satisfied and not cause slower machines to run forever.

Link: https://lore.kernel.org/r/20250721134212.53c3e140@batman.local.home
Reported-by: Tengda Wu <wutengda@huaweicloud.com>
Closes: https://lore.kernel.org/all/20250710130134.591066-1-wutengda@huaweicloud.com/
Fixes: 1a4ea83a6e67 ("selftests/ftrace: Limit length in subsystem-enable tests")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ftrace/test.d/event/subsystem-enable.tc   | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index b7c8f29c09a9..65916bb55dfb 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -14,11 +14,35 @@ fail() { #msg
     exit_fail
 }
 
+# As reading trace can last forever, simply look for 3 different
+# events then exit out of reading the file. If there's not 3 different
+# events, then the test has failed.
+check_unique() {
+    cat trace | grep -v '^#' | awk '
+	BEGIN { cnt = 0; }
+	{
+	    for (i = 0; i < cnt; i++) {
+		if (event[i] == $5) {
+		    break;
+		}
+	    }
+	    if (i == cnt) {
+		event[cnt++] = $5;
+		if (cnt > 2) {
+		    exit;
+		}
+	    }
+	}
+	END {
+	    printf "%d", cnt;
+	}'
+}
+
 echo 'sched:*' > set_event
 
 yield
 
-count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`check_unique`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -29,7 +53,7 @@ echo 1 > events/sched/enable
 
 yield
 
-count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`check_unique`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
-- 
2.39.5




