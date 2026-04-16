Return-Path: <stable+bounces-238241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE+aE0JV4Gl5fAAAu9opvQ
	(envelope-from <stable+bounces-238241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 05:19:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C43409E67
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 05:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BBB43061272
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 03:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3117282F18;
	Thu, 16 Apr 2026 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaPreFgq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1F1F16B
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776309563; cv=none; b=EZVbx+1VpcMHmiqU/BLhwk8UQ7XxKc05YmOO2SX2hUrXOeS7fm1FbvWOpsoqA9+lpGYkmUQM3fSjanL+q8meGdcgTtBDw237L2fm4IqTnmaR/wWPzTkfjIlgf9OgrCGtmb+zgmXdUnUbkw5yXcvFE48aaXL4erKL8iGWfis4gxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776309563; c=relaxed/simple;
	bh=6gffQwVrZbWmmoZmS6ntD3kXVEXf3L650/1kWkyePIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYgGBY1J8sKtuS/q2u9wlL6mVzbqOWH+ztarmoGpRmpGHPy0oaNr2Y/4IlBdiWOKHpDunCccS1iTI2LZRguxp+6s8jm2QZ2t9zxxQ5T5k/2vmWj6LxX+JSYL5HmEfyUiSHh6YlBYkAUG2jbMmFhMVRm8BgKQ4Q/tyP0ewlQLfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaPreFgq; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d6d5e45c43so908901985a.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 20:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776309560; x=1776914360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgBzs6EKzyDLWZ+aqE87/ScBh1gHb7gMVIBVANVXsG8=;
        b=VaPreFgqvH6YxdHi7lpfMyQ8zQHsFSai9T1koCoIkNPxbjCkYMK/NNaRkJYWC79mpk
         XcU29drJP427G9fYkn0q/U7P5v51t3MNzKYGskE2ShwIvZ464bXMlVzg3WbrD5s5qo4r
         iuuZQHh2EufS1CQIiGqyNnk+de0K5c6DIjsbcaBAuVRJ3Lq4IPM/hwcUuyQn8dNpC0zv
         eZfFRpzS4DWJX2PRsr13c6Gs5fOECcA9vmzjq5lvqMX8U0julgXQqm1NzJl1ph1ShERi
         BpbMxDgN30zBimN6LircLEgTNU98k+Lw58NB7poGNl/Dzna8dYplLnG3U24w0bJYiboR
         Lv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776309560; x=1776914360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgBzs6EKzyDLWZ+aqE87/ScBh1gHb7gMVIBVANVXsG8=;
        b=KYBYRwqia4JFCVqqZoL+/Xm+Sf2ufaYR9DMNO60lUtUinmaJZzpLZ5NVltpL9mxSW0
         Jt1WgLbZkIQL0YVQF08N4aiz9pM30ORkF0M1Hea7LGWKCtEZJjmEvWtjsjun9MjfZ92+
         aeXkRc0eyYW9iP75trRmp+rw6uQZzbccnxlfCtDL1loPbai2QJO9TMblvb9f7x11xZqO
         yw1aH0rn9gQcCv50ubh2Q4ppi5JKvKeFSm1UYxNpsRyOWh7lYuZxdYIgxtdoCnalnKYQ
         EBIJUWyCwi522nPWxKKcD4lbjz/QWRmtlZQ/Jj029doYCLavrXiF87nlxGdw1yj/vPe0
         iaxA==
X-Forwarded-Encrypted: i=1; AFNElJ9vZL+L3YTURMrUCRC6qzs2ptdJfgX4N+xAwEjlrUgWU1DOmticpRFsK5vmkuDobAOrFNc1zBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYXaPSgHSsxmphtclWhJ9Lsdgs6u7nYzVcMT91d+QgHan+TDe
	uOmYzvivqr9yX33Cg6xoKkfnJFupk41LZ41AdtZtDlT278Bfp/W8tx82
X-Gm-Gg: AeBDiev+rne4bRS78zvWHjACWiKSM7XlDJLcIKM6zG5IPG7jRrO6lhcyOqabxYajmkw
	AeN6ACieVzytLccxHVjtqWDI8kfXCy2hw/zPtj/9byPLc5ZxFI2QKAfSV9Yft09hSpKwsz3Y4av
	FKkBcpi4ZuofvHhgpHreRvFecy2kdNd65nQS/2o452TOVUfwvQnIHIZZL0Q7jkTb4F9GUaFiMc/
	3qCE7FD7OtK5W179JVlfjQRXNllqjRqtc/Zh0SmmYszXixx/6nP/4uMW9y7Z0H78Wzam6BAOTwd
	GoLEUByjCFP0sLJNqwqA7PmwKz5L7gf3aJ1fmVCS+apeIhacLt3E4XIjsbuxHxtWqW9K17aZNML
	S13hgpecLTPMdBUdJEJRghTgD7VvmddRhiprhbXdMxrrtp+/gS/cNtPYZxaPjYArP6PnGnGi6g/
	3bj2NzR6wC+UTw+9fcxYBmInvS8Bb9dFGMNhaLGfIjdfT4XczRdPv47nZs1hzByeL9nMhaJWg6B
	2betELO0nXDEOwMIb6w4vQwJqkj99XYH5LaRdsc5ZN4tSa08OkT3Q==
X-Received: by 2002:a05:620a:29d1:b0:8dc:eca0:35bd with SMTP id af79cd13be357-8ddcd11942bmr3421071185a.5.1776309560487;
        Wed, 15 Apr 2026 20:19:20 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4eed6eef3sm297805585a.2.2026.04.15.20.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 20:19:19 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-sctp@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
Date: Wed, 15 Apr 2026 23:19:03 -0400
Message-ID: <20260416031903.1447072-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238241-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36C43409E67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sctp_getsockopt_peer_auth_chunks() checks that the caller's optval
buffer is large enough for the peer AUTH chunk list with

    if (len < num_chunks)
            return -EINVAL;

but then writes num_chunks bytes to p->gauth_chunks, which lives
at offset offsetof(struct sctp_authchunks, gauth_chunks) == 8
inside optval.  The check is missing the sizeof(struct
sctp_authchunks) = 8-byte header.  When the caller supplies
len == num_chunks (for any num_chunks > 0) the test passes but
copy_to_user() writes sizeof(struct sctp_authchunks) = 8 bytes
past the declared buffer.

The sibling function sctp_getsockopt_local_auth_chunks() at the
next line already has the correct check:

    if (len < sizeof(struct sctp_authchunks) + num_chunks)
            return -EINVAL;

Align the peer variant with its sibling.

Reproducer confirms on v7.0-13-generic: an unprivileged userspace
caller that opens a loopback SCTP association with AUTH enabled,
queries num_chunks with a short optval, then issues the real
getsockopt with len == num_chunks and sentinel bytes painted past
the buffer observes those sentinel bytes overwritten with the
peer's AUTH chunk type.  The bytes written are under the peer's
control but land in the caller's own userspace; this is not a
kernel memory corruption, but it is a kernel-side contract
violation that can silently corrupt adjacent userspace data.

Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/sctp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 05fb00c9c335..f5d442753dc9 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7033,7 +7033,7 @@ static int sctp_getsockopt_peer_auth_chunks(struct sock *sk, int len,
 
 	/* See if the user provided enough room for all the data */
 	num_chunks = ntohs(ch->param_hdr.length) - sizeof(struct sctp_paramhdr);
-	if (len < num_chunks)
+	if (len < sizeof(struct sctp_authchunks) + num_chunks)
 		return -EINVAL;
 
 	if (copy_to_user(to, ch->chunks, num_chunks))
-- 
2.53.0


