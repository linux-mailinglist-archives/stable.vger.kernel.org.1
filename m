Return-Path: <stable+bounces-240600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFw4NPU662nRJwAAu9opvQ
	(envelope-from <stable+bounces-240600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:42:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 422D845C5D8
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E336C3008787
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13B38AC75;
	Fri, 24 Apr 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u6ekS4fF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307091D5CC9
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023731; cv=none; b=J6NRXrqPCl7Kifie78FjCm0C7F95dzaFKShHHhGqcCuRTPls5oqKAk8uwFNEC7FK3mWinoC8//ZJq4TX5C31rjkrWybCAK+lUODT1l6k1hKkzr/ab8RtNq/PIzlmQFOl43fQQ+qs5mzo9sDSfuOeVKfZlzbRa3B4IqtEaxcQJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023731; c=relaxed/simple;
	bh=dM7FulM9veUKHgCiCTe2dXfCfx4PKc2o21ys9YoRKIA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hpt8e8876R6fsVcwbFgfvfZPBTml6zNW+6yhVkF+O3bzB0CEg4rb1YElXQodhO0xUOTeQb6H44rFVsLzcCl50KOahpQJhSeCW6gJD9q6pLPa+pTLZsD2fOrT7Zn9OA7GaOerW1wUjZBkUVg5zb1IRavVmENGax1HAV5rtqvGILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u6ekS4fF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8327FC2BCB4;
	Fri, 24 Apr 2026 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777023730;
	bh=dM7FulM9veUKHgCiCTe2dXfCfx4PKc2o21ys9YoRKIA=;
	h=Subject:To:Cc:From:Date:From;
	b=u6ekS4fFZlqJNNBJomSR173jqF5vI7n7EhFBnHRXMbJa9VVnC/8eIlZ9ZOEOLUHRq
	 jmBScZWRdvOf3JVJJ5d3U7wlA6H/cq3PkUiCux2wWs8ANz/YkLwe7bHVl5jBZ6tb27
	 k4m2v54+8oflLPJcke+qHK6EkE0JgbmOoUwqn6fQ=
Subject: FAILED: patch "[PATCH] smb: server: fix max_connections off-by-one in tcp accept" failed to apply to 5.15-stable tree
To: charsyam@gmail.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2026 11:42:08 +0200
Message-ID: <2026042408-reshuffle-engraved-f843@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 422D845C5D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240600-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ce23158bfe584bd90d1918f279fdf9de57802012
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042408-reshuffle-engraved-f843@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ce23158bfe584bd90d1918f279fdf9de57802012 Mon Sep 17 00:00:00 2001
From: DaeMyung Kang <charsyam@gmail.com>
Date: Fri, 17 Apr 2026 06:17:35 +0900
Subject: [PATCH] smb: server: fix max_connections off-by-one in tcp accept
 path

The global max_connections check in ksmbd's TCP accept path counts
the newly accepted connection with atomic_inc_return(), but then
rejects the connection when the result is greater than or equal to
server_conf.max_connections.

That makes the effective limit one smaller than configured. For
example:

- max_connections=1 rejects the first connection
- max_connections=2 allows only one connection

The per-IP limit in the same function uses <= correctly because it
counts only pre-existing connections. The global limit instead checks
the post-increment total, so it should reject only when that total
exceeds the configured maximum.

Fix this by changing the comparison from >= to >, so exactly
max_connections simultaneous connections are allowed and the next one
is rejected. This matches the documented meaning of max_connections
in fs/smb/server/ksmbd_netlink.h as the "Number of maximum simultaneous
connections".

Fixes: 0d0d4680db22 ("ksmbd: add max connections parameter")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 8d7fe71f525c..13b711ea575d 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -281,7 +281,7 @@ static int ksmbd_kthread_fn(void *p)
 
 skip_max_ip_conns_limit:
 		if (server_conf.max_connections &&
-		    atomic_inc_return(&active_num_conn) >= server_conf.max_connections) {
+		    atomic_inc_return(&active_num_conn) > server_conf.max_connections) {
 			pr_info_ratelimited("Limit the maximum number of connections(%u)\n",
 					    atomic_read(&active_num_conn));
 			atomic_dec(&active_num_conn);


