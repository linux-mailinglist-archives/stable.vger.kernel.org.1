Return-Path: <stable+bounces-163603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B956B0C794
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 17:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C35254292B
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3582F2DEA9E;
	Mon, 21 Jul 2025 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6JP1+dN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3BA2DECA1;
	Mon, 21 Jul 2025 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111713; cv=none; b=FbjP7BUSo1eiBbPojxjuMl1H/0wfBgmjpvscli7EYaHubogxzhNC7tSv1lGETE0NwFJQ2ZFaxDXIZV/vQ3rt6/14qAk4N+2z68++NtE597vKscYDeg1Syglg3FcOW9BpHpEQmzdDVM2SyFNH8B0i4AHrB+5TyGXlTYcd5BDI9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111713; c=relaxed/simple;
	bh=0x7AlFf/zSQtyGfrxywbD+ZCXfFBkFZceiIJvgJFwgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPdA/Y0NfHLWvimyQ0mUSshBSONAZoHy/Q35/9JJSG/2PL9pYshSu9KyWKOtvV65NzUadC1cRmtOYa+ru5QPmFkb3YuyeEl2fGS79CYGEXpp67+6Voqq4F0JpyJV1m59J19vo6IpPvav3wKIUDUMwjx58hMKrBDsVLZGr4Ehx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6JP1+dN; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7183dae670dso41259467b3.2;
        Mon, 21 Jul 2025 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753111710; x=1753716510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxyUby716vtNBhVOSKlP2j4uEXJ9sXitnuotbZdiw0Q=;
        b=V6JP1+dN01ftuUqUcn7jCE6jHYRIk6cYHOTdEcX3iVh82GR4GnaKqcEC/1JCeFy0ox
         o8R1ZSe8Lbk+P4WXRnUv1gVp5WftxEdAJTa3QYf0ITFtQwiORvzfmojubMHbVcK/n2wg
         sGdEI+vDfD9AXB8gDGDaS3jnu6mNYnGmJ3dQgl2qfRYzdv44ep5L8q9ySQC/A3lIKaG9
         VAs3CA5neVTkJGfuiPOWd7b7a/XxZU6BVV5Kx0L87Gmk7uk26VQAR71PEKO8jffCGO9F
         B0LLZ2XT2WxFg7QDdvJ70H3tATbtjQw/haWxYmDHWWU1Z7YBmZct4iCLJX48i9W2nyus
         fd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111710; x=1753716510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxyUby716vtNBhVOSKlP2j4uEXJ9sXitnuotbZdiw0Q=;
        b=mevXWKi2LlyEMin62+suwQLGVBpSHRqJLxQC8Bx3Yfn7WcbNGjyMeggUIsChPtt5Yb
         Hc6+QK2Oi1R701HEB36DGaqqX4rJ0jzfa1wfs7TzpDBu2Qrw00GSs3QwpOJcAF6M7+te
         zhC6hAPBfEzE9bd9fTYFJJrT8XnKaZJqGFgj7s7FcV6Yn9Ppb+5luMFAcVpLGotR4C+H
         1MLqRds2EbtdSa5Llh0buZSQ/XNybklB+NBqLms62wLl+iSjAesWLzNo01MBzTRwkpOB
         TgNthcacXpn/pflh/P3jJ+DYdYuMHr/dhgWnN7Wvpjd3T9nB8XKt2W0Pn9Ihd3eWJs84
         oQgA==
X-Forwarded-Encrypted: i=1; AJvYcCU1HnPb6EZE3ee18sDVdjQRUNs3Xm/tSFmZszCUuZAkx2gZH10Jaje7H1H67zpSIo7Tx0j5MsuL@vger.kernel.org, AJvYcCXCOUNqfDczaGFlZ6g4BTYXM1RlQ+7ia+TwkD3kKbBvBiqr7MI1E2Ux2auOLXX+BpoiCK3jKUMPIN50gWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0PA8xDxC0CBsK4UuIGXBEekrH+3OwPdxtExfgfdvCTkpT61L
	CW1HASKkqqRZOi7js3QfMlDGkY1IoeQnPdYDTSeZL3s14wNmWSoJGOE8V06wKg==
X-Gm-Gg: ASbGncu2EpYE+ISgYTXMMfMfoqs1dCS8MDJuGdQRZNAEYF+fvZMU4md5u9y3Ly1xAUz
	2MFTB9QdP+/TO2eTyheGGcXIDSvpaAq12NenLRnwDhSMecAvKFt03euzhTnaktgzcJCsJ5J9CQm
	eU5HY2gytTykXECGIynEGinG0I0fN5pVBXyrzzqoYtykm4ubgOiZ0tc78qgTvLq8YUSLr9CZjHZ
	KBOS0aKWQ8Q5G+CI679E6srpuNSVsi+RhFs7bP5w4bXMiI1yR84ofSFwkRuh0Noc5eqANinclsl
	RnI9nV9OFXSNgoVrRjqqI75FtRqjc5mk2LGwROE6hsnJodozGznO6mwwj36qLGqIOkbNb2YHzlZ
	gMLRHWgteVk8NM4Rnqeeg
X-Google-Smtp-Source: AGHT+IF1Fnu/+9zJWEVuDvvjuUAk+1v5Dd7E8Vm/Bkak4K3NtI4w/E/dbUzbbpXxhKawIOb0SvkmeA==
X-Received: by 2002:a05:690c:a08e:20b0:719:6b98:c2eb with SMTP id 00721157ae682-7196b98c619mr71944077b3.8.1753111709979;
        Mon, 21 Jul 2025 08:28:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7cc39897sm2554397276.14.2025.07.21.08.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:28:29 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/ops-common: ignore migration request to invalid nodes
Date: Mon, 21 Jul 2025 08:28:26 -0700
Message-ID: <20250721152828.423605-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250720185822.1451-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Jul 2025 11:58:22 -0700 SeongJae Park <sj@kernel.org> wrote:

> damon_migrate_pages() try migration even if the target node is invalid.
> If users mistakenly make such invalid requests via
> DAMOS_MIGRATE_{HOT,COLD} action, below kernel BUG can happen.
> 
>     [ 7831.883495] BUG: unable to handle page fault for address: 0000000000001f48
>     [ 7831.884160] #PF: supervisor read access in kernel mode
>     [ 7831.884681] #PF: error_code(0x0000) - not-present page
>     [ 7831.885203] PGD 0 P4D 0
>     [ 7831.885468] Oops: Oops: 0000 [#1] SMP PTI
>     [ 7831.885852] CPU: 31 UID: 0 PID: 94202 Comm: kdamond.0 Not tainted 6.16.0-rc5-mm-new-damon+ #93 PREEMPT(voluntary)
>     [ 7831.886913] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.el9 04/01/2014
>     [ 7831.887777] RIP: 0010:__alloc_frozen_pages_noprof (include/linux/mmzone.h:1724 include/linux/mmzone.h:1750 mm/page_alloc.c:4936 mm/page_alloc.c:5137)
>     [...]
>     [ 7831.895953] Call Trace:
>     [ 7831.896195]  <TASK>
>     [ 7831.896397] __folio_alloc_noprof (mm/page_alloc.c:5183 mm/page_alloc.c:5192)
>     [ 7831.896787] migrate_pages_batch (mm/migrate.c:1189 mm/migrate.c:1851)
>     [ 7831.897228] ? __pfx_alloc_migration_target (mm/migrate.c:2137)
>     [ 7831.897735] migrate_pages (mm/migrate.c:2078)
>     [ 7831.898141] ? __pfx_alloc_migration_target (mm/migrate.c:2137)
>     [ 7831.898664] damon_migrate_folio_list (mm/damon/ops-common.c:321 mm/damon/ops-common.c:354)
>     [ 7831.899140] damon_migrate_pages (mm/damon/ops-common.c:405)
>     [...]
> 
> Add a target node validity check in damon_migrate_pages().  The validity
> check is stolen from that of do_pages_move(), which is being used for
> move_pages() system call.
> 
> Fixes: b51820ebea65 ("mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion") # 6.11.x
> Cc: stable@vger.kernel.org
> Cc: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---

LGTM, thank you SJ!

On a side note... This seems like it would be a common check. However, doing a
(quick) search seems to return no function that checks whether a node is valid.
Perhaps it would make sense to look deeper and see how many other functions
make this check, and export this as a function? I can try spinning something
if it makes sense to you : -)

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Sent using hkml (https://github.com/sjp38/hackermail)

