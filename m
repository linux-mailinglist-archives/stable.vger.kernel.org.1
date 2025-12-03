Return-Path: <stable+bounces-198197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0B3C9EDCC
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE82D3A6977
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB7A2F5499;
	Wed,  3 Dec 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SH7PNnKe"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DDA2F5483
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762021; cv=none; b=CJBQhQPHWROAD3mUIVcytHO8WFyLO79KPxGxns88xzd2iht50GHmesn96g8SqlSmu+M5oFEJzTlh+jY1F5DonYAPyVRqwWhLXCv7ihMbtSbaIUFzbpz1OoNNytqGFWLSUadZOde2ekP6BRCBm/OWWwAMkohfAVbnEmBgH16zuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762021; c=relaxed/simple;
	bh=p/Rj0Psh2EAfAYgsAuA7nwQsyek+tAAKf0IyO3BP/S0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJxh+7l7ZuY8J7WtN5iqp2e3BaA6J49s08DJTYmQ9sU8Xcu0LwfiUwKddroCun2mSQqMqAWowbOZm59TeBefSOOZBJ3Z3M/sCaILnfNRTqh0+2VPfob4Am5G4A+f3acwqTld9fGFCS4OlqmzfllYEvgh9aUBbPq6FRMvISAXgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SH7PNnKe; arc=none smtp.client-ip=209.85.161.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-657490df6f3so2809771eaf.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762018; x=1765366818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ss2w7sWhyfqGOhk5P2wYsaAlaVXgk2DzRiIy1mHqt4Q=;
        b=ho2p10nszWxRlfa63rrI++vyx61KmeQxuTMCzViTxWyzlMcCfj78AL/XWZbbzxoRR0
         WFgzBH0afjKWPQqqs6PSaLPsD2Ek1B7E4NWqC05OzqvvHi7qJlnx1g+wLWFcd4VfktE6
         necakNNSwh6SdIk+PWLWcYeFcaBRX40RMM+N0p9G+A7E2GUQYWLv5fYjOl1q4yZu9UZf
         ELPXCIERzgVJgy7q3T2YgGsLho+nj10FUvhn+F2qafLMt/Nlr9Aog02IkmMSggg42CbY
         gqogvZ21NX6x64aUGzr3eSfy30p/GLhsVD2jfCvNdEg7BTnHCr5t4PjffoG/yYtkHaHL
         oWVQ==
X-Gm-Message-State: AOJu0Yx4ual+C6vxF+RKyFJYZVETfcjiAO2TPl5Ws4Dkv/H6heMtX0tA
	WUwdFZv1IVKTViJ3EpBfMe3dle/71kItRsM5XLIPPzh8oANZYwsjifM5+W1rBIZB11+HbfSvRM8
	MqkXLo1ccrrCmmqPYR3iZWlIURcXB+tnTEX74tWCvVqEzBxzQRBxqjsYH9gkU5W7/aZgYCTlkgX
	ZJUSlxyS1PtT2ApYUttejhwSzZMp/fEiw61XaQg3m+48TD/OD8x1CCd+leiMDTWt9+TrSTbwyc8
	fm83NVKSYg=
X-Gm-Gg: ASbGnctg3+l2JL80ef/Yzo5OaRg+BCyD3NJo7lRqOkW6HaBxzial07/1A8FRqKwfwf6
	DvpZeoImiOCkG/lQeP9mM/LpcaM+wRZnC50q7Cx9hhWZ8gXJcH0as3MRBtKPyh226DCcVa3/8n4
	m8vnWb90uOD3GXxbdNTjeUi+p+e4yO5XnwxSw+JzYt4OTN4ge+/zgqqwOEzfrDInmUNYjqCkYlo
	LBWYUie04TMD84uNkw1Q3ZXfoKop4KCM0nHwXIRP+HfANWrsskFwr4mXcA+Gr0Ea5UJluVJXgrn
	blUh25H2iXaqPahzCWcirpYqvyEJAeuQWpz6M9rzUAtAZj7yJkcAaR1qI3cDxYUrode1k67moOO
	CpUTqHVs/CgVT8tKOyqW3d4p4dR2uv6J5ZtWf1QDAEVtFe5ImqpG6mCdUcGsyRWYYZ82NZUwr5K
	xpFZdP72jSNs1Tq7RQL9Syidct1/CaUeIy4esHRegSc326
X-Google-Smtp-Source: AGHT+IFQHa8/KIYWPW7PTa0pX6dWM3NJr6tKhdeUx91eD/3P//6KPYuXumtt0Cs9FjACuGclRGruGozvfVKn
X-Received: by 2002:a05:6808:120c:b0:450:cfd3:cfa5 with SMTP id 5614622812f47-4536e58a027mr815508b6e.60.1764762018011;
        Wed, 03 Dec 2025 03:40:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3f0dc9fcf46sm1958403fac.1.2025.12.03.03.40.17
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:40:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b9b9e8b0812so9710823a12.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764762016; x=1765366816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ss2w7sWhyfqGOhk5P2wYsaAlaVXgk2DzRiIy1mHqt4Q=;
        b=SH7PNnKeTRhAf5Wklz/K+/0dIsNC2k//tvzSOWYCCBWlgFOiz7YpFUE3SG5p/PH1WB
         UP6czY2GrkqT6PAtazT+1JVy7XHzqjPtpF5cGTrYwo/UFsu2GxBZSG46CgB8d+n+Ig65
         5uxd29iWDMqG4uoJyLYtmCUzTNt15HNxNt550=
X-Received: by 2002:a05:7301:1014:b0:2a4:3594:72d1 with SMTP id 5a478bee46e88-2ab92bc0784mr1096025eec.0.1764762016360;
        Wed, 03 Dec 2025 03:40:16 -0800 (PST)
X-Received: by 2002:a05:7301:1014:b0:2a4:3594:72d1 with SMTP id 5a478bee46e88-2ab92bc0784mr1095993eec.0.1764762015471;
        Wed, 03 Dec 2025 03:40:15 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b1ceeesm63324781eec.5.2025.12.03.03.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:40:15 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com
Subject: [PATCH v6.6 0/4] sched: The newidle balance regression 
Date: Wed,  3 Dec 2025 11:22:51 +0000
Message-Id: <20251203112255.1738272-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series is to backport following patches for v6.6:
link: https://lore.kernel.org/lkml/20251107160645.929564468@infradead.org/

Peter Zijlstra (3):
  sched/fair: Revert max_newidle_lb_cost bump
  sched/fair: Small cleanup to sched_balance_newidle()
  sched/fair: Small cleanup to update_newidle_cost()
  sched/fair: Proportional newidle balance

 include/linux/sched/topology.h |  3 ++
 kernel/sched/core.c            |  3 ++
 kernel/sched/fair.c            | 75 +++++++++++++++++++++++-----------
 kernel/sched/features.h        |  5 +++
 kernel/sched/sched.h           |  7 ++++
 kernel/sched/topology.c        |  6 +++
 6 files changed, 75 insertions(+), 24 deletions(-)

-- 
2.40.4


