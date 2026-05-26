Return-Path: <stable+bounces-254302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMKKFPt5FWrHVAcAu9opvQ
	(envelope-from <stable+bounces-254302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:46:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 264175D4591
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C87A3045A93
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6CD3DD877;
	Tue, 26 May 2026 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="AZscnxFV"
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D923D890D;
	Tue, 26 May 2026 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792167; cv=none; b=cR0g3bw4/9zuIe+b3NBHYcxn+l3NnF3XjKDDhDgxehscCsyXsafmM3jRJDX5IhNs6dPvVuPnLkILCIr2iJ22VzHsXsOBA7yyGryTv4sFwmUAIZ8HaBVzdRnQlBxn6Z4NN63eCspJjj60aLXCpwIvEyEJpEd/zEyKIeYgeZ+s340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792167; c=relaxed/simple;
	bh=FVBhahXg7F8BMDQ8zNPThbQpo6Ye9nutrNvRIHDaOTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBAkJOr6CJ2t1E8EfFze1aQSfQt6jLYTxBocFiKCotdvJXj6HNDme36GkkUXhVRDlU1Fu8f66U4v9c9ORfYtWWaewTWmGSbSoTi4Sdp7Hhdr7pMH3VGhZbeYRYAR/VEzDMU6Wwu2+1WASlZYjN+FS8K/fXQUScc+nGAjRCKTV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=AZscnxFV; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gPq8D1Q4hz13YM;
	Tue, 26 May 2026 12:42:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779792155;
	bh=Yq1TyUm9d3TSuY78R8bGgCKwCsZykTxCuKHGIG2lLzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZscnxFV+hlSEXuNQWCSX+VFgP8y6Rc6/LgoKZZeHu6An0C4T0kEJ0pTmTPtsKVuk
	 9tdiErZjixMbanHsRRgfLKMvNdu1kV9JN5cU7+shPL55oJNuaZYwPXU+uThVU6PMb1
	 K2xXzTNTxDO6MBldfNF/qMYB/QogzvAAJnO5+wUU=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gPq8B5DYtzDvW;
	Tue, 26 May 2026 12:42:34 +0200 (CEST)
Date: Tue, 26 May 2026 12:42:32 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Justin Suess <utilityemal77@gmail.com>, Kees Cook <kees@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 10/17] landlock: Set audit_net.sk for socket access
 checks
Message-ID: <20260526.ThoNeit5ioqu@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
 <20260406143717.1815792-11-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260406143717.1815792-11-mic@digikod.net>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.99 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254302-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,gmail.com,kernel.org,efficios.com,buffet.re,huawei-partners.com,maowtm.org,cloudflare.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[digikod.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,audit_net.sk:url,digikod.net:email,digikod.net:mid,digikod.net:dkim,audit_net.family:url]
X-Rspamd-Queue-Id: 264175D4591
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I merged this fix in the -next branch.

On Mon, Apr 06, 2026 at 04:37:08PM +0200, Mickaël Salaün wrote:
> Set audit_net.sk in current_check_access_socket() to provide the socket
> object to audit_log_lsm_data().  This makes Landlock consistent with
> AppArmor, which always sets .sk for socket operations, and with
> SELinux's generic socket permission checks.
> 
> The socket's local and foreign address information (laddr, lport, faddr,
> fport) is logged by the shared lsm_audit.c infrastructure when the
> socket has bound or connected state.  Fields with zero values are
> suppressed by print_ipv4_addr()/print_ipv6_addr(), so the audit output
> is unchanged for the common case of bind denials on unbound sockets.
> For connect denials after a prior bind, the bound local address (laddr,
> lport) appears before the existing sockaddr fields (daddr, dest).
> 
> No existing fields are removed or reordered, and the new field names
> (laddr, lport, faddr, fport) are standard audit fields already emitted
> by other LSMs through the same lsm_audit.c code path.
> 
> Add net_bind and net_connect audit tests.  The net_bind test verifies
> basic net denial auditing.  The net_connect test binds to an allowed
> port, then connects to a denied port, and verifies that the audit record
> includes laddr/lport from the socket state.
> 
> Fixes: 9f74411a40ce ("landlock: Log TCP bind and connect denials")
> Cc: stable@vger.kernel.org
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> - New patch.
> ---
>  security/landlock/net.c                       |   1 +
>  tools/testing/selftests/landlock/audit_test.c | 187 ++++++++++++++++++
>  2 files changed, 188 insertions(+)
> 
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index a2aefc7967a1..d8bc9e0d012a 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -225,6 +225,7 @@ static int current_check_access_socket(struct socket *const sock,
>  		return 0;
>  
>  	audit_net.family = address->sa_family;
> +	audit_net.sk = sock->sk;
>  	landlock_log_denial(subject,
>  			    &(struct landlock_request){
>  				    .type = LANDLOCK_REQUEST_NET_ACCESS,
> diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
> index da0bfd06391e..65dfb272c825 100644
> --- a/tools/testing/selftests/landlock/audit_test.c
> +++ b/tools/testing/selftests/landlock/audit_test.c
> @@ -6,14 +6,17 @@
>   */
>  
>  #define _GNU_SOURCE
> +#include <arpa/inet.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <limits.h>
>  #include <linux/landlock.h>
> +#include <netinet/in.h>
>  #include <pthread.h>
>  #include <stdlib.h>
>  #include <sys/mount.h>
>  #include <sys/prctl.h>
> +#include <sys/socket.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
> @@ -160,6 +163,190 @@ TEST_F(audit, layers)
>  	EXPECT_EQ(0, close(ruleset_fd));
>  }
>  
> +static int matches_log_net_bind(struct __test_metadata *const _metadata,
> +				int audit_fd, __u16 port, __u64 *domain_id)
> +{
> +	/*
> +	 * The socket is unbound at bind() time, so laddr/lport/faddr/fport from
> +	 * the socket object are zero and not printed.  Only the sockaddr fields
> +	 * (src) appear.
> +	 */
> +	static const char log_template[] = REGEX_LANDLOCK_PREFIX
> +		" blockers=net\\.bind_tcp src=%u$";
> +	char log_match[sizeof(log_template) + 10];
> +
> +	snprintf(log_match, sizeof(log_match), log_template, port);
> +	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
> +				  domain_id);
> +}
> +
> +/*
> + * Verifies that network denial audit records include enriched socket
> + * information (laddr/lport/faddr/fport) from the socket object.
> + */
> +TEST_F(audit, net_bind)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
> +	};
> +	struct landlock_net_port_attr net_port = {
> +		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
> +		.port = 1024,
> +	};
> +	int status, ruleset_fd;
> +	pid_t child;
> +	__u64 denial_dom = 1;
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	/* Allow port 1024 only. */
> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> +				       &net_port, 0));
> +
> +	EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		struct sockaddr_in addr = {
> +			.sin_family = AF_INET,
> +			.sin_port = htons(1025),
> +			.sin_addr.s_addr = htonl(INADDR_ANY),
> +		};
> +		int sock_fd;
> +
> +		EXPECT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> +		close(ruleset_fd);
> +
> +		/* Bind to port 1025 (not allowed). */
> +		sock_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
> +		ASSERT_LE(0, sock_fd);
> +		EXPECT_EQ(-1, bind(sock_fd, (struct sockaddr *)&addr,
> +				   sizeof(addr)));
> +		EXPECT_EQ(EACCES, errno);
> +		close(sock_fd);
> +
> +		/* Verify audit record with enriched socket info. */
> +		EXPECT_EQ(0, matches_log_net_bind(_metadata, self->audit_fd,
> +						  1025, &denial_dom));
> +		EXPECT_NE(denial_dom, 1);
> +		EXPECT_NE(denial_dom, 0);
> +
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
> +static int matches_log_net_connect(struct __test_metadata *const _metadata,
> +				   int audit_fd, __u16 denied_port,
> +				   __u16 bound_port, __u64 *domain_id)
> +{
> +	/*
> +	 * After bind(), the socket has local address state.  The audit record
> +	 * should include laddr/lport from the socket (via audit_net.sk) and
> +	 * daddr/dest from the connect sockaddr.
> +	 */
> +	static const char log_template[] = REGEX_LANDLOCK_PREFIX
> +		" blockers=net\\.connect_tcp"
> +		" laddr=127\\.0\\.0\\.1 lport=%u"
> +		" daddr=127\\.0\\.0\\.1 dest=%u$";
> +	char log_match[sizeof(log_template) + 20];
> +
> +	snprintf(log_match, sizeof(log_match), log_template, bound_port,
> +		 denied_port);
> +	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
> +				  domain_id);
> +}
> +
> +/*
> + * Verifies that network denial audit records for connect include enriched
> + * socket information (laddr/lport) from the socket object after a prior bind.
> + * This complements net_bind which tests the unbound case.
> + */
> +TEST_F(audit, net_connect)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
> +				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +	};
> +	struct landlock_net_port_attr net_port;
> +	int status, ruleset_fd;
> +	pid_t child;
> +	__u64 denial_dom = 1;
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	/* Allow bind to port 1024 and connect to port 1024. */
> +	net_port.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
> +				  LANDLOCK_ACCESS_NET_CONNECT_TCP;
> +	net_port.port = 1024;
> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> +				       &net_port, 0));
> +
> +	EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		struct sockaddr_in bind_addr = {
> +			.sin_family = AF_INET,
> +			.sin_port = htons(1024),
> +			.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
> +		};
> +		struct sockaddr_in conn_addr = {
> +			.sin_family = AF_INET,
> +			.sin_port = htons(1025),
> +			.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
> +		};
> +		int sock_fd, optval = 1;
> +
> +		EXPECT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> +		close(ruleset_fd);
> +
> +		sock_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
> +		ASSERT_LE(0, sock_fd);
> +		ASSERT_EQ(0, setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR,
> +					&optval, sizeof(optval)));
> +
> +		/* Bind to allowed port 1024 (succeeds). */
> +		ASSERT_EQ(0, bind(sock_fd, (struct sockaddr *)&bind_addr,
> +				  sizeof(bind_addr)));
> +
> +		/* Connect to denied port 1025 (fails). */
> +		EXPECT_EQ(-1, connect(sock_fd, (struct sockaddr *)&conn_addr,
> +				      sizeof(conn_addr)));
> +		EXPECT_EQ(EACCES, errno);
> +		close(sock_fd);
> +
> +		/* Verify audit record with laddr/lport from bound socket. */
> +		EXPECT_EQ(0, matches_log_net_connect(_metadata, self->audit_fd,
> +						     1025, 1024, &denial_dom));
> +		EXPECT_NE(denial_dom, 1);
> +		EXPECT_NE(denial_dom, 0);
> +
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
>  struct thread_data {
>  	pid_t parent_pid;
>  	int ruleset_fd, pipe_child, pipe_parent;
> -- 
> 2.53.0
> 
> 

