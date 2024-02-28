Return-Path: <stable+bounces-25386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D876E86B3FF
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83311C23018
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 16:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B24115D5DA;
	Wed, 28 Feb 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZ0vSSPj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0ED15CD67
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136141; cv=none; b=Y58z9XKmf9D0QI4kv4N5BbGVA5v+nSG3DoHwn7jZOKQzi0oIdYVM+ryjtAK9cqGG+5+PD5hVqh6m2Ptz0bDIPrtz2pACGBXTlE44kFY93XneRg/74TNx8MqslEsCAn0yfcdj9Aqs+t0ihngKineCOuWFk6catMwTHIEUvGXoTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136141; c=relaxed/simple;
	bh=8cqkb/NZkYtK8b/nuAyQZ4SuAHiDijCUwWScznwSvJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYO617N6IzCNe5Xkwc6ghdB8CpQg/CPK4WgXgXC1dH9r7jBeejeV6XazkXYp/TSKWo/2NCeH4AoZ3tZZkX44HipWHerI+x88pK2FvaeBmuFrQIidVN6ZGfc3UXR6F7msM1JztyjzJn7tjtU4TIhSG6NYaZZ/f5Ub+/RpzGk3ooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZ0vSSPj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709136138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WP42bm8xvL/lRAIfAu8ESZY/T+/pzLIZT0SH+0ebrAY=;
	b=CZ0vSSPj2pauJrEPAxLNSyibbCiYekCQmgzvKnc2iKla0Q+gdstRIUJd/bc95CnCA5XOte
	gEGKT6eKZZu++2QVbAIJb7fN9BTUW9VRfgXJ6m0xH2EgswyGsOSChXNYnGoTH+primtCh1
	h1QesJdD83s5q/we4Lj0VLsEMGR0XQM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-6HdCqrcVPPup3TcPHBLmww-1; Wed, 28 Feb 2024 11:02:16 -0500
X-MC-Unique: 6HdCqrcVPPup3TcPHBLmww-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56451e5801dso2811787a12.3
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 08:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136135; x=1709740935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WP42bm8xvL/lRAIfAu8ESZY/T+/pzLIZT0SH+0ebrAY=;
        b=h9xRxP8QEZUBGgYabKxrs36Q1ntOZZ7ojAEZPmsWfeBlmAvTzt81I+ZwcPub8AMz7f
         MRqToF9XnC7tfDEchUSw/9jsHxCX4MMX9kZLq28718PqUyJqMnTuAsq2iG3ffG/5oWAg
         O9Y24radS18ad6j6wX8PpsOG+XYLmzbK2CG+Dl8bMaNFW04a9gI+rxLmxAobTMm3FiAL
         4As/g2KiKID/F7FoNVF/VuTetVmEDkUvVzuOH0BDqL2gwq4Jk1b/VqjxfF4aMx3HNjnz
         jxG6/hPehnGP1iJLL1PcEKsKPe0yFPpDDd2cRdpRWX0Ze+KsDZNV60KrVFTBi/xbbrKv
         gERQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGcv10RuDlFzSEmleq/RT31Lym21qejgw9hhB3SsARK0zRKf2ZSuqmx/hbGUFTl6H/Uh41IvaVdCLcOY9Wil4T7rd3lL8t
X-Gm-Message-State: AOJu0Yw1UwtQ2FMpTId34vV9bIrRcl7XWmp7T3+I4Ju7mnnJQlPaEYJ/
	eQ1hMRdf0mxfxc01IADV1giGHsnkdvILlpxiq1VQstKMz27vOW9wvqHC7Z5a6XNEpP6suxsI+q/
	y9ARaF25hSMweh7ET1dBtrdK3eDLkmFM2pSxHmp3S0cxP2J+bF5Wsfw==
X-Received: by 2002:aa7:df83:0:b0:564:73e9:a9cd with SMTP id b3-20020aa7df83000000b0056473e9a9cdmr9669399edy.31.1709136135661;
        Wed, 28 Feb 2024 08:02:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhhOZBBGievRQ2E08GYgV8+5DLLuEJUMrQs4R+hCjv9A2VRh4drqAEe5JKlOv5W337oXfK8Q==
X-Received: by 2002:aa7:df83:0:b0:564:73e9:a9cd with SMTP id b3-20020aa7df83000000b0056473e9a9cdmr9669383edy.31.1709136135345;
        Wed, 28 Feb 2024 08:02:15 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (fibhost-66-166-97.fibernet.hu. [85.66.166.97])
        by smtp.gmail.com with ESMTPSA id ij13-20020a056402158d00b00565ba75a739sm1867752edb.95.2024.02.28.08.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:02:14 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: 
Cc: linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Amir Goldstein <amir73il@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] fuse: replace remaining make_bad_inode() with fuse_make_bad()
Date: Wed, 28 Feb 2024 17:02:06 +0100
Message-ID: <20240228160213.1988854-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_do_statx() was added with the wrong helper.

Fixes: d3045530bdd2 ("fuse: implement statx")
Cc: <stable@vger.kernel.org> # v6.6
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 25c7c97f774b..ce6a38c56d54 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1214,7 +1214,7 @@ static int fuse_do_statx(struct inode *inode, struct file *file,
 	if (((sx->mask & STATX_SIZE) && !fuse_valid_size(sx->size)) ||
 	    ((sx->mask & STATX_TYPE) && (!fuse_valid_type(sx->mode) ||
 					 inode_wrong_type(inode, sx->mode)))) {
-		make_bad_inode(inode);
+		fuse_make_bad(inode);
 		return -EIO;
 	}
 
-- 
2.43.2


