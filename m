Return-Path: <stable+bounces-224711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H2GLm+UsWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:12:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1AF26713C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 336133015D03
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E87320A0E;
	Wed, 11 Mar 2026 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SQx0nyZ9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80D2836BE
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245349; cv=none; b=KByqOGQB1VwtMk23gV17/zvhiA/sb1D8hXeXgHQf4ZrvWVnDv95bNXOawRMOIxlzl2YKHmIBV5n3ATuXeiOerXsL3AOvYwQ6ORsP3XmdzXGUegAweRevEfzP1r8vmWpvo512Fph3O9OqPaWOVQ2yoG6d7ZmQWKj1wv3lO6hBhMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245349; c=relaxed/simple;
	bh=8jYcDGodtpSwJhTwixQOKf3vIBHR6G9gy3RXw+RNRP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZmqONxsHB6RCzVboTs4nHT4iDUQihWWJ2ZhqX8Ne/r0tQvYxBlAQJFZQ2yK9ZWdq/oLD5BHvJezmWwRxFZk6hMdJ8IX4RrUu2OdLE2l3kR5k0Kbb495U3pP+kDuc1AN4vY6wO+zFklvn80/I82EBG1sr/y95nwKXRa3tWTUsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SQx0nyZ9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so121405e9.1
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773245344; x=1773850144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gVSVuZCY4DN/AOXDxmYSHDACnTa9Rrny+DZImbC8pA=;
        b=SQx0nyZ9ApcSnLKUYIGoFFGVKTOnUPdX/xf3qAGS0wDHR9BgMWWFkelLdv5091S94q
         HcjAk8kgytxwBtU0CqPwffzTb3abtXtYkJ+Z/m6nvaMCqbk6xhfYRitgdZ4ju69u+CYS
         CL+oGTT6y1D7rD6q6pzWl2j1TIwKGFtIIzKL/asuLbIVbzq2H6mFUrTqF2IVRqPCL5vG
         YJGjUBmFtMsjNo7JIPEVfQmSlQNWjCgL/HQBYqbtDUpdvIguSHYxSLbAlWhMaaGF/xZb
         9M5CmPedneoAc9NfeTsL4jtb3eHSk3UiXqTftCUysb17wrCVy8GL68Q6QTlyunMtzYzK
         G6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245344; x=1773850144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gVSVuZCY4DN/AOXDxmYSHDACnTa9Rrny+DZImbC8pA=;
        b=lyY3edYX3AwajcHKMOVPC+sFmiAVhnoTuyFOYAkC/Y0ZZsZv4YaN+YaiDqPBl5o1pn
         1vyfFggc7wUa9kHds5vkp3QuM/kpz7oRQ2v1Sjz1fy81MSL3+ikj9fwGVhyatMBVRiMW
         QiTlex4yIRxM4PPhGxep5sds1WY+r3T6h/WXPjT5QJX1w07cgMp7+0PK0+WqpSWcsmbX
         CU5ePto/OdsCQC5cf2HTYpbW5/GGV4CXkB/dtt3u0w1uxfW8JR1eUGPCfC2opAOFCtTo
         zgx+fwKqmlFXGcorV4W0f7kmnOnPb1pauHeLFHUzLMwnavV+QcxpPmDxXVOm6VZVL9Xp
         9OjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAvAc6Mh+TgKAp0RdFgtewb3px+aDOwInI8KfYLYlqnshLIZhuL1GJQRfZbiknbKF4q6dKu1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6R5IkdKrsK00PSskGdztGRhkC8lzWJtfs1DVUHbPHFikBRzWX
	ezFBnhzRfgTPX4zlW1cWk/OU36VQugKR18RkhvPf2kzsugrj+Jf2dlnubnoNVWb39Ec=
X-Gm-Gg: ATEYQzzLQwFOPCERiAUm4P6bWm5RTjU6hA6eetEfPjNQfYSIbsOk8bnj5n16bLaWjnT
	2PWBHosQBS7mG+J6YTfVRH2hp+48nO4mrl2zs+O7VvsC9sPssPt0WHMGwbDnYfYwEq7tBvHiLWL
	arRiF3W5ggWg7tGQK19SqvIVAfWu3kfMesuL82xRNRqabtCSecFYNSIqnI7ZcXoRBG7TFVvi13m
	Nui6PVJ8B3OvqH6r0VgFq4I9NTL5YufDLcoJqR8/ZBwc7rX4KF3YZ5B3aC0HQaNG6R0r35P8XA8
	JChoCjms19iTuDWI/sTIdImVkQww3Axua/4DdJgJzwVxGMvGNoHRJzcB//evlOV0cH4NQJSL2C/
	jOHav9F03umDG/7IsmlwZ6kJdosGGPIlmsgVE+gsq0ibrLs4Iz5yvShCACvKfvHELYf9nswQLQk
	Tj+5DA+8GV+JdAR4RsHzldoZPLEbSBhP28CWT7JWpQxM613agaS1dLnGU=
X-Received: by 2002:a05:600c:8b45:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-4854b1008famr45351985e9.16.1773245344207;
        Wed, 11 Mar 2026 09:09:04 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:b103:6a0a:3e1c:778a:5cc7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7cb558fsm4000846c88.10.2026.03.11.09.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:09:03 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: sfrench@samba.org
Cc: pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	ematsumiya@suse.de,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: preserve destination port when parsing server interfaces
Date: Wed, 11 Mar 2026 13:08:56 -0300
Message-ID: <20260311160856.635916-1-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-224711-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 5A1AF26713C
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
Fixes: c1846893991f ("cifs: update dstaddr whenever channel iface is updated")
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/smb2ops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7f2d3459cbf9..d3cbfb3fdfc9 100644
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
@@ -676,18 +677,20 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 		 * conversion explicit in case either one changes.
 		 */
 		case INTERNETWORK:
+			port = ((struct sockaddr_in *)&ses->server->dstaddr)->sin_port;
 			addr4 = (struct sockaddr_in *)&tmp_iface.sockaddr;
 			p4 = (struct smb_sockaddr_in *)p->Buffer;
 			addr4->sin_family = AF_INET;
 			memcpy(&addr4->sin_addr, &p4->IPv4Address, 4);
 
 			/* [MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore these */
-			addr4->sin_port = cpu_to_be16(CIFS_PORT);
+			addr4->sin_port = port;
 
 			cifs_dbg(FYI, "%s: ipv4 %pI4\n", __func__,
 				 &addr4->sin_addr);
 			break;
 		case INTERNETWORKV6:
+			port = ((struct sockaddr_in6 *)&ses->server->dstaddr)->sin6_port;
 			addr6 =	(struct sockaddr_in6 *)&tmp_iface.sockaddr;
 			p6 = (struct smb_sockaddr_in6 *)p->Buffer;
 			addr6->sin6_family = AF_INET6;
@@ -696,7 +699,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			/* [MS-SMB2] 2.2.32.5.1.2 Clients MUST ignore these */
 			addr6->sin6_flowinfo = 0;
 			addr6->sin6_scope_id = 0;
-			addr6->sin6_port = cpu_to_be16(CIFS_PORT);
+			addr6->sin6_port = port;
 
 			cifs_dbg(FYI, "%s: ipv6 %pI6\n", __func__,
 				 &addr6->sin6_addr);
-- 
2.52.0


