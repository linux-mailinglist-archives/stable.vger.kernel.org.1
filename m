Return-Path: <stable+bounces-6769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 241A3813AEE
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 20:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228941C20F9E
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 19:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F8D6A01A;
	Thu, 14 Dec 2023 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQdLLFY8"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D4697BC
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-35f71436397so14808165ab.3
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 11:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702583120; x=1703187920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+vp9xvFGaBSnAdpXIUiiQdELjYDbylqKJbXLBrrHzc=;
        b=NQdLLFY8sxPWf9pbsw2/JisctnB+tI1xZ525oBpAJ4M0R0l16eo4gQlax32XIitX4K
         KnaiTgMht0tTUo6qQycZai/sR3yF4zwsGtpuekbcPZ7h56W3gDER/wNvD46CMBRsx8RC
         QImVsNr4Q776xv4Rpj0Vxa1gn4GLrgJpCK+p52b3ojt5IIiWSYrbOEa8ezegBMstVRaR
         XesAo5b62G7u0Ru7hhHHt2aPVeVD4Z3u4PyoYRpkVviLVsbQzUHofrQPMNnCvsRtBJ+V
         wKod+sqeijMUT5hAmiq8r2Ix1FwebmeAX34k/J9qwHvZSXhZoJAv0XfFK/LIImpfMlT3
         djsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583120; x=1703187920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+vp9xvFGaBSnAdpXIUiiQdELjYDbylqKJbXLBrrHzc=;
        b=h9sZMowL77uT4hPXkqAFi6wcJXAHxcX9lDZdpISvO0wRS2aZE5464jXx1idX9M0x8C
         gC5hxWUjr77qEqA570guQ2Tc6I9wskPnXBf+2u3o4E4lNQkLXaP8ktZ0pwpV39279FwM
         QyCK+6IrOzLFt3g9kaA3lM8IJjng5iFlgARGxpPJ3gXpgpoQctLopKNLx7j5rTRV7fWI
         t4UXatCnxllznOE7qOHW9JXvUvRd9/DyVfs/8txzMdGm1t9qBb0aJ3Ox3IWg7S8Y1IKI
         ikDH/E+mJBEhpz96HbENrjD6QXx9YxknJ7dv9ebIosieXVYQAE67nici1SkuYR37LslX
         8cWg==
X-Gm-Message-State: AOJu0Yx/oIaR47CQ8C3Q8vFwqSvRLfvM0tLC/NAfMLOMrLKJ3zksjsQh
	uoZ4THmL9dbyhkzILxUpCLhgk0KjbRY=
X-Google-Smtp-Source: AGHT+IGX6fX8T0DRdJWHIOkBIO+cgxUm/3XsbTqNy//z5Uatr2y+rIGTOczb6z8/t1v+76eG4NtilQ==
X-Received: by 2002:a05:6e02:1848:b0:35d:5995:798f with SMTP id b8-20020a056e02184800b0035d5995798fmr15344654ilv.41.1702583120402;
        Thu, 14 Dec 2023 11:45:20 -0800 (PST)
Received: from john.. ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id r12-20020a6560cc000000b005bdd8dcfe19sm10279870pgv.10.2023.12.14.11.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:45:19 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: kuba@kernel.org,
	jannh@google.com,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	borisp@nvidia.com,
	stable@vger.kernel.org
Subject: [PATCH] net: tls, update curr on splice as well
Date: Thu, 14 Dec 2023 11:45:18 -0800
Message-Id: <20231214194518.337211-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit c5a595000e2677e865a39f249c056bc05d6e55fd upstream.

Backport of upstream fix for tls on 6.1 and lower kernels.
The curr pointer must also be updated on the splice similar to how
we do this for other copy types.

Cc: stable@vger.kernel.org # 6.1.x-
Reported-by: Jann Horn <jannh@google.com>
Fixes: d829e9c4112b ("tls: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/tls/tls_sw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 2e60bf06adff..0323040d34bc 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1225,6 +1225,8 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
 		}
 
 		sk_msg_page_add(msg_pl, page, copy, offset);
+		msg_pl->sg.copybreak = 0;
+		msg_pl->sg.curr = msg_pl->sg.end;
 		sk_mem_charge(sk, copy);
 
 		offset += copy;
-- 
2.33.0


