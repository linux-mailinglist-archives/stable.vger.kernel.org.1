Return-Path: <stable+bounces-240373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEexEr8H6WmgTQIAu9opvQ
	(envelope-from <stable+bounces-240373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:39:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A57DE4494C9
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCE87302F5AB
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2B6386C3B;
	Wed, 22 Apr 2026 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6rwZLP4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6717F378D9B
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879537; cv=none; b=MiReak3xmrhtyPcb/QOwaOu51wj6vujxsftJJ47NP4DgwDf/p4HqPCB2Tb9lWVNNZEWRsxjbiWKlShUAwRmKT9e4MV+8atap1JF+EM2hATbkGJB4BwphycGjaIn/P7RxO3blN9jSoH7WTqqYvqd6DOu10/l2elxtPJ/cRU+ki/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879537; c=relaxed/simple;
	bh=bFP5AY+UYMSrKv1tWAgu98ebUaRPsKu3WMtQE+No8Po=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O6qkEzADoW3lKDy2fl8ZTks/hXGQ7aPJWdrUBKm065707Pzx6sjcoyV1MJflC4jpC0ed9MQDyXauNhLN36PG775MN4ui+eLzmXTb1Z7Q2Jzj8hEQOCTJUwNkmNNJO7CxONV7fSf2h8dBO9q126RsLr6nd4L3xhaif+r2dixa9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6rwZLP4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824c9da9928so2889192b3a.3
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776879536; x=1777484336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEFtXcpoTUuSx2EDCkhHpiXviuYOC89Clel/2QQUNdI=;
        b=M6rwZLP4eXmqVS4bj2zvnY3V6mXoQ+XH6oiAE12QgXwPCnY78iPJtXjcB0YI2FE7Li
         gJ/D0hWs2S3UBPoJ00uXHRfEIXYsE93rB+P0rwqroIfFzOZ00zyCPw9MKedwEQfDvVhq
         0yiWHTYm/MwsdBhR3n+fbIWaialy/Ha3TYjKfypV2O51tmU9QzVexYe/kHfqNTn06BcD
         XfSVI2CZg+3nKfE8pwg9CGUJVlh41lpxX14kAJEraexfpHTrJsFbME6FsAeeVZheY+Jy
         aVvDYy72R9pV/xu+FIxBD9l3l8OKBigx4iwIoiU9oXy4PuZbKVjXhLkWpFLsmBiMq15M
         LCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776879536; x=1777484336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEFtXcpoTUuSx2EDCkhHpiXviuYOC89Clel/2QQUNdI=;
        b=PEmYxctmteaZUl6PzARe7RgvgmNTV2mzcCdvGTCBGRu9yyyF97nakNwUN0HrAe+Qzh
         DAx02nZ76A9k/Cis8aaFhRgrd41QYNziFRR/XQ/dneVfWgnmCriKx+WHlAak62gzz9FR
         8L9fRArYlxqa2jMp6SyFmK1UdwDbimBzrCmuSfhmMvRYiCGbTONMnoqOGqU5q9Vcp6pY
         ZyzsIGcFLez5KfST3iwH5gYV1gymU7XVxSgRdixQOzA1xj6uz/5IvOfNqOlyE/XOj5Ie
         M+bMOJHBpey+ueKjk1aWMnTZY0R8gQG1BMdIPT4lz02P3WdeZegKDzI/sVFo+L60o99p
         sR0A==
X-Forwarded-Encrypted: i=1; AFNElJ/+L2wCUgS8lkDyUYNQyb+usseNlQv6qajY/QxV7evkM1b4UgUE1hnk4142ifxYafTaJgWcGGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxYqN5LQzJejmryFQ5Tmehr+deI/pFSPziblZN0QF+yoKrapH
	3Au1eq2LU1pBQzL/IpyxdaGmHzs22lgde9TA+WE8EB/Il0sj6SGXDTSx
X-Gm-Gg: AeBDietL+a51G+KvjiNHOqpKe73E4B7AkEsAcTiyytFivSSWdP2hnkwfmp06kEiaRIj
	3xvvepIeRmcrUJ4vrax1J9sTAzMOqivl5lLAk6mBK22i58nIgaVHN0NoBc5zQOFjt3JxnKIWmf2
	YlquHBTzr4ITWpzEiDfZyOgVFsyof0s1SwEbGJyJbFh+W1KQ5EBj+tjqFqEztgAKphVhTm4Ce7o
	/snOvEX8FMVKKED+o/4oc36caDdVvdRNIcF4AoZ4Q/UzICW11OUZN0ABFDxgSAyr7eE7EXC/eVp
	FywQqLRRJF7D5C/7e6Ej8ndRtxID1CDVOThtZPPcOilinXfVjSH0MzLlpUOaOmN2tJub8nL9tOx
	XoeX7MxQ2UrnillebHBccvJBf9xcLx2lGiWicIAoqwpCWJUJDvVmg1Fq1anTMXdMMV3g/jfaCmX
	lSO+cX3mgfJrf4/WUb8rpesU6wBLG9u8ChqahsFVZEK8PN6mtarFJyng==
X-Received: by 2002:a05:6a00:1826:b0:82f:37e3:ae6e with SMTP id d2e1a72fcca58-82f8c961f73mr25139528b3a.31.1776879535597;
        Wed, 22 Apr 2026 10:38:55 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([14.48.8.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec0307esm18014517b3a.53.2026.04.22.10.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:38:55 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5de83f57cd8531f55596@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] wifi: rsi: fix kthread lifetime race between self-exit and external-stop
Date: Thu, 23 Apr 2026 02:38:46 +0900
Message-Id: <20260422173846.37640-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240373-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,5de83f57cd8531f55596];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: A57DE4494C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RSI driver use both self-exit(kthread_complete_and_exit) and external-stop
(kthread_stop) when killing a kthread. Generally, kthread_stop() is called
first, and in this case, no particular issues occur.

However, in rare instances where kthread_complete_and_exit() is called
first and then kthread_stop() is called, a UAF occurs because the kthread
object, which has already exited and been freed, is accessed again.

Therefore, to prevent this with minimal modification, you must remove
kthread_stop() and change the code to wait until the self-exit operation
is completed.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+5de83f57cd8531f55596@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69e5d03b.a00a0220.1bd0ca.0064.GAE@google.com/
Fixes: 4c62764d0fc2 ("rsi: improve kernel thread handling to fix kernel panic")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/wireless/rsi/rsi_common.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_common.h b/drivers/net/wireless/rsi/rsi_common.h
index 591602beeec6..3cdf9ded876d 100644
--- a/drivers/net/wireless/rsi/rsi_common.h
+++ b/drivers/net/wireless/rsi/rsi_common.h
@@ -70,12 +70,11 @@ static inline int rsi_create_kthread(struct rsi_common *common,
 	return 0;
 }
 
-static inline int rsi_kill_thread(struct rsi_thread *handle)
+static inline void rsi_kill_thread(struct rsi_thread *handle)
 {
 	atomic_inc(&handle->thread_done);
 	rsi_set_event(&handle->event);
-
-	return kthread_stop(handle->task);
+	wait_for_completion(&handle->completion);
 }
 
 void rsi_mac80211_detach(struct rsi_hw *hw);
--

