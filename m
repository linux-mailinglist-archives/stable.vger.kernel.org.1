Return-Path: <stable+bounces-191710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFFAC1F541
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 10:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC1DD4E8715
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FC5341674;
	Thu, 30 Oct 2025 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP5we5U6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20333F8DA
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816992; cv=none; b=m/iRymXnME5fhsxLrh7HshBLPpiCN3e4YooHpufLOrOvfsi/HfMmzuK+TaQFKS3+nt4MRZXxAB4tncwsiv2fSxY1eJpdZJTkfbjrg8+T4mYxl8/z50nFPghalrRyh+WAqgkt0vLjU22+F/JLiM80nZVGqdxBijGPOv7FH4WWfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816992; c=relaxed/simple;
	bh=sfqSbMdJvCJp1YjMxi5hsyF0u2V6uwNe3n1xaSR62Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGzyNUX2mCYii8I7cPZTMQLJgf37G30I5ZCOqcMTtuUM9NDZD5VUrdFXkEfUvR19HFvvk++8rHVRCDUhRF9bKT0KEeXOBN5xtkaoR6obEZ5pkuNivIKz94REg+5FN7UrxFkllsQM3SzXGXWOm+YMWvDL1pyeswsbQljHTjodhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UP5we5U6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so839035b3a.1
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761816990; x=1762421790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAGiv6sfeXhaN9XGho18iG32VKPlMqvx7GJaQfDv2XM=;
        b=UP5we5U65nErVbz2Uyp5wIQzvu50EDf/ELjv6em+9jP7EK6b5oFWJnty0rz6R37ose
         pD8RrnjtbB32I/lOIDtznAt3cAw/SJDUUN+4B6uzmuo7reqegolNb2TuuGcHfFBuIlsv
         vprhz/DcomVkLcJAeHb7+fB+xbs8grfOYeQTyUHMJLSX/PCcr3YkEq+h7Ot9QPqvZvxZ
         8xtD6Tal4ogeClGXJQp/n1cFCmyLDpbLisTvt2BnV6SLGePoktQuYzNQ7pLLNhahRzFN
         B5Gg3HASIJxN2pfMVj65znfcadySnFaRRcR9XqzNd4YDFljtEcwl+0Ujf+eNtH/MUY1D
         WFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761816990; x=1762421790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAGiv6sfeXhaN9XGho18iG32VKPlMqvx7GJaQfDv2XM=;
        b=DXDc3Fmn/14U5qzf0y8b8CMjACf9HQnfx1eGp/cbE2krS+8FkF4h1MVfFYaG5HnOB7
         Hr/kAJOzWcAX7sytn5KGLUKsePTwYGAi2+VcliYJ6HMp4JOceThilM1omqbKtgkHos0K
         21U5xCcRLNTBIqUBEtWub6VkA8uQndvDRTutY2JifzjelFKnTGLEoip8FspUK8qCJMvy
         WQkziyAWK+9CsvzyxPOMemy/F23avVcwUjZJLbB7gJN+a74vkr/UXwc6eOo3NNjPgUVS
         Qp8lTyRYTFGemCgUeEy+aUOAP/on+bdhlQZrFRQJ59hyYU4UzSt3VHslHIPdbyzH3dvR
         NJyw==
X-Forwarded-Encrypted: i=1; AJvYcCVb2kviEF+6i5tl9QwlJziP0fmePdv0MuzVBmm7Y8UWZclXbX2Mf1k3UxZBgkXr3Jls2iUpRBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPJFUYZ9WJMYvUxMn/AsLpMYKF5GcD1vkwlhi6vJRRWjWxy1y
	QO9n0rwAYnv2gZ9XjBh/53pUz9iPwvQedguRWqz5gKu6hIUnvVmaXEy6
X-Gm-Gg: ASbGncv+99pAU3arr8RN/Ih1LP2qjGMHL9vHf9twEXLU+Pxv+asip8VQdNBvrMep2W6
	x9rIbamhkqBnJispOXEvCrHnWJqJxsPXrrUhLgClH42eO1EYKjV6tMrFMBkPD7E3vjZK06njUw1
	lI+zrvDzv4fgyfMBLRqtoqc4eWLIlQ34tgRfzcsW9WixAjSPkRiTeU3VIRgjTtX4tnzZncI6ecF
	Nj61/K4OKvJUZ5SQr71PGbbDeK7nJeTDPvYStgvKGsVMJRipIxg0fKA5coLFsiTr5X8aL9j16+4
	j1AsCpRkGPP2sYR4owbNI0LEviPG1uZm/mzMOGbZtHEYWd4Eyjr9F8+uekujVMIvzXaGSLUppYh
	8iQhjupE23+7BUaGAmX7Q08G/YTfeMCTmry5oxsaw4tHgSkckYH4/loAtaqg9HUtxXRrgwrDA8y
	YR6jeOaD46YS9j
X-Google-Smtp-Source: AGHT+IGdKogiwWyOyyIFYlPsQ9DYU+/bEn7Q1lh9S2aXq6iqPoD0yGhRazUW5aaRnUgYkm8dLjuIKA==
X-Received: by 2002:a05:6300:210f:b0:334:8f40:d6bf with SMTP id adf61e73a8af0-3478768ff1dmr3641729637.42.1761816989410;
        Thu, 30 Oct 2025 02:36:29 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([123.124.147.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7128885251sm16003643a12.17.2025.10.30.02.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:36:28 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: kory.maincent@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	r772577952@gmail.com,
	sdf@fomichev.me,
	syzkaller@googlegroups.com,
	vladimir.oltean@nxp.com,
	stable@vger.kernel.org
Subject: [PATCH] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Date: Thu, 30 Oct 2025 09:36:21 +0000
Message-Id: <20251030093621.3563440-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029110651.25c4936d@kmaincent-XPS-13-7390>
References: <20251029110651.25c4936d@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethtool tsconfig Netlink path can trigger a null pointer
dereference. A call chain such as:

  tsconfig_prepare_data() ->
  dev_get_hwtstamp_phylib() ->
  vlan_hwtstamp_get() ->
  generic_hwtstamp_get_lower() ->
  generic_hwtstamp_ioctl_lower()

results in generic_hwtstamp_ioctl_lower() being called with
kernel_cfg->ifr as NULL.

The generic_hwtstamp_ioctl_lower() function does not expect a
NULL ifr and dereferences it, leading to a system crash.

Fix this by adding a NULL check for kernel_cfg->ifr in
generic_hwtstamp_get/set_lower(). If ifr is NULL, return
-EOPNOTSUPP to prevent the call to the legacy IOCTL helper.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Closes: https://lore.kernel.org/lkml/cd6a7056-fa6d-43f8-b78a-f5e811247ba8@linux.dev/T/#mf5df538e21753e3045de98f25aa18d948be07df3
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 net/core/dev_ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index ad54b12d4b4c..39eaf6ba981a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -474,6 +474,10 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 		return err;
 	}
 
+	/* Netlink path with unconverted driver */
+	if (!kernel_cfg->ifr)
+		return -EOPNOTSUPP;
+
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
 }
@@ -498,6 +502,10 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 		return err;
 	}
 
+	/* Netlink path with unconverted driver */
+	if (!kernel_cfg->ifr)
+		return -EOPNOTSUPP;
+
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
 }
-- 
2.34.1


