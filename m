Return-Path: <stable+bounces-224769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG8ID374sWl7HQAAu9opvQ
	(envelope-from <stable+bounces-224769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 00:19:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60F526B506
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 00:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C0A4300BC8E
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 23:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEB92F39AB;
	Wed, 11 Mar 2026 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bMVoa1Vs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D73A1699
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271059; cv=none; b=q14hVeTVB617UU3Mjkz2WNfQCuZtMIWFruuzezoSOuydpW3sUVA5+dZRnr3SnPm2d9esO+MCWwz8n65SmdpKbhU15uBkd6xnCLS9VMlPc3bzukdKsklv8tuis248OulgcWmvoSnz9vomIHzHdUcFuJOGY+ZNT8PjlHs1n5I2sFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271059; c=relaxed/simple;
	bh=hP8gUqN7Gejq6lxAh55bb13vxMkqUcjPK6Vq0Lt4/zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMFZmLlaw0mw5NrMFIOXLD5Fa6RNl5XL0M+cDITeC2hTlV31ajDiJJJhPpax/8jqTPgnoJKnvq11H6E2QpLWN+/VzQnJCt3TyF7XxiKlJ2fHMtpyhzNoUXSDJDHKYmzpSN3Xjm4YG5TtbE131lr1pUnIrjCQt0jYWdHm49QqrAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bMVoa1Vs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso3200495e9.3
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773271056; x=1773875856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gKtkJ0sICHIojbLRDenDgLx0yniTaA4WdmAGcAVtIqM=;
        b=bMVoa1VsZXA/42LVDUsWbAjiGH/CgzAtwYUwLOVFq+3nIW12b9omUh6NL6h9RtbbNc
         U19WquqmTLg6CzlYDMT7dI/7kOJO0NC2W5pzRDM5JMzqokIzw+kvaRRkK0sURyFHyy+G
         SEtEp6u5hwx2ODvOT2O9KRonKhqBLTQdWDdsdwj3GqXpH+DFJpgZqeu7C4qj0cOK0Nbq
         Q6+74IP9aukZibZnlFgRoZtQbev6Dky91GFO3D9UFAFr5pNVjGJXAcShZ/IZ1v61KGvm
         D5U8jBYSUzRzv9x3xARiydWL7fFOug6/xdBwacR64HfAiJXc/XWrepGMhfw4+cKOmEWv
         HT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773271056; x=1773875856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKtkJ0sICHIojbLRDenDgLx0yniTaA4WdmAGcAVtIqM=;
        b=uU3+90drW1LggEV4Vi6I4wP05boC4ewGPfkB1mCLSK2ySNuxBk70TjiuTFd/97gE2/
         /5byGqnFE7u8P3pp95XX7EowdmyEvmLKVoXt1XB+TDiMvWlH/cltlYqkuF/KFDgq/64v
         xaMmHYq4oecZPlpC9kfQi9RHLYpQtObJ6NYfAOuhFhHzTNLkQWIb4M8/S5WdNjQkY6nM
         Jx2douS7qyiCwoIVJY2rMFikBbv5ceOUYJ9j35gzH8WXqBtavpyjV4mN2JKskWtiiSdK
         slaXR1FVE7BhycQu5f/6+k3+V1tmxJeJR9Z+QfRZYgjghB4iFgwFEkea6YLABMZ16sIQ
         1LRg==
X-Forwarded-Encrypted: i=1; AJvYcCU2yMytiF7Q7yhw3+PjUKvmwyk14sXitxq5bg1farEx3nR8cOgeu59dK1srr6ftBay1fOO+r1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfSXDmiVDE1X7oEYp5FZmbq0tF/sfl5hmH3Og69WpsWRqyexUg
	WXBojKnDGOUc5BiyYF1dXHBkZ7sKw3/WstX/wOeYSZ+VDaOsi2ZmWpO88kwQMEcudU4=
X-Gm-Gg: ATEYQzy2AhlNPc1gOAyzLIvjsbn4aKoWGbB4jK7EyxGXWdYMkTulxfjrXqqKdfrF1ey
	/gZJIWVCdPpWfpxgayNKhVh7WK1IJyunQl+r3udh+pdpChlgLBWpHFIaG/AWhm5L3dWxmEIlUqz
	ZSHatvUMdQdZSBII6NZ2fN4/ZXhfsLv6HvhlYhGKU8k+I0smtydd9NctPq4/xVVvYMoQNRn7EEm
	zRTCU+LV5qTDP9zg0lQG3w5nh8BKGclvnxG+dXf/r2x/NtP1augS9+/ceG+a1hXCKfN3JZxa028
	srDWVMWy0dz59yCYA6emphOjW5C1rOd8tENrzVUFqbj9NNVm2xWcivogjAGE6S7ZYeEm9FRMKG+
	oCWR5/aB2whsvvu1z2CXAEMixX7mbXeI+JIUBYRJzjBewDF4CA/MpAqsaYZNbpKVN38TA+KXS02
	k1/evnSLBknPWCOtzceLlNSF30ZOg9AP8kNYAceGGMKKVehyF+IIPx6lg=
X-Received: by 2002:a05:600c:4fcb:b0:485:469f:5320 with SMTP id 5b1f17b1804b1-4854b1319f2mr72608785e9.30.1773271056124;
        Wed, 11 Mar 2026 16:17:36 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:b103:6a0a:3e1c:778a:5cc7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7ce6135sm4758290c88.16.2026.03.11.16.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:17:35 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: sfrench@samba.org
Cc: pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	ematsumiya@suse.de,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org,
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Subject: [PATCH v3] smb: client: fix iface port assignment in parse_server_interfaces
Date: Wed, 11 Mar 2026 20:17:23 -0300
Message-ID: <20260311231723.751558-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224769-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org,uni-hamburg.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: C60F526B506
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
v2 -> v3:
- add spin_lock around server->dstaddr access
v1 -> v2:
- read the port once from server->dstaddr before parsing iface entries
  and considering *server* ss_family
- update the commit message to describe the fix more clearly
- adjust the Fixes tag to fe856be475f7 ("CIFS: parse and store info on iface queries"),
  as the later commit only exposed the bug rather than introducing it


 fs/smb/client/smb2ops.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

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
-- 
2.53.0


