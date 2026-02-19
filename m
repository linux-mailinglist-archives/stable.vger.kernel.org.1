Return-Path: <stable+bounces-217499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMnuMqBtl2nxyQIAu9opvQ
	(envelope-from <stable+bounces-217499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:08:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B471623D5
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BA74301A2FB
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 20:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63A5304BDF;
	Thu, 19 Feb 2026 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmqO1imb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE830DD3B
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771531664; cv=none; b=QQ5GZ8kMDRF80y/0T9UGFsRMTaHpEuc/cku7DsqLHH8aifNKknyXtGQ2CzX3cffta5Ym7wbIBE+WU41JIpewe2HK+PaYI3grYZTy5MinA2Hmltloxq2+c6N3kAZTTZu5yHDA7XD0dEzCfFRJ3cH9qctNsDe/48VTeiAh9mZrgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771531664; c=relaxed/simple;
	bh=4hKDGUDaKLhwYa10wo2QUB1w2/7YI/N2c1XW+iZG8HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJqZhZvVFE5BlVKkgpcWZv13/Q6XjlyGC8KkpSSmubJ75FJRZkb2GxfC6mDZd6jOkPDA0K1OuFYjYuNKh/Ah+yDqLEAhAscIfC/a9gSFwHO523AHSoAR56aadMzqNLc5dIZSS8Brt64Cmz+suhkJ+h7KhwGvjxh5/0B+xQqrx3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmqO1imb; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7950881727cso9660197b3.3
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 12:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771531658; x=1772136458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/qmzM+i4dYpgByb8fBfDVhdvTlZELGZrVQkv0zNaF9U=;
        b=lmqO1imbRIlo79Y9c90FVho2utTjZJQIdRzOHniaQM8FskebgEI4dwQ2qK6W9ew/YY
         TrmZv0HXIYr8kGiDvJQ3FZJqbblCKMFryGZTo9TP6765CQ3gf6PLMXWKFuBuiq/XTuHL
         SowL8LfohVNlVlzGgZxiTwb1fSp3G5iRloRUJUCIdIOtbrnS3N48pdQ0aFU22sEEbLbs
         2RUaNwGV5Lh0pRuOa4jCxalBPMgeZ7Vd3qlVHY0pHyfZpAHaTEjLIP64rUZty27mOmZo
         fqNYEP13hjG6HQKpSv/kF5et9V3HXhaimnohpW/tVqGSr3G0/T1f230s1xgGNZ+EAAdP
         J60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771531658; x=1772136458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qmzM+i4dYpgByb8fBfDVhdvTlZELGZrVQkv0zNaF9U=;
        b=GSo2MxzbqDY3HPi8WKNyocfBJvere8veGSncie/6g8tbsAoy7ItbZLvdqKlfVLzYaR
         Q3Hg3MWi1VSr4+fITnMuHwJ0P6ILfvPFgJH4sLZaYRAWIoCwS1P+kEjlEeVSuuuv7i5V
         IoMG3P+IRNvtrit50PHJmsEgdVU/VjSZxoEWDMYDiK9euStWbT7aIWJYz0RfKZxE4g3G
         80sW4/2d9gyTbVpnVdhOOf1mwmCPJOzyV830+t3OZkbqSyT2Ka6JoFuaqGHWnbu0k43F
         0ryJD8EVFoybTQIbODNAO1Xa2NTJCY9JxCfqkkpSIxHIg/SqpzrYJ4EjMNgbUNn+bzZa
         kK1w==
X-Forwarded-Encrypted: i=1; AJvYcCWhul5q9PGNxeceKDQiWLC7NpWWbX6VC2VGTD3VQps0AOTt/zrAbx1ZxrSeQBPevajAqRIqyMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQIUdEwkUHf3iK0sdUqeQl7mLkwrAFaV+/l7n5HzU5rWsN9S6
	4sPxa8/6YQN4qZdP48nfhghdFVIG619Ao+YnsSLcVp+54AvXZMT/SRBl
X-Gm-Gg: AZuq6aIfgBBomtl0htc5GCR4ZJY+YhhVj7hA/MM5XypG2zhAqAc6aNFwJzFpU3rI3vz
	hnFwTf9iBFOhD5NNG+pe5J4Yh3z6c/IhHxEN2lP3JQw+PRvbNz9NkcxoS8r7wbY0W21mp4SXXfX
	bX+pWeUOFFPHmnviww81V5yEmzJTB8oA8TtddqiOU4wzBeZqT34Ia7caOkvgYOhy7WNgwJ+Nkfb
	+eaFvtYOaw3xJ+5t8Fw0wNA1C+9ePgBf0EbJLlEjiSXZ+0OInKHQb25yk46HbVZT+qb2u3RlBIc
	pFYUxgndoUhRdASlvpuw7A9K0puTbx3V/MiU/bE4p8pFnBnORHgB4xqZIj6tE9sfzRtfwwlJgs3
	tZ0P0ZOIRbEAxDta0QZfvpM4v2Yl6o1p5JTVyqGZ32EGcQMOm+pUR41C6/tRCoUmQ9zLlTSfZhH
	DASN8S+ugqbcDY0mG6k3V4h+XCpPRlsw1Ne/aIIS+osZZ3GET2gw1UwzJhcB5ViCwLqWZeQhkQ5
	pQwG3TkgVXVECiffEZg39yoRV+mFqOWalb0mfPv5Lg=
X-Received: by 2002:a05:690c:6612:b0:796:4ab9:f29b with SMTP id 00721157ae682-797f7353b65mr48586537b3.39.1771531658458;
        Thu, 19 Feb 2026 12:07:38 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c2667f9sm138276567b3.46.2026.02.19.12.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:07:38 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: cem@kernel.org,
	djwong@kernel.org
Cc: nirjhar.roy.lists@gmail.com,
	neil@brown.name,
	brauner@kernel.org,
	jlayton@kernel.org,
	amir73il@gmail.com,
	jack@suse.cz,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] xfs: Fix error pointer dereference
Date: Thu, 19 Feb 2026 14:07:15 -0600
Message-ID: <20260219200715.785849-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,brown.name,kernel.org,suse.cz,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-217499-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88B471623D5
X-Rspamd-Action: no action

The function try_lookup_noperm() can return an error pointer and is not
checked for one.

Add checks for error pointer in xrep_adoption_check_dcache() and
xrep_adoption_zap_dcache().

Detected by Smatch:
fs/xfs/scrub/orphanage.c:449 xrep_adoption_check_dcache() error:
'd_child' dereferencing possible ERR_PTR()

fs/xfs/scrub/orphanage.c:485 xrep_adoption_zap_dcache() error:
'd_child' dereferencing possible ERR_PTR()

Fixes: 73597e3e42b4 ("xfs: ensure dentry consistency when the orphanage adopts a file")
Cc: <stable@vger.kernel.org> # v6.16
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v3:
- Add dput(d_orphanage) before returning error code in 
  xrep_adoption_check_dcache().
- Revert xrep_adoption_zap_dcache() change back to v1 version.
- Include function names where error pointer checks were added.
v2:
- Propagate the error back in xrep_adoption_check_dcache().
- Add Cc to stable.
- Add correct Fixes tag.

 fs/xfs/scrub/orphanage.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 52a108f6d5f4..682af1bcf131 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -442,6 +442,10 @@ xrep_adoption_check_dcache(
 		return 0;
 
 	d_child = try_lookup_noperm(&qname, d_orphanage);
+	if (IS_ERR(d_child)) {
+		dput(d_orphanage);
+		return PTR_ERR(d_child);
+	}
 	if (d_child) {
 		trace_xrep_adoption_check_child(sc->mp, d_child);
 
@@ -479,7 +483,7 @@ xrep_adoption_zap_dcache(
 		return;
 
 	d_child = try_lookup_noperm(&qname, d_orphanage);
-	while (d_child != NULL) {
+	while (!IS_ERR_OR_NULL(d_child)) {
 		trace_xrep_adoption_invalidate_child(sc->mp, d_child);
 
 		ASSERT(d_is_negative(d_child));
-- 
2.53.0


