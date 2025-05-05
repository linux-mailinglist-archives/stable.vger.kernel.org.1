Return-Path: <stable+bounces-141455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A744BAAB39B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABF73ADF6C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E6C293736;
	Tue,  6 May 2025 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwYXWZ2x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96828153A;
	Mon,  5 May 2025 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486356; cv=none; b=THB3w7zEmBkQWMDRmSWlu5SIro2sgoyTdLurEvZyfpxnUDskO/fd+ef3+J5PvgUFLcydOsJksny1+reMpqszp3DtJ0wHvbAxF5QByZKlIB46JEWfbYxCuiu8BTFLUhKLOOUTKCbqnQehAOTgzskWBvMEwehyn8MTdGHuuwXyLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486356; c=relaxed/simple;
	bh=4VF94PrXVRjvhxZctZCRwPwMl/OyynMcRvYM0Eb4v2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afn3T6gyeIOKvNhVrRV8SYT/DZFiA4whIqXhgBDvwmJjjTpbKrWZ7xFZysXHa1lMv/QN1TFKrYHbXDeaxlgRg9x0ujNqMucy4aK7JtcUcmqdUinf6IBvuhd8Qjyr+JK6gZ08j5dPd2DW25b1oNLLh629WGdcA01nZT18CKcfVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwYXWZ2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FA4C4CEF1;
	Mon,  5 May 2025 23:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486355;
	bh=4VF94PrXVRjvhxZctZCRwPwMl/OyynMcRvYM0Eb4v2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwYXWZ2xeIbjfbtUYbZd8YDPldQ2GVfkrZrOoeHIKox9luFjH1qrS7MTanHX66HXt
	 dl64nevsqSgMq7ePeAxhJ1/YfTtq+00IctMTj7SH6X8SPBINKAfmQKb4a8H+SbS9zp
	 euyUwQ080eABQKiz7220hG+kqbxnladnELCQNII0TWlDUO48dC06a/si1MTOVZ3vtM
	 EZN6bJvam0PvXxoE5cCq2Zg5OlMMGeFuFWhs1Z99MCcrizjF0Lb6OU6gxAvQ9wZk34
	 +At1Dhx2zR1EAuOfxiu/a+FnO5FgW4HwOWpzIYtxict72vuM/o8PtPJm2uAqa451+d
	 ZBusoKdWPSlnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viktor Malik <vmalik@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 277/294] bpftool: Fix readlink usage in get_fd_type
Date: Mon,  5 May 2025 18:56:17 -0400
Message-Id: <20250505225634.2688578-277-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Viktor Malik <vmalik@redhat.com>

[ Upstream commit 0053f7d39d491b6138d7c526876d13885cbb65f1 ]

The `readlink(path, buf, sizeof(buf))` call reads at most sizeof(buf)
bytes and *does not* append null-terminator to buf. With respect to
that, fix two pieces in get_fd_type:

1. Change the truncation check to contain sizeof(buf) rather than
   sizeof(path).
2. Append null-terminator to buf.

Reported by Coverity.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/20250129071857.75182-1-vmalik@redhat.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 9b75639434b81..0a764426d9358 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -461,10 +461,11 @@ int get_fd_type(int fd)
 		p_err("can't read link type: %s", strerror(errno));
 		return -1;
 	}
-	if (n == sizeof(path)) {
+	if (n == sizeof(buf)) {
 		p_err("can't read link type: path too long!");
 		return -1;
 	}
+	buf[n] = '\0';
 
 	if (strstr(buf, "bpf-map"))
 		return BPF_OBJ_MAP;
-- 
2.39.5


