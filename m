Return-Path: <stable+bounces-114130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854FBA2AD90
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C41D1882C44
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8470E21C9E1;
	Thu,  6 Feb 2025 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sy3+MMGv"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C661F4184
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858861; cv=none; b=mQGtwTD8j/ZRYNXFht+KOrL3/HBgvBCtuHHxgaWsSfqpt3FgwrO4rB5qHNEzpS6f0RMhH4qAkIoL1SF0IxQY7JcRBd1vrTMIGNAlaU3t+qHdhyaUrVs0RzrHmzKwyvbJv/D3BByW5VSbbooKbyu5fTnxty9TN73GS/lWIDA+3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858861; c=relaxed/simple;
	bh=qkBF/sLwaGJKUiic0KIslln1wj/Y0ngaHPYDpY/jSqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKMlW4odw0MD14UbL5/dtV3OPal81ZjA3HcHMJOKwV+eAN5WWQxo60/nz/ChOoLJ3umrAkiOgaflDmdGuPYGYEaZWMHpZ2i++xB6yfMiMWp5NmFNC94aU/y+EO83/uAy6WQ49laTPGoeixY2FynhbzmjtezDzQgj39k3pSamSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sy3+MMGv; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4A41B3FA56
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738858856;
	bh=PRZiP4FKhrgd+6VmlwGQdSoB/+rYk/737V+rSOueHMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=sy3+MMGvVsh9M1f/SG3Tml8MqPWF/5sbv6UGHZ/IviJkLnk8hj1tcdbz38jZXAnCf
	 iB8T8NSWSdL17OXVQ+TyYORH92NcOfuvIC2JBYfW8KL8BgZ79TK3YNs6jesUb7uNz+
	 Ku9mZ37mrxE07UnR5hDmUCNRUk5Vy8FCRqqSG5ShaKY3iiovAYjKlVXvi4KikLMMAb
	 bWzyDPtHRAt24UL3VSWMOkH778mA95m6sBnJqHQhLUqIApo9OaTMtrJm+rOpYmEReJ
	 XlIN/tD0zYCzkoT7v8hW9TL/n8fvoq3UGnWei4H941m7eiPsDytLDqtPS3TpWC50rJ
	 K+xHxFAv/Cr9Q==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f37eaef03so12990165ad.0
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858852; x=1739463652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRZiP4FKhrgd+6VmlwGQdSoB/+rYk/737V+rSOueHMs=;
        b=xL9Zj8g60nR6jbrCjgWGkSICip5dCz+RUm0mZb6FhktyyRu674dlFB6cimZWA6i8W8
         BeZmEJOIffE99JkM8sX2GqPbcgMRaDsGjsy9h0k+OHIlIk4MUzl6O3GYLFItwRF2hZBP
         hLz0eCI31Od2SVH6ukreQNgl/Qhtmxq5BY5BWfUD0EGjLQ6pvYDqS4nf+ipIf3IA4FjV
         bP85/xeIOlFQdQJQZjxzYGOK6pw7cMHJJS0z0VjDS/0CqC0tY94YbpOSAF6Nh6BVfmZS
         um+L9XTy5+1fJZPV8v882QZpu6WnIkPtW7kcB1ocy131gP7HPJy5b02ezi4kFrqycukv
         Q0/A==
X-Forwarded-Encrypted: i=1; AJvYcCXz0LN3Ojhmtw8PNwXu74ZxautVZsQXRTIuT39LmD84Ma1QU4V1HyFIWd4CRYHkhVSdnOlbZEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYD7TIiJwpMVQsa8QkqFIY6u0arGOc8h8wXo4RehixyO487QG3
	dN03+7J5T2ZZNmzVkaloLORAatsTEADfhwSmRwmKJ2dMX+pwh5F1FrpmnrnIgfIOHHTmEQuM4WJ
	cXokyDJsQ0hUF0KHh5or5sHxL18dvyzMXfHN/XfSnD/MDJehasgksJq4TjZOtKZm13rgZZA==
X-Gm-Gg: ASbGncuOZa2y2iEDKRnZMmOAdr09ekx15fHOAHYklKNbA3xuLUUmULt6WoqL3XTqDdX
	iT2SKfek2/PHap/mCBtZZ7QOM9wpMBXdhFLLPsw2pWKwG3CjDoiVkEm7NS5Zm8DkSt/oXlmFUTF
	1LIBfGxV2q3Jxc3FH7qqkBRI4SwEeeC4UGnhCpXZBmStnav0hbwlC20vOvIBqc/32BugEyUd6eb
	whpRaWaOQe1kqx1bFkYhYqVX3vZVnrDKNINZwyKOvjGk4Nz3aB4lDHNMA2Kx4fdQhOKeRVYZa+b
	8EUO/SIwFiTbEvWdraPRmoY=
X-Received: by 2002:a05:6a21:9013:b0:1ed:a6c6:7206 with SMTP id adf61e73a8af0-1ee03a09dc7mr65720637.8.1738858852411;
        Thu, 06 Feb 2025 08:20:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS7Ug1zxctMEAYD6wy80eKVPGaHniNsTevNq3x6/lcfyjfUFcmvLSrh+rucdGeANTE5x/NTA==
X-Received: by 2002:a05:6a21:9013:b0:1ed:a6c6:7206 with SMTP id adf61e73a8af0-1ee03a09dc7mr65677637.8.1738858851975;
        Thu, 06 Feb 2025 08:20:51 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf13e2sm1539312b3a.107.2025.02.06.08.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:20:51 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wqu@suse.com,
	fdmanana@suse.com,
	dsterba@suse.com
Subject: [PATCH 5.15 2/2] btrfs: avoid monopolizing a core when activating a swap file
Date: Fri,  7 Feb 2025 01:20:23 +0900
Message-ID: <20250206162023.1387093-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206162023.1387093-1-koichiro.den@canonical.com>
References: <20250206162023.1387093-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit 2c8507c63f5498d4ee4af404a8e44ceae4345056 upstream.

This commit re-attempts the backport of the change to the linux-5.15.y
branch. Commit 214d92f0a465 ("btrfs: avoid monopolizing a core when
activating a swap file") on this branch was reverted.

During swap activation we iterate over the extents of a file and we can
have many thousands of them, so we can end up in a busy loop monopolizing
a core. Avoid this by doing a voluntary reschedule after processing each
extent.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 fs/btrfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f048e517e65..d6e43c94436d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -11031,6 +11031,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		}
 
 		start += len;
+
+		cond_resched();
 	}
 
 	if (bsi.block_len)
-- 
2.45.2


