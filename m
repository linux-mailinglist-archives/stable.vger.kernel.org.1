Return-Path: <stable+bounces-89093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9106F9B35B7
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 17:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C218A1C2200E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114C81DE88B;
	Mon, 28 Oct 2024 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="pRb6zxXT"
X-Original-To: stable@vger.kernel.org
Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF9215C13A;
	Mon, 28 Oct 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131557; cv=pass; b=DbcC450lAZNY+b7P7ycC0IPPiLpPgXcW0SRoV1MgIoIRVHjtan79iG0wUPxhFDIy+4O0iqQ1SohRbeHuQiqSAQsIXgUyi7vukfYJupHIJ+Lnit0Eu1HECYwjI85kQ2XcxLOFEN4BOxqpXJG3ojhCpgnHwaIB3+Ve+CwwGyZr4a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131557; c=relaxed/simple;
	bh=tRCzbSUsTCh+0Z4ZKKxrsha7cooCEG0tDml+CfGNwv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fsm56WZlfU6R8jethKkCQsQ6zMN3CVOReIL9RrU0orU8QzunGc0W3jVkul3gL9P5blyalGTMEyP3uId441TR1lJ0M8YKw11XkKevloLNe+PgJPcgNec7C6Vk8SLxNqWSNIV3OWL3OpfsZOKrNjKO3VZ4TvOkaXHhYcP/+CzYil4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=pRb6zxXT; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6EA0FC23E0;
	Mon, 28 Oct 2024 16:05:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (trex-1.trex.outbound.svc.cluster.local [100.103.137.60])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D7B60C2663;
	Mon, 28 Oct 2024 16:05:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730131547; a=rsa-sha256;
	cv=none;
	b=gjOSM2Z9Jm9LYkdQHmgJXWqSUh7fs1HtqOXqc9BZ+m1Mkullab/Y3QQVFs34Vrx23PtddD
	MqNXIi6gtCh7h/e1v57fAuZYMM0gXyRu+7z+b7itG5rTqU5acmA2OWqFhmkl3J7iBfmZAL
	1nFdUhq1A80+wcI4+yyY16E5pQP7AS0kfzruy8KtL9KlXTzjEM7lvJtAwxBor2FWPlWT61
	AyGoTjPu/fGHK2gbmzShWnglB3nFuyez5Nr5xJewoe6TS7lA9DYqOnc65px42j43RoVUMY
	h2giAuq1wl0Vi0uD8qc4v5yCaAIlMZ4nT+rlwxK6bDFbOEzOUL4LAm5sPczR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730131547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QrniIkJ7AhEemPvfI/4hebsJ2/X7SQhZHVjWmCujUIk=;
	b=prlnfOqlRTtx64vNliTHZpmg8x/ACe7Omj7n7mIxrfnq6L9yWKRALiJiXGfKdu+2VjTUI2
	yq7Z8FYgYSVj32SnCCRD4fRWIlBf7V8Fh6oCVTBqQnQpUcOr51h72oSHHsTHIMIjbIRZ+f
	hROkNRN2DhMnc3pAIF8LNzhjsRpFCXFXu5Zah2AdB1u16dDfaWqR01tlWpRdhsafJ8m/tT
	fOgHVwnLggiv5AdKcK6Jk4/ytCkFz+Q7surfHsN0JttC34GMRg7FPPSX5J6i0O7QbORMh5
	nXygM9XA6Gf1M42RpUmYHXDpEVCDbo3l33x+2vg41CKZKm/jAg7WT0PxaW4ZJA==
ARC-Authentication-Results: i=1;
	rspamd-7fb5679c85-q9vff;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Obese-Average: 6124764d4c3d56fe_1730131549271_1704196374
X-MC-Loop-Signature: 1730131549271:1143415517
X-MC-Ingress-Time: 1730131549271
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.137.60 (trex/7.0.2);
	Mon, 28 Oct 2024 16:05:49 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4XcdXV6hw2zFT;
	Mon, 28 Oct 2024 09:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1730131547;
	bh=QrniIkJ7AhEemPvfI/4hebsJ2/X7SQhZHVjWmCujUIk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=pRb6zxXTtYvDTPeG9SRZ6nbgS3wM+h/vwqna5XxL16DhjD+cPHqJlKpnqcWojhvrs
	 LPXRom2VjmRUjkSUXcG7Qlv26c1DPM7iRxAmTQ3dFPNyRD/rJzohL9gbc/bdd3+1uz
	 tHQFOMJKGvvA8ZRYXgFPpzW8DOKj5Ix+/lh3QbE7Z6a7IQXopvg2At6l3MQmGF7BK2
	 sYSVFMHak78kaUTL5UwLhtTQNaqtFPMLEY2+Tex2t3+6oDDJEJnXDLUSnDZBxX3IjN
	 5EbCudo97qAMcaX7r/2q8ADmTm2BVlhdm7TyaaMUBOS5sPgtqZp+lgKAuyAj/I8SPL
	 CO2ySZXP607cQ==
Date: Mon, 28 Oct 2024 09:05:43 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
	akpm@linux-foundation.org, ying.huang@intel.com, weixugc@google.com,
	dave.hansen@linux.intel.com, osalvador@suse.de, shy828301@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] vmscan,migrate: fix double-decrement on node stats when
 demoting pages
Message-ID: <20241028160543.rzx6nqsyldwocxe6@offworld>
Mail-Followup-To: Gregory Price <gourry@gourry.net>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, akpm@linux-foundation.org,
	ying.huang@intel.com, weixugc@google.com,
	dave.hansen@linux.intel.com, osalvador@suse.de, shy828301@gmail.com,
	stable@vger.kernel.org
References: <20241025141724.17927-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241025141724.17927-1-gourry@gourry.net>
User-Agent: NeoMutt/20220429

On Fri, 25 Oct 2024, Gregory Price wrote:

>When numa balancing is enabled with demotion, vmscan will call
>migrate_pages when shrinking LRUs.  Successful demotions will
>cause node vmstat numbers to double-decrement, leading to an
>imbalanced page count.  The result is dmesg output like such:
>
>$ cat /proc/sys/vm/stat_refresh
>
>[77383.088417] vmstat_refresh: nr_isolated_anon -103212
>[77383.088417] vmstat_refresh: nr_isolated_file -899642
>
>This negative value may impact compaction and reclaim throttling.
>
>The double-decrement occurs in the migrate_pages path:
>
>caller to shrink_folio_list decrements the count
>  shrink_folio_list
>    demote_folio_list
>      migrate_pages
>        migrate_pages_batch
>          migrate_folio_move
>            migrate_folio_done
>              mod_node_page_state(-ve) <- second decrement
>
>This path happens for SUCCESSFUL migrations, not failures. Typically
>callers to migrate_pages are required to handle putback/accounting for
>failures, but this is already handled in the shrink code.
>
>When accounting for migrations, instead do not decrement the count
>when the migration reason is MR_DEMOTION. As of v6.11, this demotion
>logic is the only source of MR_DEMOTION.
>
>Signed-off-by: Gregory Price <gourry@gourry.net>
>Fixes: 26aa2d199d6f2 ("mm/migrate: demote pages during reclaim")
>Cc: stable@vger.kernel.org

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

