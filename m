Return-Path: <stable+bounces-74228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB8972E26
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BC41C24799
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F962187325;
	Tue, 10 Sep 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hmZ2geCM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFCD1885A6;
	Tue, 10 Sep 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961190; cv=none; b=cLoa/AIQ2cLovo7y9GnwYz9fWUp7gCOtbTBI08D7SNaXO4mfKof3I3eDnpB8qmEbLhsitAKeFI8oIU/rKCLLYvT6FlenlrdvXZhEk9t3XDflZCqoCClqPVH+2UpH9O0yLo7KzVnFpIzbBwfcq6cmjsYCw16fZ0FOUByStX9oPPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961190; c=relaxed/simple;
	bh=u+gUqgp0U2WK4w58+bk6irbAvImav1AlK5Yq8+bGnks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfcTW11L+oVHnEsJjc+UEovv4GJ9/Vxb2Q0sGDn3AJ4e1IIotfGMA0uT5V8Ox2GWYlr79Eg00OqgnDggIMwcuI3vGsjcLOVG5fQ6x6UUkTNxLNuEdo296SKO2xJoTXqDO+nWA6clBQK/tV05uCPWuzTiwDNuZl7tyqzRxaKPyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hmZ2geCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FAFC4CEC3;
	Tue, 10 Sep 2024 09:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961189;
	bh=u+gUqgp0U2WK4w58+bk6irbAvImav1AlK5Yq8+bGnks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hmZ2geCMGii7265VeW3Rmnnz0axW6r7BarXN3MWvFSrNVpWQWm0Gd0BIKnzOoV3mN
	 tX3lxS2hg3//O+4dO1VfsLD+LfrrV70iGM40JA0sxE2ov9CAi+SoYEUM4G7UQQ0ayd
	 S5RJWuob315wWXrQgXEm3BNGpMRTs+KfT9FMCNV4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Zheng Yejian <zhengyejian@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 83/96] tracing: Avoid possible softlockup in tracing_iter_reset()
Date: Tue, 10 Sep 2024 11:32:25 +0200
Message-ID: <20240910092545.186807078@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092541.383432924@linuxfoundation.org>
References: <20240910092541.383432924@linuxfoundation.org>
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

From: Zheng Yejian <zhengyejian@huaweicloud.com>

[ Upstream commit 49aa8a1f4d6800721c7971ed383078257f12e8f9 ]

In __tracing_open(), when max latency tracers took place on the cpu,
the time start of its buffer would be updated, then event entries with
timestamps being earlier than start of the buffer would be skipped
(see tracing_iter_reset()).

Softlockup will occur if the kernel is non-preemptible and too many
entries were skipped in the loop that reset every cpu buffer, so add
cond_resched() to avoid it.

Cc: stable@vger.kernel.org
Fixes: 2f26ebd549b9a ("tracing: use timestamp to determine start of latency traces")
Link: https://lore.kernel.org/20240827124654.3817443-1-zhengyejian@huaweicloud.com
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 022f50dbc456..63c3c17d406c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3251,6 +3251,8 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 			break;
 		entries++;
 		ring_buffer_iter_advance(buf_iter);
+		/* This could be a big loop */
+		cond_resched();
 	}
 
 	per_cpu_ptr(iter->trace_buffer->data, cpu)->skipped_entries = entries;
-- 
2.43.0




