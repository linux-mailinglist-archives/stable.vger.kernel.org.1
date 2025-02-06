Return-Path: <stable+bounces-114135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 761CCA2AD9E
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389D81687B4
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4163E1EDA34;
	Thu,  6 Feb 2025 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cJy1XQrN"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94423232360
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858974; cv=none; b=ne2c1UF/oteBEnmUZtUONllfnIgD5S0XHBdB8POvVibeIW2/FmRpAI2Cf0RwODz//KedQsJ+JadNCMO7hVUhOpIcO2TQf1Qu2TM+YvObio0447f1ij4ZHDAsegWrvPFPtDbUKoSwCBVnaLEOycS2YtQ+GYlBKi68i3OyCgjN7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858974; c=relaxed/simple;
	bh=Ltc6jrY5w35a4UxCPzSovc+6x2/J4rR+jQprTv42NMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8CmsnoeXPoj4yZRHvH3j7RFbNGQbkUpoTOZ5vr0ISToVr9ou8IqtkXj4Za7ArD/91l5SuWdbcHsv/Ds+oUcgL8CWZoeIPKzMFCmY1xsyjYDN6U7MJOWacXWN6ea3kNPeZBY3fojdiPXEXbkL13USIHEpb+Tgc6TJDEbOZ0vqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cJy1XQrN; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 951B23FA55
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738858969;
	bh=5x/MR7mcQvflQdhdpeBz9f4a5AhmqAk/EAo3qWI8BzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=cJy1XQrNx1fOJZS9JtCwYo52IYu2Ul5694++ZgeDF3km7F8m1XiNuVwl155S2twHp
	 2BxF5IZhHOIvNQ0TzQvUzfjMKCleP3g6swQKtXW6JDXes79cCt3K9Vi+oHBr/LWCVT
	 uLZWfD1a8NEC94qcH2XK2mqZD3Y9fj8So0zuCQy04xSASn4TtWbIkQ+/COQX1fe1Tg
	 KSulzgjhiyX1fBerIBGXam+6RzzypLD0uuN8Kpk7QGZ22eTkhlx9rnZDmVDAbT1ZXo
	 mUzhXI76VLQZqlmD6k3vsyeU4KVT7YBRnUNJWjnld7YHqtXvH/RRcfF43m4M1T9Vlt
	 jfaGoGjIn6bBA==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f1a7dc0e6so41766305ad.3
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858968; x=1739463768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5x/MR7mcQvflQdhdpeBz9f4a5AhmqAk/EAo3qWI8BzU=;
        b=QDgLwyrpuFBegzXSZUO9xP4761HhvcuebGW+U472ryuu2pmq/6Usw31QmI7CVkpFXW
         yk6iERxr36yX8hhXhmqWUevn9hB4YIBYyW0G9fVJv5Xxhn96eoV6iCuartcWXPtPL5jh
         Q6l4vhLctv4sNYFE7hj+UPxHrUNYQ4dFzgUJpqE5Hzbm1f3uaD2vY9BNNcR3xlWVo28L
         fzjX28ztFIQ4GWDaj5QrQTnQmxrbgjVb3aVH9mfVu6Z0YiaXzuI05UVlVCu1tWz9qOxD
         gJiyNWD8KgUJf9ZxYZ0KnmvJdl7t0lpyZ8XTjkAWhP3oPHcqn7YNL8FTE+SrYAxiwVLG
         oKRA==
X-Forwarded-Encrypted: i=1; AJvYcCUL5YkiUdMMY05SytGeeypzpj9OcoVOh7M2TexugRBOF0/gROfIgg5Ycr+lk2g4f4+4LmK4+24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmXMqovsyJjHOywX/cQYs5dfFowAncMvOGXTOUiMyPoRX0m6Qw
	s5t6cbhKZm5hlb0Jk48+UGO0Df1gNpo2Hj4WlA/+ZpojkmcH3IE8EKeQ7vTCaU6Ck0K7wUPrXUM
	TfDuQ9IDwryHOZh+HUwWQNBo8Vz3Js4dSLGjXH8EvbsR+p8SltLfBt8YHXZWNz1hJzlr0BA==
X-Gm-Gg: ASbGncs40wvfbfvh/eJpY7ff81age6j82ZihEg0EbqIx6MMFh7zacZbvIDRSHjlRGRN
	uMDzEgqZSsC+11IWSYv16keqsfjkEEfh5eFHCAN7z6+D3U88pCTNxvobEQxJTUTOLHBlVg4CQSp
	3Xebyk4hGjRvvWPonKXXQ5apWQWUG5VGwYew5drpfb49x2sBQZ+49jUMamHNONtIrQsmnQXfPS/
	zICsGWYxcGJzsJ/HycTsrYILBV0gpsKQtm6NFco9cl+87iu61rpN25dwP0Rnr4/AwZlnN940ml9
	YIbZZZ26wfnCjBzPK1wanfw=
X-Received: by 2002:a17:903:2346:b0:215:7421:262 with SMTP id d9443c01a7336-21f17df5870mr140685455ad.12.1738858968008;
        Thu, 06 Feb 2025 08:22:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEoF+mHYaQ+vUK212IADu7SeJs8oT2a60LBASpJVYEoEgsr6tBDa42qOJUwMIC8WdYdsEcPg==
X-Received: by 2002:a17:903:2346:b0:215:7421:262 with SMTP id d9443c01a7336-21f17df5870mr140685145ad.12.1738858967705;
        Thu, 06 Feb 2025 08:22:47 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e69fsm15008815ad.1.2025.02.06.08.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:22:47 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wqu@suse.com,
	fdmanana@suse.com,
	dsterba@suse.com
Subject: [PATCH 6.12 1/2] Revert "btrfs: avoid monopolizing a core when activating a swap file"
Date: Fri,  7 Feb 2025 01:22:16 +0900
Message-ID: <20250206162217.1387360-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 9f372e86b9bd1914df58c8f6e30939b7a224c6b0.

The backport for linux-6.12.y, commit 9f372e86b9bd ("btrfs: avoid
monopolizing a core when activating a swap file"), inserted
cond_resched() in the wrong location.

Revert it now; a subsequent commit will re-backport the original patch.

Fixes: 9f372e86b9bd ("btrfs: avoid monopolizing a core when activating a swap file") # linux-6.12.y
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a3c861b2a6d2..a74a09cf622d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7117,8 +7117,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			ret = -EAGAIN;
 			goto out;
 		}
-
-		cond_resched();
 	}
 
 	if (file_extent)
-- 
2.45.2


