Return-Path: <stable+bounces-256530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLZEIGU2GWrzswgAu9opvQ
	(envelope-from <stable+bounces-256530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:47:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8334C5FE1DA
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 499C53002F7F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122203AA9E8;
	Fri, 29 May 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t0iz5BRK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fp1y/pB5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ojfIjkYI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mxhtg3sP"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13843AA9D4
	for <stable@vger.kernel.org>; Fri, 29 May 2026 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037123; cv=none; b=hnuEqvU3WZEH0AqdCoxxHkhm2AAmSLCeCxLa8r1HI8Ghkd48C8rvYBcoUdu/IJ0uz31vAnMMfcGGCZXhlaV+J7/h/tyLnWqnRovwvZ5q7w/U3a3PmJkm4cwC9GmFc7dHeyqM+EMormMBZv0nXpQHps0dYBCRUbkjsF6DKhLBd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037123; c=relaxed/simple;
	bh=1TxjLqhPlkY8s9kpbe/og5fpssH1ox29Lplr1Nppq1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KI6lVekVALI44hvlXCt1WSbuxbngM+RFMo6Bh1KDU9hJOaL54haSy8VFyUNg8o5AL5+Qw7wPLZKNnE2kW59SIP7NEo2QyfjUribrHs3k4FrVnSQfMjuSpWwOnitZhk+cjKp6P5+Fqa5R4SHxo5BvuLjeT+GcIasCkqb+pqHzdPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t0iz5BRK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fp1y/pB5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ojfIjkYI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mxhtg3sP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E576266F47;
	Fri, 29 May 2026 06:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780037120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00oEdflBq6KtkPgqg+2OlO9BXkLU2OZ1RZrsgnWL2Ac=;
	b=t0iz5BRKXWdsSEWHa3rj+u4/+i2ZOjAHjRrsExfQHjs8lH7LnN5F/qQaYSGiC/3e/dmFWM
	6YCbHFBS5obGZIl62ruSzz+2gsZ6W6exB3tMsqyhHk1AwfHc0imeMAqNx2+KtMtAXxwZ5T
	F28uH2gkgm63iT3cN1BI/JIGMskTGuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780037120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00oEdflBq6KtkPgqg+2OlO9BXkLU2OZ1RZrsgnWL2Ac=;
	b=fp1y/pB54Vrz/Gb3TnWm5e81o1BdVG+PTYhbL3hYbvGRKEphT0G94xAwVPzVFa/xVZrV+E
	20Mfe7yIX0SvAKAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ojfIjkYI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mxhtg3sP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780037119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00oEdflBq6KtkPgqg+2OlO9BXkLU2OZ1RZrsgnWL2Ac=;
	b=ojfIjkYI2nuF/7Y9I3HXPpfSAdVFyF2wj+tTT3rH6IQSCd4S8qHpxeeskZ90XoMJEG9Kt9
	ZCNkQsg8ViBgBJN9GZ8g8CgM2pkNqiK+tCXOJgrTzy9+v4jTaSr4CVWpfFuDV35LM5pn7N
	BeBEfFMVT7+6Fa0WSWZFsPSM/gSAux4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780037119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00oEdflBq6KtkPgqg+2OlO9BXkLU2OZ1RZrsgnWL2Ac=;
	b=mxhtg3sP8KzGeSU/0ymb06q22HJ+tACNXXIH+2p/Oq0CyaFARXUnxhZhzIEFkQOULfL4P7
	A7SOsUwjZi6qZHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9C215B1E1;
	Fri, 29 May 2026 06:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bvg5KP81GWrcLgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:45:19 +0000
Message-ID: <b8d1fda2-a2da-4b35-9bd5-941834f26c32@suse.de>
Date: Fri, 29 May 2026 08:45:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-256530-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8334C5FE1DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 17:24, Achkinazi, Igor wrote:
> When nvme_ns_head_submit_bio() remaps a bio from the multipath head to
> a per-path namespace, bio_set_dev() clears BIO_REMAPPED.  The remapped
> bio is then resubmitted through submit_bio_noacct() which calls
> bio_check_eod() because BIO_REMAPPED is not set.
> 
> This races with nvme_ns_remove() which zeroes the per-path capacity
> before synchronize_srcu():
> 
>    CPU 0 (IO submission)
>    ---------------------
>    srcu_read_lock()
>    nvme_find_path() -> ns
>      [NVME_NS_READY is set]
> 
>    CPU 1 (namespace removal)
>    -------------------------
>    clear_bit(NVME_NS_READY)
>    set_capacity(ns->disk, 0)
>    synchronize_srcu()  <- blocks
> 
>    CPU 0 (IO submission)
>    ---------------------
>    bio_set_dev(bio, ns->disk->part0)
>      [clears BIO_REMAPPED]
>    submit_bio_noacct(bio)
>      -> bio_check_eod() sees capacity=0
>      -> bio fails with IO error
> 
> The SRCU read lock prevents synchronize_srcu() from completing, but
> does not prevent set_capacity(0) from executing.  The bio fails the
> EOD check before it reaches the NVMe driver, so nvme_failover_req()
> never gets a chance to redirect it to another path of multipath.  IO errors
> are reported to the application despite another path being available.
> 
> On older kernels (before commit 0b64682e78f7 "block: skip unnecessary
> checks for split bio"), the same race was also reachable through split
> remainders resubmitted via submit_bio_noacct().
> 
> Observed during NVMe multipath failover testing at Dell on
> 5.14.0-570.23.1.el9_6.x86_64 (RHEL 9.7) and
> 6.4.0-150600.23.53-default (SLES 15.6).
> 
> Fix this by setting BIO_REMAPPED after bio_set_dev() in
> nvme_ns_head_submit_bio().  This skips bio_check_eod() on the per-path
> device; the EOD check already passed on the multipath head.
> 
> NVMe per-path namespace devices are always whole disks (bd_partno=0),
> so the blk_partition_remap() skip also gated by BIO_REMAPPED is a
> no-op.  The flag does not persist across failover and cannot go stale
> if the namespace geometry changes between attempts: nvme_failover_req()
> calls bio_set_dev() to redirect the bio back to the multipath head,
> which clears BIO_REMAPPED.  When nvme_requeue_work() resubmits through
> submit_bio_noacct(), bio_check_eod() runs normally against the current
> capacity.
> 
> Same approach as commit 3a905c37c351 ("block: skip bio_check_eod for
> partition-remapped bios").
> 
> A broader solution that moves bio validation into the queue-entered
> context and eliminates the set_capacity(0) hack is being developed
> upstream, however this minimal fix is suitable for backporting to
> stable kernels affected today. The link to the mentioned patch:
> https://lore.kernel.org/linux-block/20260519172326.3462354-1-kbusch@meta.com/
> 
> Fixes: a7c7f7b2b641 ("nvme: use bio_set_dev to assign ->bi_bdev")
> Cc: stable@vger.kernel.org
> Signed-off-by: Igor Achkinazi <igor.achkinazi@dell.com>
> ---
> v2:
>    - Corrected race description: primary race is in the initial
>      submit_bio_noacct() call in nvme_ns_head_submit_bio(), not
>      only in split remainders (which are no longer affected on
>      current mainline since commit 0b64682e78f7)
>    - Dropped incorrect arguments about submit_bio_noacct_nocheck
>      export status and BIO_REMAPPED propagation to split clones
>    - Added analysis showing BIO_REMAPPED flag does not persist
>      across failover (nvme_failover_req clears it via bio_set_dev)
>    - Referenced upstream RFC series addressing the root cause
> 
>   drivers/nvme/host/multipath.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 263161cb8ac0..04f7c7e59945 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -511,6 +511,13 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
>          ns = nvme_find_path(head);
>          if (likely(ns)) {
>                  bio_set_dev(bio, ns->disk->part0);
> +               /*
> +                * Skip bio_check_eod() when this bio enters
> +                * submit_bio_noacct() for the per-path device.
> +                * The EOD check already passed on the multipath head.
> +                */
> +               bio_set_flag(bio, BIO_REMAPPED);
>                  bio->bi_opf |= REQ_NVME_MPATH;
>                  trace_block_bio_remap(bio, disk_devt(ns->head->disk),
>                                        bio->bi_iter.bi_sector);
> --
> 2.43.0
> 
> 
> Internal Use - Confidential
> 
... or you could introduce __bio_set_dev():

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 97d747320b35..5a2709adeea7 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -518,15 +518,20 @@ static inline void blkcg_punt_bio_submit(struct 
bio *bio)
  }
  #endif /* CONFIG_BLK_CGROUP */

-static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
+static inline void __bio_set_dev(struct bio *bio, struct block_device 
*bdev)
  {
-       bio_clear_flag(bio, BIO_REMAPPED);
         if (bio->bi_bdev != bdev)
                 bio_clear_flag(bio, BIO_BPS_THROTTLED);
         bio->bi_bdev = bdev;
         bio_associate_blkg(bio);
  }

+static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
+{
+       bio_clear_flag(bio, BIO_REMAPPED);
+       __bio_set_dev(bio, bdev);
+}
+
  /*
   * BIO list management for use by remapping drivers (e.g. DM or MD) 
and loop.
   *

to avoid all this clear-and-set-flag dance.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

