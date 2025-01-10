Return-Path: <stable+bounces-108248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06549A09EE9
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 01:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB62F188ED55
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 00:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0597D7E1;
	Sat, 11 Jan 2025 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="ZgHdXtEG";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="DvbC7oMf"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A96634
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736553773; cv=none; b=Cpcq/k+eaibQVE1yqH//1YrRCi+rpaQP05ILYJ16/aPLPD0d8H6p4Vhes8VnnqQQnPX93NKlv9graB6vP32WqP1aL0i94RHNT7s0C+NpsTe322xSgLMoIAKoqg6fhMkewU99Hvb1aGd0nLv/mCZ6GfabkbgUNtjKSKah0IXMN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736553773; c=relaxed/simple;
	bh=eK6+jIZVoWfg5kTomRU8zhTFqBhjiK9fMT3OGkn2BCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LhiBW/FO8XFjTJe0Cgk+B8zDJGKLEJ1FVse71WnwYMRf0Hb3/xfSqjI1v7cIg4H625aCiPkLqfaugpDpUBsOm1IHjsKcavkH0hqeHthhxvaPzkA9c1JD/wTMLpQxeWViWB7T+96x5Cht0WrlqQUTJR+VcAS6Zdd+vSvxdnYv22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=ZgHdXtEG; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=DvbC7oMf; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1736553771;
	bh=eK6+jIZVoWfg5kTomRU8zhTFqBhjiK9fMT3OGkn2BCE=;
	h=From:To:Cc:Subject:Date:From;
	b=ZgHdXtEGz2bbrf0fSDPaBPN8gjiy9IQoy5us+d6NB0FXOrL0vurRY5FgR2S6QF7zy
	 OPzDC1o00AGw6e/GA2NsPtzUvEcb+LAPSJBRYD65bQgCgYl5613TM3Gvv+vBwrgu9h
	 MwvCsMsJUkHZgouGjAyuyi068/yqmytIqh/CXhYAAfxwqkC1y1sl7gbx+gFFx3aM5g
	 ZiErMFhGv5LlyqQBRoJpjnflJwRiLL0VCM31gS/6iG5cpFDpPWlCrWYiKTpnts90QM
	 wWX5d0nV5k5/w8xG3fTMbh8S0hdQQWhs9o2IqWTJ/ZIptwZAxYiC06uhaHj5BGga8I
	 RIrlgXtxkksIQ==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 1E87AA0
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 09:02:51 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=DvbC7oMf;
	dkim-atps=neutral
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 019CDA0
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 09:02:51 +0900 (JST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6e6cf6742so631513385a.3
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1736553769; x=1737158569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KR9Jb7+M96a7m3wyj0Qq3Ui7G5w6rg2/MtJ+sETTqwU=;
        b=DvbC7oMfGQGISRXsa+8wp2i3fjVDoXdZKpM6IukpOxF2TwAIeLC/qrZDiANqJphEHV
         2iQebgT7TI5ZoXFe9lzLQx3rlkQ0svOdtZmpky8cskMKYzn6oeZx/ok8mSHmCG4QtwVS
         buBMc/cQUHcM4Wv1rGiM3RWPgrn0TeTNDrE/bUrJcSY6Abziyna0/Lhpqude4h4bj2kn
         PVByj3RhAeWjSGCq4UjJ+Zn6O9xcoEPkfiZ8q6+aZy+CdCSaojKdvIHHQzh+kBrQloQ3
         ANBmPJkymvfiQKt2Ar9p2nA2lCrYrN4om/EF170UkNIZYzzvdb/S5L/6fKxP2qisxuqw
         4AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736553769; x=1737158569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KR9Jb7+M96a7m3wyj0Qq3Ui7G5w6rg2/MtJ+sETTqwU=;
        b=mjoFmuHfnWY/E9dCu2MsG9yyPE87NeEtmm1+HTwT79RtUBEqmhO4WcjIDa25NCgPO7
         gGwkem4JQcU8ry8d5OgUR0Ew+LLuMYaFMxFAZiZwZYkClZ5d1tdtlyVxn5OM6B3CPBFp
         EyCfUKyR5sTE1J/C//qucnu0F+NButCqHsdchz/MpTEiAuR3zema+95QQ3N/6l4KPC7f
         S7LLvwic3mgv/IU2DLl4bi9E250Pgsgg5Q677akkBDidWNtfBupAT5ZxsvSbhHKGPLRI
         HtjmymSVK5yZWD4lEtIgJ+f2Qa8lH1jIrTIgjCA/fziruH8uIpMM5F6Gc8Xbvumlgh7b
         /Tcg==
X-Gm-Message-State: AOJu0YxgQjwvhCUb+C6slINgpli95Ef+K+AWlEpPbknwRw1b2esFWHmv
	GTaYtGTrSD0pMX7XZvkZXYAVyvW20M1FLlzh+USPw1I2GIEMfhWzAJEM5ki3MwwGybbv2CsveRI
	X7jk6508FiT0KsSXReH3Qr+Koc1Rc8rAINVp8jjHUJsg2lIwTY7OQbWE=
X-Gm-Gg: ASbGncs8rbrqnHypVJZLlHboTQGXsEy22eJYJZowli0ysqwpeG/rGyRWKhOFCp8Hvmv
	TcUQu4R6h8t6stotKXzpzeqIDVrB/yEfbdHfsKFcmJyGREdNT/XN8JHIBzGynOVEpunqjheYHdk
	BWY23XGiz6rX+bKh3ie0WsWfAdFUbJiCM7sLDnfAPjddsvQWFIIa7Dicy0yrjIIh19KCBSkSilQ
	b+8nIaNS7QZnQjFEd3HdrVYaqW2nypHZaIvcX5H67mbmnbM+HQTFtvWYQga8cK+iIzeyxcGO+1O
	CXEgjQkEY5ixM7Fb8+D1gYS9BHwSFw4XjSTFIDw4
X-Received: by 2002:a17:902:f693:b0:215:a179:14d2 with SMTP id d9443c01a7336-21a84009d06mr128912775ad.50.1736495930205;
        Thu, 09 Jan 2025 23:58:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzHWwgLPaOeVSM+1jbeshjC7R1SjDFRzk2NVokl2pNGuifQbicAyr4dgasHpvI3I4p+9/enA==
X-Received: by 2002:a17:902:f693:b0:215:a179:14d2 with SMTP id d9443c01a7336-21a84009d06mr128912565ad.50.1736495929872;
        Thu, 09 Jan 2025 23:58:49 -0800 (PST)
Received: from localhost (103.131.189.35.bc.googleusercontent.com. [35.189.131.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12fbf1sm8992735ad.77.2025.01.09.23.58.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2025 23:58:49 -0800 (PST)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	patches@lists.linux.dev,
	Kairui Song <kasong@tencent.com>,
	Desheng Wu <deshengwu@tencent.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 5.15 0/3] ZRAM not releasing backing device backport
Date: Fri, 10 Jan 2025 16:58:41 +0900
Message-Id: <20250110075844.1173719-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a resend of the patchset discussed here[1] for the 5.15 tree.

[1] https://lore.kernel.org/r/2025011052-backpedal-coat-2fec@gregkh

I've picked the "do not keep dangling zcomp pointer" patch from the
linux-rc tree at the time, so kept Sasha's SOB and added mine on top
-- please let me know if it wasn't appropriate.

I've also prepared the 5.10 patches, but I hadn't realized there were so
many stable deps (8 patchs total!); I'm honestly not sure the problem is
worth the churn but since it's done and tested I'll send the patches if
there is no problem with this 5.15 version.

Thanks!

Dominique Martinet (1):
  zram: check comp is non-NULL before calling comp_destroy

Kairui Song (1):
  zram: fix uninitialized ZRAM not releasing backing device

Sergey Senozhatsky (1):
  drivers/block/zram/zram_drv.c: do not keep dangling zcomp pointer
    after zram reset

 drivers/block/zram/zram_drv.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

-- 
2.39.5



