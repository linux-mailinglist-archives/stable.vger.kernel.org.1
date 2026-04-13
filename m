Return-Path: <stable+bounces-237640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLblHl5A3WkubQkAu9opvQ
	(envelope-from <stable+bounces-237640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:13:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 389DA3F2874
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 247803050408
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236723BD22B;
	Mon, 13 Apr 2026 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OUXumIF8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541903B6BEB
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107483; cv=none; b=YFTj6rUXLySgiUonPtmeTQzNysqYc83UWMIl7Qf6vNk0D1Ksr7OWjfWyeY3VZtEdf04vC4B9604TnUuqIbdu+o1sKZKgNImtSbGvSfHpv3tpZV+wmWMFzZ7H8kjMKjN9GzLvXfjkh0UpHBRFpSbQJ1k1GaZSSBgP5J2QfmsCDsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107483; c=relaxed/simple;
	bh=E2hjxYStm3aD6IMH0x56H1eA9O7MIAYApbvv/cTbWNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTNHMnUIvS1XuYT8dSC3joY1i4sLBCfsukO3Qb7AgNYp0R+qnI332Dpgp6y3J8VVH2Pxq8j6bKaGq4S8fR5phrRGZRheWaxjlfVEhN35Y4jOJDbKIfCkjicHMlhZO8NL5cTxpF/nxKljy/mjWUD3a76W/x4Y69yq/GfCMaiVxqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OUXumIF8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso80583145e9.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776107481; x=1776712281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXWGSvkFU16FgOFRkCaaPZi61w++nh88NCvP7Zfs+t0=;
        b=OUXumIF8AX3lCnvtPOWN1pLHMorUFBkYKEcjLV69DTQNZDtECiiWfMJ6MRk3VLpqYE
         0ojH3vi4S6K7VUX4R3B8rwKUQQs4HMuHUvp9Em6QRI4SO0zth1JEmdTUhsU60XZgVW7f
         ZVRD5HNHreH+NKT9pfq2kKnIrUylru0MCIi3tZfOuyhL3GFK3glTZfxh2Qtl3GLv/wfK
         7qfTX6Fh7/6vXCDAf/0Xaz1G1KDmAjnhN6AMsTDJWe43PXOo/C5NDU5XG//sgV5NxCwj
         EV1jiOPWDAywFgskNDhDJDmarPU9N3Eef0Mfe1YME4LMPRMa0yNurpow/Hv4B7PgEF9H
         A8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776107481; x=1776712281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXWGSvkFU16FgOFRkCaaPZi61w++nh88NCvP7Zfs+t0=;
        b=SSFAehNgS+SFZgS6MBItr3SqMCMhHeHt6q8v+nSnnQnwTFhkFbDOJzB3UufPmpdzaw
         spbWTv+XDS7nSUw/tgKo/qhg5Gqtd7kE4ysgSsx62INw39I33JedpbBdSUQY7VIz5Uro
         qhguQyQWxMeOOeejxSnUPOa4gNAanMhuDO2yWU5j8cPHNXzpB7xwMkCtkwOBmJpmUPqY
         vB/355nulDyPZjsmvzn8K5PGBDJGzEStvH1rkumm6zS/XXMQPhmLjpRaPx721/fKygVu
         Iwmn1SlEMekQW5pIuHTkLhR9JWe+KgaQ+pA1lR0ocIdV0Dpgg5wHNsGJixZlWel/9K44
         3wjg==
X-Forwarded-Encrypted: i=1; AFNElJ8pWQ2Qvk4c3/A8U8VrTkJrWO4ddZ5HLrFdZ0GKOA7+x9ZX01PiTmOFNN97d5LcT1pIThxAlk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtw/HaLvIrFyTAB8eMewPeifiD6tcIkpvjkwjVtATOn/EtJ0YM
	0E12o6Ll3V6Ri0ftMCvPBrulIE07qxdXlJw21Xwty50hc2J6yk5u2U7Mh3Yih9iJOmY=
X-Gm-Gg: AeBDieuOBLbL5877NwECiI1wjjBp24bm+hFRpogj6vR3nHCCnAfNgt3BLHUQ/L56+eJ
	IzS+KyJ7nJYk+mhXHQtC2Qe0JabXtGOXNoRCMFBZhp11JOK7ZVNTZUR9n1MdvDVvt2UeLDft1+F
	hGnjoST8cELuUjEyxtpdosiF1kEwbwEVrDeswDiscQ0g/BoEmtt1eGIJZr1koNCNoxbZEqAUIAh
	N6nbzP+4S+74K2QUbPsBOokSJNl477KVP6RGCAS3MTxoe17EqEHvAlKItY80LcuxFD8bwimSZb/
	LgBWGVc7Jm4pwuZWz9HvzICCmo16hxiH9Q6ROwsP1iQ7kW9hgpKAWkRY/hHadijdZfkmNQ0JLeH
	1d6LP+UImDENuYhttERnL4Kscz7+qE7Ko7Mdy6EehcjFLKIEXTw6R6z0BVcS98kOlzd1ab7Js+2
	0ZUUGmvtnbqY9C/rgm2Kl+70/BjuM/1RM=
X-Received: by 2002:a05:600c:3f0d:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-488d68769f9mr181491475e9.26.1776107480576;
        Mon, 13 Apr 2026 12:11:20 -0700 (PDT)
Received: from precision ([2804:7f0:6401:5290:433e:afae:f475:c9f7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c6afdsm17508032eec.4.2026.04.13.12.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:11:19 -0700 (PDT)
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
Subject: [PATCH 1/2] smb: client: serialize channel scaling path
Date: Mon, 13 Apr 2026 16:11:09 -0300
Message-ID: <20260413191110.1508848-1-henrique.carvalho@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-237640-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 389DA3F2874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Channel scaling serialization was coded at several call sites with plain
flag values in ses->flags, which duplicated the same bookkeeping in
reconnect and remount paths, and was missing in the mount path.

Move the CIFS_SES_FLAG_SCALE_CHANNELS acquisition and release inside
smb3_update_ses_channels(), and convert the session flags to bit indices
and their operations to bitops.

Make smb3_update_ses_channels return -EBUSY if there is already an
ongoing channel scaling operation.

Fixes: 556bb341f9f2e ("smb: client: introduce multichannel async work during mount")
Cc: stable@vger.kernel.org
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/cifsglob.h   |  6 +++---
 fs/smb/client/fs_context.c | 15 ---------------
 fs/smb/client/smb2pdu.c    | 24 ++++++++----------------
 3 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 709e96e07791..7b1323927711 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1049,8 +1049,8 @@ struct cifs_chan {
 	__u8 signkey[SMB3_SIGN_KEY_SIZE];
 };
 
-#define CIFS_SES_FLAG_SCALE_CHANNELS (0x1)
-#define CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES (0x2)
+#define CIFS_SES_FLAG_SCALE_CHANNELS 0
+#define CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES 1
 
 /*
  * Session structure.  One of these for each uid session with a particular host
@@ -1089,7 +1089,7 @@ struct cifs_ses {
 	bool domainAuto:1;
 	bool expired_pwd;  /* track if access denied or expired pwd so can know if need to update */
 	int unicode;
-	unsigned int flags;
+	unsigned long flags;
 	__u16 session_flags;
 	__u8 smb3signingkey[SMB3_SIGN_KEY_SIZE];
 	__u8 smb3encryptionkey[SMB3_ENC_DEC_KEY_SIZE];
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index a46764c24710..e0e13c22e159 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1166,27 +1166,12 @@ static int smb3_reconfigure(struct fs_context *fc)
 
 		/* Synchronize ses->chan_max with the new mount context */
 		smb3_sync_ses_chan_max(ses, ctx->max_channels);
-		/* Now update the session's channels to match the new configuration */
-		/* Prevent concurrent scaling operations */
-		spin_lock(&ses->ses_lock);
-		if (ses->flags & CIFS_SES_FLAG_SCALE_CHANNELS) {
-			spin_unlock(&ses->ses_lock);
-			mutex_unlock(&ses->session_mutex);
-			return -EINVAL;
-		}
-		ses->flags |= CIFS_SES_FLAG_SCALE_CHANNELS;
-		spin_unlock(&ses->ses_lock);
 
 		mutex_unlock(&ses->session_mutex);
 
 		rc = smb3_update_ses_channels(ses, ses->server,
 					       false /* from_reconnect */,
 					       false /* disable_mchan */);
-
-		/* Clear scaling flag after operation */
-		spin_lock(&ses->ses_lock);
-		ses->flags &= ~CIFS_SES_FLAG_SCALE_CHANNELS;
-		spin_unlock(&ses->ses_lock);
 	} else {
 		mutex_unlock(&ses->session_mutex);
 	}
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 5188218c25be..2eb13b2665a4 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -228,6 +228,10 @@ int smb3_update_ses_channels(struct cifs_ses *ses, struct TCP_Server_Info *serve
 			bool from_reconnect, bool disable_mchan)
 {
 	int rc = 0;
+
+	if (test_and_set_bit(CIFS_SES_FLAG_SCALE_CHANNELS, &ses->flags))
+		return -EBUSY;
+
 	/*
 	 * Manage session channels based on current count vs max:
 	 * - If disable requested, skip or disable the channel
@@ -243,6 +247,7 @@ int smb3_update_ses_channels(struct cifs_ses *ses, struct TCP_Server_Info *serve
 			rc = cifs_chan_skip_or_disable(ses, server, from_reconnect, disable_mchan);
 	}
 
+	clear_bit(CIFS_SES_FLAG_SCALE_CHANNELS, &ses->flags);
 	return rc;
 }
 
@@ -432,15 +437,6 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		goto out;
 	}
 
-	spin_lock(&ses->ses_lock);
-	if (ses->flags & CIFS_SES_FLAG_SCALE_CHANNELS) {
-		spin_unlock(&ses->ses_lock);
-		mutex_unlock(&ses->session_mutex);
-		goto skip_add_channels;
-	}
-	ses->flags |= CIFS_SES_FLAG_SCALE_CHANNELS;
-	spin_unlock(&ses->ses_lock);
-
 	if (!rc &&
 	    (server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL) &&
 	    server->ops->query_server_interfaces) {
@@ -450,11 +446,11 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		 * is in progress. This will be used to avoid calling
 		 * smb2_reconnect recursively.
 		 */
-		ses->flags |= CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES;
+		set_bit(CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES, &ses->flags);
 		xid = get_xid();
 		rc = server->ops->query_server_interfaces(xid, tcon, false);
 		free_xid(xid);
-		ses->flags &= ~CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES;
+		clear_bit(CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES, &ses->flags);
 
 		if (!tcon->ipc && !tcon->dummy)
 			queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
@@ -492,10 +488,6 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	}
 
 skip_add_channels:
-	spin_lock(&ses->ses_lock);
-	ses->flags &= ~CIFS_SES_FLAG_SCALE_CHANNELS;
-	spin_unlock(&ses->ses_lock);
-
 	if (smb2_command != SMB2_INTERNAL_CMD)
 		cifs_queue_server_reconn(server);
 
@@ -609,7 +601,7 @@ static int smb2_ioctl_req_init(u32 opcode, struct cifs_tcon *tcon,
 	 */
 	if (opcode == FSCTL_VALIDATE_NEGOTIATE_INFO ||
 	    (opcode == FSCTL_QUERY_NETWORK_INTERFACE_INFO &&
-	     (tcon->ses->flags & CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES)))
+	     test_bit(CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES, &tcon->ses->flags)))
 		return __smb2_plain_req_init(SMB2_IOCTL, tcon, server,
 					     request_buf, total_len);
 
-- 
2.53.0


