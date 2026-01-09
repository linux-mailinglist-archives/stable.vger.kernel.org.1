Return-Path: <stable+bounces-206768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E06ED09356
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81C1B301AB3B
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01553359FB6;
	Fri,  9 Jan 2026 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i9hS4mb9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962E1946C8;
	Fri,  9 Jan 2026 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960143; cv=none; b=o3NVzNlw2DXbTfkbImlUA5yWU0nR6hpswjuKpcYvhmnGWvut3pQcBKj3H9tKwU6mVIOQHsldStlP8OXEZcqq0RVg8ZZGpgzOmjYON2pA1HY9hk7baX6373BuLT2bxsHW+TPfs8afZLGjMAGngXzqXetqK5T32I6QDM0FAYaHZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960143; c=relaxed/simple;
	bh=7DpjxilBHNKzm1AH2MuBE1exnxu1Aw6mkqYgWoUKKaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdc1qlkkhK+nqgbRtc+MqxjXPj3gJS3v3vse9bi+Ag41oP/hukN65+Pw4Th6PCBQSSOkvL4F77D7/l85pQqYkjWcitbZhLl7bBufLVNrV2C8bYv08Wvz5/JEKZMHwYHj9BG4nfix4lkBmNOTjJqco9HDEvp8MUUvnr4woBTyboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i9hS4mb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FD0C4CEF1;
	Fri,  9 Jan 2026 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767960143;
	bh=7DpjxilBHNKzm1AH2MuBE1exnxu1Aw6mkqYgWoUKKaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i9hS4mb9RgyIBQFp3kpAv/+ULlFI24ORrZOWRVTb4OYDIxOQhm9oog/fRMrIGysdf
	 aYcbDMAoaSARHVdZ1Fczsi1Y3ahlBdzu8kGqSyZt8gBInDQpcVpPxwGge0NS55ZdZV
	 iOGZ6JEQJ6vBJnz24/aPaScibjzLE5Zr1djS40Ss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 301/737] bpf, arm64: Do not audit capability check in do_jit()
Date: Fri,  9 Jan 2026 12:37:20 +0100
Message-ID: <20260109112145.330398426@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
References: <20260109112133.973195406@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit 189e5deb944a6f9c7992355d60bffd8ec2e54a9c ]

Analogically to the x86 commit 881a9c9cb785 ("bpf: Do not audit
capability check in do_jit()"), change the capable() call to
ns_capable_noaudit() in order to avoid spurious SELinux denials in audit
log.

The commit log from that commit applies here as well:
"""
The failure of this check only results in a security mitigation being
applied, slightly affecting performance of the compiled BPF program. It
doesn't result in a failed syscall, an thus auditing a failed LSM
permission check for it is unwanted. For example with SELinux, it causes
a denial to be reported for confined processes running as root, which
tends to be flagged as a problem to be fixed in the policy. Yet
dontauditing or allowing CAP_SYS_ADMIN to the domain may not be
desirable, as it would allow/silence also other checks - either going
against the principle of least privilege or making debugging potentially
harder.

Fix it by changing it from capable() to ns_capable_noaudit(), which
instructs the LSMs to not audit the resulting denials.
"""

Fixes: f300769ead03 ("arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Link: https://lore.kernel.org/r/20251204125916.441021-1-omosnace@redhat.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index d8012d1a2e152..f11de7484ced8 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -666,7 +666,7 @@ static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
 	    arm64_get_spectre_v2_state() == SPECTRE_VULNERABLE)
 		return;
 
-	if (capable(CAP_SYS_ADMIN))
+	if (ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN))
 		return;
 
 	if (supports_clearbhb(SCOPE_SYSTEM)) {
-- 
2.51.0




