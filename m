Return-Path: <stable+bounces-118588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD61A3F63B
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0940616E875
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BDE2054FC;
	Fri, 21 Feb 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTGQotzA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E51C3BEE
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145138; cv=none; b=II1mF4TvPGLV0kkwo/BBFKwvoSdvhz8KOel/I/BJQbWzTTS+x7FVtrUWnQIsolYgSgQP5U6j9Nq09Tl+IMQCRFJFy8zXXTioo/TeTwcni/XzAqVJW6g7alVEIJuwbdynemoWR2M0Wqo2qnblRvNfWNbvyhJEDWO2hhEDJzLU148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145138; c=relaxed/simple;
	bh=7nQW31xNZsaPQqaHdgHPCPTkYiSa/0/04MaKO9cquf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPgHm/791NLkUKZCj90Lj9lrusQWcxxPkG1OIHhKGeAyiB+OBVPQRVRO5pSSpTLpWWbP3U+8AXYA9uglLwyFuERTAYWTj5yIIxTYOkZ2b7G+Vo+UkcFtz/1AT8JOWshLWBZYuQNw6vNAYuGmzpf2cCbil5htVJoDepSs9kN1GGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTGQotzA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c8cf98bbso45796545ad.1
        for <stable@vger.kernel.org>; Fri, 21 Feb 2025 05:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740145135; x=1740749935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rGyqXDkunWI9qtnTdWNbc60db+6gGDdnTlQQK1pRs5c=;
        b=UTGQotzA+zwmhMn4truiieRAid9Cwdhxa/GsHTS0muWbUOA5NODXsZx9Yr4hCh9BuJ
         2DzmbKHDv0dM57Hf+qv/sznUXS+UHVuANI2IlS3P2d+cif/sgoGG2uP02fakRMlRTc8T
         /EAMilacvRNyCrUPRpsDVEtjRMs+vRcORTZ4+H1c/FkNqh0bu7BCSK+KYwNo0eShzTek
         niHQnwVgQegq5AXI8P3ew9uo7GUDwUjDBkumqbaPygvuRkJ+XJ69b+tsJq+6ZyghqMVj
         KL4YIcnptW5TcDcflJGU+J6MXdSR3TlijIu4oH3aEd4jiaLAJh8ja1lU/ycV4XfiPedn
         9vTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145135; x=1740749935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGyqXDkunWI9qtnTdWNbc60db+6gGDdnTlQQK1pRs5c=;
        b=aLY2zmJohDS7dSuDxhnFDkUWnKEd/OHtdA68QsS9Y0VmEKOoWvfKajSAZ5oa+lVtZ/
         hmwJ9LgbxR9SKsK93++sa0rbNNhm2jLzWfyY56BazxK0yJoybQfjXwZQABLy/0m7PEJE
         fe1OcTNmmb33QuRo/PEFMtKQCRG7XauBei3fV19Hmw974/Wsq8lac0abUUrJQXuiESzT
         oD6sXSnH1WJfoR+ha9KtJwqDyZDuFDWeYkVzsTe3q87+Rt4B2LsgcIztMDGqWv38OA+9
         /0hnGgGb4Co/o5BocCndl8i1XfKt3J1GEYSCnFlFjBj9gXzjE5i+M2O0a66itgTSY87t
         cXwA==
X-Gm-Message-State: AOJu0YzRGMD30htskjle/nNLonBXgegC4m1kkSjBuIZAQbYwTIyR+Rfn
	IG/iH6WdfZl/rRzcLAmUObqMDud5KZL+ZGHbHfLS43bXtciJwNmpnCSJLA==
X-Gm-Gg: ASbGnctlYzxY/HxuYxB9QhpCtc9Ki2aclHqkKqGg0kiTI4DMBZ0dq+6mOZZB/HyGlJu
	6nyLEiF1gHASgt9JmVYnfv8thnO/LDId3yy5C0bjBSF1SjrwonsZIlNEUfbl3CF3cVF6MRoI3lc
	1Q9Hp19owB1BFNg76y5Ph6iss3OTN88EnAfe9+CfrfMtRcvI/pW2ObquW7M1MciOiqVkUyz+8kJ
	OWLYWERkckqGc66vTJ4xZ9AGa1CKB3Vm8JRAbq9iOHvVkG/JcdQU+D8Va/Fn3xHQFTgdT2El5bK
	JMXJwBkS4MZzIFkiSHvhCtnclZdkOXZJ+PhdsBUa3N6dXY4FCPfh3dCniknQMLuojqpBUVq+KA=
	=
X-Google-Smtp-Source: AGHT+IGyXHHFhisRjNmQtVmHriATN2gCgCcN5bShzj3RMSjk/VBv8Kz6Iivxu9OdvGVztSQGWdGP+A==
X-Received: by 2002:a17:902:c94d:b0:216:3d72:1712 with SMTP id d9443c01a7336-221a118cc5emr41570815ad.48.1740145133959;
        Fri, 21 Feb 2025 05:38:53 -0800 (PST)
Received: from carrot.. (i121-113-18-240.s41.a014.ap.plala.or.jp. [121.113.18.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349047sm137818645ad.7.2025.02.21.05.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:38:53 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 0/3] nilfs2: fix potential kernel BUG on rename operations
Date: Fri, 21 Feb 2025 22:37:52 +0900
Message-ID: <20250221133848.4335-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please apply this series to the 6.6-stable tree.

This series makes it possible to backport the fix for the BUG_ON
check failure on rename operations reported by syzbot.

The first two patches are for dependency resolution.
Patch 3/3 is the target patch, and it has been tailored to avoid
extensive page/folio conversion.

This patch set has been tested against the latest 6.6.y.

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


