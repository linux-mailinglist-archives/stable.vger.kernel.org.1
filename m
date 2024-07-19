Return-Path: <stable+bounces-60618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B844B937988
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 17:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3461C21491
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3113F145B01;
	Fri, 19 Jul 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="usuUl5s+"
X-Original-To: stable@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F9F145334
	for <stable@vger.kernel.org>; Fri, 19 Jul 2024 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401615; cv=none; b=QS788o6tfWY0u8N6CaJUvQGAjyY76YTgRiL1mf46mfoG4ThG8qDNUFtcG5YAfwcTzK7Vk0YjpQcbFBfEtx2WOeLI3YVewlLl2S2/UETIbhAsDbjD0crZIG0G2MJOiDtHbMDx1vB9cBK+8+iqdPuM9n0pibaU987Qga1dNllHYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401615; c=relaxed/simple;
	bh=kADlIJlgL0PtH6xamTShU02YuFjeQvkBz3WQ+QSyA+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBc2piKajq+JlxaAYE9juYDREqtU+Zbf1fiWvstTlQjrl5+ArkRkxFATSdzgEbT11T7eYhzZtVgzmPDKrLO6HbkzVdT8oSf1eedb0bjdKrW+dm2a59gs0F9yhunky/LFyxdEI/viWb2OprXSg5vhJqZyGUawjXx0RiQ7LfzlLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=usuUl5s+; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WQY11354Szhx2;
	Fri, 19 Jul 2024 17:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721401605;
	bh=Cnjhb1PfZ2PnvwlsA5/2Egjh5Wo4KWAUx42MC+Pl8co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=usuUl5s+Zf8zF7dWvWNP6L87CbkRvD8mX7SA8lY/q36Y0hAGIOQN4kfEq55qLnEfY
	 p3DOlFJQI0FD/9kcTh2q3c3qsR2m0xd17dAuWZ1vrSIj4kEsE6KW0ffVsYVQX2XCDV
	 IbI+qK8igGyZmWFMz86Dk7vpebhXmjKJoPpqB8Tc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WQY106Mndzw76;
	Fri, 19 Jul 2024 17:06:44 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <keescook@chromium.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC PATCH v1 1/3] landlock: Use socket's domain instead of current's domain
Date: Fri, 19 Jul 2024 17:06:16 +0200
Message-ID: <20240719150618.197991-2-mic@digikod.net>
In-Reply-To: <20240719150618.197991-1-mic@digikod.net>
References: <20240719150618.197991-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Before this change, network restrictions were enforced according to the
calling thread's Landlock domain, leading to potential inconsistent
results when the same socket was used by different threads or processes
(with different domains).  This change fixes such access control
inconsistency by enforcing the socket's Landlock domain instead of the
caller's Landlock domain.

Socket's Landlock domain is inherited from the thread that created this
socket.  This means that a socket created without sandboxing will be
free to connect and bind without limitation.  This also means that a
socket created by a sandboxed thread will inherit the thread's policy,
which will be enforced on this socket even when used by another thread
or passed to another process.

The initial rationale [1] was that a socket does not directly grants
access to data, but it is an object used to define an access (e.g.
connection to a peer).  Contrary to my initial assumption, we can
identify to which protocol/port a newly created socket can give access
to with the socket's file->f_cred inherited from its creator.  Moreover,
from a kernel point of view, especially for shared objects, we need a
more consistent access model.  This means that the same action on the
same socket performed by different threads will have the same effect.
This follows the same approach as for file descriptors tied to the file
system (e.g. LANDLOCK_ACCESS_FS_TRUNCATE).

One potential risk of this change is for unsandboxed processes to send
socket file descriptors to sandboxed processes, which could give
unrestricted network access to the sandboxed process (by reconfigure the
socket).  While it makes sense for processes to transfer (AF_UNIX)
socketpairs, which is OK because they can only exchange data between
themselves, it should be rare for processes to legitimately pass other
kind of sockets (e.g. AF_INET).

Another potential risk of this approach is socket file descriptor leaks.
This is the same risk as with regular file descriptor leaks giving
access to the content of a file, which is well known and documented.
This could be mitigated with a future complementary restriction on
received or inherited file descriptors.

One interesting side effect of this new approach is that a process can
create a socket that will only allow to connect to a set of ports.  This
can be done by creating a thread, sandboxing it, creating a socket, and
using the related file descriptor (in the same process).  Passing this
restricted socket to a more sandboxed process makes it possible to have
a more dynamic security policy.

This new approach aligns with SELinux and Smack instead of AppArmor and
Tomoyo.  It is also in line with capability-based security mechanisms
such as Capsicum.

This slight semantic change is important for current and future
Landlock's consistency, and it must be backported.

Current tests are still OK because this behavior wasn't covered.  A
following commit adds new tests.

Cc: Günther Noack <gnoack@google.com>
Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Cc: <stable@vger.kernel.org> # 6.7.x: 088e2efaf3d2: landlock: Simplify current_check_access_socket()
Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Link: https://lore.kernel.org/r/263c1eb3-602f-57fe-8450-3f138581bee7@digikod.net [1]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240719150618.197991-2-mic@digikod.net
---
 security/landlock/net.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index c8bcd29bde09..78e027a74819 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -50,10 +50,11 @@ get_raw_handled_net_accesses(const struct landlock_ruleset *const domain)
 	return access_dom;
 }
 
-static const struct landlock_ruleset *get_current_net_domain(void)
+static const struct landlock_ruleset *
+get_socket_net_domain(const struct socket *const sock)
 {
 	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
+		landlock_cred(sock->file->f_cred)->domain;
 
 	if (!dom || !get_raw_handled_net_accesses(dom))
 		return NULL;
@@ -61,10 +62,9 @@ static const struct landlock_ruleset *get_current_net_domain(void)
 	return dom;
 }
 
-static int current_check_access_socket(struct socket *const sock,
-				       struct sockaddr *const address,
-				       const int addrlen,
-				       access_mask_t access_request)
+static int check_access_socket(struct socket *const sock,
+			       struct sockaddr *const address,
+			       const int addrlen, access_mask_t access_request)
 {
 	__be16 port;
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
@@ -72,7 +72,7 @@ static int current_check_access_socket(struct socket *const sock,
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
-	const struct landlock_ruleset *const dom = get_current_net_domain();
+	const struct landlock_ruleset *const dom = get_socket_net_domain(sock);
 
 	if (!dom)
 		return 0;
@@ -175,16 +175,16 @@ static int current_check_access_socket(struct socket *const sock,
 static int hook_socket_bind(struct socket *const sock,
 			    struct sockaddr *const address, const int addrlen)
 {
-	return current_check_access_socket(sock, address, addrlen,
-					   LANDLOCK_ACCESS_NET_BIND_TCP);
+	return check_access_socket(sock, address, addrlen,
+				   LANDLOCK_ACCESS_NET_BIND_TCP);
 }
 
 static int hook_socket_connect(struct socket *const sock,
 			       struct sockaddr *const address,
 			       const int addrlen)
 {
-	return current_check_access_socket(sock, address, addrlen,
-					   LANDLOCK_ACCESS_NET_CONNECT_TCP);
+	return check_access_socket(sock, address, addrlen,
+				   LANDLOCK_ACCESS_NET_CONNECT_TCP);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
-- 
2.45.2


