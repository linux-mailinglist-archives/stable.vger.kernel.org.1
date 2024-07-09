Return-Path: <stable+bounces-58605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF2892B7D1
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8713285571
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD0615749B;
	Tue,  9 Jul 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S5mSwphu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981727713;
	Tue,  9 Jul 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524450; cv=none; b=vFLX4WMPu83VEiMxoksfg4Nqd7i+++Pelw47jOqK/7Yd4x7zG4O0Ij7E9AYqI+S3XnS3gIYMl3uBoClHdDAGwQelACdUh5F63rByBe31KJ0JoLPwqC024MYe6SEY7D248rqNNvz8GMigA15GF94opd5hhKpKe2HeR6o/gStnTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524450; c=relaxed/simple;
	bh=qP/MFKBq/bX2uM2iqJhNtGT83FE2Zf4jZW/+fmR50Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsFcMgzirWJlKrSHuFiiqoADkTSSOJ0WRIUQbYkCKq1J7U2ThxhRMmKw83V9it2PxGkKROUiCy+MwPaHnI+jeeUrd1cW06x33wYIMU8HFQfvNGqHkAONReuz+C/ciz9LxEbdvylj55F8bPAg7b5Cm2OjCczCUcylyKnKDYZGLWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S5mSwphu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CABC3277B;
	Tue,  9 Jul 2024 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524450;
	bh=qP/MFKBq/bX2uM2iqJhNtGT83FE2Zf4jZW/+fmR50Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S5mSwphuwnYxw7zypaQW3WQBqttytU3nQcBgS88QnOAFghjCJyyYaJB0cbirtBncq
	 5J2IHwETyZISvGFVrYQLWfQgkOwUi3cNdCmyilF3bU0TD4bLeE+VHdTtWFR+bebsVE
	 7Fst7KjZghu8jDgxxZu9VZJVAWNTP/ihfiyNat4w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 184/197] libbpf: detect broken PID filtering logic for multi-uprobe
Date: Tue,  9 Jul 2024 13:10:38 +0200
Message-ID: <20240709110716.063000598@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 04d939a2ab229a3821f04fc81f7c027842f501f1 ]

Libbpf is automatically (and transparently to user) detecting
multi-uprobe support in the kernel, and, if supported, uses
multi-uprobes to improve USDT attachment speed.

USDTs can be attached system-wide or for the specific process by PID. In
the latter case, we rely on correct kernel logic of not triggering USDT
for unrelated processes.

As such, on older kernels that do support multi-uprobes, but still have
broken PID filtering logic, we need to fall back to singular uprobes.

Unfortunately, whether user is using PID filtering or not is known at
the attachment time, which happens after relevant BPF programs were
loaded into the kernel. Also unfortunately, we need to make a call
whether to use multi-uprobes or singular uprobe for SEC("usdt") programs
during BPF object load time, at which point we have no information about
possible PID filtering.

The distinction between single and multi-uprobes is small, but important
for the kernel. Multi-uprobes get BPF_TRACE_UPROBE_MULTI attach type,
and kernel internally substitiute different implementation of some of
BPF helpers (e.g., bpf_get_attach_cookie()) depending on whether uprobe
is multi or singular. So, multi-uprobes and singular uprobes cannot be
intermixed.

All the above implies that we have to make an early and conservative
call about the use of multi-uprobes. And so this patch modifies libbpf's
existing feature detector for multi-uprobe support to also check correct
PID filtering. If PID filtering is not yet fixed, we fall back to
singular uprobes for USDTs.

This extension to feature detection is simple thanks to kernel's -EINVAL
addition for pid < 0.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240521163401.3005045-4-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/features.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index a336786a22a38..3df0125ed5fa7 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -392,11 +392,40 @@ static int probe_uprobe_multi_link(int token_fd)
 	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, &link_opts);
 	err = -errno; /* close() can clobber errno */
 
+	if (link_fd >= 0 || err != -EBADF) {
+		close(link_fd);
+		close(prog_fd);
+		return 0;
+	}
+
+	/* Initial multi-uprobe support in kernel didn't handle PID filtering
+	 * correctly (it was doing thread filtering, not process filtering).
+	 * So now we'll detect if PID filtering logic was fixed, and, if not,
+	 * we'll pretend multi-uprobes are not supported, if not.
+	 * Multi-uprobes are used in USDT attachment logic, and we need to be
+	 * conservative here, because multi-uprobe selection happens early at
+	 * load time, while the use of PID filtering is known late at
+	 * attachment time, at which point it's too late to undo multi-uprobe
+	 * selection.
+	 *
+	 * Creating uprobe with pid == -1 for (invalid) '/' binary will fail
+	 * early with -EINVAL on kernels with fixed PID filtering logic;
+	 * otherwise -ESRCH would be returned if passed correct binary path
+	 * (but we'll just get -BADF, of course).
+	 */
+	link_opts.uprobe_multi.pid = -1; /* invalid PID */
+	link_opts.uprobe_multi.path = "/"; /* invalid path */
+	link_opts.uprobe_multi.offsets = &offset;
+	link_opts.uprobe_multi.cnt = 1;
+
+	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, &link_opts);
+	err = -errno; /* close() can clobber errno */
+
 	if (link_fd >= 0)
 		close(link_fd);
 	close(prog_fd);
 
-	return link_fd < 0 && err == -EBADF;
+	return link_fd < 0 && err == -EINVAL;
 }
 
 static int probe_kern_bpf_cookie(int token_fd)
-- 
2.43.0




