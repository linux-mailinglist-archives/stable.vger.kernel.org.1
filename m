Return-Path: <stable+bounces-271913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N0IYB+ZqSGpSqAAAu9opvQ
	(envelope-from <stable+bounces-271913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:07:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8622706732
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:07:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S79PiGOU;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271913-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271913-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 434493052FEC
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9132372B5A;
	Sat,  4 Jul 2026 02:06:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CACC374731
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:06:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130768; cv=none; b=Js+AOiU86Z6VD3NMo0y9BoMBT2pgMVQPu/S0rLbHbw7GWXlqnlbkjAOPdOgsb1Zno4tkzGZAiOd42TNmCMwcl0B/o53ecD7L3SX8JsiAfMY4NOyHTut314lITyIzNvwkeZ1D/ttpgay8vBT7vO6rZy6rP9gnOmV47WGi14Tv1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130768; c=relaxed/simple;
	bh=FBFq9dAeCVni7zkMjICeLLc0tapwVo8wQIxEYfmQo5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pt+gV/Mnks803pjSatVKwUVEUWRcsbmcQ+wgMSNgVritic7VURO6N7+vPkoWMy3kkJcyPf4ZDdqmQRE3GDIC4eEBYCpRQW/9zjW89xUlREi6qA+AwYAbQRPNMvx7EaF8GMBCFskR3MV4fE03jWFNVaA5iPaO5GmcG2jp2/AC0qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S79PiGOU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589371F000E9;
	Sat,  4 Jul 2026 02:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130767;
	bh=DyoPHs4l3/dZFD3QTBOPCkOSjHYt8zbBJsp7JlbbYZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S79PiGOUs5t7XFr4fSqE6G5xF3rpMDCVtYQPZwrgU0IKrK0gdidrETMacBte6j512
	 3m9PDjwD0MSc8a7LkZ40/uV9z/lwhNwlUjDVMrDPFdIclHMvmq01pGTfmqYvm1KnWG
	 +E+FHqgww09faeX2x+Dfg9783iUZffxrCFp2Flv08cMr8RjGTvljHAHdgrinAou9O0
	 3yFxIde/5A0fIUdhDeDh82thH9HXL/XoJwBYkUIVyTNvwT8yvAatp3sZgruWKF++s7
	 0XDO5Z22JmIADusNr6T3gKBATWpLtVDhYkT8UzuyDpsVBSUcoZVZzxXH9OMVdlSlY0
	 bzcm9hQXBPPHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Hyokyung Kim <pulpannie@gmail.com>
Subject: Re: [PATCH 6.6.y] virtio_net: clamp rss_indir_table_size to VIRTIO_NET_RSS_MAX_TABLE_LEN
Date: Fri,  3 Jul 2026 22:05:24 -0400
Message-ID: <2026070315-stable-reply-0030@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703105059.3821189-1-pulpannie@gmail.com>
References: <20260703105059.3821189-1-pulpannie@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271913-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:pulpannie@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8622706732

On Thu, Jul 03, 2026 at 07:50:59PM +0900, Hyokyung Kim wrote:
> This was fixed upstream by commit 86a48a00efdf ("virtio_net: Support
> dynamic rss indirection table size"), which reworks the driver to
> allocate the indirection table dynamically. However that change is too
> large to backport to stable. Instead, clamp the device-advertised length

Thanks for working on this, and for the KASAN/UBSAN testing. However, rather
than a stable-only clamp that deviates from what upstream did, I'd prefer a
proper backport of 86a48a00efdf ("virtio_net: Support dynamic rss indirection
table size") with the conflicts resolved for 6.6.y and 6.1.y. Staying aligned
with upstream keeps future backports to these trees from getting harder, and
avoids carrying behavior that was never reviewed upstream.

-- 
Thanks,
Sasha

