Return-Path: <stable+bounces-233926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEvaIBZl1mnIEwgAu9opvQ
	(envelope-from <stable+bounces-233926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:24:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 897A53BD9E4
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C3263002F5B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2502A2C1584;
	Wed,  8 Apr 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9mhvM51"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5123D3492
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658256; cv=none; b=oJbsFJeeaCpz1wixvLxBktPTw55YAulkxVgtgNRbOgVJjm7FbWjjXdxOhk8CD4SNAheY2W9vvKip23+lWxSrrHGv20nLw9vNZihtG+MTAfN9uVTcIWWUML8459trwChyaNG2PzdCDbt9QQovSid6gddGjvbzmayarDujimKVCM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658256; c=relaxed/simple;
	bh=EA0LUlzTmwQYUylZWstpx5RpK7BRBsExeu87PuVHmpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PP2JEasf7u6N5SA4JQc84kmV41g5pGPAOpkfmX+izqDa+Jxo8FEV0vPzAbrSz+r6Z+OkHZqE/eGmZbfkgI86UXaKxhzSAl5cwE++6DDJbrh6qWtcbEribnJUBwHbu8uRLY+18CTXs4jHxJKZPA3I2UcpPD6JqWBcjEjaC9Q9sEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9mhvM51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B55C19421;
	Wed,  8 Apr 2026 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775658256;
	bh=EA0LUlzTmwQYUylZWstpx5RpK7BRBsExeu87PuVHmpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9mhvM517UcelJp0XcWBPh5mJ9HOoEdEe2XFTK68rcD0wC8fQc8rxIRQc0KIElW16
	 0BR3/+e7Fp/GOYS6sTT8fVp2WgJ6tUk1wai5poBNIos7haFcF68OPUERBZXYq4cOgf
	 WNorEDp1ybJphwqK3P91fbmklyiWkxrdvP2G8C6+OZ3sROD1naGkIq5KcpqG4BZc7x
	 Q65lDHYWNvNckI9pnvewTeyK8Cpma5wj/+4+qrXo/DOQLrpgjmnoweFNdV2t+zbEbp
	 A20gLvPINOJ7431yawtJkustRk7EKAz729xC2niX1FiiOPWPvv5qmFhg+qBlDNmCSz
	 xziGAVADvF3lg==
Date: Wed, 8 Apr 2026 10:24:14 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stable@vger.kernel.org, Srujana Challa <schalla@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Message-ID: <adZlDssL48EBKzON@laps>
References: <2026040856-ploy-antiviral-fecc@gregkh>
 <20260408134351.1100654-1-sashal@kernel.org>
 <20260408095309-mutt-send-email-mst@kernel.org>
 <adZjFGvv3VAPLV3I@laps>
 <20260408101810-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260408101810-mutt-send-email-mst@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233926-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 897A53BD9E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 10:20:50AM -0400, Michael S. Tsirkin wrote:
>On Wed, Apr 08, 2026 at 10:15:48AM -0400, Sasha Levin wrote:
>> On Wed, Apr 08, 2026 at 09:54:33AM -0400, Michael S. Tsirkin wrote:
>> > On Wed, Apr 08, 2026 at 09:43:51AM -0400, Sasha Levin wrote:
>> > > From: Srujana Challa <schalla@marvell.com>
>> > >
>> > > [ Upstream commit b4e5f04c58a29c499faa85d12952ca9a4faf1cb9 ]
>> > >
>> > > rss_max_key_size in the virtio spec is the maximum key size supported by
>> > > the device, not a mandatory size the driver must use. Also the value 40
>> > > is a spec minimum, not a spec maximum.
>> > >
>> > > The current code rejects RSS and can fail probe when the device reports a
>> > > larger rss_max_key_size than the driver buffer limit. Instead, clamp the
>> > > effective key length to min(device rss_max_key_size, NETDEV_RSS_KEY_LEN)
>> > > and keep RSS enabled.
>> > >
>> > > This keeps probe working on devices that advertise larger maximum key sizes
>> > > while respecting the netdev RSS key buffer size limit.
>> > >
>> > > Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
>> > > Cc: stable@vger.kernel.org
>> > > Signed-off-by: Srujana Challa <schalla@marvell.com>
>> > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> > > Link: https://patch.msgid.link/20260326142344.1171317-1-schalla@marvell.com
>> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> > > [ changed clamp target from NETDEV_RSS_KEY_LEN to VIRTIO_NET_RSS_MAX_KEY_SIZE ]
>> >
>> > Does this not make the subject and the commit log misleading?
>>
>> Probably, but changing the commit subject will just create more confusion.
>>
>> --
>> Thanks,
>> Sasha
>
>It's not just the subject. The commit log says:
>
>	Also the value 40 is a spec minimum, not a spec maximum.
>
>but the changed patch seems to treat it as a maximum:
>
>+               vi->rss_key_size = min_t(u16, key_sz, VIRTIO_NET_RSS_MAX_KEY_SIZE);
>
>
>so unless I misread the code, the value is never > 40.

I tried to explain it here: https://lore.kernel.org/all/adZitVex9UGVyH-V@laps/

-- 
Thanks,
Sasha

