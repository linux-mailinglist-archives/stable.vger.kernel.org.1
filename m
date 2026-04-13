Return-Path: <stable+bounces-237641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCVVEoZA3WkubQkAu9opvQ
	(envelope-from <stable+bounces-237641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:14:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0884F3F289B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B02893061D43
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2381837EFFA;
	Mon, 13 Apr 2026 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J3yExkq/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD0382388
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107502; cv=none; b=LICDV1lO3ZbdNYXyI4XhvOAo6G0eDdijTnnqcC5RlRfJayQUK/4HHhe8AWvN/sBt1XjtRWDe1Lon7giT+muCzV6GWkQY7JIH2lVrchvts+6RZpi+mRJEeFJNdTJHVSitBKAV3dX5QUI+qxOTxqxa02LcwCEywJsuyfpgUtGaSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107502; c=relaxed/simple;
	bh=f9oCGipDy6RcLee8mwGZHQR7Mqjd2U38RG0Ya7eHqI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2TxeVnl6IBIQGHU2a47TZ+LWBVr7nQCc5toUu6Kl0Na3PkF8VICftmtAxw7X27ml7rjkvlGqIaHpxMXb1myYLOW/UOfgR5f+8P7QAnpxZNZyvXO3urc9pLU+ThbXTpEcsQsu2dv8SrB1ytYQjcO151z5h/jRxaKWH1rStx7+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J3yExkq/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488c21c636dso28552575e9.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776107500; x=1776712300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nCfqvin2GADlXqoFK8yPp3FrJJtNV6XYhevnyEsvuc=;
        b=J3yExkq/eUdMKl/tyHfOCOOcCpVY0AhMLrU1K6qAW8AoQfiUMsHzAaBMD7aaJpWqMA
         5b2lMpJvSZ2iEGqAcgDM6KcHFXr9EJClp7rzJ6VACq+YKep3p++aF00kaqg/NZj3t600
         UD+b3J+J2rpEqtGO8Jg/b7e7f11UjTxK9rNLBZbYvscr14t2eEzrLWMvM09qSn8NZaqJ
         Cffy4MVAqm4ENslu71GGnEscMZqdnDr6ACHqHFyj1XuKmIjiJNzuqqZsJHCBLg3sgVRe
         mcXDgadBqisFy1zM1B2v0OxQ8B43rjQNWCsGJ8jlpZzql0BKJ8pUpUSclL7YfCaNq3rl
         WkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776107500; x=1776712300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3nCfqvin2GADlXqoFK8yPp3FrJJtNV6XYhevnyEsvuc=;
        b=FLh+hsZd2+cJjfkW+myrYXjq4iU/ODoKU54121GX2RFIrufNSXhROCZZ6+AOGk/cBp
         z0K1bltF3GsSkeJtef0mIhpyPh6ehA5WUSb6mnGj2mBN+ZFLNqt9j3/bGErPL7cetakh
         bShYAZGoB28ZbobHc17PRVlfuV314YeNxAuIp9Rc9gH0YNo0tMc+gInuKWjVz3wDpFPx
         TfimxLB/yCekyHCTOY/+U8mrzvL6w/WdptmWTn9gaOWlpF9zjg3MpvFGyOmYFUpj6Zcg
         slfTSVLQo83lQZjEIimbV4t3FVCIuXnr3bYOTpJOlfLPAgmFd8yVGcFrHh65c6HKDLqT
         dOCA==
X-Forwarded-Encrypted: i=1; AFNElJ9vRdIcbpJogN5XVJwIAnUVLVYqF9BdpfbCBFVQhQ8Cj4dQOSadxmyHziiy1nmNzvORR9OslV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7C6ij3W8j5QS5289hjpiDn5mbcMk7Xvq0kuQGSc0r/pXSSMVp
	Xt5UhEf/xsH0AKtq1yyWVoqagA7aYSJvkkarHBCvA1uEyNL3FEBqKgqHfhnLwCsYHnk=
X-Gm-Gg: AeBDietMGy+mB3HRjVZrTex4wo4UxVJzwVadtvf5VsOd93bHrpObBG06RZTJREw/v84
	qIqxd5IGtxUrPv+nvjdu1WcQqb/yTw0dGDESUFz02A69cWgXzLgNfl4G7XvBBcNns4vgpRK+puA
	gh9yrM6FExgONaxPniYrR2ba7iSoSDsGdyjuGHQSY8qEH9Yk2fMDJZ9mCH1yRRNQ6AtHHSOoaQ2
	6UiK7oCv6CiCu75z42AJWl//Vzr92Oot8YRlp/2EDFg0v8/09bH50CuDvXSU1oJBMDDatWTVlRH
	NEvqsiLi/2oAmd2/mIqJZLw4Gn2v7/uLRxuK99iqW6JPKIov5SOADZ4nUpcIULxgQGd3sRl4Z9X
	pcxuXgev0hp81x8DwShL+BoMFq6LqqdrRGq2Tw31LC2s44DVEm/uybg+Z6Bg7fnvy4gOGs1BOzI
	jKl4MrKSTOd3nVXUbngDb/UkIh9zNkZq0C4tsnp/NJxA==
X-Received: by 2002:a05:600c:8b27:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488d68766c7mr185272365e9.18.1776107499704;
        Mon, 13 Apr 2026 12:11:39 -0700 (PDT)
Received: from precision ([2804:7f0:6401:5290:433e:afae:f475:c9f7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c6afdsm17508032eec.4.2026.04.13.12.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:11:38 -0700 (PDT)
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
Subject: [PATCH 2/2] smb: client: pass correct from_reconnect to cifs_put_tcp_session()
Date: Mon, 13 Apr 2026 16:11:10 -0300
Message-ID: <20260413191110.1508848-2-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413191110.1508848-1-henrique.carvalho@suse.com>
References: <20260413191110.1508848-1-henrique.carvalho@suse.com>
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
	TAGGED_FROM(0.00)[bounces-237641-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 0884F3F289B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cifs_decrease_secondary_channels() tore down removed channels with
from_reconnect=false, even when the shrink was triggered from reconnect
context, which could synchronously wait on reconnect work and break the
reconnect-side teardown path.

Pass down the from_reconnect argument to cifs_put_tcp_session() so
reconnect-driven channel removal uses the same non-blocking teardown
semantics as the rest of the reconnect path.

This is a minor fix. I believe this bug cannot be triggered in the
current state of cifs.

Fixes: ee1d21794e55 ("cifs: handle when server stops supporting multichannel")
Cc: stable@vger.kernel.org
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/cifsproto.h | 1 +
 fs/smb/client/sess.c      | 4 ++--
 fs/smb/client/smb2pdu.c   | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 884bfa1cf0b4..b00b2e070ada 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -374,6 +374,7 @@ bool cifs_chan_needs_reconnect(struct cifs_ses *ses,
 bool cifs_chan_is_iface_active(struct cifs_ses *ses,
 			       struct TCP_Server_Info *server);
 void cifs_decrease_secondary_channels(struct cifs_ses *ses,
+				      bool from_reconnect,
 				      bool disable_mchan);
 void cifs_chan_update_iface(struct cifs_ses *ses,
 			    struct TCP_Server_Info *server);
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 698bd27119ae..47bb566c8731 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -273,7 +273,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
  * Otherwise, it disables all but the primary channel.
  */
 void
-cifs_decrease_secondary_channels(struct cifs_ses *ses, bool disable_mchan)
+cifs_decrease_secondary_channels(struct cifs_ses *ses, bool from_reconnect, bool disable_mchan)
 {
 	int i, chan_count;
 	struct TCP_Server_Info *server;
@@ -319,7 +319,7 @@ cifs_decrease_secondary_channels(struct cifs_ses *ses, bool disable_mchan)
 				server->terminate = true;
 				cifs_signal_cifsd_for_reconnect(server, false);
 			}
-			cifs_put_tcp_session(server, false);
+			cifs_put_tcp_session(server, from_reconnect);
 		}
 
 		spin_lock(&ses->chan_lock);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 2eb13b2665a4..cf7b74a2b9b0 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -206,7 +206,7 @@ cifs_chan_skip_or_disable(struct cifs_ses *ses,
 		return -EHOSTDOWN;
 	}
 
-	cifs_decrease_secondary_channels(ses, disable_mchan);
+	cifs_decrease_secondary_channels(ses, from_reconnect, disable_mchan);
 
 	return 0;
 }
-- 
2.53.0


