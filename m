Return-Path: <stable+bounces-211023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIIIJ+E5cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:41:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 538C45D72D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3D148085B3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBD9392B76;
	Wed, 21 Jan 2026 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="od4RW+u4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07333ACA71;
	Wed, 21 Jan 2026 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020175; cv=none; b=re07iKLtE5v4+aBSedbSTswXK0pSqaRYPMVNteSP3mKn0YqDUxPRgVu4ZGuEIp65NI4/ScDYqONPazXAch4bLeQcciFyXi1X5fR25vCEuIM7ZI6DgDg2Sr4S5LYwRLxnVyuyclTZy6RPF7ZRBdOVGUPYzLcNruz2tx6xEcc1gyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020175; c=relaxed/simple;
	bh=fkR6oJglZERAp/ALhhPs2n/yJKGjX91odtCuBLG1z+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9Yr7QPK5YA2UpKm7ZLNqmiIyYufAVZ8Is7DkeLR/dc6PzNL+Mwr10CrlatfvzNnLrLMw+JDXaPvpFyGWENsHZ4AldDWJKR+6+iBZLox9u141NmSxJJMn+efP5U8RLc0dJ0eS43VAq4W3+wun67tzaMYRM9CzAyUWCTOwWEHFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=od4RW+u4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F270AC4CEF1;
	Wed, 21 Jan 2026 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020175;
	bh=fkR6oJglZERAp/ALhhPs2n/yJKGjX91odtCuBLG1z+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=od4RW+u4pbNdtLfv1LGaRRML6TWNxV+PczAoraXS7pMc+rKbKDpmlf8+yoEJES/up
	 y3hKzL0t4k/c2iaNzpE7DJhx0YaZGzioq8J4OVMMNTsZnx0aYDybCK9QJNNMo4Al/O
	 SZMbhnZVRuRGqiin8XGSxAl0VLQFuFSEC9lo+N9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 082/198] selftests/landlock: Properly close a file descriptor
Date: Wed, 21 Jan 2026 19:15:10 +0100
Message-ID: <20260121181421.511114762@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211023-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,digikod.net,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,digikod.net:email]
X-Rspamd-Queue-Id: 538C45D72D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Günther Noack <gnoack3000@gmail.com>

[ Upstream commit 15e8d739fda1084d81f7d3813e9600eba6e0f134 ]

Add a missing close(srv_fd) call, and use EXPECT_EQ() to check the
result.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
Fixes: f83d51a5bdfe ("selftests/landlock: Check IOCTL restrictions for named UNIX domain sockets")
Link: https://lore.kernel.org/r/20260101134102.25938-2-gnoack3000@gmail.com
[mic: Use EXPECT_EQ() and update commit message]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/landlock/fs_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index a6eb9681791a5..29cdbb8367358 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4385,7 +4385,8 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 	/* FIONREAD and other IOCTLs should not be forbidden. */
 	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
 
-	ASSERT_EQ(0, close(cli_fd));
+	EXPECT_EQ(0, close(cli_fd));
+	EXPECT_EQ(0, close(srv_fd));
 }
 
 /* clang-format off */
-- 
2.51.0




