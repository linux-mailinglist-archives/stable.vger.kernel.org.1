Return-Path: <stable+bounces-160084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACE8AF7C6E
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9933A35B6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC4122257B;
	Thu,  3 Jul 2025 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrubID+R"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698BB2DE6F8;
	Thu,  3 Jul 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556602; cv=none; b=r+/0m6G+h8boKWt7RlDEnkyzD57O3DATUVGLSChtZI9dWrWu7VdgpjwBR/ZT/5mNb+cGrTzB6jM22AqaBZ5comP1M83jsT9AwKRRX/IMK49foPsalZhdst1G6Ee5jQNwnOU47P6cEd08CXz8QgO1s7lzDFocZxLg30BUlkWpkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556602; c=relaxed/simple;
	bh=hgVRR0PR/ckdvyIGS+3hX9AlKTj2YA2xeoGPQSp3j2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=apgxfAaN0PpImno2kzhLch2h+QpbE+1U9zcP22TGr4TRjcAEp2nwKCdSsEbHA28B/bF24gQjMSchvynHzY27WxubT6vkPJIui7JegCvn34rcK7bNMOKMZ7pF5sz9Lx7X8NkO5c0jGwrmq4eY7+AX/6yosW70Iq+kKa5tvzejYxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrubID+R; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so13448480a12.3;
        Thu, 03 Jul 2025 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751556599; x=1752161399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRZoP19mVo+xouu+rD216ylrbdoQ3y6C2mRJgbjte3E=;
        b=VrubID+RFWuVwIcqwBPYt/CNfL6+3a/u4HqMVI7yIhLxhE3dY+0Bh0nLbmXKTqz1TE
         +qII/UqyDb9/AbDiGv/3vxmBfTW8uwnbyZ6+YP/cw81c5Rx6qQWX63g7caMXTBeOX52f
         1BkCBw83trUm2m0FNA3ST0Hb9b64eBIqoTcgxlA7mAa7tm7r4bCPoWfxTr+oe8z2qsUe
         KysOZ6wnBrR10Glkpq8kW8sM5Mvn9OPhmWJXyjZuoZrqT7vZnOq7zeX4Y+rYceaLwo3M
         trlipSNrWFvyXTznpmhS1eu8GgRYViRjp7BKCSTClXqkfcbDQf+ZE0s/+WdaQxsrTYCW
         Cflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751556599; x=1752161399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRZoP19mVo+xouu+rD216ylrbdoQ3y6C2mRJgbjte3E=;
        b=WjWRpQhG+A5ODlhAw8U9Deu6JLmQRTtnnKJKBRLHTdanTvLw7Ht5jVs8GtC098v1wN
         yF3jgrhFYzpjZS4n++iWlBdmthzG8Ak7Oz42FQl6LsKqOJSLsATpHu0rXy1CT5VmQTxA
         X4aH5Rs3vsnlROfkNQkL+FVENSXil5+xWPOoPpUJS0RDcivAUlyEsS6qK1vsEp0f6RiE
         wNRdPB4pdA6ec7QvzcveeTxv6dwtm6pDK/TKpb6glZxKp0/cDFnFF+614HxuLJ/yWpop
         unyxBX0hYUyUag2bFi+RHRdgEMjryoafmz3F0xwWtFB2KzjiMrnn3rxHNe9tPvP6FwkV
         dwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjTPL4sKnhJ7m9nYRCOlaXusNRdMErisl61G7EhRl4TtjI9EB0dobGR95mYqnXky7g17490b0tDCcFUR4=@vger.kernel.org, AJvYcCXE/MoPfuj0GVYTMsq7ORZdIb9HQ0oz+ZbbB1dSKvqI8XDSN65hmG9wQGf1PsU052YUjHAonACo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfp9zZVTmoFP5Au0/cvyrTVydSa+osGIVD4vcQGUSKq+pIuIVg
	WLh1z9VomPAm3Ay4jyHCO7kzCzvYETj2Xwk/IGMIL+QJt6X76QGj4qU540V4B3JM
X-Gm-Gg: ASbGncuX2iC79LGQVmoR7js/TED1Vd4VNS4rOzkGm/t6/SKidTaDZOTRbN6jOLoJDzy
	tMpfZSXNNyzBoi4Ztdk+D0uQZnfq8NBUYSG2MR45vrvj0mJcBNtc8O6OuqAgdgO7I0mHybZz1+A
	sGBBMMgUbkI3k0cl2w+DrXWaSPv9IuR/SueA8tEssFBdnC3YMIj0oaixzaXYMpMcoEpHIwhP+52
	lJ5lShb1Q6EFzQP6zW6IdY6WmxMM8nDpEOPOZud5T/i5D0pXRPWnKP3tEyLMysmE1m3dsmc0SUY
	LguWJa6eSS0drPPm03fyIRvc7XDA/Tu3mexAD+ardgdpCOOh6u8/cewH4T85igx9a+UcPiD3BCo
	=
X-Google-Smtp-Source: AGHT+IEW237e46po5P3TNWym6kVweYTp3ui+Tfd+KY8J2Cs2au9HsO2DmN64shkJWJ+1Bh3rPL/N5A==
X-Received: by 2002:a17:907:962a:b0:ae0:c6fa:ef45 with SMTP id a640c23a62f3a-ae3c2c43b75mr776144766b.41.1751556598199;
        Thu, 03 Jul 2025 08:29:58 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c013cdsm1289978766b.93.2025.07.03.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:29:57 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net v2 1/2] net: ipv4: fix incorrect MTU in broadcast routes
Date: Thu,  3 Jul 2025 17:28:37 +0200
Message-Id: <20250703152838.2993-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, __mkroute_output overrules the MTU value configured for
broadcast routes.

This buggy behaviour can be reproduced with:

ip link set dev eth1 mtu 9000
ip route del broadcast 192.168.0.255 dev eth1 proto kernel scope link src 192.168.0.2
ip route add broadcast 192.168.0.255 dev eth1 proto kernel scope link src 192.168.0.2 mtu 1500

The maximum packet size should be 1500, but it is actually 8000:

ping -b 192.168.0.255 -s 8000

Fix __mkroute_output to allow MTU values to be configured for
for broadcast routes (to support a mixed-MTU local-area-network).

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 net/ipv4/route.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fccb05fb3..a2a3b6482 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2585,7 +2585,6 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 	do_cache = true;
 	if (type == RTN_BROADCAST) {
 		flags |= RTCF_BROADCAST | RTCF_LOCAL;
-		fi = NULL;
 	} else if (type == RTN_MULTICAST) {
 		flags |= RTCF_MULTICAST | RTCF_LOCAL;
 		if (!ip_check_mc_rcu(in_dev, fl4->daddr, fl4->saddr,
-- 
2.39.5


