Return-Path: <stable+bounces-225986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPFhJl9SuWnYAgIAu9opvQ
	(envelope-from <stable+bounces-225986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:08:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD682AA812
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08B9231D4924
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A7E3C73FA;
	Tue, 17 Mar 2026 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rC2L+F0o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2F3A8725
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752502; cv=none; b=lrAT1FsiwZNHJQ81x5Yq4pBUJTUMrgfY+RPBrmIEkj+puE+mhhmrWTW7a6BxQtUYypVpSxbPX3coHateDO8PcFdYITMIdDSyAx8hm9E5DmfzXdNR02LRwdBjJqPp7GVP0LT9gH27pthKpOqSdxRRN5dAXPTxm2xWD4LtEaHY07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752502; c=relaxed/simple;
	bh=fd6DFVPrkR+HBNt0VBsMyvq8SYR+CvpR0Nf1pgob6cQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a1AXLtPvrM3rngc9WlRFGk+WMOyBFQsrShU78ABTmDGr/Hm89pE/nwWLDK0LhI71bnhYBwnOi+t1obPZyEMF9dNZP6UriR5E3pdsKIBqTYMoKNAIePjZx/MoxYX81N7h4amxg6tV1CTq1Va6aIoSmYSHBnmAsnstI8QDcTsTrmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rC2L+F0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE137C4CEF7;
	Tue, 17 Mar 2026 13:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773752502;
	bh=fd6DFVPrkR+HBNt0VBsMyvq8SYR+CvpR0Nf1pgob6cQ=;
	h=Subject:To:Cc:From:Date:From;
	b=rC2L+F0od9Iy+OFKfMVK22bc8LiWKmRsctETWvEUlONZg/iRbRetHAO9Y2cNYotNP
	 /bgHWqTSxUq5LNjdFRCnT9QOPsElQdr+vZQ1SIQiN/cWwvp2JliuPC11QWPmKCdK/i
	 vwThChBcE8Iic03n5gNRiiKVfh/Q04CuD2mAmiOU=
Subject: FAILED: patch "[PATCH] smb: client: fix iface port assignment in" failed to apply to 5.10-stable tree
To: henrique.carvalho@suse.com,ematsumiya@suse.de,stfrench@microsoft.com,thomas.orgis@uni-hamburg.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 14:01:29 +0100
Message-ID: <2026031729-supplier-untoasted-565e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-225986-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uni-hamburg.de:email,gregkh:email,suse.com:email]
X-Rspamd-Queue-Id: 0CD682AA812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d4c7210d2f3ea481a6481f03040a64d9077a6172
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031729-supplier-untoasted-565e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d4c7210d2f3ea481a6481f03040a64d9077a6172 Mon Sep 17 00:00:00 2001
From: Henrique Carvalho <henrique.carvalho@suse.com>
Date: Wed, 11 Mar 2026 20:17:23 -0300
Subject: [PATCH] smb: client: fix iface port assignment in
 parse_server_interfaces

parse_server_interfaces() initializes interface socket addresses with
CIFS_PORT. When the mount uses a non-default port this overwrites the
configured destination port.

Later, cifs_chan_update_iface() copies this sockaddr into server->dstaddr,
causing reconnect attempts to use the wrong port after server interface
updates.

Use the existing port from server->dstaddr instead.

Cc: stable@vger.kernel.org
Fixes: fe856be475f7 ("CIFS: parse and store info on iface queries")
Tested-by: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>
Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7f2d3459cbf9..612057318de2 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -628,6 +628,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	struct smb_sockaddr_in6 *p6;
 	struct cifs_server_iface *info = NULL, *iface = NULL, *niface = NULL;
 	struct cifs_server_iface tmp_iface;
+	__be16 port;
 	ssize_t bytes_left;
 	size_t next = 0;
 	int nb_iface = 0;
@@ -662,6 +663,15 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 		goto out;
 	}
 
+	spin_lock(&ses->server->srv_lock);
+	if (ses->server->dstaddr.ss_family == AF_INET)
+		port = ((struct sockaddr_in *)&ses->server->dstaddr)->sin_port;
+	else if (ses->server->dstaddr.ss_family == AF_INET6)
+		port = ((struct sockaddr_in6 *)&ses->server->dstaddr)->sin6_port;
+	else
+		port = cpu_to_be16(CIFS_PORT);
+	spin_unlock(&ses->server->srv_lock);
+
 	while (bytes_left >= (ssize_t)sizeof(*p)) {
 		memset(&tmp_iface, 0, sizeof(tmp_iface));
 		/* default to 1Gbps when link speed is unset */
@@ -682,7 +692,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			memcpy(&addr4->sin_addr, &p4->IPv4Address, 4);
 
 			/* [MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore these */
-			addr4->sin_port = cpu_to_be16(CIFS_PORT);
+			addr4->sin_port = port;
 
 			cifs_dbg(FYI, "%s: ipv4 %pI4\n", __func__,
 				 &addr4->sin_addr);
@@ -696,7 +706,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			/* [MS-SMB2] 2.2.32.5.1.2 Clients MUST ignore these */
 			addr6->sin6_flowinfo = 0;
 			addr6->sin6_scope_id = 0;
-			addr6->sin6_port = cpu_to_be16(CIFS_PORT);
+			addr6->sin6_port = port;
 
 			cifs_dbg(FYI, "%s: ipv6 %pI6\n", __func__,
 				 &addr6->sin6_addr);


