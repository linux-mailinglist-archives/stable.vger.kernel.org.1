Return-Path: <stable+bounces-191717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BABC1FA34
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 11:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 454894E915E
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 10:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117BD3546E7;
	Thu, 30 Oct 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVn6MkF5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D782206AC
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821394; cv=none; b=VLWX7qx3EDoM8vaipgqXPaur9pGWdrMITQQHbnY7dHhObDeo5U3Q28zr+JAqyw4tWbVIrsEltFdyYzFf2BQ+4QqjqhFhgAHP1l9lmNGn0J9nAICwz/Tq0+2oPOkEXcI6ZQH52IUgEKcB9yfGQKEoZ7uISzncSd6jiVvvZjWzaiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821394; c=relaxed/simple;
	bh=VTIGLJoqL09T3qdqKCWT95vPfPOyfhp3sKIJURo8kec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ufsUHNFZW+5J0fRW+gMXz3U+bJsbnScx1d/Ts1c6TKhBLCg9xc9n0nDb1DOTGOBzUCDqCNuK6l36KWWffALDebQ7RPxNGhfGlSCCtzfdIEwpssPdmAQrE9BaFosV/o3y7Z5eXgE90lI9T1YgNag+rYvU7dNGIP5VZhGhHPzg74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVn6MkF5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33067909400so718911a91.2
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761821392; x=1762426192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3p2yqAWOCqYWEXlmFTpGQJoAadTNkNOwJpC5qXOYbs=;
        b=PVn6MkF5bwbrksfoO7vlX8x/1JzAkAOf/4MbPNeeb3558hEBSyEstX7WP+fuyy8dGe
         +lSt2nL4K36uzzbfMWgbrv9n2A/JuSyJ+rrG+l0YILSmP6BUTV1z9JY9gPRZie6C/1p8
         BmP2O0k2d+2GcPKXFKBLdH4C0JIWrt/EBtC7tEf8EHWFzCLR/fF7BYchlMBtmWf0JKSH
         GjSgLXwRVbD9WqSX7ERxzw0ivWQTpK8oW5H1mo8urSVbxPDuKlwh5DlgEMNXKyhuuFjs
         Y970H5fbV13iScc4HnGtM+kBCzJK3dmEZwC/suGQskNntYQCWlg/WW3xmFEOr2Im+ybz
         UT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821392; x=1762426192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3p2yqAWOCqYWEXlmFTpGQJoAadTNkNOwJpC5qXOYbs=;
        b=fQWVuCYgzMJOVbep9IMlrZViBIZ1d+N5ut9/m2yxWOmT8xkcuyLdDSIlWXlC0yEg+e
         gnvOqFbMczO+OjnGV+hn6gAFM559FLBC9dEcQ/DI1K8wvIpKUpZDzMMqC1D66ki4cUcy
         tnp7XNHtKRFanFoiYUr6keBnUjqNL3j0mZeS3nRewKMavyrGF7INcQ0cdQejeE0Jtcnq
         A9XTZDUB0KwWQJQQXEczRfe1AcnzShNPakERUgobJz14Crku0w1WF6b2dy0C1Q3c6FF6
         h6U8LfvvSyrtWD400gudDDA14s1ilZyZ80+rZWcjgy7+cGaWWkjKJXvlTneysJwsnnk0
         Moaw==
X-Forwarded-Encrypted: i=1; AJvYcCVlszlRTvNrrWrm8ECAEziDwhm4jIYdPb81iAwN+r6kvl0NLS1ugK3hSEsLvvG8BHRhOS018z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXA20aK3VJcc4uVAxdyhnZEt0hdRsKKtWxY4+C2CxydOuNB1yR
	r7HGwDIga3lrSByKf4Di58+5oeaeLejM4wCzqEE8g0vZdEJljMkAPNLL
X-Gm-Gg: ASbGncuCDAsCpC4l1808mSWvzil9AVhrbOOzeiBpAejer/T+thtnuEJSGLymvBksTG2
	CaVPphC/S0lxSPMavvMA+c6Njjk4CryFkSCNAyUJ6J6bAdeoQkYqrl+nObVVA9ngZVJZH7qn7R6
	irRIGJ0QA2SroQGgAQOkxBdycRZQpW66cY0tVdVrxlAjMyHa+ljbXJuZatVi6iLcho6/FjIpiY3
	hy9zDDImbxu4ZyB83iYx0t/ihgrYjbCjhcOOjd9GkExspHbP+bPb/Y5y+c08Nmp3hy3p6yVfb4Y
	PfOgIYxfhDBiZhkEEBvt8aHSHttZsVbAL+KBME6VvCYPH73XrFf4WrD8fXbcXzDybkXj1GodZeF
	hff/wAmLu6GYRc5VvBRXARL96epRobC0MskTC0sZupw5nyKXSmDtPP7Jz2oUZZ5WjTyCqI9+skD
	UB8VjOGrsDdzOpSJWlEIpdKg==
X-Google-Smtp-Source: AGHT+IGU7fXKMPGFniTXJxT+Y1B4SNOc8ney/kiF1ZfNDyydbRHCeKanSDnjrz8dd8tokm2NLVK8SQ==
X-Received: by 2002:a17:902:d512:b0:294:ccc6:cd2c with SMTP id d9443c01a7336-294dee491f3mr72004445ad.22.1761821390964;
        Thu, 30 Oct 2025 03:49:50 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d273cdsm181053915ad.55.2025.10.30.03.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:49:50 -0700 (PDT)
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
	stable@vger.kernel.org,
	syzkaller@googlegroups.com,
	vladimir.oltean@nxp.com
Subject: [PATCH v2] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Date: Thu, 30 Oct 2025 10:49:42 +0000
Message-Id: <20251030104942.18561-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030111445.0fe0b313@kmaincent-XPS-13-7390>
References: <20251030111445.0fe0b313@kmaincent-XPS-13-7390>
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
index ad54b12d4b4c..a32e1036f12a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -474,6 +474,10 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 		return err;
 	}
 
+	/* Netlink path with unconverted lower driver */
+	if (!kernel_cfg->ifr)
+		return -EOPNOTSUPP;
+
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
 }
@@ -498,6 +502,10 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 		return err;
 	}
 
+	/* Netlink path with unconverted lower driver */
+	if (!kernel_cfg->ifr)
+		return -EOPNOTSUPP;
+
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
 }
-- 
2.34.1


