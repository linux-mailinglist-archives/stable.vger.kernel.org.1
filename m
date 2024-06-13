Return-Path: <stable+bounces-51703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E4907131
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9E61C20C1B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764E28FF;
	Thu, 13 Jun 2024 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QOqZSmBf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14700399;
	Thu, 13 Jun 2024 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282068; cv=none; b=i2ZQoVphMub5N2drYKB6OG/zsq6Ldu7BkHvEwCgY3odyhxSkeDaHuCDC3LcJt7y4hZ3SHlRAbVm1lWNh2Bl57ZP0xUov6iz4NAoxyYvUhiTBKAlVU8Y6UTieXX0yqQHmu6vrmtpMQGDcOaioBotkSfz0lUmOgwUccV+zE2/2C9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282068; c=relaxed/simple;
	bh=69DZWh3kGWalWNI9iPAZ7fQeEvHFN50uHUhrcajUZfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1c0kfi89zQfiQaCzPLGcgQ6Du+jzqutauAf7iUEaeXwG09DxZfK5GKgpPSClc+ZazdpwZTjU989SCZPthVkMO8E0Q0jcE6JsSmyBvDv4PeyQ7NZdAl2RyM5j8rx3p/dKG6mgRLWcLxXD9pY7XLaJJKo348nN/f6kx6XD0UqzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QOqZSmBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC1CC2BBFC;
	Thu, 13 Jun 2024 12:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282068;
	bh=69DZWh3kGWalWNI9iPAZ7fQeEvHFN50uHUhrcajUZfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOqZSmBf2+YPrszrFgqTbBUpaRBBkiFcuLP0CV/loJshuHXbrJIvMXUQDBhPLLLsA
	 ixha85Wxlpt70ERe5vgn5Sxu7ZHSw1VXZRbloUiB5zl+8zEIOBDQpJFKDq/bu92MsX
	 snullhumlNEhl9xtse0gqUqT4b8SXsaEM5+JG+qg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 120/402] mptcp: SO_KEEPALIVE: fix getsockopt support
Date: Thu, 13 Jun 2024 13:31:17 +0200
Message-ID: <20240613113306.812677612@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

[ Upstream commit a65198136eaa15b74ee0abf73f12ef83d469a334 ]

SO_KEEPALIVE support has to be set on each subflow: on each TCP socket,
where sk_prot->keepalive is defined. Technically, nothing has to be done
on the MPTCP socket. That's why mptcp_sol_socket_sync_intval() was
called instead of mptcp_sol_socket_intval().

Except that when nothing is done on the MPTCP socket, the
getsockopt(SO_KEEPALIVE), handled in net/core/sock.c:sk_getsockopt(),
will not know if SO_KEEPALIVE has been set on the different subflows or
not.

The fix is simple: simply call mptcp_sol_socket_intval() which will end
up calling net/core/sock.c:sk_setsockopt() where the SOCK_KEEPOPEN flag
will be set, the one used in sk_getsockopt().

So now, getsockopt(SO_KEEPALIVE) on an MPTCP socket will return the same
value as the one previously set with setsockopt(SO_KEEPALIVE).

Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20240514011335.176158-2-martineau@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/sockopt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 4bb305342fcc7..bd797d8f72ab1 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -177,8 +177,6 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case SO_KEEPALIVE:
-		mptcp_sol_socket_sync_intval(msk, optname, val);
-		return 0;
 	case SO_DEBUG:
 	case SO_MARK:
 	case SO_PRIORITY:
-- 
2.43.0




