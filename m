Return-Path: <stable+bounces-233922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H4/FpRk1mnIEwgAu9opvQ
	(envelope-from <stable+bounces-233922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:22:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A533BD99C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8A5302D5EB
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51181274B46;
	Wed,  8 Apr 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbohu23N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140542A1CF
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657750; cv=none; b=M/ULmnFpqYH/9HhUOzXD8nEDWTeUjn1cCGl0wawAG9wjVigStXnXaAnt5Xyc6sEftuIZ7AEGO1KolggKUH5c7o/O42GN8crcVtlC8qEfVkX0ly7qxV42iLhZCOuMflQ9IqhdCCYcydvjJ17UpF06z/4iOAwLQZ69768EZL3B8sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657750; c=relaxed/simple;
	bh=rnq0U7JY8qE6zrOwZEEcxoG+R8aASn9t9dJfsz2jTFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTTk2F2Kh0MJjhqhHw6mwHH/ie9W61di3y+wdpD7ukCvvaF57VcZgVnxhqa6iANPxskVnZql90Sgg7bgCo0BmUB7Bec2uxMoDPQVzQY/s1C+nC5m3FJ04sOUVj3tREKuIoXeblDqnihxHUaVzHwWsSepWQHJRd56PIQC2wdqN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbohu23N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A15BC19421;
	Wed,  8 Apr 2026 14:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775657749;
	bh=rnq0U7JY8qE6zrOwZEEcxoG+R8aASn9t9dJfsz2jTFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbohu23NXjmSQzWdaFQ0JmWx8JAwZKoLn5IqPIxXR75QI1m3IGsOFxkr4PQmBlv/d
	 G4EBFFNreWNwrwKaqF8ocMYol+yoGXoB8INTeXWkmZXakXoJPrJl0g2leWuhsRMv8R
	 V/vf5PaaEVwXxd636R/21MnJx+WX2OfkB2MwUKIWXt7vG06xMpO2faj12I9nIupDD5
	 d7xuCu/Ja+7i08GPIhaMlnc5Pfe0tGcdX06W2K3wvyEPjY2vl24UCfWojRrMqYnG/B
	 YpbsMN2mX6o2rFBjl9cd7fx1KFsvH1xYSsmvzhhCtiprpLf4GrtSFhNzYf/N1qXh98
	 kF7b2mc5kVoBQ==
Date: Wed, 8 Apr 2026 10:15:48 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stable@vger.kernel.org, Srujana Challa <schalla@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Message-ID: <adZjFGvv3VAPLV3I@laps>
References: <2026040856-ploy-antiviral-fecc@gregkh>
 <20260408134351.1100654-1-sashal@kernel.org>
 <20260408095309-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260408095309-mutt-send-email-mst@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233922-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,marvell.com:email]
X-Rspamd-Queue-Id: C2A533BD99C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 09:54:33AM -0400, Michael S. Tsirkin wrote:
>On Wed, Apr 08, 2026 at 09:43:51AM -0400, Sasha Levin wrote:
>> From: Srujana Challa <schalla@marvell.com>
>>
>> [ Upstream commit b4e5f04c58a29c499faa85d12952ca9a4faf1cb9 ]
>>
>> rss_max_key_size in the virtio spec is the maximum key size supported by
>> the device, not a mandatory size the driver must use. Also the value 40
>> is a spec minimum, not a spec maximum.
>>
>> The current code rejects RSS and can fail probe when the device reports a
>> larger rss_max_key_size than the driver buffer limit. Instead, clamp the
>> effective key length to min(device rss_max_key_size, NETDEV_RSS_KEY_LEN)
>> and keep RSS enabled.
>>
>> This keeps probe working on devices that advertise larger maximum key sizes
>> while respecting the netdev RSS key buffer size limit.
>>
>> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Srujana Challa <schalla@marvell.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Link: https://patch.msgid.link/20260326142344.1171317-1-schalla@marvell.com
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> [ changed clamp target from NETDEV_RSS_KEY_LEN to VIRTIO_NET_RSS_MAX_KEY_SIZE ]
>
>Does this not make the subject and the commit log misleading?

Probably, but changing the commit subject will just create more confusion.

-- 
Thanks,
Sasha

