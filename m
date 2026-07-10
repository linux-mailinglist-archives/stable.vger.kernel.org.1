Return-Path: <stable+bounces-273325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lcXSGGleUWpLDQMAu9opvQ
	(envelope-from <stable+bounces-273325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:04:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BEE73E9B5
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:04:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ggspvjEe;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273325-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273325-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC92F3032761
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 21:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECB73932D0;
	Fri, 10 Jul 2026 21:03:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2713A5422
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717411; cv=none; b=XQezV1zEmA5orHxLOtPG7J5gAnNGSI14VZdjbr7y9hRnzGMOvxc0UgtJyUtK0zzuNffxdmTRXwj6msQkX7MYbHKCp5WqH7Mqfcp5WRbZG7lwj1AKSbgUpzx4sOD9DvDjG8ySkjX5mBdcfrrbBZRu/pKwqnDD5ecZJChpyD/Otrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717411; c=relaxed/simple;
	bh=dGhvgE1KPwWzvjYxuoJ0GOlhR7MymQh7elYZaRPNznA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl1gMh/4NdhL2GHdI9sjN7A7hdfpEoSFnysKo0pMHRq2kfgohTkchY25Ebpqp7DnP8eP+yAhNgbk8TZOaK//Fe8yb8mDqyPTJpU7vqS4Nk7El9T6t4IsxncG/7KoiURqmA1zjXZTZDR2qK7iY254oXmS6Qx3zescKM1uUKKf+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggspvjEe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2C31F00A3D;
	Fri, 10 Jul 2026 21:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717409;
	bh=ULt6gHh2QCdF8zBbv63MnnI7JTZyzfPB5ocJSvuLQZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ggspvjEe71UciJcW4OC1V6S1KpRjoNP6I0ns1KgpIUPl4MTl47uLWtTmizQoQeK0W
	 o061InGZCSgctE/0HeDeRIVuIjEqi7s6a3qazXS5Xvsx+inTrfboLP3UsZdltUfw7v
	 TduLs8ntNo834jp9qOUGG2l6GXyMrxvZsVfZCMAtSkNa+oM5+9mN1f07S9NZ2xUC8v
	 Qx2RMIoIP2+of6P/1iKR+2ZTlEDJLUFMUoNmK4n58A36Xu9bwfTGukgRkxNSIJuvqA
	 Kx2/IlzPqZ+RO8nfB9WhM4el364snvJMV55nbuPiTlGQRM0aswqkOnOTyLC0RWY4x9
	 J8I8iaFXtKd2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Hyokyung Kim <pulpannie@gmail.com>
Subject: Re: [PATCH 6.1.y] virtio_net: Support dynamic rss indirection table size
Date: Fri, 10 Jul 2026 17:03:02 -0400
Message-ID: <20260710163023.agent5-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710112521.234909-1-pulpannie@gmail.com>
References: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com> <20260710112521.234909-1-pulpannie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273325-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,linux.alibaba.com,fastly.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:lulie@linux.alibaba.com,m:xuanzhuo@linux.alibaba.com,m:jdamato@fastly.com,m:pabeni@redhat.com,m:pulpannie@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20BEE73E9B5

On Fri, Jul 10, 2026 at 11:25:21AM +0000, Hyokyung Kim wrote:
> However, the indirection_table was statically sized as
> VIRTIO_NET_RSS_MAX_TABLE_LEN=128, potentially causing issues when
> vi->rss_indir_table_size exceeds this limit.
>
> This patch implements dynamic allocation for the indirection table,
> allocated alongside vi->rss after vi->rss_indir_table_size is initialized,
> and freed in virtnet_remove().

Queued for 6.1, thanks.

-- 
Thanks,
Sasha

