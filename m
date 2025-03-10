Return-Path: <stable+bounces-122556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85506A5A034
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5696E1891733
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD87230BFA;
	Mon, 10 Mar 2025 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PRfgAtSO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A461C3F34;
	Mon, 10 Mar 2025 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628833; cv=none; b=srTR4ra4xgDuB2fB9IxmKsRhghKcFcC2LIoX/tyfoktR2lIoBcaTg6JU+Y8Qbe3J7OG2R0UnDtC37Vl/KmXTAiwboUthG9f0YHFoKcoXDV/Gh4EhZsff6TMKgNjmpIbK9yR1g8IJwfkmI3aIzPXpYzAxt5EIz/VJK59uWU7WEZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628833; c=relaxed/simple;
	bh=Zv7XqXC4YxQhi/pe8CbC53IyyRwi0eqNzFB0VM4pxuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lunncOUJkgz8hxbWdvT8i92/GqQbhAkkOolDtwd2SgE3/h/WvwXb82U5tgxEZYm76m5WZRhyQmmvWiseXNaLkSoc4gZC2SfFtfT6hIt+eCaLXUkIOJFI9r9NhORI0bKDDb85wMIWMtTjd8hWKQRVOQZnk0fyaoKQ4r8ReI/iRvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PRfgAtSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A44C4CEE5;
	Mon, 10 Mar 2025 17:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628832;
	bh=Zv7XqXC4YxQhi/pe8CbC53IyyRwi0eqNzFB0VM4pxuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRfgAtSOkEpf5m9qViZDiFXiwgxCV5LSxUADSI9KxB6CGI9K6VYyTipEGnypILFit
	 vR62WQZs3gZLOGln4IBUw6HrAvmhcPsxgOHaQNjrhNhYoL6p0sJpkDaRj5CjBBmbgJ
	 JpHTm8MKpe/18SB21Oh+TXvX4ORyBaEv86JYgsMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marco Leogrande <leogrande@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 077/620] tools/testing/selftests/bpf/test_tc_tunnel.sh: Fix wait for server bind
Date: Mon, 10 Mar 2025 17:58:43 +0100
Message-ID: <20250310170548.623309419@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Leogrande <leogrande@google.com>

[ Upstream commit e2f0791124a1b6ca8d570110cbd487969d9d41ef ]

Commit f803bcf9208a ("selftests/bpf: Prevent client connect before
server bind in test_tc_tunnel.sh") added code that waits for the
netcat server to start before the netcat client attempts to connect to
it. However, not all calls to 'server_listen' were guarded.

This patch adds the existing 'wait_for_port' guard after the remaining
call to 'server_listen'.

Fixes: f803bcf9208a ("selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh")
Signed-off-by: Marco Leogrande <leogrande@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://lore.kernel.org/r/20241202204530.1143448-1-leogrande@google.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_tc_tunnel.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 38c6e9f16f41e..88488779792ff 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -295,6 +295,7 @@ else
 	client_connect
 	verify_data
 	server_listen
+	wait_for_port ${port} ${netcat_opt}
 fi
 
 # bpf_skb_net_shrink does not take tunnel flags yet, cannot update L3.
-- 
2.39.5




