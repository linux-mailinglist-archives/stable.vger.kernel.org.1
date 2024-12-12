Return-Path: <stable+bounces-102493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E0C9EF355
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87D217E1A8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EAE22A7F7;
	Thu, 12 Dec 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rDFItD/R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798C223C5C;
	Thu, 12 Dec 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021430; cv=none; b=lpbRM4HvKSTHyIfnu2l+zyrAhBUu8779MtVNMPSeQYBq4r+b/0gb9WszGbPQnbPmqkxgq8wLz1M6MCUmedbkERt2icAykPJ5r5ug22CmIQz0uws8xGere1nDLJSVJ3DG0p9RlRHyAnzh/C968FW6QbYhva5PrjIjSzp1hNxcy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021430; c=relaxed/simple;
	bh=u2ByaEum127LxX2x4DLRyJCBSYIfddE7MGL8dzF9N08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8bV40qJvIaiEdhfcEXqLyPaogsqILinO6HwxdNPqCSbq20RunRsh8Zi6rNqqS2m0RgkFWIwSCOjPuv5E8O6uBhqcWXPe/FxO/tAihWUrIy7CuidvElue0Wp3P2TCwwjdEDjerOXKhmP7hjwn5CzQOEnwYt4hxwKpG/uYCQR0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rDFItD/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925B6C4CECE;
	Thu, 12 Dec 2024 16:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021430;
	bh=u2ByaEum127LxX2x4DLRyJCBSYIfddE7MGL8dzF9N08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDFItD/RvrO8RFqcwOtk+zvF5v/4ti3urb98PEBe/mFgNiFjxW1DDWPneKQMUqbl4
	 jgttQfLKmZD8Mibz2DIe2tI5vUFwxR9AHpWIvbCaUOutO4eWlgG/lBSNgGxiuhwZdF
	 oA9KolJsiz9Z904APxKY5Jljy490iEffROrp85jA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 735/772] tracing/eprobe: Fix to release eprobe when failed to add dyn_event
Date: Thu, 12 Dec 2024 16:01:20 +0100
Message-ID: <20241212144420.289412526@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[ Upstream commit 494b332064c0ce2f7392fa92632bc50191c1b517 ]

Fix eprobe event to unregister event call and release eprobe when it fails
to add dynamic event correctly.

Link: https://lore.kernel.org/all/173289886698.73724.1959899350183686006.stgit@devnote2/

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_eprobe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index d2370cdb4c1d6..2a75cf3aa7bf8 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -1069,6 +1069,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		goto error;
 	}
 	ret = dyn_event_add(&ep->devent, &ep->tp.event->call);
+	if (ret < 0) {
+		trace_probe_unregister_event_call(&ep->tp);
+		mutex_unlock(&event_mutex);
+		goto error;
+	}
 	mutex_unlock(&event_mutex);
 	return ret;
 parse_error:
-- 
2.43.0




