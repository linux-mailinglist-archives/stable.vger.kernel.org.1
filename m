Return-Path: <stable+bounces-233376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d32LLZ+t02ngkAcAu9opvQ
	(envelope-from <stable+bounces-233376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 14:57:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F00123A3687
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 14:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DB483012243
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4D370D48;
	Mon,  6 Apr 2026 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxTdZpNP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAF136F42E;
	Mon,  6 Apr 2026 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775480218; cv=none; b=BdS2JDtvyhQiOlVZ+iqBI/DyXFSUGCJYhYlH9uJ1wu+QBJm6x6rn6q7f7/+VAT8bDV6Y9ECBHwQov+4/hZ4pGUPsUC8aEGamA2MYCa0VebvcQhqPrWPmIkcbzco630wetSYoWP0Dru7de1MDohHlPFpSi3HkOhfBZwYnW0AqYKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775480218; c=relaxed/simple;
	bh=/gqPBpHI/Dqnmm0q5zZtq8gfBWK8tRIWRdnPie5+/64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmIpE0sWI4sdkVWxPYclT63IQwUKd2QUlN54zBwFUul/6qL0meLx7dMOn2oPCgLRSdddT4B2FYZN75ZCBszSK3+VNnS6aKL4Y4WnI5g5S8HuYkP5YD4kR692UE2zS19H6jLXkv6uH3Ltku92ClrjsKWd6fkZMAzetfYmVPWIzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxTdZpNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A43DC4CEF7;
	Mon,  6 Apr 2026 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775480218;
	bh=/gqPBpHI/Dqnmm0q5zZtq8gfBWK8tRIWRdnPie5+/64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxTdZpNPlT24ktQ1DHuXs5pVEHWUtdLUhqp575cj5MBhhXOQT29+UPraloNK36Sm8
	 qWBbI5pTGRuKtx8qK7UdSRFNHz2mBeoiy4oSqAsEs/luTI8pp8Gk+GVMpca1GMU9TC
	 t7DXEm18qQEN/RpF0RQ3SOgT9cb2Kss8jmeuuPQ+/oVlBwfcYJs6BB/d39KLD5xrxu
	 0lMIKwxBCu/8jPJHKFMim3AqQKJ2EAzgX/G2lJD2mOfuW+ltD4fbsXKRjgZun+ZqTm
	 TUiYq/hxI9nYho8cYDtjdgn36W6z+QjdYBj18umTGufERACT2zTJW5zZuAhA8ppqlV
	 PO8JKvoFaL+wg==
Date: Mon, 6 Apr 2026 13:56:49 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Alistair Popple <apopple@nvidia.com>, 
	Ralph Campbell <rcampbell@nvidia.com>, Christoph Hellwig <hch@lst.de>, 
	Jason Gunthorpe <jgg@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org, 
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5] mm: Fix a hmm_range_fault() livelock / starvation
 problem
Message-ID: <adOtS_q1MuFOawGM@lucifer>
References: <20260210115653.92413-1-thomas.hellstrom@linux.intel.com>
 <adOqU0UDzpxvQuwA@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adOqU0UDzpxvQuwA@lucifer>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233376-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,nvidia.com,lst.de,mellanox.com,ziepe.ca,kernel.org,linux-foundation.org,intel.com,kvack.org,vger.kernel.org,gmail.com,sk.com,gourry.net,linux.alibaba.com,infradead.org,oracle.com,google.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F00123A3687
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 01:54:13PM +0100, Lorenzo Stoakes (Oracle) wrote:
> I see John gave a tag (and he's great so that gives me confidence here),
> but we should really follow the procedure on this properly.

Oh and just noticed Alastair also :) so that adds further confidence, so this is
really a point about cc/M signoff requirement going forwards.

Thanks, Lorenzo

