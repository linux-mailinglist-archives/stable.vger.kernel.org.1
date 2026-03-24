Return-Path: <stable+bounces-230188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHjwMVauwmkyggQAu9opvQ
	(envelope-from <stable+bounces-230188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:31:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9DD318108
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDAA8308761D
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439E4406264;
	Tue, 24 Mar 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELwz1qWX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7A4405ADC
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365746; cv=none; b=XZy6Xdl5TadnqbirRHA5itwixjrtOhUe47EnWrsg6V4aokqdbtO2I/mb3NtpbG2yrTIbpiXZ9E6cor86Bh6lMH1P75jAdfx2LGOEk71wwjT/H0sRlqlrBf+GEDSg1wmiFVZdLDXlzMXCZvz8Pd/E88Yda4O/s564CShAGedL5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365746; c=relaxed/simple;
	bh=UqgJUUtHXG46FtoCy5D841b1snD2nAdDFGbSknd5iH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRJsJ4z1YS8mYZh8s0uVlVAUUtVCOkIeowBRygHkZ5HXPCYN9BLnveM/VEBWfry+GMtLyg+6p7Fl3qt8cNiXKiBMl7cuTZASL8kkxp7/DtApaz5KfUyEdGy5Gfb1x6y5q8gBvWNcct+DE8ItWFIgYTOa5b5W0VKPhSFdDY02gT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELwz1qWX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9382e59c0eso660957766b.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774365743; x=1774970543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYDGorIwTYZxMzwCVryBDkbvpbGzwymfm8qqa+jq02o=;
        b=ELwz1qWXDSltHjhxKl+aEruLhIIEZgoF+BxE09nO0V2qIc3GEJDbrogxw+KXGcRkLX
         iRFHl4MD/j0loD8gy5izeF37YctlclVas88Ju6c0Fu2JOEKoV/yeMTtv4uaqXd9Ftyy2
         ek+1m3kkyF+9bhkSGwg6Ttw1FbvvFK4FMXYEtsYpzGhzvmHarlGIcyC7zmfwhcXuv3ls
         4oe/hwCGV2/ibbnxPqciJtIs8NFXhKK9RTxxnSx7hmYfCKvp+fn3yuMsnGpDe4OC43Pc
         J3nveypa3KbuuoItO8fhqCHS0SAJ53Gtdk6331qPq75zXwVYBagm9mbSI8f77uaXAw7l
         1cXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365743; x=1774970543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYDGorIwTYZxMzwCVryBDkbvpbGzwymfm8qqa+jq02o=;
        b=Daj2Smxgu9eWsK/t2saNLm9Ip6NwNrVDtRx5ttZ2QpxDXUFwah7nHnGei9wpJyxpzS
         Zge74A7fUIR/2W253OBDa411kXIga+Ym1EgN+HRLK9Wd04N14jasFc0oO1Kecbcgk/en
         ItTsp6t8Os2ii43bqqIVdhPlS3kxOW+cujGun/W4eXVyqmTrjCSXmglsTh8n/G8JTw7/
         Ngt2lVq6n4mnOyEUeUyi5mjscqPdNsoYCMqBhH3iWdCw8UZOK/eOjRpiQXYeUZrLIkjK
         x4KFW29XQRvOMur/zE2Xe86z+iFzFyv4ObxIgc6uyfHLoP9SeWYfRVhtzMvayOkdxjCX
         BL/A==
X-Forwarded-Encrypted: i=1; AJvYcCWnEmidiiJjrVl9H67BlcPBMGrm9kqIIh76J/W/HMZ3qtgNsy1zPvx4fxffalY+daBNC7XunVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wMwK73c6S9lIOAPMtIV4J6Dm+/qkki3j64J5l1cql5l9QrX4
	3g99erRE/jlXjrJRTzN1a4E+RPUNGiTF3p1DU6U4L1jlwX3U0XTPESCwBli2HZ/W
X-Gm-Gg: ATEYQzxQC8Ph3TuXJnw63CLrmwg3AaseKBIkMtMuDs5gYteOIycdeqsjdcEirVxuF4i
	dou+sNoQopOGtCxTUyLE28rekP/lXytvCTAwnNYxi+y6R72L73EqwGY/+FJO1HuBc+6eIWwnCY/
	XgAvR9enbzkUd8kuphiub5MROqBYWhcKjq75YU1OHunmkofiBGBbpEHxcNLrjfbw4VUFprOjqoZ
	X4T+mV2Xzl2iv0iBQEhTb6+qvbbG/+R1HGCOS05yltFGgb8DkETvtzh8D0uULZGw4iD7KmvVGB3
	oK0uSZQZwrb4pl4V4lzqLK+Tg6th0InayPRNw9LcaDwVGRcKCgtQ7mDS7tHBCMTUGtpjtAX5I1o
	AYPUKvsqDCZ/PCZDE3lqVtBNT5GiEA8W+iDJ1XHXKw+pqI418Xj9fADpHWHpBcEJobCaU30FMS8
	0mCwI7TZ/PnQeU9hMGmQ5zU9bcronIAJqCKNoryrI6OeCioWm2YkRGopQ9n1JSO5zqReeuAa7D/
	NWE/UkbpsHvwnKTY32elvmOHqVB
X-Received: by 2002:a17:907:3da7:b0:b97:b45e:785 with SMTP id a640c23a62f3a-b98453e7ef1mr1023339466b.6.1774365742586;
        Tue, 24 Mar 2026 08:22:22 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-4ce2-3481-21c7-16a7.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:4ce2:3481:21c7:16a7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983387085fsm661023466b.52.2026.03.24.08.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:22:22 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ovl: fix wrong detection of 32bit inode numbers
Date: Tue, 24 Mar 2026 16:22:21 +0100
Message-ID: <20260324152221.96677-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230188-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B9DD318108
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The implicit FILEID_INO32_GEN encoder was changed to be explicit,
so we need to fix the detection.

When mounting overlayfs with upperdir and lowerdir on different ext4
filesystems, the expected kmsg log is:

  overlayfs: "xino" feature enabled using 32 upper inode bits.

But instead, since the regressing commit, the kmsg log was:

  overlayfs: "xino" feature enabled using 2 upper inode bits.

Fixes: e21fc2038c1b9 ("exportfs: make ->encode_fh() a mandatory method for NFS export")
Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

I have queued up this fix.
The regression has no serious impact on most users, because xino
works pretty well either way.

A nested overlayfs, where the lower overlayfs is nonsamefs ext4
would have less xino overflows, but this is a very corner case.

Thanks,
Amir.

 fs/overlayfs/util.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 3f1b763a8bb4c..2ea769f311c34 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -85,7 +85,10 @@ int ovl_can_decode_fh(struct super_block *sb)
 	if (!exportfs_can_decode_fh(sb->s_export_op))
 		return 0;
 
-	return sb->s_export_op->encode_fh ? -1 : FILEID_INO32_GEN;
+	if (sb->s_export_op->encode_fh == generic_encode_ino32_fh)
+		return FILEID_INO32_GEN;
+
+	return -1;
 }
 
 struct dentry *ovl_indexdir(struct super_block *sb)
-- 
2.53.0


