Return-Path: <stable+bounces-232747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPLxH6HtzGknYAYAu9opvQ
	(envelope-from <stable+bounces-232747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:04:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E282C3782D9
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2BFB30F34BE
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5439BFF5;
	Wed,  1 Apr 2026 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ST4emp8p"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685C384242
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036886; cv=none; b=NfrqyTicHzoVgi6cA+0YbMT8hfk3D27Mody+sFcAuUIeH06J5adhWSPadHD/2U4Kyycue0eO4IY1F94QbYdMzg5/CKUZHNSwn1JI/5omniWZBeE05uf0yKvZ3rKBDZAUaULvEs95Q0umzTJrPLqHFK8KBAxHB3wkBFrpU50+On0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036886; c=relaxed/simple;
	bh=j7Vt/jlDtbxn7mqZMpxforSUGE7x43cWhuQ/GjEoAh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB/7Z664VIsUWzaPhQ65bY/kcW+naq6zS2XyQwEvsty8g2yHyiy1CpM58toq317v+yltG524Ez/E3ri71qIyNBbkeJhQT1UDtYnF7UCebowTnQGRT44QaDFUPEd7gvCEkyzWZZhGrUB6Q11ZhLcdcCbPzxsdlgJIE6shCJ6FtlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ST4emp8p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775036883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5Fn2UlyTzbBubxoJbwHjMcPOZ/geBIS1AM3iCXfMrc=;
	b=ST4emp8p0HfbFaxElkURR+xQXozyTbNouQuvW2cnmy1Dm0Ymx5FFd+l3Fnf3dmvuSEgWbX
	oAxxg8qIBthI6hUsqc7HUiOoTuDZlM4R5tNY7tMsoP7URTbeOQ18t5HK/hcdFvtpz/OFSK
	LSrVKAlDNw60sQdPWrQOewM/e4maWMM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-OchIZal7PCWIHHQhgfKtSQ-1; Wed,
 01 Apr 2026 05:48:00 -0400
X-MC-Unique: OchIZal7PCWIHHQhgfKtSQ-1
X-Mimecast-MFC-AGG-ID: OchIZal7PCWIHHQhgfKtSQ_1775036879
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A33418005BF;
	Wed,  1 Apr 2026 09:47:59 +0000 (UTC)
Received: from localhost (unknown [10.72.112.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1FF819560AB;
	Wed,  1 Apr 2026 09:47:57 +0000 (UTC)
Date: Wed, 1 Apr 2026 17:47:53 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	lirongqing <lirongqing@baidu.com>
Subject: Re: [PATCH v3] mm/vmalloc: Use dedicated unbound workqueues for vmap
 drain
Message-ID: <aczpyc7sxzBL4MQn@fedora>
References: <20260331202352.879718-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331202352.879718-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-232747-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhe@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E282C3782D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/31/26 at 10:23pm, Uladzislau Rezki (Sony) wrote:
> drain_vmap_area_work() function can take >10ms to complete
> when there are many accumulated vmap areas in a system with
> high CPU count, causing workqueue watchdog warnings when run
> via schedule_work():
> 
>   workqueue: drain_vmap_area_work hogged CPU for >10000us
> 
> Move the top-level drain work to a dedicated WQ_UNBOUND
> workqueue so the scheduler can run this background work
> on any available CPU, improving responsiveness. Use the
> WQ_MEM_RECLAIM to ensure forward progress under memory
> pressure.
> 
> Move purge helpers to separate WQ_UNBOUND | WQ_MEM_RECLAIM
> workqueue. This allows drain_vmap_work to wait for helpers
> completion without creating dependency on the same rescuer
> thread and avoid a potential parent/child deadlock.
...snip...  
> @@ -2385,29 +2390,31 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
>  		nr_purge_helpers = atomic_long_read(&vmap_lazy_nr) / lazy_max_pages();
>  		nr_purge_helpers = clamp(nr_purge_helpers, 1U, nr_purge_nodes) - 1;
>  
> -		for_each_cpu(i, &purge_nodes) {
> -			vn = &vmap_nodes[i];
> +		for_each_vmap_node(vn) {
> +			vn->work_queued = false;
> +
> +			if (list_empty(&vn->purge_list))
> +				continue;
>  
>  			if (nr_purge_helpers > 0) {
>  				INIT_WORK(&vn->purge_work, purge_vmap_node);
> +				vn->work_queued = schedule_drain_vmap_work(
> +					READ_ONCE(drain_vmap_helpers_wq), &vn->purge_work);

The new schedule_drain_vmap_work() could submit all purge_work on one
CPU, do we need use queue_work_on(cpu, wq, work) instead?

>  
> -				if (cpumask_test_cpu(i, cpu_online_mask))
> -					schedule_work_on(i, &vn->purge_work);
> -				else
> -					schedule_work(&vn->purge_work);
> -
> -				nr_purge_helpers--;
> -			} else {
> -				vn->purge_work.func = NULL;
> -				purge_vmap_node(&vn->purge_work);
> -				nr_purged_areas += vn->nr_purged;
> +				if (vn->work_queued) {
> +					nr_purge_helpers--;
> +					continue;
> +				}
>  			}
> -		}
>  
> -		for_each_cpu(i, &purge_nodes) {
> -			vn = &vmap_nodes[i];
> +			/* Sync path. Process locally. */
> +			purge_vmap_node(&vn->purge_work);
> +			nr_purged_areas += vn->nr_purged;
> +		}
>  
> -			if (vn->purge_work.func) {
> +		/* Wait for completion if queued any. */
> +		for_each_vmap_node(vn) {
> +			if (vn->work_queued) {
>  				flush_work(&vn->purge_work);
>  				nr_purged_areas += vn->nr_purged;
>  			}
...snip...
> +
> +static int __init vmalloc_init_workqueue(void)
> +{
> +	struct workqueue_struct *drain_wq, *helpers_wq;

Maybe there's one local variable is enough like below:

	struct workqueue_struct *wq;
	unsigned int flags = WQ_UNBOUND | WQ_MEM_RECLAIM;

	wq = alloc_workqueue("vmap_drain", flags, 0);
	WARN_ON_ONCE(wq == NULL);
	WRITE_ONCE(drain_vmap_wq, wq);

	wq = alloc_workqueue("vmap_drain_helpers", flags, 0);
	WARN_ON_ONCE(wq == NULL);
	WRITE_ONCE(drain_vmap_helpers_wq, wq);

	return 0;
}

Just personal preference on nitpick, not strong opionion.


