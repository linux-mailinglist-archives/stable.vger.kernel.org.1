Return-Path: <stable+bounces-247050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BIWMHYGBWqiRgIAu9opvQ
	(envelope-from <stable+bounces-247050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:17:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8074653BE2F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8719930323B7
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5973659E8;
	Wed, 13 May 2026 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il1vKm3s"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB41356763
	for <stable@vger.kernel.org>; Wed, 13 May 2026 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714133; cv=none; b=ACTJwesYHQd4lkWrSBw09rJTYZQDL2aDRYue2nGBfgRid0XghOtWQHAtgSXgv5fiTgJW4ajjiYUQyMCon6trQ1ILRF29Zloe5wxn2KDVMFjm29Gv3K3ln93Ncw54QNslRsZtMKLQH9kXpJFt1xxAZel9OJYXAQ4t1yFZihh3z88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714133; c=relaxed/simple;
	bh=OP6feStZGZdFFWZ14CThiMu8VdQOuHA2BR9V1ND4ff4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuPmsY/LxZLF0kVN8mQpjSbRR/7D3wUUB9K3KBwg0/+2TftiSwL73/VZ+LAfJvlgxxAWXSqgJlXfsLKCqjNgcKGpg+2EOr7yEovf8i9py0NDV9JWz8UurHLcb2z0x57p5NC2+9+CgGROoFP1xVGlFZ12YPhX9Mc9vGM0qgpv1xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il1vKm3s; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c2cd216c9so7599817d50.3
        for <stable@vger.kernel.org>; Wed, 13 May 2026 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778714131; x=1779318931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+tDo1tY/LI2PXPcsTmkqJ4CzUr5sNutShNSx1ijTlg=;
        b=il1vKm3s87qWg3Q/+fmMkDFFgnwteJmVQDgvTMevvl0MLcY9Apkl01e13T6YGrU4sy
         p3ULtJL16jeoUj+tjFwoYF3KBoCMH5IcuvKCNQtWHO8BoIkukJH45G5Q4QxfvGDE3+VK
         l7KoAOkW+xyd6tYyADjv401OAL2Q8lCLIYxQE9efufpC9z0jj5ZNleGqHhB1A3k8IYTz
         IeeCwxFC5q7QFaz0fVeSYnDVdI4lbmYcQCLDruBzQwEybMMNRcVourUOuZNTOE7c4Kk3
         dJmnCm/yB9rC3Iy8v48WemazFR2uum9Kz9rzliXQSQEoLCi3rnxNZaBUGLpFOtolUOy2
         ERVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778714131; x=1779318931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+tDo1tY/LI2PXPcsTmkqJ4CzUr5sNutShNSx1ijTlg=;
        b=kXKRUN/tWtLKmdPW3G7+KQ3bkQZCq+VdHLfGE5iZNDXGw0qOXYt+lUwWo8LjKuu9Ai
         FPv6SCVLnD4vfJwxrxKW49vXhGc/VwZ6qr3Ix8sDf9v2iYjtC74K6+GzF7oNc0R0TY06
         GbzLA9dCskDvm4kCjWcxl1+O2SjVJWGwGKewqdSTGLWKjgGT6FmPim2MOIFp8JAnBmbZ
         5OJnT/HlpvqM4ljVGNARWh7o85XIAZEKptUD8WnC2hpMZg18NkvEPnBAaDb7JHIrCzXR
         D/QB+Cz0XUVbEmVIIJHLDf0Kv7f7zGhWRcG79rNGApZr6QC+vemdLTBZ7aUz33WrjCR4
         oKVA==
X-Forwarded-Encrypted: i=1; AFNElJ/rEin8q2GzPwdbWG1IdZ1QmjROmsOtQWeMk9Tyh9ZqFKQGpQluqFjatQWaDmYZLXYK/R9+XoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UtQzbnbH1pcf6GWgNXseHVQdWGLqi7A5J6/ksE9a+pNfkiaa
	E7gwWJVClxHP8ew4Y9mjE49BIiBsMHmHS7nEj2NjIqdNt5E/FDi+Sa9z
X-Gm-Gg: Acq92OFoEigbSpvvXAQDJvDYARGi+44EGEV3SjdwypbYOLoYDliR9IpuNMnZdE635IL
	hF9Wcu2eqFUPfcAHNTCAusJ8/j5KuNMco5hSPFDoe17yGqZWKu0kBz0sLF+sxkV+hmI5P8EpmJb
	nrjISd2I+H1KzQfA+QilQ3G92SfQEDaLfK68kZZyfNl7qODg36L6qjOCxDUzIqxp/JIP/thrknR
	fQx2YKtrsF765wwKyThyD/2dUahnfRW0CK4teuuN2rq5+en4GhmxOldUho57EDAoxXDu+eYlp0J
	dcCb7DwOeiW7l3ZAX3Smmtb5sWDjPi2OI4m7vNfIF6XQIEC7RRfwJ5GpWKTwPX+QR28cv0AQvyB
	7/2F2N20MEHKGyial/+1dqrZH2dd8LKyM1FpBlt5WhxEwIBxNA+FuBIOtaMibK8SqyGvnNA6V9E
	/cq0rKaty7Qsb4mDA+L9JS
X-Received: by 2002:a05:690e:4808:b0:65c:1df4:545f with SMTP id 956f58d0204a3-65df63468admr4097359d50.47.1778714131098;
        Wed, 13 May 2026 16:15:31 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:50::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0dbd101asm254164d50.19.2026.05.13.16.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:15:30 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	fuse-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2] fuse: use copy_splice_read() for FOPEN_DIRECT_IO splice read
Date: Wed, 13 May 2026 16:14:37 -0700
Message-ID: <20260513231437.1806724-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8074653BE2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247050-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When FOPEN_DIRECT_IO is set, fuse_splice_read() calls
filemap_splice_read(), which populates the pipe with pages from the fuse
inode's page cache.

This is incorrect for files opened with FOPEN_DIRECT_IO, where reads
should fetch fresh data from the server rather than using cached (and
potentially stale) data.

Use copy_splice_read() instead, which will invoke ->read_iter() on each
splice read, sending a FUSE_READ to the server every time.

We do not need to add checking for O_DIRECT since this is already
handled at the vfs layer in do_splice_read().

Fixes: 2cb1e08985e3 ("splice: Use filemap_splice_read() instead of generic_file_splice_read()")
Cc: stable@vger.kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
v1 -> v2: 
- Reword commit message to be more accurate, per Amir's feedback

v1: https://lore.kernel.org/fuse-devel/20260512200448.3818665-1-joannelkoong@gmail.com/
---
 fs/fuse/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b8fd148dc109..7a35ac3e0023 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1858,7 +1858,9 @@ static ssize_t fuse_splice_read(struct file *in, loff_t *ppos,
 	struct fuse_file *ff = in->private_data;
 
 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
-	if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
+	if (ff->open_flags & FOPEN_DIRECT_IO)
+		return copy_splice_read(in, ppos, pipe, len, flags);
+	else if (fuse_file_passthrough(ff))
 		return fuse_passthrough_splice_read(in, ppos, pipe, len, flags);
 	else
 		return filemap_splice_read(in, ppos, pipe, len, flags);
-- 
2.52.0


