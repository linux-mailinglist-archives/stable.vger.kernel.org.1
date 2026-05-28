Return-Path: <stable+bounces-254715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKcHInfHF2onQggAu9opvQ
	(envelope-from <stable+bounces-254715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 06:41:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EC95EC8C1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 06:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 088FC304094C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 04:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E71730C17C;
	Thu, 28 May 2026 04:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir80Vd7K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8FB17B425
	for <stable@vger.kernel.org>; Thu, 28 May 2026 04:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779943279; cv=none; b=tglr7Ckl/tgPChOxMwC4IfzbEdLX4iSEWRiOiRROZ2Jbamlklv+FdsfeF2xEa78p4+gVVwVrHEBprUAJig6LPQHgUHWVvbb2BQ98Y+z4OJUxVrdGXJ9b02WoieAVTkgAkFbuzZ8rjy5HHCZDZkEDTzfPSo68iMISTAe90M/S0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779943279; c=relaxed/simple;
	bh=7vt9Dx769oaUdo/bwZA0p41FbBu63/h0lAHrddyItqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=SOs5G9tF+wcwcRb2c4gP529iVDNkrP8mNazp1K88EMPf3UoV1Vp4GFex3K9CeZWD5LrIiU+WTNGw4KIah0TLX9NDkG86pU57pQoEcdlNfqbXmBSp8mTnEBI/txqNRPQNrMEqg29/CW+Mw4HWQw3uWoGBdxJWCuDtBse11bpG7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ir80Vd7K; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so5656712b3a.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 21:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779943278; x=1780548078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=du8cY++I/mag/xwhX2GLm0MJj99dlckXgLQrAUks2z0=;
        b=ir80Vd7KMRszgD6KxF5PflIhy6Lf8qjnyWHtUvkJMwMXbfO9MOPXcni6oNfQS2wFaa
         /GdtEBVrVPpxDgOuJXu5g+m44I5JfM62wZYfbbRoTnly0N5R8s9kT5maMDcORRAMaSqc
         LW4pMBTrdl6QrtnC4G9fvF/WkGrK6W3WB77UjGW0lJDkrP2AUFzYUahI97MGfpyHMqH2
         LiqH/6UWasIr0wgtyrdcI1i09/mQOWRioVHDd0poxy7eu3FsnQX440xmDHjJ1ZkCXfGu
         y1FyO4Rn7qZjDbxCUUMDxqXtOY6Y6noxGeWWrZQkW7IHr6Wa7KY3ho91oaCP8UM9fYp5
         MHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779943278; x=1780548078;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du8cY++I/mag/xwhX2GLm0MJj99dlckXgLQrAUks2z0=;
        b=ZEfVXjM83vYprpQyPbdzMFRcP9w3vP9nI469+YIB9aIfLtohlYfRaboQflcTZPBS48
         ybWMxcKW2tnZLvF2ShaKD5rN527/kOvjuf3hEVj/MGqd4HJ+cQaoRA5O+t6Nl3Ky9lkC
         IjzVO0HkL29zzEKeYqvT8lGRapHJh3+jGH/7bIJFZW3wvHADviUxFtcxDcnO0ua4UB/Z
         7kGQL2gqpFbzzdIiAA6C2km/ZkrRKyy3R5vovFPe6SoTLSKrqXWPIk0MepamhA1TqJeT
         iYT/oJX7/WpWTnjRj7FUKRDTu+0gSdyc0OTPUL4W8YXTNU+uTABZt+iHbGBFo3MMyuCU
         CpxA==
X-Forwarded-Encrypted: i=1; AFNElJ+VmPOd0FCDCyaYfRwdAGR/bfUx0kI7Ej08jJGSTlxooiW/BE+ZZweryxpCwmFrOGFfzIBSNxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8KK0UX91hs443433kgBwqzQabzT9WD1VdOPlRHmS8QU3FXjo
	3Begz/7VOM1xbunOhFzXSiISwV8u4UW9sPvP3GuD0f96y7cjB1dc1spS
X-Gm-Gg: Acq92OHezhKZCFq0iC0A1T+UjIdnDZ7+cUyG0+K+Um19oF2PTunyP6kDfU8eWWOK7Hx
	4WQbn5HO/XSPQN7E9PIlneIJ6zN0BcHGZkvDvlgmcvtvQa6xgCJeiPSOVEJV/XUxZ2KNshfKNDQ
	t3w/ZGHkRdj5/t3klzJ8kqb8CmDd/uQxJXaeLIbZU778RehvHMbXwWF5Aaa+4D12YOpr/ZsQ3vG
	RTXqxKkj9LkFUtx/BQMvUyD6JMNNgwTVpf3awztebnW7Jb1cNYTXUUXHSCSzNXWsJ2+nyJhOzNR
	KOF03cjGTcYZAq6s31sdCRH+Unnt/5AA0KDDNUbukYZfEgkXlZjcMQCcnXlICVptnC+6DmgpIyl
	1z30nO6DtVtbGbJa2mFL0RZi2zh3d4NmD4cpXdxKI1yOuHtx12DZk6ClnJ/jT2M611tyXi/Nade
	RKcUC907nuAz/ahFvbshpTSDjFDpyAlQT4FKmYoEjgSfgzQjU=
X-Received: by 2002:a05:6a00:1c9e:b0:823:9b7:9c0e with SMTP id d2e1a72fcca58-8415f35c689mr23241583b3a.34.1779943277978;
        Wed, 27 May 2026 21:41:17 -0700 (PDT)
Received: from localhost.localdomain ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841f3cbcddbsm586596b3a.4.2026.05.27.21.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 21:41:17 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yisheng Xie <xieyisheng1@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/2] zram: fix UAF in zram_bvec_write_partial() and drop dead bio plumbing
Date: Thu, 28 May 2026 12:41:11 +0800
Message-Id: <ahfHZs0j2Zzpp/aq@debian>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260528-zram-v3-0-cab86eef8764@gmail.com>
References: <20260528-zram-v3-0-cab86eef8764@gmail.com>
Mail-Followup-To: Cunlong Li <shenxiaogll@gmail.com>, Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, Yisheng Xie <xieyisheng1@huawei.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254715-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shenxiaogll@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 05EC95EC8C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 10:48:43AM +0800, Cunlong Li wrote:
> Patch 1 fixes a use-after-free in zram_bvec_write_partial() that
> happens on PAGE_SIZE > 4K configurations when a partial write hits a
> ZRAM_WB slot.
> 
> Patch 2 is a follow-up cleanup that drops the now-unused bio parameter
> from zram_bvec_write_partial() and zram_bvec_write(), no functional
> change.
> 
> Patch 1 is tagged for stable; patch 2 is not.
> 
> Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
> ---
> Changes in v3:
> - Update Fixes: tag to 8e654f8fbff5 ("zram: read page from backing
>   device") per Christoph.
> - Link to v2: https://lore.kernel.org/r/20260527-zram-v2-0-2fb84b054b5c@gmail.com
> 
> Changes in v2:
> - Add patch 2: drop the now-unused bio parameter from
>   zram_bvec_write_partial() and zram_bvec_write(), per Sergey's
>   suggestion on v1.
> - Link to v1: https://lore.kernel.org/r/20260527-zram-v1-1-ce1acb2bfaf9@gmail.com
> 
> ---
> Cunlong Li (2):
>       zram: fix use-after-free in zram_bvec_write_partial()
>       zram: drop unused bio parameter from write helpers
> 
>  drivers/block/zram/zram_drv.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> ---
> base-commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
> change-id: 20260526-zram-b01425b7e6c6
> 
> Best regards,
> -- 
> Cunlong Li <shenxiaogll@gmail.com>
> 

Test results for reference:

Tested on arm64 16K-page QEMU (Apple M4, HVF) with KASAN enabled,
kernel v7.1-rc5 (base-commit e8c2f9fdadee).  zram0 backed by a loop
file on ext4, fio bs=4k randrw (4 jobs, 120s) against ext4-on-zram0
with a parallel loop triggering idle writeback.

Without the fix, KASAN fires within seconds:

  BUG: KASAN: use-after-free in copy_folio_from_iter_atomic+0x830/0x18e8
  Read of size 16384 at addr ffff8000d1168000 by task kworker/u16:4/321

  Workqueue: loop0 loop_rootcg_workfn
  Call trace:
   memcpy+0x3c/0x9c
   copy_folio_from_iter_atomic+0x830/0x18e8
   generic_perform_write+0x308/0x558
   ext4_buffered_write_iter+0x140/0x438
   ext4_file_write_iter+0x868/0x1004
   lo_rw_aio.isra.0+0x838/0xc94
   loop_process_work+0x2f8/0xdf0
   loop_rootcg_workfn+0x20/0x2c
   process_one_work+0x560/0xc10

  page: refcount:0 mapcount:0

The async backing-device read bio still references the page after
zram_bvec_write_partial() freed it; the loop worker then writes
into freed memory.

With the series applied, the same workload runs clean for two
minutes with no KASAN reports.


