Return-Path: <stable+bounces-45340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEE8C7DEB
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 23:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFC51F223D9
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 21:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA72A1581E5;
	Thu, 16 May 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWUjoyL7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227481581E7;
	Thu, 16 May 2024 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715893951; cv=none; b=nhtx8+m8UuxW+nSyywpRQIZW19ZbxGgGUgjuljhGtfiIP2wGMEQ2cs5PFO4GURbW9GV9rcO5ZSyfQx1xyCfHXN5WeBiffk/WNIUG6rTtiRjqqNZTpivM+YQ8PeQ5Ri+0lL4n22FNRvOXDByPU034ROQoe3JFeCGHtbLT0uaZETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715893951; c=relaxed/simple;
	bh=wx9aXGL4fOtXdHE8CNQE+6FHvEPWji0l2JcHJZKefo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BheWY3J7pp4kqOKOx2Mrw9woOgE1a151RTf3JhmwwfLVl/OC9O1hDoWGy/zCcSpu12xCZkJclwSkVPvTG6T2TElRPuPMzXGWP2+qEmQfUUZlKW9FIfFP3oBj4Fy87WX8/SpPK1tYPLDcCCVdVjzCXXbCXd4yBzNtqep/llursOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWUjoyL7; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-61be599ab77so441743a12.1;
        Thu, 16 May 2024 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715893949; x=1716498749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ruv0DIKIAesJEAsoXoRLgxEpKi4m5Tnsvj4DfPFrnpo=;
        b=iWUjoyL7dqz+skiTRxF0JA1XQBVHinYS65RWUKbRhHqI24WkJ2DKNc9fWANDSj/FT5
         007d1WL/RLtjXN2g17S6UAKdRjFXU0vIsPZuK4dZBC+wmy/aZKIymFBWv7vCXMm+kSoY
         O7joz3moZIGsE536v1s5MssAi+DLhC84EdGAYvw3FODyHxpW6tqkAWkcdjnGZWz9fO+h
         YOnqqlRVob3XZYbrwntfTIRYUKv0so9yLFjOu/ihIWEXYIS7rfzu+Xa5qIMUMmrCfjLR
         8fzRqmDCSneOBkdSuborc0x4YQSZ5k1OBLgCR0c9U4MOfn07YLBdR4P1/5Uv3/oCImR7
         9BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715893949; x=1716498749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ruv0DIKIAesJEAsoXoRLgxEpKi4m5Tnsvj4DfPFrnpo=;
        b=lLfPXtqlZyjI6XBuDykx1+Pu/ZLW5ZX9oHy4Ww7UIlXaa3Pdrtc5Cdd0A+1nLYnDCR
         raHjLjUg//iiDaHJ+ootynPnj7mqQ8j29AdkERRZ+46IUFiY4vU3KDXO87rNLbTI+iea
         b2YAO3rjKgV4iNmps/oMEt41mQpxvxJPQsRRWla66TIw00F9eqFiWY6vDMHNTvxAUrsK
         YzbYQ5NCUbOacpB7nIWRNgJu9gLfTSo0cjzCwZb31avjbmohKH0FU+ftVq+5Lkk0/2DS
         a5TEmnkKCnKsHhlP7fSUVNmBx62n4vlzgq0v8Jhw2K2hembWLcKL77HphCJVORMsv9t0
         YVmg==
X-Forwarded-Encrypted: i=1; AJvYcCU73AtfE+QniJrlquWuxIM1UeFkkKaJRdy9qFChC5zv69I4FOLwI6qaFjFYuvDSEBzmlOC8XYyLDuWUxK2IXOUXyPwTocfoqHao3+pLSDA8kiTj4LALWvcFKuz2/p9ao6MHVMk+
X-Gm-Message-State: AOJu0Yx4hKSNUiF/G/bSG42mt5GkSHFpUy6oVOx+IVXdsBmDZfomYYTd
	gkskd2PugzSORI2Ajht3u2+25+iNc8HXAngibHv2EZT7VXSwQlDggR43BQ==
X-Google-Smtp-Source: AGHT+IGu3WDRq62QboOOfJi0Pwov9wNPTLiji//Ed1hstPNX8PwPniKAtFNW4JzZrdgJpra0ZpzbTw==
X-Received: by 2002:a17:90a:12c2:b0:2b2:a1d0:b61c with SMTP id 98e67ed59e1d1-2b6ccfeee24mr14181018a91.47.1715893948832;
        Thu, 16 May 2024 14:12:28 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca5279sm16116918a91.41.2024.05.16.14.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 14:12:28 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: stable@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH stable 5.4 0/2] net: bcmgenet: revisit MAC reset
Date: Thu, 16 May 2024 14:11:51 -0700
Message-Id: <20240516211153.140679-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3a55402c9387 ("net: bcmgenet: use RGMII loopback for MAC
reset") was intended to resolve issues with reseting the UniMAC
core within the GENET block by providing better control over the
clocks used by the UniMAC core. Unfortunately, it is not
compatible with all of the supported system configurations so an
alternative method must be applied.

This commit set provides such an alternative. The first commit
reverts the previous change and the second commit provides the
alternative reset sequence that addresses the concerns observed
with the previous implementation.

This replacement implementation should be applied to the stable
branches wherever commit 3a55402c9387 ("net: bcmgenet: use RGMII
loopback for MAC reset") has been applied.

Unfortunately, reverting that commit may conflict with some
restructuring changes introduced by commit 4f8d81b77e66 ("net:
bcmgenet: Refactor register access in bcmgenet_mii_config").
The first commit in this set has been manually edited to
resolve the conflict on stable/linux-5.4.y.

Doug Berger (2):
  Revert "net: bcmgenet: use RGMII loopback for MAC reset"
  net: bcmgenet: keep MAC in reset until PHY is up

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 10 ++---
 .../ethernet/broadcom/genet/bcmgenet_wol.c    |  6 ++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c  | 39 +++----------------
 3 files changed, 16 insertions(+), 39 deletions(-)

-- 
2.34.1


