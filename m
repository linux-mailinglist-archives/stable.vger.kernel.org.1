Return-Path: <stable+bounces-10411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C166D829065
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 00:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3788FB24F18
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 23:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8259F3E469;
	Tue,  9 Jan 2024 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TanY1I7n"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008573E463
	for <stable@vger.kernel.org>; Tue,  9 Jan 2024 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ddf05b1922so84849a34.2
        for <stable@vger.kernel.org>; Tue, 09 Jan 2024 15:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704841199; x=1705445999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HldAr/cgQ9LjKRv/M/aug2sZMeIE8WTqGH0mqR520lA=;
        b=TanY1I7nNsn7N8JARAdCM4/Tq7I3OGpHFkPyWuDKVLbFVj/3HZ01JWV6safOIWtHYe
         ff9/cV+ztZIADJOqwdscCfZHpca5t91T2lkgkyguyL3Vci/NMmqaulgENhgGixWYVAMs
         31VAuHHygA5NSJylQYjBXxg4YOB3vAD8XWh/A8hWfsPuSSIvsxerW/n2Q8vXeB+Brb9p
         mTSN1sSiXmVOEmFmQT90sWZmU8siSFdLM99ZfBn/wmQqBnJsEYS2Sv9HR8AOy+wxwB3E
         8Gm3Xnh0aQHcxzQyyYhDe6X+wbjaofKWh7I6k7EiPl3bgFq6TAUGo2G92wfA3141RM57
         rBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841199; x=1705445999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HldAr/cgQ9LjKRv/M/aug2sZMeIE8WTqGH0mqR520lA=;
        b=K2naW+UbSQREgVpddZfiP54SrY5Ablehe+kFBTjGAz3sUuVz4w2UJOlmlWTUGTrUZ9
         hG1cOFSVe4JHnFa7WFHKW+UHIKi7xu59B8hqG/Pfn03b7ox2LwlrX6dbuGcQkohYaSJf
         uVXTmpt/iGp9ooYWvnFBsHMn/r2Jv6++9X/3emQBseRUOZyBmIJstUcOFcYRhxhzi7PY
         GnQfipJp7fObPKhqlkmEALaqR62mgHcSgejT8QMTYYoPm6NzWkH3eMvwsW7WTLnmEDzg
         b8Gdx1+QzCi0MRNZaCrIfeQJaoHM8e+ZLc47QLW8Lrwqn9t/GLokMi0rURA9SnjXNq8o
         RnUA==
X-Gm-Message-State: AOJu0YxA61dlrSiWZo5RqJGa/Oa9wEuwELyeRkXTYlw6zfTBuC23fyyJ
	hMNSZF/dhOkRG2BXYxzdzXjKl2mKVTw=
X-Google-Smtp-Source: AGHT+IH79Bdf3RKTuLDYC4WDZDprnM5dS8jK4C6ynzMNQFcSPZMTtU4hhTDIA8NhIribIKhny5/4Vg==
X-Received: by 2002:a05:6358:784:b0:175:6ac9:1c5d with SMTP id n4-20020a056358078400b001756ac91c5dmr105279rwj.59.1704841199241;
        Tue, 09 Jan 2024 14:59:59 -0800 (PST)
Received: from john.. ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00071000b006d983b43423sm2163039pfl.158.2024.01.09.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 14:59:58 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: stable@vger.kernel.org,
	jannh@google.com,
	gregkh@linuxfoundation.org
Cc: john.fastabend@gmail.com,
	kuba@kernel.org,
	daniel@iogearbox.net,
	borisp@nvidia.com
Subject: [PATCH] net: tls, update curr on splice as well
Date: Tue,  9 Jan 2024 14:59:56 -0800
Message-Id: <20240109225956.279609-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit c5a595000e2677e865a39f249c056bc05d6e55fd upstream.

Backport of upstream fix for tls on 5.x kernels.

The curr pointer must also be updated on the splice similar to how
we do this for other copy types.

Cc: stable@vger.kernel.org # 5.15.x
Cc: stable@vger.kernel.org # 5.10.x
Cc: stable@vger.kernel.org # 5.4.x
Reported-by: Jann Horn <jannh@google.com>
Fixes: d829e9c4112b ("tls: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/tls/tls_sw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 101d231c1b61..9ff3e4df2d6c 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1216,6 +1216,8 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
 		}
 
 		sk_msg_page_add(msg_pl, page, copy, offset);
+		msg_pl->sg.copybreak = 0;
+		msg_pl->sg.curr = msg_pl->sg.end;
 		sk_mem_charge(sk, copy);
 
 		offset += copy;
-- 
2.33.0

