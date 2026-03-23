Return-Path: <stable+bounces-227933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAIlLBgLwWmtPwQAu9opvQ
	(envelope-from <stable+bounces-227933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:42:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3EF2EF3DD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55CA0303AF3A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BD638645B;
	Mon, 23 Mar 2026 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TitG1m13"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3756333D4E5
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258661; cv=none; b=EvYIcljcUi6Ps7AEMg8UGtrGQoIuvkOGXdlcwov3OR9rXDjv/rio7qIxdF7S82tGGT8aK7Ge1T87c9jKQ4gSfgiOvWO9S2LklGodxVraQHtJvE06BzxuuayRQjpNBWjuJGwlnh5+yF2P6/VPQwvDHgMWDJrpfHhqXnUhjykZtwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258661; c=relaxed/simple;
	bh=mufLnaRjoYXFt45dU8DA/mxvh+Wdi4hnqMDuXedxTl0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GULGBBqyuPR9NnnXVJL8apxXNqAhIId/59gwmT6rMrs0GqqlCWVpoKs1/UFHCRthpUDbISIqYvKuCNbSfQ/8DqLbkabt4pDpOuUmyrNd+pOOes6hsBx8x7sBzIHewD0OzKlBTHJAeL0GW6zu0pFn8U7PWgkX0lQxcvWEDuaPn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TitG1m13; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79ab5fd969aso6436817b3.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774258659; x=1774863459; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=11UIp8IxrCOZ4CscQC39RgQ7SkxaeS4ajtLQc+uqo3w=;
        b=TitG1m13/2yW08uXe+8rLQxncrei4/R3E53rI2ZPHcJZuHA2T0NOZSZGZzYsJNXw6A
         669CWCesK6DffrUhu6PZAfnrJrhDuBlNaBF2PUMq2yWkBqUrYJgB5WhGB3hIHbnNogcV
         oKZbunhCpWTShCRKYPRQ7cECPY+UYRC+QAZe8+PEjGr2p5fPdwU4IxyyGDkgRGNSOL+x
         04dzyzat91q8gED6MJDJn/8i61O09PKDVq9l97LE47RYl3PtePMeMhqj1w65PF7NK4a6
         HNh8M7nw0CEuJcceMVyTINYWr0ulivVxN8wmUvXUbawFQLJXbGDqYdlN9IZCjql+33Wi
         D0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774258659; x=1774863459;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11UIp8IxrCOZ4CscQC39RgQ7SkxaeS4ajtLQc+uqo3w=;
        b=dLVLHq/0lTBvMbRxIvmYASQC2TBc5kRpedgt/iUJBdyBqbnPnbwKMU8Byb3C7XlWY4
         fLnoY8J9q/ErpfDuhFSkvYjo8GvN0LUmu4PPqdOIirVK39xK5xv2P1H3FTPaRWM0qin7
         /JiK28hef6irZt2wDHBaUw/WvWiL9h6NRv5EM0MWRjs108G9SdHbmLTTUEbobf0B5twx
         yaV1J3iDP6eARqvoMjaO5832jcL9lKohzqtfLhKoJCwuXC8w/i0GzRshHdwsHafyNQOL
         zATpZwIz+B2pHzSD4J/NN+QH1A+N/X/MyhFiXn1K5mkhWQnQHpgMnnaNQ80K/KMzMul2
         AeaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlJ7IgkayIJwkEff8/GNNQCJFkvKaeKX+vfrvzQlCxBc39pXa+4Edn9zVsiwErcY8ryA7VdUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkm9oyXLMqeHm/xjaP9PA7cuUHXjY8KD1vMyd5KK4Aa5YLbeCg
	MZ19QDPI/oTOIwLZfX80043tWN2Ql1wf8FlsaI7YyMpOFt+3132xijIw8SrewgPMQQ==
X-Gm-Gg: ATEYQzzxfOVZuCxSszvp7wqIxKY+ZXiA7ZJpadR2e70VL+B616N/VgiwGpu03EV1d1q
	1qoKtCyq4Y3L9Q9GajHbHcKMOFQD9HGNjMzQ2v/21xCelQ3pQaClQD76S7rv3BkeG6alPNQB75B
	isRnqOMSMjMent7wf2uwiaY0ngUfbACXsEX0r4tQXhxMoPn/63rFTzNhhGYWQKjgyQOnLaDf/np
	/86JcQgNn2lcVX4/Cg91hPwH81sEZm4H6R9obZV9K5Dc690duetssdXu2ai8SQ8rO0uziMX785y
	gUn2AjYTNkAonZuBvV+hQ3SFtMXIex9knPROZuHVRaglKckKfsdmFc0Kub2+RamLss96TdqlJ1F
	k3xkSQo4UfYhf7o6I9/yMj9Cd4p5kW7f7Mw8F/07OcHgCnzpnEsekaiMQopiOXb0+P2ZtqtRFXW
	tGgVqowHMt6vGu+kiM5t+Oe9cSUvPBLVpZVitoRuJPEnlq5ur4wUUakVO2mcoQM7zYvqyIgbwdE
	2DyPqpAzhk=
X-Received: by 2002:a05:690c:6989:b0:798:3a6:3f4 with SMTP id 00721157ae682-79a90c0ea58mr109652647b3.43.1774258658763;
        Mon, 23 Mar 2026 02:37:38 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a905a2eb5sm54396627b3.42.2026.03.23.02.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:37:37 -0700 (PDT)
Date: Mon, 23 Mar 2026 02:37:35 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
    Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
    David Hildenbrand <david@kernel.org>, Dev Jain <dev.jain@arm.com>, 
    Greg Thelen <gthelen@google.com>, Guenter Roeck <groeck@google.com>, 
    Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
    Lance Yang <lance.yang@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
    Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 6.12.y 2/4] mm: shmem: avoid unpaired folio_unlock() in
 shmem_swapin_folio()
In-Reply-To: <a07eace6-82f2-32a8-0cbc-85972d4b1eee@google.com>
Message-ID: <49bbe4fa-b678-1023-db47-99a730e2827f@google.com>
References: <a07eace6-82f2-32a8-0cbc-85972d4b1eee@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,linux.alibaba.com,redhat.com,kernel.org,arm.com,tencent.com,huaweicloud.com,linux.dev,infradead.org,gmail.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-227933-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hughd@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,alibaba.com:email,linux-foundation.org:email,huaweicloud.com:email]
X-Rspamd-Queue-Id: 0F3EF2EF3DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kemeng Shi <shikemeng@huaweicloud.com>

commit e08d5f515613a9860bfee7312461a19f422adb5e upstream.

If we get a folio from swap_cache_get_folio() successfully but encounter a
failure before the folio is locked, we will unlock the folio which was not
previously locked.

Put the folio and set it to NULL when a failure occurs before the folio is
locked to fix the issue.

Link: https://lkml.kernel.org/r/20250516170939.965736-1-shikemeng@huaweicloud.com
Link: https://lkml.kernel.org/r/20250516170939.965736-2-shikemeng@huaweicloud.com
Fixes: 058313515d5a ("mm: shmem: fix potential data corruption during shmem swapin")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Kairui Song <kasong@tencent.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ hughd: removed series cover letter comments ]
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 9105c732f341..9b7df8397efc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2198,6 +2198,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		 */
 		split_order = shmem_split_large_entry(inode, index, swap, gfp);
 		if (split_order < 0) {
+			folio_put(folio);
+			folio = NULL;
 			error = split_order;
 			goto failed;
 		}

