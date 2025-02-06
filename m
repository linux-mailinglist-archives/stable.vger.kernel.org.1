Return-Path: <stable+bounces-114128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7504BA2AD8E
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D69162A19
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB63921C9E1;
	Thu,  6 Feb 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kb+rmJHo"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C641F4184
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858835; cv=none; b=OOlMdm8lxQhDlXAc375WzzEHnVuwM5isjpJbgvg+1zTpJGfy+CnMVZAtm77bNdLhkICyh4D4/93InBf04Uuyi4TGLcXuV1/FR//DJHY3fC7QWhSzqy7VvM6aUG/QnqziZx8iVcemBfzQjD8RpTvuBvbLHCtWzxETSaY2M6y5yrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858835; c=relaxed/simple;
	bh=ZK4BHB41gdrylBq8svhF6xfSUFusScWtVekE3vFPc7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFvkaySAcmvFYllaUTiGqbQBu8wCvvvLVSl7Jf3WtTRdJbI6O604o9WgJKjP00Ku614Y9XfVpNrz0PPMTxI28AFZLxUmrPo0OXtCRpmxfaPt40rmnBHr+sBtlamaf7UKqBUsYgkzd3o08wAuNJUwOXdnKuKfdf69S6QU8f1PabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kb+rmJHo; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E5DD43FA50
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738858829;
	bh=+vmO4Cquvmp29dJaT4LdzmnxK9HtvMZMhUDXzymC+K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=kb+rmJHo2WyTNQyM7myy6Tl1D9s0YndyS+eXEkAZhz9bF8k5oHgMpn8zjO4TKgMOl
	 IItUIclmviXTcizm4x6lsoix+ZbamRXZd6+Mbz11Dr+CtgWLLxCSTD7iyopEXQA1de
	 XBT0oZgN6lFrjhsmTVz4uXHCFAUkgApBIY9RLI9gUMCpuCU6lWqKeWOBMeObUVP3oe
	 sDpZZBIiXGz1JYAJH+e2aXJEcURenYweJRz/N38mzQw/ZDaks/aJ16vIoNcUBAtoew
	 wR94QdCvvpeFf5zITYD5r4MkP1Kou//qA1omVU5adeVbH6+1JussLohRXgRVZdOIM9
	 86JMJEXOhUFLg==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2efa0eb9dacso2166803a91.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:20:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858824; x=1739463624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vmO4Cquvmp29dJaT4LdzmnxK9HtvMZMhUDXzymC+K8=;
        b=KKkOza503ALno5okcdmxGu1NsI3bgB6ldrbdWyvZg3Lng+0ZPKaevYCNwMQxW3hcP2
         Z2cEIYJNp5rZEjeXJjijx+qL1r7aQtjHD8P5GwK/qGa9mtb2u1+YDKnKm6h1XHnx841C
         kc25Y40Bu63IZ4Ci3qNMxG3rmXuK+Cd3XAasiatmY6l+TPjCF/m1MqvmzU2szua0U2lU
         6MoVGv9Z2LngNVM14uY+Kmf1xjaDdb1y5yVq8PMU5iDcK6GxRINbUYk4qBgXzjXkRjBp
         vWuTJPykTJ3ulmqh2KeehYEy+0RMC9uenfUIbHiL3CTbUY58u132QW0lW+/F5fwSR+Fz
         y1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCURvv2+mKrn+Qaa73rxu/Bqit1SEP9gK8wrrVcK1CfzaehwL1sMXBjURgCvgfzgBSZrE0wgHOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs83m4a+3IfoyNjnyZwZGojJQMEBDcey/mKeXZTAsq/T4Dklcs
	fIhw7Y5fZURjEt7EHrSG4y/5tlquk9F9b/7l2HDIDkpHxzjfWDhEeiRrTOCCMk7fLVJRy63cgw6
	ZrkS1a+Ib2p6Vk3+WAMl0lXXO6rMd4PE/M4rPzCYWDC6LfAU0yOFJ8wQ2s52lC2J8NNW+XQ==
X-Gm-Gg: ASbGncs63+NjSI9xHTQwy9Szed3kaslsRnoTYhXqSor0IeYOB1GXQhpg3OgR1vhZlW1
	/R/c33yikX/yp+TbrpoPoHfyUReeFhR9LkdqYinExpuRittA9xD7QZV9Zp52ZGI0HWAXK9N8An0
	yEvlm2V+Vi/TBr0ns0lOMv3lgZNb5TqD1IG8V+MeB/ZzQ2Fo0ZXivO9U3p9mYIfnuEQYjmiz3aF
	s2F4hIGUt2xWRrWrv2MIosm65FyIeIgFDh04wHJ/cCmxFLOsSox8Vrp1pJ4K3Y4Ssml9LTZAxwu
	WoB/wxv7T25Ge2tLU2y0yB8=
X-Received: by 2002:a17:90b:3e8c:b0:2ee:48bf:7dc3 with SMTP id 98e67ed59e1d1-2f9e077b9cbmr12167100a91.15.1738858824028;
        Thu, 06 Feb 2025 08:20:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHcXnxY4ZJZNfDRvQnz9x6VNlW5GswnMhMk9eK/YTm6sW4x7m8MT6L8jNamxR6mZIflzs5AQ==
X-Received: by 2002:a17:90b:3e8c:b0:2ee:48bf:7dc3 with SMTP id 98e67ed59e1d1-2f9e077b9cbmr12167067a91.15.1738858823727;
        Thu, 06 Feb 2025 08:20:23 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368d79a7sm14788045ad.253.2025.02.06.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:20:23 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wqu@suse.com,
	fdmanana@suse.com,
	dsterba@suse.com
Subject: [PATCH 5.10 2/2] btrfs: avoid monopolizing a core when activating a swap file
Date: Fri,  7 Feb 2025 01:19:55 +0900
Message-ID: <20250206161955.1387041-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206161955.1387041-1-koichiro.den@canonical.com>
References: <20250206161955.1387041-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit 2c8507c63f5498d4ee4af404a8e44ceae4345056 upstream.

This commit re-attempts the backport of the change to the linux-5.10.y
branch. Commit a1c3a19446a4 ("btrfs: avoid monopolizing a core when
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
index 45c1732a9677..8d7ca8a21525 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10422,6 +10422,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		}
 
 		start += len;
+
+		cond_resched();
 	}
 
 	if (bsi.block_len)
-- 
2.45.2


