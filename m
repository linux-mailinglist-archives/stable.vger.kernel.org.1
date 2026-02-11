Return-Path: <stable+bounces-215887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBbqN58KjWmLyAAAu9opvQ
	(envelope-from <stable+bounces-215887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 00:02:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B118128376
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 00:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76499308299C
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 23:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451430E84B;
	Wed, 11 Feb 2026 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="QU7y1Ajr"
X-Original-To: stable@vger.kernel.org
Received: from cyan.elm.relay.mailchannels.net (cyan.elm.relay.mailchannels.net [23.83.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B714A4F0
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770850972; cv=pass; b=UD9k2+JvgoawLPiC8nUC8f2OJfH/X/qtP2Ktr+a6EjUQxrN8aEWsNLnvGdoGpTroFrcPOrnuA5XM4hFTbVuAiSoCQn3qoVR68D0pMW5RPc3jvuHDKIr+jTkK7XfdafVAfNTFam1xUC9ghVuZrGss6mgx5SncsEmeIiz+n6QwKVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770850972; c=relaxed/simple;
	bh=P+fvtYziTwRZBnIuTKKn88BHCaSSK4qqUTpDU+RL768=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrPM97kalq9EFhJpveOUC2dvor5R03Bwf08mk3zfnqvYbQSujdchwrIQestmC2mjQsV5p80OFqg6rPywFKTkl5+yaVlPS276rerpc72YRiGAs3asBKVD2V6AbohrnhCA2ul1SgHB+mar06B6V8Z7c6jmGras1i7yMK/YUm0Zv0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=QU7y1Ajr; arc=pass smtp.client-ip=23.83.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C10F944199D;
	Wed, 11 Feb 2026 22:23:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-96-86-174.trex-nlb.outbound.svc.cluster.local [100.96.86.174])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 452BC441A1E;
	Wed, 11 Feb 2026 22:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770848587;
	b=IypmqsYIeBZwbj16uTuPsarvT3ON3Vy6pmMNPSgl0hoZ/VDvuZn55ohmZIIJ/Lfw3iS/23
	TeecAD390LyowofmK6q82MAlgP/9J33ZPx168sTiW2/Wla6RLNHWuDx99jCL1PwK3VWxC9
	uFK4wEXzWPR7hIz1UvtYoVXqLXJ05LMczQZjeHFkDsocFcrOtvyOOVSTaM43RVGahcAGXw
	OpyDd1C1YQMU3F/VY9tYNoc0fmweffGKs3YDcZn8eeL1Se0axDaqO+IpwVM1TYzS434Jt0
	r728vEwhDuj3ork9F0xFX3YdtQdmZYJBuSHGw2OeeqVICCFngLqVItVhIO3HHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770848587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PONYIdbDGRxdo56DTcMpUfL2VeqX9vWTpesN1Ub95bk=;
	b=uzdNdLen5mvUQkOu5dpYKKJEMNRGNPMAEcAwpbj75UB4hGdKqS4mHN8EMH+EN08PvL6oRw
	MZ68A+4ktRQwOIslbUNj48aiyX7cmZxRnXavnAqdjWK1EhjiOjt5YZWrIXoZA3JqdmT0oc
	AsYZgix4nuOJWVr0+hNrmtnH8IMBy1EwAKunjxj2Z770lsdvNR/GDtETV8EBGKOy0dMWy5
	1FxW8W1vHroev4Rut5gNj4/DOxlMgnF2k0a217Tp57u+nBXo/tBAKH2mCgcMPfKBR6vTcC
	0dD83sUWjMEJXZBGtHpgoeAHKpilyffkvQmwxu7NMa+najGhEBpWp7kt1xenNw==
ARC-Authentication-Results: i=1;
	rspamd-79bdc9947c-w8xzw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Befitting-Dime: 0ddd63e94dd79c47_1770848587598_223137175
X-MC-Loop-Signature: 1770848587598:2068019580
X-MC-Ingress-Time: 1770848587597
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.86.174 (trex/7.1.3);
	Wed, 11 Feb 2026 22:23:07 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4fBCcV2qX7z1041;
	Wed, 11 Feb 2026 14:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1770848587;
	bh=PONYIdbDGRxdo56DTcMpUfL2VeqX9vWTpesN1Ub95bk=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=QU7y1Ajr1a7JKLxkXZWmXPu5llbF+rk9H33Ux5srLDRFR3jGMgNXO3EazwSlJOO74
	 rFzzSWY8KbDsbgkCUv/ors6d/cg3U6taTgULmVYzyIJCvN1NDpg6BMRs8KPueHJxfZ
	 IuOXzmXb4dpnKIw8uLnHETQifiWtSKFjg4BufO4boU+UPABj5fXjNZsXAYjgCv8T/s
	 q5gktzcj2f6PNrjlJssrVGxJy6Gd/JM8mHRC/WLkVhWxK3JBxn39Vj9pcGh0Hmg1b5
	 e1PC/NSuvJz3ANjmx+pCcsT8JKySIzDb2g/hLIcMCgHCJaefuF80oZUPOHyGKrfeNZ
	 XGMPLpCreYB2w==
Date: Wed, 11 Feb 2026 14:23:03 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Thomas =?utf-8?B?SGVsbHN0csOvwr/CvW0=?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Alistair Popple <apopple@nvidia.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] mm: Fix a hmm_range_fault() livelock / starvation
 problem
Message-ID: <20260211222303.42qfp6rqxxnpfkr4@offworld>
Mail-Followup-To: Thomas =?utf-8?B?SGVsbHN0csOvwr/CvW0=?= <thomas.hellstrom@linux.intel.com>,
	intel-xe@lists.freedesktop.org,
	Alistair Popple <apopple@nvidia.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260210115653.92413-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260210115653.92413-1-thomas.hellstrom@linux.intel.com>
User-Agent: NeoMutt/20220429
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[stgolabs.net:s=dreamhost];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[stgolabs.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stgolabs.net:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215887-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave@stgolabs.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[stgolabs.net:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4B118128376
X-Rspamd-Action: no action

On Tue, 10 Feb 2026, Thomas Hellstr=EF=BF=BDm wrote:

>@@ -176,7 +176,7 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, u=
nsigned long start,
> 		}
>
> 		if (softleaf_is_migration(entry)) {
>-			migration_entry_wait_on_locked(entry, ptl);
>+			softleaf_entry_wait_on_locked(entry, ptl);
> 			spin_unlock(ptl);

softleaf_entry_wait_on_locked() unconditionally drops the ptl.

> 			return -EAGAIN;
> 		}

