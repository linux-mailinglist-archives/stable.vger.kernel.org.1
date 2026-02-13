Return-Path: <stable+bounces-216036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMiQI6DrjmkCGAEAu9opvQ
	(envelope-from <stable+bounces-216036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:15:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3594D134568
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 936CF301E6C7
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658BB34CFC3;
	Fri, 13 Feb 2026 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JopeMpVb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09AC26D4E5
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770974105; cv=none; b=eY3tal7W1rkKdRJXhyvnS5NNluZd7QihlAKB92qMzZJs4pxTEidWDG7k/Wa/DxRlx5hHJjssJITP571s/jNYCKx9K12bC0XZa0KyjJEXgkxwgLAF6U9MCib1kSHogzYsWVvz7gtcRVTWlcpFNM7ElAbefHiuNhwS/TJepKpdqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770974105; c=relaxed/simple;
	bh=6veDJhQ+0eIaAZOJcIL/D3XTVNjNN5zMO0OVns1Zp9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBUrbWyUNOY8Cxu75K37uBse5t1an1JJJW45vm/8lPrWSVz1huH3+1WL92AvMuZtgjm8Rq5RF7BFR8K3Q+2nyTr3l0TLVhpjKAioQ27qRUFdtY4on+RfG1Zon0uZx6uH4IXgRG92PgR7vRvWSZse+LfZZt8aQJqDFLrE1KAgj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JopeMpVb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48371104ffdso828845e9.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 01:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770974102; x=1771578902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCdD7lSk2JqQGo4mK3E+TOq0B3GIskXXL8ofh8f8Wjk=;
        b=JopeMpVbFyhvRCZ+GvvY+jVq/GkvIszhKagp8svDWVaR27vdfxFTqm1WwEVbjh2TRB
         /MoBygNutQlNi3RhzP4GlP56luqkwKSDL3GjHxpOgQhaWvkycB5XAAAgCf1J/w0f0fzA
         vQqmVLdh2535wDTVW8UqEG0PfiJ9iSr2Ivqou9JnsJG/l6YqV/GZc+6/DuO2MKZkD9nX
         4P/1oASQVaxt/eg29bHHDZFu30RC6V4WtCqiY3TarMgzdhuSn8WDZcAbvAOf65FBNqpq
         MYU8LAggOZ+hPn/Y8+2u39xw3fQk0J8S780EG93l4SSCE1bQRrEFAdmvf4zOSyvpTv/H
         aiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770974102; x=1771578902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCdD7lSk2JqQGo4mK3E+TOq0B3GIskXXL8ofh8f8Wjk=;
        b=W/HZd4xltRC9fHjkJdhQza7lFiiWTZzfuRyuXa+tpR8YwJzi67COGsItL77IjrzuWk
         aH+/QAcqqEo4ZmjvxXJzWZK4PU22o47WiimGi9zw9vlfs0GwbSYkcTnz479JCL9h3fj8
         m4rwIZT26kGmgmRTvH+mr+cjl0i8ZrWbUozS2Z2R/67j/YAU9YJoAnCNv7uC1ZAomQhS
         YvX5N5udTZru1XK8tpXMoDBUi9X+EQfhCTuKpErfpsKqI5q/WVd3tRJePuNsVNN7fH9z
         TZ4Z4+dIGWYprKpSnZYPvGE8C149Oc0Ehf96TvaCOAAexH6yQrJbFW+r7V3kRHVkTTAp
         NkUg==
X-Forwarded-Encrypted: i=1; AJvYcCWS0jWS9Ct6VVgBVJeLouVHGw5oi/7lqPDKanW+/kPWv4hCzogMK3gVipcQkA/aBZSUh6/2ANo=@vger.kernel.org
X-Gm-Message-State: AOJu0YygLctUQGKIEtVs6EnK98l0SlqkyBE+DugspRCP1csDYhBK2nal
	iD0EkxRtzTZM8ZZbA0NpBWsDEekCj6L2KPMqRJ7OI5MAxvrpQSRUN5sB
X-Gm-Gg: AZuq6aJWyQcSueXMdeF5HmPsxwDVvG7+lQJ2bfHLxdBnJ5xCZFeA4F6tGeekwcKBpmG
	zwdtz2wp4+WTPxViH0Oo37PUeuzLxEq13UIOkbl/WYJQQhjnewuHxfQqPVinbj7T05h3CII6Bsv
	+0tzdHombCZNGmgZ3HClpzkvbB8mcjET9fadO9LXrrXtNHW/WR1x3HP4K5veEzYXotAzFdNI4TI
	hYbl7YQsPLYnEvVCNj8wTUvOxqkOX6Yjih1qCkbaQbTvxPf1IBnWVbhNFa4PA0EIqZ4BOW6v8ac
	VeYUDiZUOwjotfuU2nKwnQWNm7pT3qieDjKBZt0NNa8D81s1F+pfoCxY7HEWQiKa66h37cl0lKS
	+qWdwQDPlKVxaeqE2gJlONX2rhVGY652Ow73pfTSBxBqFq6F0UrEdO2Xo2Ka+rYO5mF2xQ1Z3zE
	XU5un8EieES5kRFikoFdmmaJBByykjKNdzntGlCJofMegtBkFusbVXRZ5WK4b81PA0DlEIJYq+r
	9uD0kgJzPtkZs/xdYPq
X-Received: by 2002:a05:600c:4746:b0:47d:3ffb:39ed with SMTP id 5b1f17b1804b1-483710546e4mr18587225e9.4.1770974101882;
        Fri, 13 Feb 2026 01:15:01 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-82-204.paris.inria.fr. [128.93.82.204])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-437969fd36dsm4035968f8f.0.2026.02.13.01.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 01:15:01 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	"Bryan O'Donoghue" <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Stefan Schmidt <stefan.schmidt@linaro.org>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: iris: Fix dma_free_attrs() size in iris_hfi_queues_init()
Date: Fri, 13 Feb 2026 10:13:27 +0100
Message-ID: <20260213091330.23431-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-216036-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,oss.qualcomm.com,linux.dev,kernel.org,linaro.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3594D134568
X-Rspamd-Action: no action

The core->iface_q_table_vaddr buffer is alloc'd with size queue_size
but freed with sizeof(*q_tbl_hdr) which is different.

Change the dma_free_attrs() size.

Fixes: d7378f84e94e ("media: iris: introduce iris core state management with shared queues")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_queue.c b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
index b3ed06297953..bf6db23b53e2 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_queue.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
@@ -263,7 +263,7 @@ int iris_hfi_queues_init(struct iris_core *core)
 					  GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
 	if (!core->sfr_vaddr) {
 		dev_err(core->dev, "sfr alloc and map failed\n");
-		dma_free_attrs(core->dev, sizeof(*q_tbl_hdr), core->iface_q_table_vaddr,
+		dma_free_attrs(core->dev, queue_size, core->iface_q_table_vaddr,
 			       core->iface_q_table_daddr, DMA_ATTR_WRITE_COMBINE);
 		return -ENOMEM;
 	}
-- 
2.43.0


