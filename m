Return-Path: <stable+bounces-3643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95373800C1E
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 14:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2523BB210EE
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1833998;
	Fri,  1 Dec 2023 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="FmLOmSs0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE11131
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 05:31:03 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b4c2ef584so19005535e9.3
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 05:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1701437462; x=1702042262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5p6zvJseRO+uX6rjn8IHfoR3BMVSCh4If1Dzpb1ejE=;
        b=FmLOmSs0DEIfMcDMR/FiuUZgCwpcd9ALernMV/o07gSL8MVcWdORWLw1OPToxe09js
         w18A8DFF4zunT0+BkLWbMZqRYlgGw2qCybGOIp0tHkep+RSUchgXoMm3Lf05VAcu+4q+
         UPfKaOdmrWIAGvwZ2o95ZVjOKRkxhJeP2IgqgIYuYId/SFQG1/qs6+Rfb4MNXWrN6kSi
         H+eazpbk7LKR7VlK0OnW+Yd3DRaiE7aGjsFCSQkHMWwQ/l7gJYngMnRjq4YDV2lDliTZ
         qVtJDIZhZJ6BmVGvK5/KGihYMz4u6ubVxWRSgwKnEN5Y3CoYx+2cNDSIpuB1XL8Kr7/Y
         Z2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701437462; x=1702042262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5p6zvJseRO+uX6rjn8IHfoR3BMVSCh4If1Dzpb1ejE=;
        b=SyzfW9CiesZkIAubLJmrC1cHw8EVBdJOSsOQa2xZTNmKvakPMkcXsMxDM61jsr+tG5
         FJapO6M1KjKZnaNHOAo+d7TFZOI/Lubz3KBTrOusqgcztYVkMniG9j5cs1RIIsZukvJz
         x6guy3y3XtMawYmo13knRNxjb7PCjjIoYI7A135VKDrX8IKw9eqUEFdHuWJs30T6sb6y
         3h3p5cUJQU/VP96zHVq3CVg3S/sHW9eE/GQUXh2dZHtPCiVFbEPGMNtvENbzADd5CMq5
         5w50BPuqKBh/H73Xbk+8/dsKdZ+MowEPvOgLylhTs2nI8lDuhhLoyxjbOFKhZ/+UDVLa
         YNCg==
X-Gm-Message-State: AOJu0YxRHdvtESCF/3QyVDIN5adlbH6T+3C673KddFhRiMkrS5EuORDP
	zvycoGEClDfWz4nqPr2Ky7X7UN/QT6vvIvQBodE=
X-Google-Smtp-Source: AGHT+IFKP1BczRgb/R1J8VuljaZX/9NkJlD/0Vs0WiDcgawdU2AIXmGyOHEifCj3sA0ZcAxFlvVJ9Q==
X-Received: by 2002:a05:600c:4d98:b0:40b:5e22:981 with SMTP id v24-20020a05600c4d9800b0040b5e220981mr581403wmp.112.1701437461763;
        Fri, 01 Dec 2023 05:31:01 -0800 (PST)
Received: from gojira.dev.6wind.com ([185.13.181.2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0040b47c69d08sm9081931wmq.18.2023.12.01.05.31.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:31:01 -0800 (PST)
From: Olivier Matz <olivier.matz@6wind.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15 0/2] vlan: fix netdev refcount leak
Date: Fri,  1 Dec 2023 14:30:02 +0100
Message-Id: <20231201133004.3853933-1-olivier.matz@6wind.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The backport of commit 21032425c36f ("net: vlan: fix a UAF in
vlan_dev_real_dev()") in v5.15.3 introduced a netdevice refcount leak
that was fixed upstream.

The first commit is trivial and helps to limit conflicts when applying
the second commit, which fixes the issue.

The last conflict is solved by using dev_put() instead of
dev_put_track(), as the latter was introduced in 5.17 and does not
exist in 5.15.x.

Xin Long (2):
  vlan: introduce vlan_dev_free_egress_priority
  vlan: move dev_put into vlan_dev_uninit

 net/8021q/vlan.h         |  2 +-
 net/8021q/vlan_dev.c     | 15 +++++++++++----
 net/8021q/vlan_netlink.c |  7 ++++---
 3 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.30.2


