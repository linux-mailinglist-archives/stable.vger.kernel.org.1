Return-Path: <stable+bounces-66831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CB494F2AA
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E73A7B249F7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441AC186E38;
	Mon, 12 Aug 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fkctJujo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016B2183CA6;
	Mon, 12 Aug 2024 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478928; cv=none; b=uQFQtJWghMfqbAK/ZcuS/dl7WYdRQp3+2ThWdYZArLXzt7gNqapyjODfjeziFSGInNEC9wlc9ncgGL216Y2CtztrOwyKfhAPmGQu2ibvsL7rC4Un2Z4DWJ/MDtxgHmOGmjV3jFMqZh3vuxP1Cb1algUWBr+xpgXprWZAvbbvgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478928; c=relaxed/simple;
	bh=FxnE8F2akFSOu7htiLwkObYcOiz/E+PLOx7BKXYldXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaX9JD4SsDD77z+Qpgdy0oIWv9bwSE8fUp3ApOxnUqkuzt4hxl4AEHlezAfcvFnAdI0kkW+nGsIMXBJzcAd6sa6wqumGdcrhGcc7HvgeMU+i8FQ/j1YPMJzX21zIMhC5Mq98ipe04IguSogB/98B9KGi2bU/RQes3xl+IRPVUvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fkctJujo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DABC32782;
	Mon, 12 Aug 2024 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723478927;
	bh=FxnE8F2akFSOu7htiLwkObYcOiz/E+PLOx7BKXYldXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fkctJujoKMIg+iT8OVJKa2ZQfAKI5yoeD5APYcAm+YV65nESPxAxKcO0j3FBxQRam
	 wWhbm0+lyNoRwlIHKtvEoDh5j3mfL9hmLAhAOw66H6PpkwdE258+7r0Cc/eIVQSQ9y
	 MRAjSor03HAIa8d3ZKOzuQIERU1M2suTpex3x+Mg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Jiri Olsa <jolsa@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 079/150] bpf: kprobe: remove unused declaring of bpf_kprobe_override
Date: Mon, 12 Aug 2024 18:02:40 +0200
Message-ID: <20240812160128.224953688@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
References: <20240812160125.139701076@linuxfoundation.org>
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

From: Menglong Dong <menglong8.dong@gmail.com>

[ Upstream commit 0e8b53979ac86eddb3fd76264025a70071a25574 ]

After the commit 66665ad2f102 ("tracing/kprobe: bpf: Compare instruction
pointer with original one"), "bpf_kprobe_override" is not used anywhere
anymore, and we can remove it now.

Link: https://lore.kernel.org/all/20240710085939.11520-1-dongml2@chinatelecom.cn/

Fixes: 66665ad2f102 ("tracing/kprobe: bpf: Compare instruction pointer with original one")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/trace_events.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index c8b5e9781d01a..f70624ec4188f 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -847,7 +847,6 @@ do {									\
 struct perf_event;
 
 DECLARE_PER_CPU(struct pt_regs, perf_trace_regs);
-DECLARE_PER_CPU(int, bpf_kprobe_override);
 
 extern int  perf_trace_init(struct perf_event *event);
 extern void perf_trace_destroy(struct perf_event *event);
-- 
2.43.0




