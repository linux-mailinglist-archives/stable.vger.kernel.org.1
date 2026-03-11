Return-Path: <stable+bounces-224763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LZ3C3TasWlPFwAAu9opvQ
	(envelope-from <stable+bounces-224763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 22:11:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD9526A4B2
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 22:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C5A315BF9D
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9986D324716;
	Wed, 11 Mar 2026 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eYnw2Gme"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349E35DA5F
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263369; cv=none; b=VH3oE8l5mrlI7NVeJ+bvM+wY8PHG8E/I8C0T3gbtdQNRixvGq0+Rj/+KZpnzqNcWjDk5K5SkHDU4tLdN6WFkw3ISmWVLo8xBWyujBaz3NvI1db2Hgc9vqVQwcbfMpzMOhVQVdRXAQQ/xARxzsl8ELfNeh8PqK7E+amjUx/myGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263369; c=relaxed/simple;
	bh=QRC2zBceQZAw9NVBvIU644ZzsneR1w+YSjwrraWS+AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ndHsMzt+awtBq/C80pZO7hzgOG8l1xrX2LZ9ZF3ZUOtiBvrSA45udGlhhPBUQLjEpfDlD/oILSV0oauKdHCJOQv0UO13AiOXIlDImOZ+lSvhvhS1Qt+Ia7PF3/zAHGA6RXvoe4ffzmKomUEMwDSYOl+3rAtHVHk8pXKirjUrHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eYnw2Gme; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48534237460so2711345e9.3
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 14:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773263365; x=1773868165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UaaxnmPHTieCJFocp7VqZ1LoooxMAJJriEl5r9r2vlo=;
        b=eYnw2GmenSzafT+VZhiiPjNLBAk66dlBBvdeEMzGDDbPW32tIku4tN9ogzvT0zAEww
         kK5nywA32y0XHPhBTw1yB2+ClcxKB+Az+ypxRRgF3v2DsSzd6ka7CyxfH0fq/WqPonly
         EpA0tfqZeaATbN7XTHQ/z8RfD157qtepS9tf7zrpryWmdpN1Nu5j7HqrUo0aRPdoDKUv
         w7UxXNxEqoi3FOQyZvvV5iw3kChh/0NGhc3mhIenG4TmQVyq+5jGmdpaRSS3lUs0cET7
         cn7EsnmmtVgFqbwt0dPTLClPkA3suoqEYedHJhMqioYp75j9sNA9zdGhfw1gUcOCnuSo
         Z6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773263365; x=1773868165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaaxnmPHTieCJFocp7VqZ1LoooxMAJJriEl5r9r2vlo=;
        b=pNDz2EEhTfMFKDLm68DoiZ3wMa/dXpxPy34276NZdcJxyxupnE7aarZbSzCsCcSkYL
         TzTAmQCRCAMI2/iK2s3wqnXmQpRc5em+t8cq9bj5DBW+t7FZo33eyfoertdB37FWQ5QA
         tG2+Kecc2qB3qXe7Tury4MzGl+Qc/+L5Va0eFodB0dqpbWGVf3WvDobext32/ySLJv9+
         4wKG0Q66FHnGIj0c6rioIl10nEZdkLdmBCWXC/unAEqRLJ5vQTIlLE5LFVuK8r57JC8s
         Ic4WTDhNUDHDxdDxDuL1gXYqhj1aPffbwvA98aENXAwbE/4Zlhs1Oclq5SaFNqu7We0w
         Ml1g==
X-Forwarded-Encrypted: i=1; AJvYcCVIum+MqF13st7UmUn+9cECWXwElcl3umlOZDywRpNwILC5V3Sw4V8f5xRn2z1A6ZVxPUT4sKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIizwx6eqI+R91Wi8eVXW3SGD6gl3+a3xXo1waey77Mqkm1XNl
	HoUM70DGq2iQ0cO9KOp41WviYDlYdcj/Z+/iFZM1B5NzDcGe2x0nGTjiKGV3u+DMKu0=
X-Gm-Gg: ATEYQzyw/KVTMJni/nsA8v5tMTCgBgqVTIlsFZ9JhWu+W/QiQNGfcConAhOCOB1JxTn
	Q1yFbT8dZqlr5Vvtp4NJc3GiO31OEzzCwiaoqOQC+DWl20GvhnVX6SfViLDyRo7SxuqQC2nohn7
	PkGjGcfJZXY0Mrvgo4Wo4R259a/yxRrhM50V/xqKiw4higzrL2h6hGt8bst1qZvZWOIvV0BbInr
	7PiesGR04nehTidSG5rXBs0YPFJJ0gnHRiu7+MjhVmvt+eVc+yuG8tC1ue9AfqYEjtSOMYRzmGM
	pUcJjRZ5ORXyfOqdnBDR5MTLq11l0Mthl5jGahlOBYGl+mRYA554dwCpguBfeXSM/ubAn8K0MtE
	IN/eARsAoTsq9lDHJllnNnUBEKTEXfNe4TKibYaugsSfG3G6PwaM0J54RcCDNrbwmdImA54dQnf
	lTKOoUlkWvwiWi6L1QGxxbiNNEiTYgYhQJD/hFUIXnkKUUWvNGKQzxZbM=
X-Received: by 2002:a05:600c:8b31:b0:485:3812:36da with SMTP id 5b1f17b1804b1-4854b0afc13mr69420255e9.9.1773263365105;
        Wed, 11 Mar 2026 14:09:25 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:b103:6a0a:3e1c:778a:5cc7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa73ba6sm3896702eec.25.2026.03.11.14.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:09:24 -0700 (PDT)
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
Subject: [PATCH v2] smb: client: fix iface port assignment in parse_server_interfaces
Date: Wed, 11 Mar 2026 18:09:15 -0300
Message-ID: <20260311210915.735288-1-henrique.carvalho@suse.com>
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
	TAGGED_FROM(0.00)[bounces-224763-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 7FD9526A4B2
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
v2 -> v1:
- read the port once from server->dstaddr before parsing iface entries
  and considering *server* ss_family
- update the commit message to describe the fix more clearly
- adjust the Fixes tag to fe856be475f7 ("CIFS: parse and store info on iface queries"),
  as the later commit only exposed the bug rather than introducing it

 fs/smb/client/smb2ops.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7f2d3459cbf9..7a176088c877 100644
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
@@ -662,6 +663,13 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 		goto out;
 	}
 
+	if (ses->server->dstaddr.ss_family == AF_INET)
+		port = ((struct sockaddr_in *)&ses->server->dstaddr)->sin_port;
+	else if (ses->server->dstaddr.ss_family == AF_INET6)
+		port = ((struct sockaddr_in6 *)&ses->server->dstaddr)->sin6_port;
+	else
+		port = cpu_to_be16(CIFS_PORT);
+
 	while (bytes_left >= (ssize_t)sizeof(*p)) {
 		memset(&tmp_iface, 0, sizeof(tmp_iface));
 		/* default to 1Gbps when link speed is unset */
@@ -682,7 +690,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			memcpy(&addr4->sin_addr, &p4->IPv4Address, 4);
 
 			/* [MS-SMB2] 2.2.32.5.1.1 Clients MUST ignore these */
-			addr4->sin_port = cpu_to_be16(CIFS_PORT);
+			addr4->sin_port = port;
 
 			cifs_dbg(FYI, "%s: ipv4 %pI4\n", __func__,
 				 &addr4->sin_addr);
@@ -696,7 +704,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			/* [MS-SMB2] 2.2.32.5.1.2 Clients MUST ignore these */
 			addr6->sin6_flowinfo = 0;
 			addr6->sin6_scope_id = 0;
-			addr6->sin6_port = cpu_to_be16(CIFS_PORT);
+			addr6->sin6_port = port;
 
 			cifs_dbg(FYI, "%s: ipv6 %pI6\n", __func__,
 				 &addr6->sin6_addr);
-- 
2.53.0


