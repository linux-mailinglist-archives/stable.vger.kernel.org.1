Return-Path: <stable+bounces-114133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF15A2AD95
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA85C7A1E15
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4621C9E1;
	Thu,  6 Feb 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QCVBERM7"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2A31F4184
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858923; cv=none; b=H+0eXkjwe1L4cPvn3C7hR8GQfXwI3VxgmoTHNs0YcQjylUyG3nd6B6S9KS6kTsXEmXRJfwMgitzI1Mop3W2uCO4sGza/WPIPh7Q6DCk4yurbl3LarkZsOV+u7bVin3XLl5zk65LdUfwEv3yxXn+adfQ0WMyamLAQlEGN4z6RFi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858923; c=relaxed/simple;
	bh=ZObqjxCcECMYE4PZ/VzK8B34ehF12KY4kgC4Vajw9hU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qk5377Ik/gXMolvb5nt852oMaJVQIF9I4ZEbufK9bajuRsQ+lYHrISzqIfFH2oPbPq5xjt7KNzK7A0FGyvTT6kMmFAEzW3S00jSZMnNS4oBfe9KUQcqruwbpJ8pnRaYgMmRFO75UqNUgr//5WLtUmM5Lch0qhMi1H+Q1Xk+HQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QCVBERM7; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 68AAC3F875
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738858918;
	bh=ctmzmqlW3nGZGD/+d4tGEkmWRiHp7hCLrSjWevMaEQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=QCVBERM7/bUrDPFmZkIC93vvOG1P+lc0aYIyZT7SMEYHxFo/NrsIEbZUMspiU34Zq
	 w+lyrgUwPsLB83AHchrEpFVr+lp4IZnVGEMlRW+65RO4pPLk/bZF0ETTT3z81kHGqj
	 eq3jkpqWCedXfPrNlD1bW6YanskkFRIVJb2S6TuVM9j4oJohYt+bs6ZkBzf0DAI+XH
	 cs07XD5EJBwQY3KNKqmUOhwKiHs+MFwd5T53PLkOXTe7Kn+I9W5Ra4RjDyTF0hvQ+8
	 38YbK86VcYu6tso6u2ciogLgcwYDUiSucPWdH15ZwmlDNOEyvIn9s+fhAbGKtycWTC
	 +3jeuFI9TO7VA==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21f0f1af7c7so27477885ad.0
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858917; x=1739463717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctmzmqlW3nGZGD/+d4tGEkmWRiHp7hCLrSjWevMaEQo=;
        b=hhhelUwh/sFWCoc9aBOD4SJoT6KeUDkWhNGTQHGhAuPAMQX9dio07xJh/2whUQ+ftV
         cfkPRgMWAM1NX3y0fR7kKOpBcNh045ToPXdk4EkaqsLGg8roKgqppwXD+NPgXbY4i1p6
         bWf2QPi6nUxV3+TKQSUfBrfm5Ia/3I5RqdGA6et+LAZytE9UaicERue5oR1AtG1Th4D0
         ZeZrWUALCD/dT4/MQk0aalMVnSJlgdqFNU4bMysvC+HguyROkwzMdryN/wdrZl2v+rbA
         cGgIyMfFexAH/JRIanKPh56w5v7sqyBdcXbaqYOdVJndMiIzNTvZFoHOxIAJMwpRVmaO
         2nmw==
X-Forwarded-Encrypted: i=1; AJvYcCVqoAPB/3T5q0mlOIgGISAxfFLyx9Q9uC+JrPYh1viSEhm2aXYz67cpQXzrjc/Qhejs53cJllo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc98CrtGGctdp8pXEIyx7P1iQebhedKD5iPArQTy8DwIoVhBDj
	QoboJ5o1zYBLI4/ZgN6yVLGsvGQcp/n9h5n9y0ccVj226Zs9IN/cClZf1digOPlyl1+jSRiGquO
	3ujrAVNv/Ic5Tt6lCiAZTKjA1Tly4n/4cqqCg93vdKYKbzMa5vfiw454pzAnn44Hg2nm1Nw==
X-Gm-Gg: ASbGncvCZ0Ttp60w4LRCpeYb/Xcb2WoL+pODUdsK1RRiIW4AwhYFljffSrbECOkGkyU
	IFdGuhjdvtDCBIO6246RdtdemnAI2W4VjdStOcn7nwY0ivLT7Hox+cmB9IRygkk9cCmP6H07kCI
	KbYbyjYoFWitpwrNTJTWSwCMaX5ajeel9fW/WE9AVk4YbO9Gssmwm9iSkb9BwaTywB3aip5/R1v
	zJ5cZbcMwZ0lWtgwkSLyXgI14Rpou2IIjG+vRBQ1XAzNgyqjDLFe6Ecy7+WhwYDMhHmgkt2vf91
	a3NyoqEDx/FoSatmSfA+Zb8=
X-Received: by 2002:a17:902:e54c:b0:21f:baa:80be with SMTP id d9443c01a7336-21f17f1169amr114606755ad.46.1738858917058;
        Thu, 06 Feb 2025 08:21:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3MM78ChlCusEHp8/BFRycyP0ZQSmknvcsYrsO8yqFgjd1hBqrhjmzfa/baznfMqXf7XYEqQ==
X-Received: by 2002:a17:902:e54c:b0:21f:baa:80be with SMTP id d9443c01a7336-21f17f1169amr114606565ad.46.1738858916812;
        Thu, 06 Feb 2025 08:21:56 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c4e7sm14850665ad.188.2025.02.06.08.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:21:56 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wqu@suse.com,
	fdmanana@suse.com,
	dsterba@suse.com
Subject: [PATCH 6.6 1/2] Revert "btrfs: avoid monopolizing a core when activating a swap file"
Date: Fri,  7 Feb 2025 01:21:30 +0900
Message-ID: <20250206162131.1387235-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 6e1a8225930719a9f352d56320214e33e2dde0a6.

The backport for linux-6.6.y, commit 6e1a82259307 ("btrfs: avoid
monopolizing a core when activating a swap file"), inserted
cond_resched() in the wrong location.

Revert it now; a subsequent commit will re-backport the original patch.

Fixes: 6e1a82259307 ("btrfs: avoid monopolizing a core when activating a swap file") # linux-6.6.y
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eb9319d856f2..49c927e8a807 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7153,8 +7153,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			ret = -EAGAIN;
 			goto out;
 		}
-
-		cond_resched();
 	}
 
 	if (orig_start)
-- 
2.45.2


