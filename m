Return-Path: <stable+bounces-223077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAHxB3M+qGl6rQAAu9opvQ
	(envelope-from <stable+bounces-223077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 15:15:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9322C201242
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 15:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA90D31F666B
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442C03B4EBA;
	Wed,  4 Mar 2026 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLCiZyQh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1183BE14B
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633122; cv=none; b=LgFYeRJV3xmbgrE5K64En+XpCM494paM2TA/oHyvLXdkBm61rM7d6OInqkNpLlSVYUsg+BDhN8E2l6ipyFxb3RLzUsRjOQfV23ovH+j/tBGfYAn1EiFv4Lzqqj/RQdz8l22DB0vU39OwuWtGpifXUfNW9RRktzYKiCSz95aJoTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633122; c=relaxed/simple;
	bh=BW/nCNQi/Wwtq8VceluTVWZMpfy1RTkmPNQfQ4CSMX4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Zy5ZepkhcAKijZjNya3uluurhcYiES5oIJSvgV3ksYlEvFM8wlRsCqGw3EL9BY81okSuWPAxwFxWe8xFUu1sZIsQPig97BRJGU4xfURf4jLG/KIoyzWOCmiGdZ6wFNcIMH6Sq/UFoqLbweIXhe6fpNwOvbE9vcTTiDNwii1z3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLCiZyQh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35994d84c6dso1223148a91.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 06:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633120; x=1773237920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Drhy/JUcroGEZ7sou8Wymaklx4bBsa8tDfSu0E7JSNU=;
        b=TLCiZyQh6289c3qBuapXJreiC0O7/FJq9loLu+GA11pE/4BpFybdYYdmg5cQS3K9bE
         bsI5Wxl9LNyAYFvkLxBWcdXzdSpbUy5AHaFxkX1kWIqfTrv6y0Bj5RH5ShtLWiFNP1UF
         iGY4ag/es4PoyjApHyiVXHBtJvT8MYYEOHdznVAImlsQ2bo8L9iD2XwFRc4BD8euMO+U
         UkKAWyKw3n10ve1VrPmiIKguuJDUoL3WI+/2jPng2rKRkuE3oxDEXZ2Pq5i3TQSyLgUw
         LovtbUoLvuFFaxH+R6tGwWXWYOGLKBjGVVVDdnw+3d8Rvung3bPhACSnthe3CgNpL9tM
         PtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633120; x=1773237920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Drhy/JUcroGEZ7sou8Wymaklx4bBsa8tDfSu0E7JSNU=;
        b=lYawSixEuZgAOfRFH520iELlDq/oUeRFEYnZMtK0vU5JyspCu8mbgqIQMWsxf01Sxm
         SUQR4JtFRh/b9mdyofs5LVpY9abQRepz2FccZqFVnVa/Ju47FQV0ODst3efzhkfoJJlO
         uBU4+wCylOa8yLdQkjJnNH07m19lVgtG7yS5D3peoNZaft2bVP5QUuhr0jckVtfvX0dA
         w6m0rs9j/sw1vhH081RWQfNJUFZzyefE3sYHrU63VsEk1KrybE71y+0hE9JnI5cG2LAJ
         y4F4D1J2fjFFhByA/z4ghu58hTNNJ8VM8EpJc6vMtGV4Q37p2LwEk2YbzlmAdahJwbib
         LAJA==
X-Forwarded-Encrypted: i=1; AJvYcCVOKPc/wwS0Q10HXdetROrz1fc/KE48on8TcODw9DyZakRlLQmop75Mo4gLxNN7nOspqL4DvYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+dOJ+jOHm93zGlyTYkM+xwuQOPLaBNQdX1OxLB6FcWiSfCFh
	1W0NUvwsb6kF68eW3OKu7wexCQrdZKxZeKTCCc5amlAfH4orRjJPoTem
X-Gm-Gg: ATEYQzy+Fno0Skchu18Lqhdvl2vN/JH88lpLD2QWd90b8Yks33DnEB/bybzTmGhYGQh
	t5xxwrLAN5VDvyBeI+2hYKfCxcdE/y59qD6UEMUS9/MpNMcDLUVl69i/SZZev3wU8p4RU26EOTA
	frIrEgJSgvVWTTI4oXKoVT0H/B+QNYPsSxA5QLt2p5VOHGP6NS31qenxhljy9CoLa9e9of6uhYF
	IJEHKXFp9d5ux1N5s+1LZAU+3zhxgfW4E5n70s9spwkdTF6zC8HN/6YURE3gNGpZz+KTAKb5Dc0
	IquVGpt7ZoKaduoU3vsO782m8OEFMGTUKlX7OOiVfG8az+sXHX53Xr3Fl5SvUAMLaCxPA+bVI9z
	a2r1aYxnXVGRfMvkMZlJ+Fz9dl4IeIfy46LWcgDmjjAyNQyGUUhb9GgSAE572no7IO57Jcn+Jyu
	jEcqorg87oMU94+tMAJ+ZQ7R0rhx9EcyowrgdDTFSIctLLW4nKgA==
X-Received: by 2002:a17:90b:3d50:b0:340:be44:dd0b with SMTP id 98e67ed59e1d1-359a6a7bcb5mr2156907a91.34.1772633120193;
        Wed, 04 Mar 2026 06:05:20 -0800 (PST)
Received: from bharathsm-Virtual-Machine.. ([167.220.110.53])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-359aa40c1bbsm451953a91.14.2026.03.04.06.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:05:19 -0800 (PST)
From: Bharath SM <bharathsm.hsk@gmail.com>
X-Google-Original-From: Bharath SM <bharathsm@microsoft.com>
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	dhowells@redhat.com,
	sprasad@microsoft.com,
	pc@manguebit.com,
	ematsumiya@suse.de,
	henrique.carvalho@suse.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 6.6.y] smb: client: fix page cache corruption from in-place encryption in SMB2_write
Date: Wed,  4 Mar 2026 19:34:52 +0530
Message-ID: <20260304140452.1606662-1-bharathsm@microsoft.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9322C201242
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-223077-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,redhat.com,microsoft.com,manguebit.com,suse.de,suse.com,linuxfoundation.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharathsmhsk@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

SMB2_write() passes data kvecs inline in rq_iov by setting
rqst.rq_nvec = n_vec + 1. When SMB3 encryption is negotiated,
smb3_init_transform_rq() -> crypt_message() encrypts data in the
kvec buffers in-place.

For synchronous writes through cifs_write(), the kvec buffers point
directly into the page cache via kmap(). In-place encryption overwrites
the page cache with ciphertext. If the send fails with a replayable
error such as -EAGAIN (e.g., from a connection reset), SMB2_write()
retries the write using the same iov[1] buffer. Since iov[1] now
contains ciphertext from the first attempt, the retry encrypts and
sends ciphertext-as-data to the server, resulting in data corruption.

The corruption is most likely to be observed when connections are
unstable, as reconnects trigger write retries that re-send the
already-encrypted page cache data.

The sync path can be reached during partial-page O_WRONLY writes when
the page is not in cache (common for append workloads with repeated
open/write/close patterns).

The async write path (smb2_async_writev) is not affected because it
passes data via rqst.rq_iter, which the encryption layer handles
without modifying the source buffers.

Fix by setting rq_nvec = 1 (header only) and moving data kvecs into
rq_iter via iov_iter_kvec().

Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Cc: stable@vger.kernel.org
---
 fs/smb/client/smb2pdu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index a8890ae21714..a88a19dec494 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5072,7 +5072,11 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 
 	memset(&rqst, 0, sizeof(struct smb_rqst));
 	rqst.rq_iov = iov;
-	rqst.rq_nvec = n_vec + 1;
+	rqst.rq_nvec = 1;
+	iov_iter_kvec(&rqst.rq_iter, ITER_SOURCE, &iov[1], n_vec,
+		      io_parms->length);
+	rqst.rq_iter_size = io_parms->length;
+
 
 	if (retries)
 		smb2_set_replay(server, &rqst);
-- 
2.45.4


