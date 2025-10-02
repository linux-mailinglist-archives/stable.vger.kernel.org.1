Return-Path: <stable+bounces-183104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFD7BB45FD
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 17:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16027A9229
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCC721D3F8;
	Thu,  2 Oct 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="n2v5JF3x"
X-Original-To: stable@vger.kernel.org
Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21C4D8CE;
	Thu,  2 Oct 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419283; cv=none; b=JqrtrIPYPtQNy1P5qKikh5S1/2TxmzEGFsqHcusXS3ckCvtNA7A+C1UKbYQZewkXJtH8HlUMeo14x7LkdgBv879exrP5DPCkirBEjryijlfXdM6ZHA9K7c/e/TK7dJZwAJUP/ORyzpnOyd9+P6OLfICemNDbQZi6yaMtUJFSXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419283; c=relaxed/simple;
	bh=W+Ht1OKo6ppbB0FmjijYg7jubvNitXzdiCur9IbGLRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GDczV5l0NUE4BT/vZXt8tmGkEdvHZZz9FTsJamQyQICPewqxTlzAIEg5SQWJQGSEx07a7rXc96Xba1JN8/1+PCWSSrd5zHOhFzxrB7diWaMuPZDD3tUowQCckrRrhHUCCGE9XOF96Z5n2doUB3ObUmoU0blwIhLDPAHsHYOcUyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=n2v5JF3x; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Received: from fedora (p3797069-ipxg00h01tokaisakaetozai.aichi.ocn.ne.jp [180.53.174.69])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 592EIOl1065543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 2 Oct 2025 23:18:27 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=W52Iz4BD6R2fWFn1L+IepAxlJiYmGr97PeF/WnydoVY=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:To:Subject:Date:Message-ID;
        s=rs20250315; t=1759414707; v=1;
        b=n2v5JF3xTns63qpFn3OBkWsDbH3rcGg0JqqCT5TVucyJ9hIJheN2UNVolCWN7WJB
         xcDETHDizKSSriZvKQpDm4OtskFZME71ewEaeEqdaCbkeydFjvG4z6NsVfj9xF/k
         MgSQwG8oTJCOSBvbnh4IcwVvejphD+TR4vNsb2cvAa8+a4wWm3rAuynfGq9hKIAS
         IwoosM00BgM/gpxCfbM2T3zNcw10wObINKgb8kIe1W3m5LyLnBHPlD9vcTMKASFJ
         eduVygdNVbxtAEsnyQQtJoX1lDqqqPkjSHYkvmczyGRU8ew/CMk+opwM+MuJuv4Q
         uLwNK4dQgmeazEbOn8uFvw==
From: Kenta Akagi <k@mgml.me>
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH 6.1.y] selftests: mptcp: connect: fix build regression caused by backport
Date: Thu,  2 Oct 2025 23:17:59 +0900
Message-ID: <20251002141759.76891-1-k@mgml.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since v6.1.154, mptcp selftests have failed to build with the following
errors:

mptcp_connect.c: In function ‘main_loop_s’:
mptcp_connect.c:1040:59: error: ‘winfo’ undeclared (first use in this function)
 1040 |                 err = copyfd_io(fd, remotesock, 1, true, &winfo);
      |                                                           ^~~~~
mptcp_connect.c:1040:59: note: each undeclared identifier is reported only once for each function it appears in
mptcp_connect.c:1040:23: error: too many arguments to function ‘copyfd_io’; expected 4, have 5
 1040 |                 err = copyfd_io(fd, remotesock, 1, true, &winfo);
      |                       ^~~~~~~~~                          ~~~~~~
mptcp_connect.c:845:12: note: declared here
  845 | static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd)
      |            ^~~~~~~~~

This is caused by commit ff160500c499 ("selftests: mptcp: connect: catch
IO errors on listen side"), a backport of upstream 14e22b43df25,
which attempts to use the undeclared variable 'winfo' and passes too many
arguments to copyfd_io(). Both the winfo variable and the updated
copyfd_io() function were introduced in upstream
commit ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener"),
which is not present in v6.1.y.

The goal of the backport is to stop on errors from copyfd_io.
Therefore, the backport does not depend on the changes in upstream
commit ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener").

This commit simply removes ', &winfo' to fix a build failure.

Fixes: ff160500c499 ("selftests: mptcp: connect: catch IO errors on listen side")
Signed-off-by: Kenta Akagi <k@mgml.me>
---
commit 14e22b43df25 ("selftests: mptcp: connect: catch IO errors
on listen side") has only been backported to >=v6.1.y, and commit
ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener")
exists from v6.2. so, only v6.1.y requires this fix.
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 0d49b6753011..0b253c133f06 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1037,7 +1037,7 @@ int main_loop_s(int listensock)
 
 		SOCK_TEST_TCPULP(remotesock, 0);
 
-		err = copyfd_io(fd, remotesock, 1, true, &winfo);
+		err = copyfd_io(fd, remotesock, 1, true);
 	} else {
 		perror("accept");
 		return 1;
-- 
2.50.1


