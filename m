Return-Path: <stable+bounces-56885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456FB9246E1
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 20:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B083FB22B16
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4681C230E;
	Tue,  2 Jul 2024 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8x+wrmP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3062F4A;
	Tue,  2 Jul 2024 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943386; cv=none; b=gxEglnCqCyySsWmoySFMqOi7PoTRCH/zZFrFCkkeoRDs5ejcZGtQ+9QKGFylL1op+kmeFcmwNe3Bjn9ObOvhIZuji5aGUlinp+1VRg3IqVB3m2wNHtM3+HVdWG8ljW/lDs6LRFGm3FjC+9gTtGCeQOnrX3NKAAiClaoQgQrDxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943386; c=relaxed/simple;
	bh=B3dWdEDyNXQmx6muZkNVWHD7xKSIJpgZf/xlYbSegAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m6R78aaHRW/OdLkr1vk0YwVgVXkbDlo1uNPBbLhmF9uSkSxhsWvQb6Z+idG/t9wtmWyvniP1ozu/fgEc2pgETlOgBmswJfMmAEyPQ5zsEEHzRB7/k/hRJ5w8uALWN6EBWSS0SV+hG2YRnVYCS0/GgNZyZ9En1eDqxq++FezrZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8x+wrmP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so25332205ad.2;
        Tue, 02 Jul 2024 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719943385; x=1720548185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qvoM6VT0CJn7MVKzubAGpZvllDEzwbyo5vD8p8L/0v8=;
        b=W8x+wrmPf2I+S48Gkvq6HW8DWtOa9hr7eiI5uoY5eaPapYgbS+qVfsXxBYC/vKxhP0
         LOSNukXRwnOAzU/F4jq/nprmc4WyGxHi0MqVpQJABAA+pKjci+brv6GpY1/JT2PmtRRL
         7OebjQKjwCia2L8/iZD/b4lRH/sT+xytNreKo+C89FJxu36s4imbg0PobRUyc774N2X5
         X92mYBJdUd1kqZxIFuj52SiKTrAs0un4h7FVD+Os5VpkRcAVDOWELN1WG5m+oejhwMoY
         iuwa/RwZ08q9hf/Q8Q27D2nBNgIvHfXjnsVRmolwo2ZydNtd+tBdzepn74pwCOEkDGs7
         TkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719943385; x=1720548185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvoM6VT0CJn7MVKzubAGpZvllDEzwbyo5vD8p8L/0v8=;
        b=e/QsMZPKpv3bXmGH7kQSz54VlLUul6tsa05+1RPrkfaiUHa8vzhpbCsigPc5GDm0q8
         b74PFUfkglAecG1Jjxu9kQFqEMHekmNw606sYAKO1n6lDU0KOpHwn3sDcXvvWvKf9IpT
         J4x6didvmQ/2fWQFm0oNQV9hObr6V/xNB7PEBdhCL7pOcCI9dYivbAdO5Ph9T421c1V3
         jwjpRbzl27PbxIk7U0RrXi7BTd498BnM2V0P/d1ZKN0DJeFbO8HqZk61DtA/GjnhhKgD
         hLbYbaX0VjY9bAkiLumIe6s97sikpTl3us13dpaf3rUV0EvNCA2lOJkg8H933LnxWB2l
         YEpA==
X-Forwarded-Encrypted: i=1; AJvYcCWqvl9PclItVlBt62o0k/kVD7Tt9DiDNdaf9mE6gbNZ7he0E5HzXj2TGJEB4J9KIvZ5+P78FlyBDYrqZONmOg4iOonxZXZkYBruDFVJ4eKR+LHSHLq29oV5zyjwVbbqUp5jMuk/l1mscIDZq9rw+a4taCm8mTG7q9ttRI38vkiBWJLHpuBWqSar1KX5rZmN4ndu/ingqjahQU+wdy0zye5i
X-Gm-Message-State: AOJu0YyBIaqj2Q+rebYT2DLeXTRYlk5bWghoDIYeW18bwNelRUK3TC4q
	moAiM4CN12T3VdoMR3OTKrQfUgvPbot1VRmi9v7m56reBaVQ0hvI
X-Google-Smtp-Source: AGHT+IHfXBmJeNjdGUFTKNNAA0/gNX+F/GIrIVr1TbrrIrL6KTYRjIkDBb+7kMaXkDHLKvHq8JwmSg==
X-Received: by 2002:a17:903:2303:b0:1f9:fca9:742a with SMTP id d9443c01a7336-1fadbd04454mr59020895ad.57.1719943384771;
        Tue, 02 Jul 2024 11:03:04 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fad2eb7cdesm78518005ad.146.2024.07.02.11.03.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jul 2024 11:03:04 -0700 (PDT)
From: Yunseong Kim <yskelg@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Taehee Yoo <ap420073@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Austin Kim <austindh.kim@gmail.com>,
	MichelleJin <shjy180909@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	ppbuk5246@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH] tracing/net_sched: NULL pointer dereference in perf_trace_qdisc_reset()
Date: Wed,  3 Jul 2024 03:01:47 +0900
Message-ID: <20240702180146.5126-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support backports for stable version. There are two places where null
deref could happen before
commit 2c92ca849fcc ("tracing/treewide: Remove second parameter of __assign_str()")
Link: https://lore.kernel.org/linux-trace-kernel/20240516133454.681ba6a0@rorschach.local.home/

I've checked +v6.1.82 +v6.6.22 +v6.7.10, +v6.8, +6.9, this version need
to be applied, So, I applied the patch, tested it again, and confirmed
working fine.

Fixes: 51270d573a8d ("tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string")
Link: https://lore.kernel.org/lkml/20240229143432.273b4871@gandalf.local.home/t/
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org # +v6.1.82 +v6.6.22 +v6.7.10, +v6.8, +6.9
Tested-by: Yunseong Kim <yskelg@gmail.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Yunseong Kim <yskelg@gmail.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Link: https://lore.kernel.org/r/20240624173320.24945-4-yskelg@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/qdisc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index 1f4258308b96..061fd4960303 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -81,14 +81,14 @@ TRACE_EVENT(qdisc_reset,
 	TP_ARGS(q),
 
 	TP_STRUCT__entry(
-		__string(	dev,		qdisc_dev(q)->name	)
+		__string(	dev,		qdisc_dev(q) ? qdisc_dev(q)->name : "(null)"	)
 		__string(	kind,		q->ops->id		)
 		__field(	u32,		parent			)
 		__field(	u32,		handle			)
 	),
 
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q)->name);
+		__assign_str(dev, qdisc_dev(q) ? qdisc_dev(q)->name : "(null)");
 		__assign_str(kind, q->ops->id);
 		__entry->parent = q->parent;
 		__entry->handle = q->handle;
-- 
2.45.2


