Return-Path: <stable+bounces-241943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KApkMsVv8mk+rQEAu9opvQ
	(envelope-from <stable+bounces-241943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:53:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A6249A44B
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EAFF300FCE4
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 20:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2823A75B8;
	Wed, 29 Apr 2026 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MpwalMYL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB99394462
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777495998; cv=none; b=RLT4oswMrfXIN8EuX3nFmCFYdiIQf7w4TV/7CHeGv8DLGNuzn9EtLvJPkyn2bKl+YGm16b7xdR3wRC1eCmRj79SRwljYVa1WnhANKZbg9b/boGUzQYiacvqUIoMO9qgV0MDmGteh2hu3goStSTjOMSTZqoaddX+uG4o6HF0pi3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777495998; c=relaxed/simple;
	bh=IiFNR2+WijGb9FrHO/PADeJfGkQ9mQYCgDD03ICPANs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G087Q3+0xeczYS4ge218Jk6YlUyoK3inPpFr2rPRe5zZbFXU14a8YivWsOZFs6q3yPld7hRxLakyp4n6fpTcZIqRcLMYJCpgDUKVPpgfX/MYnstp2tJtFy6KegcW79ILL7J8b+QTkjLvTjFF/ZFnu8hopq6sGK3BoiyMLKDsB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MpwalMYL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso1615435e9.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777495996; x=1778100796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJSq4V3powXkVcfGmSruYclyZoV2WmI9BprF8rckwPQ=;
        b=MpwalMYLBrUmf3ZE1NOX3jnoTs022uwN8F9Pbh3QL/srUJ0Bj/QMuV1zK6BmV3visQ
         KgQquQOykRRH82nKGFpttjEbemEkjpFNXPO9TqxEr+kHN04fyuJkNV67l69ZHVjnKF0E
         EV5Xzz+obkPSZd+AF+eOvJfMU+Lk5EULqxIJWpVRftUl05cfWfM4LlZmHVY+0eGpU6H+
         VG6BpUA1iwnsqDjjPpShmAEgNREJPoZd1/11VttZNFO2mC9LPYirJViosVxwCY2SKL0Z
         fxpKD75T+hB4xhe+kr8vM/bs6yxm/PWPqpxUMYTb+oG8U+g0IvWXN6B5B3d82cVzrLFN
         cy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777495996; x=1778100796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJSq4V3powXkVcfGmSruYclyZoV2WmI9BprF8rckwPQ=;
        b=px7HjP1Z28nxj0nUPa0wObqXo3FgRuURc1KytH8vbWVIQA2TJGClHi40aJnxkS3G5W
         GbTDV3TfWmpNVMI70+qzN3zxB5T/4HrbcvjpIdnvX0kNXxqjPRZ3v7X5QrXsmaYGCFoN
         wlsOan4I1aQQNDIh21/Nc+bk7SkNtcJNzlM+oiesZUbg0dliLSzK5J92gcSGmMcPm3JA
         fR9N5FTG3GWxeXgr0UByt4swoef9kmXXqpbyFW81bIjkeJONa6dn6a4p0f2W4kcWRMOg
         TEwh/hT72n3471eIZZMQsvIggWB+Ne2mOjJsAVclmwjE3JqeFcISnk+PRZu7A3Zkmxu+
         xwGA==
X-Forwarded-Encrypted: i=1; AFNElJ/clHTkDjFwhgK11bds+8v0a/Kt0NmGxMtGUiNi4TXU+2NSwnSihsGsJobOKDxavJ3jogvZJM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIpRv/sN6Q33nrKRcG0eVjpVEkaouGQhKiPGaC1zYsP8zoJe7x
	8LyJDwkrPLTmzzuoRqPF98aqzOwjwkezG+CvOVELe1Xf7FUe1B4A8LGAfGx3Shiljvo=
X-Gm-Gg: AeBDieusovyEat+WbGw4dvSOr+HeMl7ThaRjiN6I1t0BhpVolq/XqtCG8wlpbzPPLhX
	dq6Uitg2d2ZxoI3kLDL2DiOBXKcFpQRCNCnsN5Mq1jMEWJ8BC8zTbJ+HYqGUxeLBMmIp40Np3kq
	VYdcqzxiEmuQVydwhkeJZo5eKb6yJ99WX5vPcFr2p+lEAsnAmiMQsGQd0MdGi0YvnZZJY5jzFAq
	4rZKqSEs4flncyMeoCfZQ1wihBgzzrJ+IaNkdt6KKKlBVzePdVPhbAD5aH/Rs9avZaGNNZ9+iI/
	B6fpDSvT+D7fPR+PlJityp2kjHortqNX42ps/dU+02x3SxMatsRTPul75yg9I9E4/E9i7XLNvw2
	5T5lEqEd/Senzu3XrDU7sljBuymIpCaMvSm/r9lWTphLf2C9jptM03Erw5bLsMyQFr5wal/6Ejt
	HimJakMIWIRcuODZ8q4onBFbi7cdvGdd1vDSdLzeE5CD+o
X-Received: by 2002:a05:600c:1d18:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-48a84459207mr2787985e9.22.1777495995617;
        Wed, 29 Apr 2026 13:53:15 -0700 (PDT)
Received: from precision ([2a01:4b00:c007:bb00:be9d:a3c4:18b1:4a25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de3269b41sm3925240c88.13.2026.04.29.13.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 13:53:14 -0700 (PDT)
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
Subject: [PATCH 3/3] smb: client: make smb3_update_ses_channels() match expected API
Date: Wed, 29 Apr 2026 17:52:36 -0300
Message-ID: <20260429205236.456099-3-henrique.carvalho@suse.com>
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
X-Rspamd-Queue-Id: D8A6249A44B
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
	TAGGED_FROM(0.00)[bounces-241943-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]

smb3_update_ses_channels() was introduced with a 0-or-errno API, but
could return a positive channel count when growing channels. Existing
reconnect paths mostly tolerated this, but newer callers can treat it as
failure.

Normalize positive return values from cifs_try_adding_channels() to 0 so
smb3_update_ses_channels() follows the expected API used by its callers.

Fixes: ef529f655a2c ("cifs: client: allow changing multichannel mount options on remount")
Cc: stable@vger.kernel.org
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/smb2pdu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index cb61051f9af3..9eb7c16407cc 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -236,9 +236,11 @@ int smb3_update_ses_channels(struct cifs_ses *ses, struct TCP_Server_Info *serve
 	if (disable_mchan)
 		rc = cifs_chan_skip_or_disable(ses, server, from_reconnect, disable_mchan);
 	else {
-		if (ses->chan_count < ses->chan_max)
+		if (ses->chan_count < ses->chan_max) {
 			rc = cifs_try_adding_channels(ses);
-		else if (ses->chan_count > ses->chan_max)
+			if (rc > 0)
+				rc = 0;
+		} else if (ses->chan_count > ses->chan_max)
 			rc = cifs_chan_skip_or_disable(ses, server, from_reconnect, disable_mchan);
 	}
 
-- 
2.53.0


