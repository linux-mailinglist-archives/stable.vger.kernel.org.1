Return-Path: <stable+bounces-223949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPYRBOX8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230A24A272
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B967031715E7
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C92BF3E2;
	Tue, 10 Mar 2026 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNJLrWUh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFFD313537;
	Tue, 10 Mar 2026 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141084; cv=none; b=ZRIJqS6Z7MZjAFqaz2qAssYdzvu2A5WG3Mxh0pZoDCJ1HGwjEz5wA9b8vinu2uViXro5hDEaSoDT1wGPlsR0cckM65ZiFqd6BjE4IQGoSMoc/owXj+XGXBA+HJicSNoxnlyXnKUG+TvBOSu53tCtxWm3grrVSYrNGFpMN0JAtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141084; c=relaxed/simple;
	bh=YiZPymN7dxn1ugYtNiA8rdoZkN7WYwZ+I34jDwkU+Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVRoKGplmjpT+yk3KbBVdjrCM71occreosMEzutlbGY/X6kbgunZxM/szhbGPFNuYLX3/xQe1U+b5IOzH8O7vkMlkDvFlkfy6AfKliaN5LzUBDjb9I/0eInOeVQClpW4+KrdbRLB89DVL5ZiBt4ReK2mvngZxpuJLTPbqLFs2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNJLrWUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FFBC2BC9E;
	Tue, 10 Mar 2026 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141084;
	bh=YiZPymN7dxn1ugYtNiA8rdoZkN7WYwZ+I34jDwkU+Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNJLrWUh/wJmzhZC7x3iAnqxkRWrHq0JKRzzmdrmOK0czXlPX5iXtU0eoxdBvNDDk
	 52ZS9MLY/aNknWrDW6oQEWBthu+sqHBV1HQGDjRyd/ALnTMBnBlB+CTMTiaIunD9HS
	 P2MNfeLu0zSX8+FuieEOToo5OpxQkuZ6FsaOT4pjlH+qGeRFv+lO32U0nK23du8S7/
	 CJXtN5/sj2+BFiYosCUIUt/zjupgtfQC+Tg2GX1c3xQxG/ECEozyTbEaGkh+KjTbGz
	 0I4L6n0kNFLChfuuLxRnx3PCfg7O/JFg6yOqKyjeGdAwgRAzELROyqZq4hPZ4S5Uo0
	 3LVLiS9aCROMQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>,
	Jerome Lee <jaewookl@quicinc.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 084/311] selftests/bpf: Fix OOB read in dmabuf_collector
Date: Tue, 10 Mar 2026 07:02:11 -0400
Message-ID: <d41a197dce3a2f0be5c5fb9d4a743eeb1abe6fe0.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6230A24A272
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223949-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,quicinc.com:email]
X-Rspamd-Action: no action

From: "T.J. Mercier" <tjmercier@google.com>

[ Upstream commit 6881af27f9ea0f5ca8f606f573ef5cc25ca31fe4 ]

Dmabuf name allocations can be less than DMA_BUF_NAME_LEN characters,
but bpf_probe_read_kernel always tries to read exactly that many bytes.
If a name is less than DMA_BUF_NAME_LEN characters,
bpf_probe_read_kernel will read past the end. bpf_probe_read_kernel_str
stops at the first NUL terminator so use it instead, like
iter_dmabuf_for_each already does.

Fixes: ae5d2c59ecd7 ("selftests/bpf: Add test for dmabuf_iter")
Reported-by: Jerome Lee <jaewookl@quicinc.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Link: https://lore.kernel.org/r/20260225003349.113746-1-tjmercier@google.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/progs/dmabuf_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
index 13cdb11fdeb2b..9cbb7442646e5 100644
--- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
@@ -48,7 +48,7 @@ int dmabuf_collector(struct bpf_iter__dmabuf *ctx)
 
 	/* Buffers are not required to be named */
 	if (pname) {
-		if (bpf_probe_read_kernel(name, sizeof(name), pname))
+		if (bpf_probe_read_kernel_str(name, sizeof(name), pname) < 0)
 			return 1;
 
 		/* Name strings can be provided by userspace */
-- 
2.51.0


