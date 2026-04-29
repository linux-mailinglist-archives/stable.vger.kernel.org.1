Return-Path: <stable+bounces-241942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SItZKL5v8mk+rQEAu9opvQ
	(envelope-from <stable+bounces-241942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:53:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0849A43C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADD85300BC68
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 20:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B929F39F185;
	Wed, 29 Apr 2026 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E8yzMhy4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0246A2FE58C
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777495991; cv=none; b=qhdovSOnhcZizC1jmcA//Yx3DPGl8ZqJNq1oP7/+eUHAkVlTM3qqEt6XC9mgGZIqoUa5bn4fniuGBaCAP4lZpj59RfgdMAEjE2bjQxnu3AgIWqXCM37ZCIt1Pyg3TmBR4iFIx/Q61RQYo7G5ZZd/TGK0hu9VVzfg3rmLFQD3rmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777495991; c=relaxed/simple;
	bh=B43jmh8tyellEDHw/JHQWGP4Kl4Bt82DdbNgnsOczTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzAo5DWal3Mzn8Jrpubbk6TULGx5rwrn6umz1jNeORrahMuDhc2isGW6eXO2VhRoh5cuOOCxe5wXJVqdpSFakXNcPuzIpk87bsxtjx69aE0UdrLRRA4Cv6dYjlWC/XbofwsowtDSEHk6W7REu5YTZF/EDynMrFs78sqhWq0S4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E8yzMhy4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso2081425e9.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777495988; x=1778100788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86QVkp45/ToGTd4flnsgE7Dt+Q0OFD4ax6NkF368peQ=;
        b=E8yzMhy4SOL6sxsHtnTEJowaR2HCdNuuHqgmWU6jqGPmlbOw+xyuK2PyvCIYvceKqb
         xnJJk3pUIGLqMo3mgHNAnaDG2+bOtb3QtoMz5mayDDiZ45dhiuKap9tTgm++VyndyhiB
         Sv2P3vVMoYPq/dPqAzv4hsbj6ZAgwcp1DijNrg4psx+6Cr1KhqGP75pevVTczZyTG9kg
         64yi+b3Jfe39HwGVfngVQw53GMXrnoaQwa149rZzezucbr/2lTf6U58jLV1eeKePihAX
         sQ61q066u/mpR+nwA3FLJ3oNBPUB8JQjuWYiWY9k6WlHo5uojm7ubZxtQLBvEW2KqJW+
         YJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777495988; x=1778100788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=86QVkp45/ToGTd4flnsgE7Dt+Q0OFD4ax6NkF368peQ=;
        b=ALHZAnFuY5Ncboy/GQ2G7LdbJMJ+swgkGZTb+Hq1UbTk/kZuuLAMFTCufTcUZEnWmN
         Bqkv/lf4o/NgYsBzaGi9wunqh7GlVkWmVn09Vh3h0aqyIIUBAJSmdNBKkDYgPKeAp0dP
         I/2KEnwzVKO3PALmvbiCOZNcHi1U4s5fLKpygrW1ArbbnWmASFuCPvpZJZtFeNHO0Kp+
         7E1BsnxA3eI7KT7POOlqI2s+cCx1nMrM1/OOda8k1Kx0PKH4PY3q+DzF74hCyRGMP7lo
         SaYHTdwBX/qbSfeM4wNHPA9LNobTEJR58aX+eGJglCe9wTmCSVA4v2qHXiWwE1OBLgwB
         fLZg==
X-Forwarded-Encrypted: i=1; AFNElJ9RFcaVchwRoapbNsqCv18hb4VEACFt3USEEgfBY9c1JrLQ0gsLCgEqDNk9WQgJj3PkZtYGt6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy1GTyGCwYVmZnk8jldOuF3YzjyD8CiEMuWeiRhAP/5i/yhSXu
	J6MumYu5ZOTe1Gk+W5HRE/MEi4o7Wy2w3wo/1Eu8ngewqU8PznmoEKQUMlmsjqaYCp8=
X-Gm-Gg: AeBDiesjlgRNjk8LtzXG3tjiJl2gYTE2KpI7YwORFD6+ELcrO4HdmLerFzlVMYvEp3R
	FHk4MRFkCpfKlBPQ79Rxt5P7l7X6/IRPcS9fe0OogyUFTOFbG5nSL5g4oEIRsGJgTYLIGyNwKP3
	jqmUEABn77POk9cSlxbWmQrQGT029nmzwlYSOeXmtJ9Wyf8EM5VpkVCek1M2xPwXSjrwXvcIxgR
	HzrID8MnvFR2OhoZgnWsNZArF89g153VRyEqcYrwuGj+0RLxHoWB5z9tVihTb5zEU9k2rzR+L45
	6RlXcXsRY5ZhwXHdKUw2qTr6l3+TpO5Ej+6RBlBrEPIzPhzk04R1akLhx+Op97U364zXsGsGx24
	EYoFRszvJPocpIMtLhmv1W1zb4BX7QPnasIWSqQLgaZO40NCdcLnRTOz2qglD/pEXkHva6GjZ4Y
	rnqkOlQp6ThqkQhL5xIkkNWIvLAd4TgKIrnCLlmPESIgqJ
X-Received: by 2002:a05:600c:c058:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48a83d6f154mr2397105e9.9.1777495988358;
        Wed, 29 Apr 2026 13:53:08 -0700 (PDT)
Received: from precision ([2a01:4b00:c007:bb00:be9d:a3c4:18b1:4a25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de3269b41sm3925240c88.13.2026.04.29.13.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 13:53:07 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: sfrench@samba.org
Cc: metze@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	ematsumiya@suse.de,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] smb: client: fix race in multichannel rescaling during mount
Date: Wed, 29 Apr 2026 17:52:35 -0300
Message-ID: <20260429205236.456099-2-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429205236.456099-1-henrique.carvalho@suse.com>
References: <20260429205236.456099-1-henrique.carvalho@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9FC0849A43C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[samba.org,manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-241942-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dwork.work:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]

mchan_mount_* introduced async channel rescaling during mount. That can
lead race with other mount/remount attempts that use the same session,
when these are scaling down the channels, potentially leading to UAF, as
described in
https://lore.kernel.org/linux-cifs/rw7ptbx22cntes5eag5r3kvg5mzfvvzdhj4v2kw6mnunmsewev@f2iyrmmitkl3/

Fix this by using the same serialization used in other rescaling paths
and if in a race, rescheduling the channel scaling work.

Cc: stable@vger.kernel.org
Fixes: 556bb341f9f2 ("smb: client: introduce multichannel async work during mount")
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/cifsglob.h |  2 +-
 fs/smb/client/connect.c  | 32 +++++++++++++++++++++++++-------
 fs/smb/client/sess.c     |  1 -
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 82e0adc1dabd..ef63a1c3249c 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1817,7 +1817,7 @@ struct cifs_mount_ctx {
 };
 
 struct mchan_mount {
-	struct work_struct work;
+	struct delayed_work dwork;
 	struct cifs_ses *ses;
 };
 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index dcde25da468d..2ea93f0b78c9 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3813,7 +3813,7 @@ mchan_mount_alloc(struct cifs_ses *ses)
 	if (!mchan_mount)
 		return ERR_PTR(-ENOMEM);
 
-	INIT_WORK(&mchan_mount->work, mchan_mount_work_fn);
+	INIT_DELAYED_WORK(&mchan_mount->dwork, mchan_mount_work_fn);
 
 	spin_lock(&cifs_tcp_ses_lock);
 	cifs_smb_ses_inc_refcount(ses);
@@ -3833,13 +3833,32 @@ mchan_mount_free(struct mchan_mount *mchan_mount)
 static void
 mchan_mount_work_fn(struct work_struct *work)
 {
-	struct mchan_mount *mchan_mount = container_of(work, struct mchan_mount, work);
+	struct mchan_mount *mchan_mount = container_of(work, struct mchan_mount, dwork.work);
+	struct cifs_ses *ses = mchan_mount->ses;
 
-	smb3_update_ses_channels(mchan_mount->ses,
-				 mchan_mount->ses->server,
+	/*
+	 * mchan_mount_work_fn could race with smb3_update_ses_channel called
+	 * for the same session on remount, other mounts or
+	 * smb3_update_ses_channel
+	 */
+	spin_lock(&ses->ses_lock);
+	if (ses->flags & CIFS_SES_FLAG_SCALE_CHANNELS) {
+		spin_unlock(&ses->ses_lock);
+		queue_delayed_work(cifsiod_wq, &mchan_mount->dwork, 2 * HZ);
+		return;
+	}
+	ses->flags |= CIFS_SES_FLAG_SCALE_CHANNELS;
+	spin_unlock(&ses->ses_lock);
+
+	smb3_update_ses_channels(ses,
+				 ses->server,
 				 false /* from_reconnect */,
 				 false /* disable_mchan */);
 
+	spin_lock(&ses->ses_lock);
+	ses->flags &= ~CIFS_SES_FLAG_SCALE_CHANNELS;
+	spin_unlock(&ses->ses_lock);
+
 	mchan_mount_free(mchan_mount);
 }
 
@@ -3885,7 +3904,7 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 		goto error;
 
 	if (ctx->multichannel)
-		queue_work(cifsiod_wq, &mchan_mount->work);
+		queue_work(cifsiod_wq, &mchan_mount->dwork.work);
 
 	free_xid(mnt_ctx.xid);
 	return rc;
@@ -3942,8 +3961,7 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 		goto error;
 
 	if (ctx->multichannel)
-		queue_work(cifsiod_wq, &mchan_mount->work);
-
+		queue_work(cifsiod_wq, &mchan_mount->dwork.work);
 	free_xid(mnt_ctx.xid);
 	return rc;
 
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index de2012cc9cf3..24d5206e5c44 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -627,7 +627,6 @@ cifs_ses_add_channel(struct cifs_ses *ses,
 	return rc;
 }
 
-
 int decode_ntlmssp_challenge(char *bcc_ptr, int blob_len,
 				    struct cifs_ses *ses)
 {
-- 
2.53.0


