Return-Path: <stable+bounces-232880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFqvIWq3zWkLgAYAu9opvQ
	(envelope-from <stable+bounces-232880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 02:25:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 067DF381F9C
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 02:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BAF301DAE9
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 00:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB5C1AF4E9;
	Thu,  2 Apr 2026 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Js4OBXXL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64181A6813
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 00:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089369; cv=none; b=UkLWuCwvo4Y7Ft+lHXK+2oXqIGR5VnY2wMAGJ7K4hej6qcvtdedJSCKqUOnM+6/QhmF84se/5V7v+22eCFIbxhZIKZHidF+UcuO4+ZoNMv2gKNZaUX9LtnYDesNhN8EbWvhkll/KOG5DdqpOkvr92RftW3h9qhRTeOyrB4Tc2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089369; c=relaxed/simple;
	bh=5CRMHl/Rqo4IGHxD+2SJpsRDBrLyJuBEgy1KMxK/buU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSIM6Bkmi/DUWDWNkPq+eE5okDPzSAkOqKAMi0TGHHvTR9UQKpPuhbHgMdeNNbkRyDYNvb3xR8SqkFRYX5I8A7j7eazUjzJSebyGnmgMR0+QA5+K8chPk2+CxzOeUEhs+YBIaTZS8+7CY/xmeaTFrAynXkHTpuKur3BrX/Daga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Js4OBXXL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775089366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NlkIZN1Pdr6pNDUfmFvV3yq+JtJ/V9pLJnouaitb3YA=;
	b=Js4OBXXL7+4QToQSvfGUlA9u9E55vm1zkMHYsluvmIvIrlKpGAVBp5xaH5GH7y3oKuDEGz
	/F3qcdCMLUli0xA8W3r7S4YRs64BG50Ys/18gcaZVxFrDtthhdv9q4dxRcT5M26yYB5rzh
	ASc04mfywqhB88qE1WUnv3Va+lsazfk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-Rcc8fe1WNMCasc1wit2v8Q-1; Wed,
 01 Apr 2026 20:22:43 -0400
X-MC-Unique: Rcc8fe1WNMCasc1wit2v8Q-1
X-Mimecast-MFC-AGG-ID: Rcc8fe1WNMCasc1wit2v8Q_1775089362
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20E7018005B0;
	Thu,  2 Apr 2026 00:22:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.46])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF2F01800767;
	Thu,  2 Apr 2026 00:22:40 +0000 (UTC)
Date: Thu, 2 Apr 2026 08:22:36 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	lirongqing <lirongqing@baidu.com>
Subject: Re: [PATCH v3] mm/vmalloc: Use dedicated unbound workqueues for vmap
 drain
Message-ID: <ac22zMBjWgQnLfpI@fedora>
References: <20260331202352.879718-1-urezki@gmail.com>
 <aczpyc7sxzBL4MQn@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aczpyc7sxzBL4MQn@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-232880-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 067DF381F9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/01/26 at 05:47pm, Baoquan He wrote:
> On 03/31/26 at 10:23pm, Uladzislau Rezki (Sony) wrote:
> > drain_vmap_area_work() function can take >10ms to complete
> > when there are many accumulated vmap areas in a system with
> > high CPU count, causing workqueue watchdog warnings when run
> > via schedule_work():
> > 
> >   workqueue: drain_vmap_area_work hogged CPU for >10000us
> > 
> > Move the top-level drain work to a dedicated WQ_UNBOUND
> > workqueue so the scheduler can run this background work
> > on any available CPU, improving responsiveness. Use the
> > WQ_MEM_RECLAIM to ensure forward progress under memory
> > pressure.
> > 
> > Move purge helpers to separate WQ_UNBOUND | WQ_MEM_RECLAIM
> > workqueue. This allows drain_vmap_work to wait for helpers
> > completion without creating dependency on the same rescuer
> > thread and avoid a potential parent/child deadlock.
> ...snip...  
> > @@ -2385,29 +2390,31 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
> >  		nr_purge_helpers = atomic_long_read(&vmap_lazy_nr) / lazy_max_pages();
> >  		nr_purge_helpers = clamp(nr_purge_helpers, 1U, nr_purge_nodes) - 1;
> >  
> > -		for_each_cpu(i, &purge_nodes) {
> > -			vn = &vmap_nodes[i];
> > +		for_each_vmap_node(vn) {
> > +			vn->work_queued = false;
> > +
> > +			if (list_empty(&vn->purge_list))
> > +				continue;
> >  
> >  			if (nr_purge_helpers > 0) {
> >  				INIT_WORK(&vn->purge_work, purge_vmap_node);
> > +				vn->work_queued = schedule_drain_vmap_work(
> > +					READ_ONCE(drain_vmap_helpers_wq), &vn->purge_work);
> 
> The new schedule_drain_vmap_work() could submit all purge_work on one
> CPU, do we need use queue_work_on(cpu, wq, work) instead?

Forgot the specified WQ_UNBOUND on alloc_workqueue(), sorry for the
noise. Then this patch looks great to me.

> 
> >  
> > -				if (cpumask_test_cpu(i, cpu_online_mask))
> > -					schedule_work_on(i, &vn->purge_work);
> > -				else
> > -					schedule_work(&vn->purge_work);
> > -
> > -				nr_purge_helpers--;
> > -			} else {
> > -				vn->purge_work.func = NULL;
> > -				purge_vmap_node(&vn->purge_work);
> > -				nr_purged_areas += vn->nr_purged;
> > +				if (vn->work_queued) {
> > +					nr_purge_helpers--;
> > +					continue;
> > +				}
> >  			}
> > -		}
> >  
> > -		for_each_cpu(i, &purge_nodes) {
> > -			vn = &vmap_nodes[i];
> > +			/* Sync path. Process locally. */
> > +			purge_vmap_node(&vn->purge_work);
> > +			nr_purged_areas += vn->nr_purged;
> > +		}
> >  
> > -			if (vn->purge_work.func) {
> > +		/* Wait for completion if queued any. */
> > +		for_each_vmap_node(vn) {
> > +			if (vn->work_queued) {
> >  				flush_work(&vn->purge_work);
> >  				nr_purged_areas += vn->nr_purged;
> >  			}
> ...snip...
> > +
> > +static int __init vmalloc_init_workqueue(void)
> > +{
> > +	struct workqueue_struct *drain_wq, *helpers_wq;
> 
> Maybe there's one local variable is enough like below:
> 
> 	struct workqueue_struct *wq;
> 	unsigned int flags = WQ_UNBOUND | WQ_MEM_RECLAIM;
> 
> 	wq = alloc_workqueue("vmap_drain", flags, 0);
> 	WARN_ON_ONCE(wq == NULL);
> 	WRITE_ONCE(drain_vmap_wq, wq);
> 
> 	wq = alloc_workqueue("vmap_drain_helpers", flags, 0);
> 	WARN_ON_ONCE(wq == NULL);
> 	WRITE_ONCE(drain_vmap_helpers_wq, wq);
> 
> 	return 0;
> }
> 
> Just personal preference on nitpick, not strong opionion.
> 


