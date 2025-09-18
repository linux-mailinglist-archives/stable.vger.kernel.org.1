Return-Path: <stable+bounces-168887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57ABB23724
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B83627782
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2151C2882CE;
	Tue, 12 Aug 2025 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BbMGjo0R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C8326FA77;
	Tue, 12 Aug 2025 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025665; cv=none; b=CPBjT37hbWySB4swdpXiz1CRODQh9utGIY3Ag+hgPfmocot4Ghkk6X7daC2J8CKHEPA4797U1/H4BvwNRNhoiotlAn7Y6lT03r2mT+TKZ/dfZz7LsVuaH3UkxWjlCHY4DX9+YzpHa95PYQD6pWycnIOVFzmvt5KmicX0busT1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025665; c=relaxed/simple;
	bh=LAlQltpdzOkDnswoqzFjLQd5lQY3YJkyc+6qjNN1LjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NH7gb7FxMEay5+iZuO65IKA/Ft8DnBq2i8ZXbLe4JgOxwIQ824NF3Opy/RemlhSWvxCeKoEdDEUwztWJ1B/WpPjZcWSJlK5tWwL1qUUUSORa3ZNCIDB+fIAhzmsoB/WrDv3GsTvaGDpazKnpLRKcO17JV7Ef1jv1fhdNiQg5Nmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BbMGjo0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6C3C4CEF0;
	Tue, 12 Aug 2025 19:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025665;
	bh=LAlQltpdzOkDnswoqzFjLQd5lQY3YJkyc+6qjNN1LjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BbMGjo0RFTXJPFKEExS1uTLTp024qQ4NDMbAFWkvs0oF76A92aVe7eg8QN6kGQVxg
	 cn0fFVpdKzC3APwTRBjCTIugpkF4FdR41+PTD06Dy5s1V/yKbpf+2mvKU6H5CU+f/H
	 BcQdTegjoyojtL6FHi2c3oLfq3e7FW0qQ1JrwYUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fushuai Wang <wangfushuai@baidu.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 107/480] selftests/bpf: fix signedness bug in redir_partial()
Date: Tue, 12 Aug 2025 19:45:15 +0200
Message-ID: <20250812174401.893387016@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fushuai Wang <wangfushuai@baidu.com>

[ Upstream commit 6a4bd31f680a1d1cf06492fe6dc4f08da09769e6 ]

When xsend() returns -1 (error), the check 'n < sizeof(buf)' incorrectly
treats it as success due to unsigned promotion. Explicitly check for -1
first.

Fixes: a4b7193d8efd ("selftests/bpf: Add sockmap test for redirecting partial skb data")
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Link: https://lore.kernel.org/r/20250612084208.27722-1-wangfushuai@baidu.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 4ee1148d22be..1cfed83156b0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -924,6 +924,8 @@ static void redir_partial(int family, int sotype, int sock_map, int parser_map)
 		goto close;
 
 	n = xsend(c1, buf, sizeof(buf), 0);
+	if (n == -1)
+		goto close;
 	if (n < sizeof(buf))
 		FAIL("incomplete write");
 
-- 
2.39.5




