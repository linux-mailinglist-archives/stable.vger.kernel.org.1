Return-Path: <stable+bounces-114126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8030AA2AD83
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B043A7DAE
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2530521C9E1;
	Thu,  6 Feb 2025 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lT/9DDFT"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6422F152
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858748; cv=none; b=btUK3+8/HHyuts2nsN8HLaGw0olIQIy5L0T2BJX2kH3Pqbj5txiAJe4d2/dw2VgX2GCz4TyQ8dViuzbmNS/2KUD3pOd/8cIdH76RMXDXc2P6Q2MiwvWS38Ddel/0awXOPOK9dj0lkYT72aQypVpWtF1Dlfhpyilvy+m/TmaBv8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858748; c=relaxed/simple;
	bh=XIVcEKTsmhCmFCSdEbyHZcRDOWJJycAiRmdS0wb1Dz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RK4aAcIiM1ADtDXwjLB5corWTf6FX4/o1OARRql1vEEw2lCfFnvRtHg/0aO0hUKtkmyYUgQFjVDn1nULAn9XglSbBS5df2Agr8ghSFEZnqs7Ea0dKtKTOnXEAzJUytjwIA918dMLywXcAhXKkHJKXnhqy9U8NG2ExnMuKJ86M+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lT/9DDFT; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3CCCE3FA56
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738858738;
	bh=rPrNbMPSpuauxRMHchfPliXntN4xezGUXzKPK6cqobs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=lT/9DDFTgEg3ak5BBYp5jDTf1tBir6crNBqTiKJqUfLohJAD0b5WPxUaMCtEg6x78
	 5xL4fa8CvZhxWLqA8kbup8/qPU96pPnQSOnXUkL4WvNHu3jZmcGYILYURqrb5kvJ4N
	 4IYrbg14Ify3vZLFcsmE0GmtuW1TPobM4i3dH4bLXD2JyCCtv1BdZahkdTbBdrIf69
	 N7asDKoyC1vWE8iKYObYt859/8aN6+OeF2YUU83MAAKVU+KhuBQfwwfMUdJs2dRpnT
	 CfGVWqNSopWnwBk0WQMryUxmngWxhPqAUlLnYb0UUKut5tN3kdadSwAus7jFn2Y/Og
	 zz0JrxJqyIeUg==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216387ddda8so24579695ad.3
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858732; x=1739463532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPrNbMPSpuauxRMHchfPliXntN4xezGUXzKPK6cqobs=;
        b=X1Koi3/4qJ/NOxfVdxxc1py3BR7UDuEIUPUYjoqLDPL2ddZTFBU4zzIGgivJB5Vbg9
         +ze8APPR8hlQZKhJHiBAAgDJiOHzUSSA9jVlw0FThuO4ZiOnFN7orDgwSE/3aIIuu2Zb
         lvaGz2ibXda0WQPpVdJqm+Plom1HhN2VnWgG6yb073BZnRKU4qB+NPjDbuXVv/Q89nJW
         Tr9UnAjjWl+6agkk4iQthYOL2CY+6cbaQbBth4d2zAmVfi8AZaqC3pjCU+0d5JaxK+fB
         3myEUFFg6x0FEC+skx+QssyKqy0m5fivG+q+f0Pqczisj23v4b42M9hpblYPub3ssXME
         x4Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVsmFm+64iZACToVuZYb98nxSlocK4JJ/TRd8GPS5h3cn6jikjvD3TQKz4xBc/WulLFBjnAw6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUa35n9R9JZTwvlcEE6SJ324rev2+0eixfw3C6aHGcI1hm0/r3
	cCHtU3B/d1yGD9NlW76A2+6ciAQHkqKZV/BZlPAbkA8poxKJoiIXXyFN/WHnOlLWz8/nAsFXwWT
	Q6u9Vp00Svi0TgsKvgvLMP+7CarsKjOJAUM0KeeeQmsiy1z/Ob03mvGVZ5cDJEq9bXzbx+S65p+
	X3Rw==
X-Gm-Gg: ASbGnctac8BAQbE9hjnkrmP7qKTaMzOwfY9sxYOQUzoPKpPpMvXdsgxa7CYiWMxL/eA
	XO6tnxRO8JRtk8VOffZoRbVIw8Nm4Hs/PkUy+ZRcHB/azzpjNrBn7M/n0eyKbLJVG4r6vp1dip6
	5TYdlHMtJX+R6Oqk0p+xg9MGRWRo9RCIDO8wvMS73/Gxz73rL8HJkPg8gNZessTumTMMF9kQSjc
	1/6RS7LSHzOOCrkEZzhdk++RgioO4VnzU7m2gawiEyLnwCFORQgeVsA/PTK54iS9NA8pKHF07+P
	0fhaj5ukmocKcB4NN0TzUJs=
X-Received: by 2002:a05:6a21:9003:b0:1ed:707e:7c4 with SMTP id adf61e73a8af0-1ede88ca4c8mr12252586637.38.1738858732473;
        Thu, 06 Feb 2025 08:18:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSVQXn9BU4ly9qjX0uKxnIS1gy2DxxmQNCYWYSIWs/wILqSvAqJITUVdKwzjUsrQNr75m0jQ==
X-Received: by 2002:a05:6a21:9003:b0:1ed:707e:7c4 with SMTP id adf61e73a8af0-1ede88ca4c8mr12252520637.38.1738858731803;
        Thu, 06 Feb 2025 08:18:51 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c1634asm1531019b3a.147.2025.02.06.08.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:18:51 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wqu@suse.com,
	fdmanana@suse.com,
	dsterba@suse.com
Subject: [PATCH 5.4 1/2] Revert "btrfs: avoid monopolizing a core when activating a swap file"
Date: Fri,  7 Feb 2025 01:18:24 +0900
Message-ID: <20250206161825.1386953-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 3d770d44dd5c6316913b003790998404636ec2a8.

The backport for linux-5.4.y, commit 3d770d44dd5c ("btrfs: avoid
monopolizing a core when activating a swap file"), inserted
cond_resched() in the wrong location.

Revert it now; a subsequent commit will re-backport the original patch.

Fixes: 3d770d44dd5c ("btrfs: avoid monopolizing a core when activating a swap file") # linux-5.4.y
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d9a581f46f13..cd72409ccc94 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7679,8 +7679,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			ret = -EAGAIN;
 			goto out;
 		}
-
-		cond_resched();
 	}
 
 	btrfs_release_path(path);
-- 
2.45.2


