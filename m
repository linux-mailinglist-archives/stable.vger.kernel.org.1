Return-Path: <stable+bounces-254235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJBlJQ8DFWroSAcAu9opvQ
	(envelope-from <stable+bounces-254235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:18:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B4C5CFCBD
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9CF9300FEFE
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 02:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B963C2F0C62;
	Tue, 26 May 2026 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJyEA+Fu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287BA287259
	for <stable@vger.kernel.org>; Tue, 26 May 2026 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779761914; cv=none; b=C1swsZywlqx4kWJqhwXWCWxwreoPYaVb2ed8+Q6Yb1UsCrFrfgJulHPKSuSi6Nzpp/MWcOFQ0CPvMCMLgyoyN5xSP0spqCCMLXDQ/d39H5zBtdPRG0ICLNtX4tRvMmWrDrEiLErbhwIYUtrli8Mh1VqPaOwvR6jkD7Fur5ba7TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779761914; c=relaxed/simple;
	bh=ugOr6h9qKSCXcCA2J2qmDK1c4p4CH4hY+NbjnHqvdDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1xOro1c7Fe5+J3DpDMutmhhPRsBZi0XkaCsAkXXbYBwtk1SfiIPxjWRi/mE+z3EKh4PVJswlM/1axVYtbGF0AseddN3rkRIHUXF4gXYigsERRKk5eRyLhE941MJbI2SA45twU7x307qS9fciANcOZWpIXtBq2aUP0KgeXtn4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJyEA+Fu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bc763e2ba8so50468125ad.3
        for <stable@vger.kernel.org>; Mon, 25 May 2026 19:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779761912; x=1780366712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xaHr4apjjXax6lzaZFsAAU5p0KUItY7eRXmilQ6CXh4=;
        b=RJyEA+FuwvFylfdlVWo6rFpJ71bFbR3ViQf4j6KV69Sg6pCf+oUtwihhm8XTdJP/5t
         apeT0x2wQxiuIkMLZLQSfOARMNqVHpFKmiFZjyPSX9z2zoOSeMMV43eQUkPBBNCdePLN
         N0NjVzJrQ2zPsw+Jb9vr5UV+iBJj7WZpa4KddUqPbNYOFQS8erAj5+j4Uw8iYVLjBH5M
         R/lI/J4oC9tK5F3YWUwJ93kGbpdmeHzDOtbuBYq1fYNEkOm2SQG9+9RcXL6TxpLrkBeS
         xr+iUimqIUxYNT1XvKLf3thnkLZmNH0ZQ+t/q/ksqoBc1LTkvSC4xAMzyYDiJvGF/A1Z
         0NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779761912; x=1780366712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaHr4apjjXax6lzaZFsAAU5p0KUItY7eRXmilQ6CXh4=;
        b=SKDAMiW/U7jdCIaQmwJwLHtEXNKDlmUyi5GfgpyVXGy3wrzxHgU5ur3k2JUSPs0mzu
         OKMXBqkw0eK+m2bwzypDPw+mWQv3qMJbZsOcCdyRrYaJfLSFc7yWIE5GwBXbsLDUaI3o
         cCb0HEoFBnbNdXPtA5NxDtXjPg69+h61gj+5LmnOYbmPVXxgU2a4HVWtEvDrX7r5TJfD
         tu1HVdECtBFpOAHvuQEHNQ2YB0lqUu5KlyiH7NL42uf6dT+tmZRDhg1dLpnH0J8eXnEI
         Lt2df/3kb0ssF4YJuX6jC8MomXT9Z0fGRjX1oXqYwEYDHeQi6zV1wB5C8XCykyXvJ1Ub
         ePxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BEf1iWEXXP9Aq+F9e0qv/kH4aIfsjDj+suQ8KztmLiJrK2F5XmFvSMm0OH2G50920cR9ACZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxNgJwhD43TBndHIiygMemQTjDMZ5lH+FcAojKrdEvOTValq6
	XMkllPDCpdYythHS6+UDPezo+CboNgDlI5HOM6gsWi9mMgFYFJbE2oJ/
X-Gm-Gg: Acq92OGmiKBORjpa3eguB264Sj4bYkJ5uHkzPSbb81ytLBkCzaSqfnNSItWe+fs72nC
	Mveil2FN1mR+7T4Yc4PaFv6S3AoVK2LJT/pRPEgEd0rupbeol1q/XVMYGfyA1GvPCjKKsblT46M
	D2WKhb2gKYO6/vdMaRSqD8QEHgH/71viz0jS4u+4QNqqZRMujYZGKcbHxsb1R0UOxpIFA8vhlF9
	Bdth0oE+xNCb+hBOzVraoEfKjr6f+Km6WjLXH1zlYkOQMuhghscI3ZMmoAmK1/GEjaEw0ax2lmK
	wDOW1m8auPLnxq90DuCwvSFvjCYml5U7kMDwWH1Q6BHXO5Cqh+dd8phzm1a/G0M2YKWz4sFpOC9
	R5EskeeUpX0lEy8LpD84aByJ74Dh/bH3AEPyya3uIjwI/y3TkXrHjJYiJGCNahEje6sqBuHkwQ+
	3yWtrknUB4T/Oi2fe2b6+Ud9sY1Id3Uonhd+U7Ig4VwR35o0lF6aWRmbExZvcUn5icgwx9q5ZhK
	iuDCpHvw3Tv5KKnqBRY+Lp765MRq+Cn2RJ+22jajjeILZ4vVAsLEuGA5wFpvyHZxVkAgiDZIFc0
	PF3aBleRpsVOR0c=
X-Received: by 2002:a17:903:196b:b0:2ba:6ebe:4897 with SMTP id d9443c01a7336-2beb069a893mr171232725ad.3.1779761912481;
        Mon, 25 May 2026 19:18:32 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb591d07fsm112242735ad.82.2026.05.25.19.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 19:18:32 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	johan.hedberg@intel.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] Bluetooth: L2CAP: fix heap over-read in l2cap_get_conf_opt
Date: Tue, 26 May 2026 02:17:47 +0000
Message-ID: <20260526021747.31634-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254235-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,linuxfoundation.org,intel.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 00B4C5CFCBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

l2cap_get_conf_opt() reads opt->val via a switch on opt->len (1, 2,
or 4 bytes).  opt->len is a remote-controlled u8.  All three callers
loop on (len >= L2CAP_CONF_OPT_SIZE), so the loop body executes with
as few as 2 bytes remaining.  A packet ending with opt->len=4 and
only 2 bytes left causes get_unaligned_le32(opt->val) to read 4 bytes
past the buffer before the caller can act on the return value.

Commit 7c9cbd0b5e38 ("Bluetooth: Verify that l2cap_get_conf_opt
provides large enough buffer") added a post-call len < 0 guard in
each caller, but the over-read fires inside l2cap_get_conf_opt()
before that guard is reached.

Add a buflen parameter and validate L2CAP_CONF_OPT_SIZE + opt->len
<= buflen before any access to opt->val.  Return -EINVAL on
violation.  Update all three callers to capture the return value and
break on negative.  With the bounds check ensuring the option fits
within the remaining buffer, the post-call len < 0 check is no
longer needed and is removed.

Fixes: 7c9cbd0b5e38 ("Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/l2cap_core.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fdccd62ccca8..6052ffb280ac 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3051,12 +3051,23 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn, u8 code,
 }
 
 static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen,
-				     unsigned long *val)
+				     unsigned long *val, size_t buflen)
 {
 	struct l2cap_conf_opt *opt = *ptr;
 	int len;
 
+	/* Guard opt->len dereference: reject if the 2-byte option header
+	 * itself does not fit in the remaining buffer.
+	 */
+	if (buflen < L2CAP_CONF_OPT_SIZE)
+		return -EINVAL;
+
 	len = L2CAP_CONF_OPT_SIZE + opt->len;
+
+	/* Reject options whose payload extends past the remaining buffer. */
+	if ((size_t)len > buflen)
+		return -EINVAL;
+
 	*ptr += len;
 
 	*type = opt->type;
@@ -3437,9 +3448,11 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	BT_DBG("chan %p", chan);
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
-		if (len < 0)
+		int optlen = l2cap_get_conf_opt(&req, &type, &olen, &val, len);
+
+		if (optlen < 0)
 			break;
+		len -= optlen;
 
 		hint  = type & L2CAP_CONF_HINT;
 		type &= L2CAP_CONF_MASK;
@@ -3675,9 +3688,11 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
-		if (len < 0)
+		int optlen = l2cap_get_conf_opt(&rsp, &type, &olen, &val, len);
+
+		if (optlen < 0)
 			break;
+		len -= optlen;
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
@@ -3946,9 +3961,11 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 		return;
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
-		if (len < 0)
+		int optlen = l2cap_get_conf_opt(&rsp, &type, &olen, &val, len);
+
+		if (optlen < 0)
 			break;
+		len -= optlen;
 
 		switch (type) {
 		case L2CAP_CONF_RFC:
-- 
2.53.0


