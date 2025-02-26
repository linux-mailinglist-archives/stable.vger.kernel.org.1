Return-Path: <stable+bounces-119730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD648A468CC
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 19:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07A81721E3
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548F2253A4;
	Wed, 26 Feb 2025 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA6EZcwM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578B15C0
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592974; cv=none; b=rD7CsxYbp+3zLOo6VL9d/Zm2Ogl3RoQSEeSfKQ7vRYCujPM+EzQa6pgVXzCoRRYQjXroC/bfWkIEMvd3Z0y7BymCosC+LActnuBo9bau+eGapV8Ye+37+roK4OLruGnrlwHDZHCLHcs13gtlgxjmLG4CfowTHUWJJ+m+ccJXDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592974; c=relaxed/simple;
	bh=kXbzESS3mCLsUrxyitsWDEXhLMPGdifRyCftEdoFOMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDYv+KWdtUnvVHYWS9j5l9BdbdPvN6m6LMfBnwPXh+TPnsky7OqH/XEiFO4HrYzjsmo7ijEjPN31U8hf65B0Ym8cr2fgbcsusk7PyzCtAcmcIqVjfsF7hkV3sP8GiYcaLz4OK64qmSMdcofR1WMV++58N5X089INrJaFRyE+8QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA6EZcwM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2211acda7f6so567905ad.3
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 10:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740592972; x=1741197772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGO+TUjH9/dGIuqYHnBTxnyquN973Exwm8f9ms5HveY=;
        b=FA6EZcwMfoQNx64NjOQeu7YSJst9rs0QT3fCf06sZsmf4w2ouINljcq0a1F59Nuco4
         XbfShH0z5vurYde3Od4G1Sd3RUtbC2zfWDnKMFRlvnr7yk7uf76fuRM5S0fmUFUbI4Wv
         Q2ItXONzQkPzK/8BzKif/amzOihTFtZjjtlamziTU+zB4XPBFG7uodEzVxLX1wAZSPDf
         nbsmQhqpnE0mRBG6wgyLw/hh7xVv2/dAaxW82OGoSjeoI5a9iyydjbr+ur3yej+THQut
         3zqN0dmhBsa145wgSUPvxr9FCsxepWoJuYOf2lfG0zuQ0yEkkMP4Z45whl044y1oFr8h
         E/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592972; x=1741197772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGO+TUjH9/dGIuqYHnBTxnyquN973Exwm8f9ms5HveY=;
        b=qf15kMBCMBiVsWVO7wIaG3swNDwuWiiY+irKiuljsFthouaEgXQmdNQmcD/Un5xM6S
         XL0ID2QnCMkeMsn38MCF+9fwAR9Pv5gqlMzfDksVCx/kcABhIH964jVM+hmdVTEN/M0J
         vxWGsVRQUCXhsrXVJgjlmS+TeHDXema21jKLbwu48OS/RRLuAFtj69L4NhHjPvNsh3O3
         EAwswS08l6BrAkFTcz/Pa90p3BtV0IpzXY6xEhvyTdMRwfxzCTvSPnTvQjmta6mOpmvy
         +j8j89ZRttD2af6UVQzjehkhHw2mwb2q2+wsqyRA15DA2o0UXprWhpBATWA0jj+mIa65
         5p7w==
X-Gm-Message-State: AOJu0Yw4ipbUfIlFaHqpiSJJoXyi7tZfVTfth4Eq0i4DuW2qvi/5hwOy
	JuBp2HGWO0lWmxQcTwo105W/X0MNcj4RH2b08XhT16RWigDXKbCVZhbwOw==
X-Gm-Gg: ASbGncv0vkJKTkhhhj0KwvH6lGJ32oFQbP1i27lmpUPnkLen+FomeN6Wc1W7eEG5xtS
	Ni3p0wk7/0nWc7bk+GOqvVW1CZZJgWYU+sOe9qUA9WPktsdxDtFuy53Vkk0KNyYNoYIqUZpoF96
	3JO9Y5gmYeQf9gs2aRDAenqRa49W05dWKxZkEnNolsANsH8uT6f3dDgOzynXqwlRGt8x4ZlGLdp
	wEn3irPhovBnjcQXX7Un6rh8Nw2U20v7htURQpvLZozccpKbAm1wFb7BxIbl6tbbkc2G1JVj0kX
	0sTfEvkvXCrXDaIye9Q8wzv2HwccWvOHfV69N8+CC+4fsNxdGwLIm6iHICova5IX9g==
X-Google-Smtp-Source: AGHT+IFMNHYryERrlCNNOggV1iFPDUo3aTKeIseo1EZbdKLcYhUywM5Tjcllj7PBROQeB1HAr/fskw==
X-Received: by 2002:a17:903:2f8a:b0:220:e392:c73 with SMTP id d9443c01a7336-223200a12f1mr64239795ad.22.1740592972202;
        Wed, 26 Feb 2025 10:02:52 -0800 (PST)
Received: from carrot.. (i118-19-4-47.s41.a014.ap.plala.or.jp. [118.19.4.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000995sm35747655ad.46.2025.02.26.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:02:51 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 5.10 5.15 6.1 0/3] nilfs2: fix potential kernel BUG on rename operations
Date: Thu, 27 Feb 2025 03:00:20 +0900
Message-ID: <20250226180247.4950-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please apply this series to these stable trees.

This series makes it possible to backport the fix for the BUG_ON
check failure on rename operations reported by syzbot.

The first two patches are for dependency resolution.
Patch 3/3 is the target patch, and it has been tailored to avoid
extensive page/folio conversion.

This patch set has been tested against the latest stable kernels
listed in the subject prefix.

Thanks,
Ryusuke Konishi

Ryusuke Konishi (3):
  nilfs2: move page release outside of nilfs_delete_entry and
    nilfs_set_link
  nilfs2: eliminate staggered calls to kunmap in nilfs_rename
  nilfs2: handle errors that nilfs_prepare_chunk() may return

 fs/nilfs2/dir.c   | 24 +++++++++++-------------
 fs/nilfs2/namei.c | 37 ++++++++++++++++++++-----------------
 fs/nilfs2/nilfs.h | 10 ++++++++--
 3 files changed, 39 insertions(+), 32 deletions(-)

-- 
2.43.5


