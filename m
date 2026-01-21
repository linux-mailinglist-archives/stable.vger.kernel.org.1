Return-Path: <stable+bounces-211019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wICoJfAxcWlQfQAAu9opvQ
	(envelope-from <stable+bounces-211019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:07:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 379315CD17
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BAA05ED063
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734AF36827D;
	Wed, 21 Jan 2026 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tc/x2o8E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA357392B76;
	Wed, 21 Jan 2026 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020166; cv=none; b=RfzjBdq6uXkSabwk+2xv7FpCkLqWX71XneuAIUkBmqTdMX7sYuBAOxFuORgbUQqz4dxGXHK2svEbJyG20Tk7/fQQGhtrVcsGf9V6+gKihI5Bv1m1SfRW16kuhEgC1br6IuxrzDIFz/6SDLeeiWapesF6rKi7TX1jvLW+jAIBtUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020166; c=relaxed/simple;
	bh=yR0dwN9RpHyVkE/bNuc0owC/HJJUEqL8/pWEoGzIiGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBb5GgVGds4dgfZaCS99HNIoWN66wSJi8xYyT0gdS1LMCnh7FYe1eFn99AkETE9rz2FlOY6HP2dtcrC5zNAeGD/y7GKB084yPjc/ktFxuW9GbzesYgly0HM4EoWxSXkbxEF7+XdLmNbZJspPxfp8a7plS7meKxsVCzqGa8lHRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tc/x2o8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317ABC4CEF1;
	Wed, 21 Jan 2026 18:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020165;
	bh=yR0dwN9RpHyVkE/bNuc0owC/HJJUEqL8/pWEoGzIiGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tc/x2o8E6WJXhCfQcOtBm4lXSBSUMpJeF9OH343AlUxVGvzvRtRMhwPfyIVTdf6Nh
	 JDvfG3JeEYcmgmvmsdA27InxuLd4if/N6I8LleNvr21f3/mhpZMKL12epPLCjz1gcc
	 n884cTH4sIc7Rst+KfWn+gxZp48Grbu8NeLgrJjM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthieu Buffet <matthieu@buffet.re>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 079/198] selftests/landlock: Remove invalid unix socket bind()
Date: Wed, 21 Jan 2026 19:15:07 +0100
Message-ID: <20260121181421.404621086@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-211019-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[digikod.net:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,buffet.re:email]
X-Rspamd-Queue-Id: 379315CD17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Buffet <matthieu@buffet.re>

[ Upstream commit e1a57c33590a50a6639798e60a597af4a23b0340 ]

Remove bind() call on a client socket that doesn't make sense.
Since strlen(cli_un.sun_path) returns a random value depending on stack
garbage, that many uninitialized bytes are read from the stack as an
unix socket address. This creates random test failures due to the bind
address being invalid or already in use if the same stack value comes up
twice.

Fixes: f83d51a5bdfe ("selftests/landlock: Check IOCTL restrictions for named UNIX domain sockets")
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
Reviewed-by: Günther Noack <gnoack@google.com>
Link: https://lore.kernel.org/r/20251201003631.190817-1-matthieu@buffet.re
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/landlock/fs_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index fa0f18ec62c41..a6eb9681791a5 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4375,9 +4375,6 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 	cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, cli_fd);
 
-	size = offsetof(struct sockaddr_un, sun_path) + strlen(cli_un.sun_path);
-	ASSERT_EQ(0, bind(cli_fd, (struct sockaddr *)&cli_un, size));
-
 	bzero(&cli_un, sizeof(cli_un));
 	cli_un.sun_family = AF_UNIX;
 	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));
-- 
2.51.0




