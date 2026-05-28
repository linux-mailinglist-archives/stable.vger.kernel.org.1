Return-Path: <stable+bounces-254981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL1YCxZDGGoEiAgAu9opvQ
	(envelope-from <stable+bounces-254981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:28:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB7B5F2B7C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7229301876B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179C13E63AA;
	Thu, 28 May 2026 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBNDvI4V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A23375C5
	for <stable@vger.kernel.org>; Thu, 28 May 2026 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974763; cv=none; b=MBrVhvQ4+6LIcficZb/bXesgjU0cyLAZdh00fUluvcTq6W97rfH0jgVFjCU90TTAdr/tab8S7IiXGUu6GRIMbYDJptl5ReYxZL4k82lXzOFSX/SqvHwf9m+cn9Hjzsx7cA+HXdcn+NW7wYks+PPXDJQmT3q0SR/XOeQjIUABV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974763; c=relaxed/simple;
	bh=QUR06i/oLQGVwvHm5+5o0AEps5inWNG8u6llh7dN7sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVoUUR81jc0R4NztMTZ1d/y/2+Qm0kCLWARfTRRHOCDvfoIjMe2Wv3m4ZUWcrlqixmz936217SrdoqEmLGbHtVzGboZrbYP3ae906GH8VPA/u2MoiAEAm5QdTFGr1maKQ9fVe1yWHtlZ9JDAvw97TyNoaYJsAhJwzBg1XyveX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBNDvI4V; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf13af8405so118365ad.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779974762; x=1780579562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97b/ycKTWwDTGkqz750uQ/lr8PRa7HdfY9OOwRMtKcU=;
        b=cBNDvI4Vku9FaY2eMyqfilpEjG3e9WSgUIXkIErdKp/QAynmvwqe8PpWn6jHMNj3ST
         R84nkQIR3to7giUUyRqSg/mkngLhZcmpJL4N1XwmkDiZ76c8Mw/oI8e1uZ7jrmHJ6YdE
         CJu+94RHLHcjI5pAjom2aAdxvr99/DUYUDqTppCo6gHpq5tkbmpuzQLZljgd3lpg+EDY
         Hc2dqT62eE9NIWsEgfybtUJliAxwOhwmlQol6ipcbXiX6Tjc33muMyXLkDLljZ1rm3o5
         4UuiW+/aUfcX8MSQ+/cyMEz2UdO/rN+gvLJf21eMTC82ihiFHRoP7MWls4jtD7fE6ePG
         N/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974762; x=1780579562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=97b/ycKTWwDTGkqz750uQ/lr8PRa7HdfY9OOwRMtKcU=;
        b=ST6YE1XXGw1/FsaBeJD6f7gKI40QoTICAM/gvxEKAI9TfnQazRXFRO1DqeOrimJqTm
         ITawe1D8pdDeJtxUEDB/iDlvm6CQQ33rEqRhNQKZW+vm+lDexilOcQN0VdCnVWzljsy+
         2y8rKqhbGzZW+vLTkK8a0G84ismEbTMtyNUk61InKBWi7KgOhGYpnpWBOfn1XxJngS1R
         5tcbDduIihdRCr5+Ttt1eSyzMqBp0vL+FwR2aHhQv/88yJGZQ1eKqaTX1U/dIT1czQ2T
         jjQqGISP5xgWZQ1MZ6U8hozgHSUdm4eky5HOoX9RPpcpq8gS6zjuknsgpYc06jL+SEZ/
         LQFw==
X-Forwarded-Encrypted: i=1; AFNElJ/X38PEZzv/G7uh180a1yAdEA9wLqkb36+NUdrD6zhtbnWEV5ZaUnW9Yy1GjEGLb5icLmUs5EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMo3OCbeVOSKAizpKK4s32dneQUHz0ve9qCIdBWNlJQYz886aw
	Hv5mu6vPCLLewaTK3QL1Uj7iqofKdAbSJsHpE1dMPmoTy/JzlXOp/TZH
X-Gm-Gg: Acq92OF+c3dbvC7rrREXZgWEoEzs9W3EqySx5EKJ1S559tU8uRWLqrogQuUESDQPBGd
	tr7wZ393HuQbJ1BLw4pp1xM7Q1jcFlE850VOhoK4iDOg7mGdhi2RzDNtx83pgEONO8lXCg408TK
	dNynYo2eKNxYb4eNOG4OWl+KAZCx4b91XQA4lJh8Z0jmvztD81+1RtRKD5U7gKdeas80dGLWg4q
	wIbIXVI0zR7ODimV7C32em7tq58Y76/xYshTI2yO7T+HzsL8c96zuRJTmfrBgO01yIGBsaRc4l3
	mi63G5dA6A3wfI/otf/1DJ+yqtg1wirkHl9iKqv0rvKZR2HgBHn/4D4fxLkk92BFyOm0p7gs83x
	Vuusq6KJHpaqlH9PvzZkM3ENZpNvRPg6irAApHsd61dBQJzkvCVVgzHuP7h81deRydQW2vk1/L1
	pUunb+9gPrtCIY58rksWfQ/Ze5LWU=
X-Received: by 2002:a17:903:faf:b0:2b9:8f98:3ccc with SMTP id d9443c01a7336-2bf038379a9mr19947455ad.8.1779974761976;
        Thu, 28 May 2026 06:26:01 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56b51aesm234623465ad.19.2026.05.28.06.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:26:01 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com
Cc: Slava.Dubeyko@ibm.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] ceph: fix bare ceph_decode_8 OOB in decode_lockers()
Date: Thu, 28 May 2026 09:25:21 -0400
Message-ID: <20260528132521.843004-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <50dc5a7472fb2d6da4ebb71cc659b03a5df06747.camel@ibm.com>
References: <50dc5a7472fb2d6da4ebb71cc659b03a5df06747.camel@ibm.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ibm.com,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254981-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9BB7B5F2B7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

decode_lockers() in cls_lock_client.c contains a bare ceph_decode_8(p)
call after the decode_locker() loop that has no preceding bounds check.

If a malicious or compromised OSD sends a cls_lock_get_info_reply where
num_lockers is crafted such that the decode_locker() loop advances p
exactly to end (or if num_lockers=0 and p is already at end after
ceph_start_decoding() accepts struct_len=0), the subsequent bare
ceph_decode_8(p) reads one byte past the validated buffer boundary.

The result is passed directly into *type, which is subsequently used as
a lock type discriminator by callers. An OSD-controlled one-byte OOB
read at this position gives an attacker influence over the lock type
field with no further preconditions.

The safe variant ceph_decode_8_safe() already exists and is used
consistently throughout the codebase. This site is the only remaining
bare ceph_decode_8() in the decode_lockers() post-loop path.

The goto target is err_free_lockers (not err_inval) because *lockers is
already allocated at this point and must be freed on any decode failure.

v1 of this series fixed the bare ceph_decode_32() before kzalloc_objs()
and added the err_inval label. This v2 addresses the second bare decode
identified by Viacheslav Dubeyko's review.

Regarding the -EINVAL choice (raised in review): -EINVAL is correct for
the err_inval path. The failure is structural malformation of OSD-supplied
data, not a memory shortage. -ENOMEM would misrepresent the failure class
to callers and to stable@ backporters triaging error paths.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment can trigger this against any kernel client that issues the
lock.get_info class method (e.g. during RBD exclusive lock acquisition)
without any further privileges beyond OSD session establishment.

Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
v2: Replace bare *type = ceph_decode_8(p) with ceph_decode_8_safe(),
    goto err_free_lockers to correctly free *lockers on failure.
    Address Viacheslav Dubeyko's review question about this site and
    clarify -EINVAL rationale.
---
 net/ceph/cls_lock_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 4f27b3d15..c9183a348 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -314,7 +314,7 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 			goto err_free_lockers;
 	}
 
-	*type = ceph_decode_8(p);
+	ceph_decode_8_safe(p, end, *type, err_free_lockers);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s)) {
 		ret = PTR_ERR(s);
-- 
2.53.0


