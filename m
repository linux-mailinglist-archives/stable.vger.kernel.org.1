Return-Path: <stable+bounces-261948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9wxmAcouJmq3TAIAu9opvQ
	(envelope-from <stable+bounces-261948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 04:54:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478665258C
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 04:54:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=google header.b=Ko6RTm9F;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261948-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261948-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2C90303B6DB
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 02:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B63396F4;
	Mon,  8 Jun 2026 02:51:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A8336882
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 02:51:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780887066; cv=none; b=rzVOBc++JT9oAjG+B0B5T/hRhxvZP8VRbmDl0xeP2OiezJOTIOHBA1NkZ9VAzLwek5W//sXOY2hF7wgWogbOJAccbGLrv9KD6tKJN9JqRUFFkhoxlXah0U++JKccz3UucVG6it9PP62wIeEBxfkSEGR1DnTCRxNRsD9FGTvvh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780887066; c=relaxed/simple;
	bh=bVHdtl+1gXb+41m7LssdlHTlwh2k7sT1ak0F8ZrEBqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dy7+sesZGVHCHALUie2EAsqQZ/1BN/+6z4zSZ3CTQX5qwazqhZZQvmy0FljQ7NiT6L3gb8p8N7tlcRHfIA6Up/JqZ+JCxFlZWZSAj9HLJfebIBt2v8OEQTSNpMGJJZ+9+ctPwe/hugkuMVLLTnBDCDmavTeQeoU68hXaH89WEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ko6RTm9F; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84231305a80so2019366b3a.0
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 19:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780887063; x=1781491863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6pATA/q2zOEosF2pnrG8syYg/IBJ1PmeGXJDn1SU0Q=;
        b=Ko6RTm9Fkrgf+BpigxdrBj/my13Upy/IYtjnb4mo7XQD7uaymE7DtbpS+rdmv6GWtL
         p2unaJ9vFrigzNzO/ygoGmVZy6p8hhLyym/CvCTPDBuKP9y2wzq8MrEvMR4v3O966eYy
         PzOG3cO4Ny9ihqokHUCFcu4/rAhoKg0bMUhmsp7KU+v6z0NVpuvrqg+9gGsFUQIPK/gc
         6TWrCPuA85FBVCy0GD//llG3mhU0JhrbPDD7A+VjBntlz2JKeTmeC0U3+FK2rJHA8Yl1
         YWaGqJxZZBTBEMYiaEujxKi3RMuYEZkAYTjcGCSqcNmPrk79Lpn8SFMus+mkHSJSX50r
         xxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780887063; x=1781491863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6pATA/q2zOEosF2pnrG8syYg/IBJ1PmeGXJDn1SU0Q=;
        b=F+WOPKXWr7Z7O9OjWXAqaNioMpRl6FuoGe6i4ybvibPuMJQoZRwU8mOF7Eo1Ohv4IK
         1aX/cDGbF2b/DE9meEk9XyivM2h5gS2mQab5kRQZHKj4LBx0/kLUTG8EVMjMuJ0hmUhG
         ZedViSUNtCYdyfjogc/E2tOB/kSIrMJH3T2PgnNFelFghYfajRrJy2lYKhJW8OR/xuRD
         2iIph0leleZnF5nxHchpv17o7gJLlGu/Lk55i4hdAs3XEAbNQaKjyZjPCb1adIQMgXR8
         yoh5heZ5XpZCD2sdNTd+TOb8geki1nM7f4bddwzu5kw3RnLqm0NywUsTJnYanufVSHbs
         TGxg==
X-Forwarded-Encrypted: i=1; AFNElJ8toH6iMjURLnLVUK5VSXHQhBIExj23jIHOBMBVq2374IgjjT8wcstC/rD3totUvMNLW1LS4MU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00H8r+67G74xktAoDIr9myMmxtOPTvBPkUP8feJPJYtClHK8+
	69NBo33ValWuonfDtx41d3AA7ei3Qwa26C27csCm9kD0Tfwy1/2vRb1ueZIifEDySVo=
X-Gm-Gg: Acq92OG+Ic97PZHFAzh2ofiqFjgL9NTdO4wIc5ZWbcBprEHWRIX4mSg4Lv+124zDxYv
	xwq+Q/UzZtcvtMFLO0Ho8k9cSR0HPV/oujJXZtoBpVDvwKOMH1Hw4PuHjxIMJDZAeu8JRtq+Lqj
	KsK12PWbe+/6TYARrrQTdekRCAA1H3hYrdrUUnCrHGdxhMT+puwtwk7fqKWMjNjnTNGm375RJmW
	3i+zna2T1XAvio0Jw+5ugHq+6rBJJmt4AQxksrqhX+nmOUN6ZVDcCA0P+9SPnEqPNQaNoIEunPY
	7q9ngUtpU5hX3dpaRq1jPEOTyiBCxnSakK9utIb/y97TvYdaRlFmrPgBxVGJhxK8fIcvkLG7yoe
	pXUP5lj+5zCY7/7tsWsy8JgA2U75knPRD/93QXyInm8SSx29USK1lTxnB2HQctfhCcAHgz11Zju
	Vs1+618Y7MTvcvL/VKpuscrym2+a9W5KQO6RV704xK3tVpo6sevPfcEgTSyE4gukYuUH4=
X-Received: by 2002:a05:6a00:1942:b0:842:623b:38a9 with SMTP id d2e1a72fcca58-842b0e1e761mr13215260b3a.4.1780887063320;
        Sun, 07 Jun 2026 19:51:03 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821d0sm16033532b3a.28.2026.06.07.19.50.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jun 2026 19:51:02 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	yang.lee@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/gup_test: fix race with PIN_LONGTERM_TEST ioctls
Date: Mon,  8 Jun 2026 10:50:42 +0800
Message-Id: <20260608025043.88087-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261948-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:jgg@ziepe.ca,m:jhubbard@nvidia.com,m:peterx@redhat.com,m:yang.lee@linux.alibaba.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cuiyunhui@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cuiyunhui@bytedance.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[cuiyunhui@bytedance.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:mid,bytedance.com:dkim,bytedance.com:from_mime,bytedance.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4478665258C

The PIN_LONGTERM_TEST helpers keep their state in global variables that
are protected by pin_longterm_test_mutex when accessed from ioctl().
However, gup_test_release() calls pin_longterm_test_stop() without
holding that mutex.

This can race with PIN_LONGTERM_TEST_STOP and let two callers operate on
the same pages array concurrently, corrupting the test state and possibly
freeing it twice:

 CPU 0                              CPU 1
 -----                              -----
 ioctl(PIN_LONGTERM_TEST_STOP)
   mutex_lock(&pin_longterm_test_mutex)
   pin_longterm_test_stop()
     if (pin_longterm_test_pages)
       kvfree(pin_longterm_test_pages)

                                    close()
                                      gup_test_release()
                                        pin_longterm_test_stop()
                                          if (pin_longterm_test_pages)
                                            kvfree(pin_longterm_test_pages)

     pin_longterm_test_pages = NULL
   mutex_unlock(&pin_longterm_test_mutex)

Protect the release path with the same mutex so that stop and release
cannot run pin_longterm_test_stop() concurrently.

Fixes: c77369b437f9 ("mm/gup_test: start/stop/read functionality for PIN LONGTERM test")
Cc: stable@vger.kernel.org
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 mm/gup_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/gup_test.c b/mm/gup_test.c
index 9dd48db897b95..d1c2b1014f0ef 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -373,7 +373,9 @@ static long gup_test_ioctl(struct file *filep, unsigned int cmd,
 
 static int gup_test_release(struct inode *inode, struct file *file)
 {
+	mutex_lock(&pin_longterm_test_mutex);
 	pin_longterm_test_stop();
+	mutex_unlock(&pin_longterm_test_mutex);
 
 	return 0;
 }
-- 
2.39.5


