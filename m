Return-Path: <stable+bounces-203367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 183C6CDC066
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 11:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12751300788C
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241263191A1;
	Wed, 24 Dec 2025 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cm2hRCFd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A52F1FDB
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572989; cv=none; b=JLX0bjjwcGykE/LmEv94ifYKDEYEEN74/TVHqL2AvZwrx0d0Zh3dAkVNA/ZYC7jz6/sBhVpbr6aJw9oJ3mogQpA5zl6FupbiB0r3edJFeQMF/smikhxFInaEo73ceN8kZ+MjzeMVedijU9AJFk174wpe7nBc6PdQAKuXbtV1hRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572989; c=relaxed/simple;
	bh=8V9QsYWmM3ZMSm1Wa+daHxyStuk8jCcnZs6Svt4EEAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L2yXPMg+486WV14sd74MiQmtNBEG2xr9hX50inZiSw5Qg1RZw05P2zBsmFwufwZzSquu6kD0F7bCcJbOJz9bFvmJx8wEB2tY6R14kGJoVpjiKKLTiW4c/evNZVXmPexxr7MCMkJ97ubpzscGFAjcpNg87smp5ZCc9lH0xiGB+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cm2hRCFd; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-29efd139227so78182545ad.1
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 02:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766572988; x=1767177788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCs2SAia/rHlPfgeMvF1iciOa1F61MisCzZmCnV7BuM=;
        b=gC6wZHX0V7xD2CaIRse/mXjyvR6kS6YztJSvGQi/nsd/vH7UeKYXlNr4m7uF6v4IYQ
         85vFCx73Mtz86+XAX88kiNstcxOSXrmC26Toy2zRE84XnmRYPzk+LVZotBhM0frM0+g9
         wGxjDcK3nEK3DW2b72+6IaP0bCbP5eIiTYKP12FjVxPZJdCGod3zC8r2ve+8BpXWheG5
         f0+WDmjBNv1T3f8EwU6PIX/xvP9Z3aeSaaKc4UlM0NUsUToiz2Q8FOQ+d5z4X7JVHODg
         DcfFwLm7CFK65Sa5tooCSRK+DZZ01Dq7tlb8ZrqdIrz+uE4aMCMExKkyuG2aRcNQ8vQ7
         Fw3g==
X-Gm-Message-State: AOJu0YzP6fFYk3Borh5/CUZlOjEwXYJORUwAwqiS6Al0AqoNk6RYrsnK
	8CAi4qHJxSqLKzdy+8G3wd2XQmwaQvoevU2LBCNh/Z/+IETCJU+ZtPfLzCROpvXKsaV7DFgFcEk
	zdSbvtXY7WbxKeHVWXH4+OUShGRdfsjYOURNAOP0KAm/amsFW3f3R24F+5nsifrb/oIgNel22kf
	Cf2t5V0xz5HZX96wi3lP0fyu8XRIK3igtr/tiQOfM+1Obc8xw8vRec64bI4onD3UQ+G5rNycBYZ
	5sJLoH0eEI=
X-Gm-Gg: AY/fxX6SKLf7ze5+bTAWzrIl6Hf+5a4speAwgQZ11Mo0N/1SPaGqvW/EFbDkIRpFd4J
	0/zcg8CcnKQHZsA5zLbXLczoHSKIetlCDSYtRZ83OAs71cWMKlFN0eMHXqdY1cWtp7SS/1Nd/jF
	ZNMEqawJrtpUxbX2rO9q1O5r+kSUbbVVKUAHTASSbz4blfJwDlP/IZ9WeZYVlghg/t71ABapoxH
	IqHMNzdR/3lZyHwyTL0diO1AIBqTp1fau0yq5VCrX3aX9JPhYxTY9KbSoUyZ3EkupUaWgTVAYM7
	dcjPlu9R116f9goG9I7gEmbOU/NIlYAcSPuqqPN3Md9WFlUx9rsim8Dnekw36EwzszAmvu/2c+1
	80rm8MtHVhCpivqgwoPlgRofTJ99sgUVOSngJ63P2bfzM+fKB9T/Z244wDbWG65H6/6Z1JFaoYv
	XBisd0FPLAKY+uRuOirpj20VXrroe13x7qJaOFLP2Ijg==
X-Google-Smtp-Source: AGHT+IF/JI+UNsCG5faoTZ6Jk6ONev4HHUiZ1CAkshEjYTg+kFIhgCRDFUY6uF33NrWq5egqLwY1r5VEZibC
X-Received: by 2002:a17:902:fc46:b0:2a0:9411:e8c0 with SMTP id d9443c01a7336-2a2f272bd84mr174887365ad.32.1766572987717;
        Wed, 24 Dec 2025 02:43:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3d1b86dsm18142685ad.45.2025.12.24.02.43.07
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Dec 2025 02:43:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c6e05af3bso12406784a91.3
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 02:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766572986; x=1767177786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCs2SAia/rHlPfgeMvF1iciOa1F61MisCzZmCnV7BuM=;
        b=cm2hRCFd861o/6UvT2pIYUSr/GBVYOevfIPISyU6GndR//SnO9TtTx2ZUFgZSt/9wH
         saUj0ZumLpLndE+/ci+gnV0+tiyn6SJXMfWtjYOuU+nPxraqHsiQZKRJSjU5LYE+R92O
         IjA9xjMP3oPTCOwxaBLsAZQ/3Y1HouzTCtu/A=
X-Received: by 2002:a05:7022:213:b0:11a:4016:44a5 with SMTP id a92af1059eb24-121722de1e1mr24560875c88.24.1766572986062;
        Wed, 24 Dec 2025 02:43:06 -0800 (PST)
X-Received: by 2002:a05:7022:213:b0:11a:4016:44a5 with SMTP id a92af1059eb24-121722de1e1mr24560845c88.24.1766572985271;
        Wed, 24 Dec 2025 02:43:05 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm68746919c88.13.2025.12.24.02.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:43:04 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com
Subject: [PATCH v6.1 0/2] x86/mm/pat: fix VM_PAT handling
Date: Wed, 24 Dec 2025 10:24:30 +0000
Message-Id: <20251224102432.923410-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

[PATCH v6.1 1/2]:
  required to backport [PATCH v6.1 2/2].

[PATCH v6.1 2/2]:
  backport to fix VM_PAT handling when fork() fails in copy_page_range().

 arch/x86/mm/pat/memtype.c | 50 +++++++++++++++++++++++----------------
 include/linux/pgtable.h   | 31 ++++++++++++++++++------
 kernel/fork.c             |  4 ++++
 mm/memory.c               | 10 ++++----
 mm/mremap.c               |  2 +-
 5 files changed, 62 insertions(+), 35 deletions(-)

-- 
2.40.4


