Return-Path: <stable+bounces-241504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHALNF128GkMTwEAu9opvQ
	(envelope-from <stable+bounces-241504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:57:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71993480B3C
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAF193034D6E
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAD23D7D6A;
	Tue, 28 Apr 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZhMhEMoZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A933D6CDE
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366356; cv=none; b=Dt03QQUBKX9TQ+l/Te4fiGROrrqCkbOyH39HHMRJ1vBijIlFv3iGOAZWTkPTfqvQqhQ11/EDc8oRL58A19rnuFDZ1vFmvSx8HSFurDaFFE8iTbMwCK3oxyZ2aK5WHwhig9vaYayP94JR2vbwjEvoIY3VkoCqEacRPCFFnnnXVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366356; c=relaxed/simple;
	bh=nQdEySHsup5tuoqx9Fwrf6ki6sgYhd+krQ8jAeZzU/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BtYAQiFK8rcKWabeGo3bYDHedEFE/16ERyivqYkUaQZRDRuuoCwJZY8AfrlH05ar8sJ2N41EQOWptEMbhrhkdwFe9hG9lrMR5ANxpJWFCjMfzyXda6vBRrEnl7cqsV6HAmEX8XfLUqjZknfXuNyQMfc4R96bR+E6Wd3oyWNAeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZhMhEMoZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-362ddc1de56so3457970a91.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777366354; x=1777971154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3RZ85zZRMSfm4V5G/nYn9e3XYF7QD6vD8DovC4NkGE=;
        b=ZhMhEMoZpXGeT1eEF0IiDMGFFkclzuLEBXmEf9xow3hHvQ/5GgU6w7i0aQn4GFtdg8
         P3Tq4MpNHo7UifWcffZ6oN4D4hjoIz7JE0C+mBUoxLQ4RqoVgNGV2ouegSp0Ta1dUEv9
         jvrn3bg0nWGkL5zj6JXOcPn5cH2kGF8nmSBJ3PlLPYx3SeoPVNtwLdsmhljFFMHMMlJS
         R9vx/HjWLE0Dit1FYoFh6KQ6cEagFxm7VYqktZWa/XKV9flyjxT9WVQajlhCyxeXG3dy
         nxVS0b2b2EVLH0kkFooA+ShjKnx+ttccMZP6/PFjAT1sTy8kq/leFHmcaPXcotFXZhkV
         /i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366354; x=1777971154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g3RZ85zZRMSfm4V5G/nYn9e3XYF7QD6vD8DovC4NkGE=;
        b=pmvBqdkJmMoFjUQhIL51ltcUAWHeHS34d5SwO1pBN5t9n0bdcGQHmFxXoJgL5bTtuE
         CDeQJon566h+CZysNZ8a7BWvtj0/8O73lI3BmytYoHCv1ILrGEG6VqmhqNKjkH0sxydo
         3CaPjmLYYwrmp4v9+ZiuT4bChDuc1nj6SS+ES4wc/EWFzm7k+McwaviV7OCZlfdArLdt
         NNJIkqTa2GJlODPE/C85smmG+Nj0hxRFGJPN6f38YWOibBsDbSL1wphnNkUlWaszSenb
         MZC1P8mCqpiTJWCeG6y35yqUdRIXorDYqquNLaKsQVDNnuhL8VHx54cz7IHGv33LriXx
         XH6w==
X-Forwarded-Encrypted: i=1; AFNElJ9Ag2MeWn/kZgHcuquF3DPrPveSp5qQ3nVM+4fy3f0dJidp1MXeO3aSXw20gRtX4mv6bL8mCR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy+RGclxddBDzH6cdgN6QQ7sBVWji9eqHwzSn7WnjSGhAFwc2b
	zsCk2oHeVnqpsipe7tal3ovl9SXDAk3sEA+wYqO5415ZoxJAhV7yO3ipTS6B2a5enp8=
X-Gm-Gg: AeBDieu2FbbZd6nSVfgOXRj/wxvQaNs46/z0sVGJ+e2wrDc+bsnu0Yt9CRmNx2Jwvdz
	5rRllcwJt4op0ElsVbR8wYy7hiV4IBbiKtHR/Wi/ewdv6b2WM+IpJ6erb63Z+FzBVy5MtJ6oY6o
	LmDKDkFBor4Ff40GqO46cdkxS1AlLLjqIaUpd0RWhBkS0JmdpoqF5sYPnM+ppiAJsjU3iVqrgcI
	MRq7BDl2nWEds4+P1UZBvGF8gKt5hwABoXIBL834thivxjDf2GcrnQS4YL/03W62MZYiOa9eRtQ
	Tt4awli9CH7IIrWPAP0qEeN71d5LZJzuLd86n6nQw+/jaNJy0tTzF+bKsm7RvtMgZ3+FA0QtI81
	aTpTmOxUfpZwagmxBkk2U2HMp3XFpGS+bYqTvaoDWeGaQLhs2iLhtjJT+2YgNxi1dh9/fdW88UW
	UFVdyWbVse+t3mjQzLsQPybsi+hxMujj7VHVax9DQOSfVVjCY75vmciwM=
X-Received: by 2002:a17:90b:3510:b0:35f:b5df:463 with SMTP id 98e67ed59e1d1-364920a5111mr2319506a91.14.1777366354012;
        Tue, 28 Apr 2026 01:52:34 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364902e7debsm2889080a91.15.2026.04.28.01.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:52:33 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org,
	muchun.song@linux.dev
Subject: [PATCH v2 1/3] mm/memory_hotplug: fix memory block reference leak on remove
Date: Tue, 28 Apr 2026 16:52:17 +0800
Message-Id: <20260428085219.1316047-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260428085219.1316047-1-songmuchun@bytedance.com>
References: <20260428085219.1316047-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 71993480B3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,kernel.org,huawei.com,kvack.org,vger.kernel.org,lists.linux.dev,bytedance.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241504-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:dkim,bytedance.com:mid,suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

remove_memory_blocks_and_altmaps() looks up each memory block with
find_memory_block(), which acquires a reference to the memory block
device.

That reference is never dropped on this path, resulting in a leaked
device reference when removing memory blocks and their altmaps. Drop
the reference after retrieving mem->altmap and clearing mem->altmap,
before removing the memory block device.

Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory requests across memblocks")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
v1->v2:
- Add Acked-by from Oscar.
- I didn't add memory_block_get_by_id/memory_block_put because this
  is a pure bugfix series. I will send that separate cleanup after
  the bugfixes have been merged.
---
 mm/memory_hotplug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a943ec57c85..40c7915dabe0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1422,6 +1422,8 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 
 		altmap = mem->altmap;
 		mem->altmap = NULL;
+		/* drop the ref. we got via find_memory_block() */
+		put_device(&mem->dev);
 
 		remove_memory_block_devices(cur_start, memblock_size);
 
-- 
2.20.1


