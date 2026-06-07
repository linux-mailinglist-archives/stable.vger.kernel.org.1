Return-Path: <stable+bounces-260929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9a1DIrc8JWpSEwIAu9opvQ
	(envelope-from <stable+bounces-260929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 11:41:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C581864F3D5
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 11:41:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jxXJyWkY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260929-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260929-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93AEB30103B0
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C4430EF90;
	Sun,  7 Jun 2026 09:41:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42062AF00;
	Sun,  7 Jun 2026 09:41:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780825265; cv=none; b=kktmLk7fAT1w+Kx7K+igmgeWLzeSRGiE7fJ7ABuLnUbCj7WLoG4gJpRqZLZBXiDGwBfnxvtlgHzP4CIEV6U491M4gBlgYwlgAIYUbVqSnPRf4YptXcn5n4vr7dLWxUZGxpMZUDoHlAvo1odg7l7o/9UaZ32/YrqD968W1I9NlxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780825265; c=relaxed/simple;
	bh=oBU+hVOHZJL4Nc2u2hWaAGFWZciV2CK/BPbJbmdPQWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmavduMXn65aa7lbdoLBu06XmO+10IwWuEO4L1vzEoNes/HR5Oy5E18cawPV1FnGfHvYUxr5qasepgoD9VdFZMSxQ+FdmWeiKr/vhosiyieZ/ITjyHluYJu1LL5Dj1+V3zcuPLbj+i3aR0AaOCOL1QzsXKljfZnOdMUiq4ofy3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxXJyWkY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5D21F00893;
	Sun,  7 Jun 2026 09:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780825264;
	bh=dQj5Uv7t9KZulzKNARL/h1xIIEJfpiotu+ZxBAIVAjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jxXJyWkYAheaa+HAD8W5RsBp+eg4te2bRDyYEF6DSdeQ1CshV9RPk7PIAzpuVOQZO
	 7FPxskvJfzH6AI155IUpqWnSrarh9/JsM4RsQO/iQHgxNWt3DX3zDt0Sf9X++xjMUp
	 J/gduDQhC1bGsbB68D05l9hxN7jNWCLYGevAX/rVPZx7O1qAuVnpD9GjgwxHReSmRD
	 72BAfOCWd35ovJVFebpIFVkNx29DSm/8RHi+gpnbX8cZwlgJVAKpZgfT4GvgpDrC/X
	 Av9yP8PB6oetxT6lEGeVHzh69SggTN9AQ6m+x7TElCkLGvSTsYolN2f+UdzTVDeWfr
	 rqpya3isueNIw==
Message-ID: <6d6f0792-2fbb-4985-819c-87fa499da4ce@kernel.org>
Date: Sun, 7 Jun 2026 11:40:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-apple: Prevent shared tags across queues on Apple
 A11
To: Nick Chan <towinchenmi@gmail.com>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260607-prevent-tag-collision-t8015-v2-1-dc4ef4fb42bc@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260607-prevent-tag-collision-t8015-v2-1-dc4ef4fb42bc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:towinchenmi@gmail.com,m:j@jannau.net,m:neal@gompa.dev,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-nvme@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sven@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260929-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com,jannau.net,gompa.dev,kernel.org,kernel.dk,lst.de,grimberg.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C581864F3D5

On 07.06.26 08:10, Nick Chan wrote:
> On Apple A11, tags of pending commands must be unique across the admin
> and IO queues, else the firmware crashes with
> "duplicate tag error for tag N", with N being the tag.
> 
> Apply the existing workaround for M1 of reserving two tags for the admin
> queue to A11.
> 
> Cc: stable@vger.kernel.org
> Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>


Best,

Sven


