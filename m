Return-Path: <stable+bounces-233921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OJwN+Zj1mnwEwgAu9opvQ
	(envelope-from <stable+bounces-233921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:19:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 493193BD91D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAD6A301570D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74242D3733;
	Wed,  8 Apr 2026 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcuHRjcw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB682DA749
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657655; cv=none; b=u5zhmHpvkW6CRsgrexPIT3pDlrrpvaJqNHzRlFmgWo6NkCWNxbW5ToRuHVnHgSmNe1OkF17DEz/FE8eODodc3wCHpmiFOU+/zZpgJa31bSACQ32QQofn0PQG/fcQmW3WlqBHFBPrgcxJBexXzqWGNzNPTQuMxE3YhsqizziRdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657655; c=relaxed/simple;
	bh=/o/w7kTnPMrIz74mMdPEpSHMugufOxlGyvO09g/2R/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OByxXBTivyidj8F9U86zsZ2KbnKgNCyfzPJtyulpX2eaGgoatMzV0f/K6GybqyPqj0JIqTZYU79zb3joK+P4PDhyMHjdLhk5atvNbCoi8m6AkshqoscjtAur16eOODS1O2ydxLi97tn6MyG1AQTpV/qycZAANpoORE19HmWtHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcuHRjcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABD6C19421;
	Wed,  8 Apr 2026 14:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775657654;
	bh=/o/w7kTnPMrIz74mMdPEpSHMugufOxlGyvO09g/2R/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcuHRjcwsYFUJhkD38rGL0lu2aVwfXKR5HzJfjUfVhvqKpPdODSndjSZFD5qoLbNf
	 mXPojYIrcdM7BSeQDF1EKGvldCLZPG48tUmYeRzoPr/8ugiAlGteyC8yB2Zm2f49LI
	 UAsfBk0R8XX7XPDQo5tUYxQhKxHXIPEWSr5q7vOPBbqh7et92FqB+CbwTrLQd/C16J
	 561qRTSAme9ddUsivkpRq5m9FsBBbrA/pSbH4G08SujLAMIfGE1nrcx+jr359mXXD6
	 zssvNqA82aBalPcM1s3MAUFR8N8Q7P1Z0/E+2Tqmrfxei1egWYzQcKzrCunULIYKga
	 1GQZqwhZK2Ogw==
Date: Wed, 8 Apr 2026 10:14:13 -0400
From: Sasha Levin <sashal@kernel.org>
To: Srujana Challa <schalla@marvell.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [EXTERNAL] [PATCH 6.12.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Message-ID: <adZitVex9UGVyH-V@laps>
References: <2026040855-hatless-marbled-c4ed@gregkh>
 <20260408131906.1087303-1-sashal@kernel.org>
 <CH3PR18MB6379BBB26D572A68D09D8CB1A05BA@CH3PR18MB6379.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CH3PR18MB6379BBB26D572A68D09D8CB1A05BA@CH3PR18MB6379.namprd18.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233921-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,proofpoint.com:url]
X-Rspamd-Queue-Id: 493193BD91D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 01:49:48PM +0000, Srujana Challa wrote:
>> From: Srujana Challa <schalla@marvell.com>
>>
>> [ Upstream commit b4e5f04c58a29c499faa85d12952ca9a4faf1cb9 ]
>>
>> rss_max_key_size in the virtio spec is the maximum key size supported by the
>> device, not a mandatory size the driver must use. Also the value 40 is a spec
>> minimum, not a spec maximum.
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
>> Link: https://urldefense.proofpoint.com/v2/url?u=https-
>> 3A__patch.msgid.link_20260326142344.1171317-2D1-2Dschalla-
>> 40marvell.com&d=DwIDAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=Fj4OoD5hcKFp
>> ANhTWdwQzjT1Jpf7veC5263T47JVpnc&m=0XuKVXgk9_1LUIZHeqL0znGhAh
>> x5KvAOLvrCl-orVeQSt__4o6Djr-79rwCl6KNp&s=cfQpAcZTTE7nTYku-
>> MVkfip0xUJoBBw4ikqm9iEdgcc&e=
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org> [ changed clamp target from
>> NETDEV_RSS_KEY_LEN to VIRTIO_NET_RSS_MAX_KEY_SIZE ]
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/net/virtio_net.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
>> 5c83983f0eb3f..5a31ccdae2e22 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -6502,6 +6502,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>  	struct virtnet_info *vi;
>>  	u16 max_queue_pairs;
>>  	int mtu = 0;
>> +	u16 key_sz;
>>
>>  	/* Find if host supports multiqueue/rss virtio_net device */
>>  	max_queue_pairs = 1;
>> @@ -6624,14 +6625,13 @@ static int virtnet_probe(struct virtio_device
>> *vdev)
>>  		goto free;
>>
>>  	if (vi->has_rss || vi->has_rss_hash_report) {
>> -		vi->rss_key_size =
>> -			virtio_cread8(vdev, offsetof(struct virtio_net_config,
>> rss_max_key_size));
>> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
>> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds
>> the limit %u.\n",
>> -				vi->rss_key_size,
>> VIRTIO_NET_RSS_MAX_KEY_SIZE);
>> -			err = -EINVAL;
>> -			goto free;
>> -		}
>> +		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config,
>> +rss_max_key_size));
>> +
>> +		vi->rss_key_size = min_t(u16, key_sz,
>> VIRTIO_NET_RSS_MAX_KEY_SIZE);
>> +		if (key_sz > vi->rss_key_size)
>> +			dev_warn(&vdev->dev,
>> +				 "rss_max_key_size=%u exceeds driver limit
>> %u, clamping\n",
>> +				 key_sz, vi->rss_key_size);
>>
>>  		vi->rss_hash_types_supported =
>>  		    virtio_cread32(vdev, offsetof(struct virtio_net_config,
>> supported_hash_types));
>> --
>> 2.53.0
>
>We used `NETDEV_RSS_KEY_LEN` intentionally for clamping.
>`rss_max_key_size` is the maximum supported by the device,
>while `40` is a spec minimum, not a maximum.
>Clamping to `VIRTIO_NET_RSS_MAX_KEY_SIZE` would unnecessarily
>limit valid devices(for example devices advertising 48/52 bytes) and
>could reintroduce the original issue.
>
>Could you please share the reason for changing the clamp target
>from `NETDEV_RSS_KEY_LEN` to `VIRTIO_NET_RSS_MAX_KEY_SIZE`?

Hi Srujana,

In the upstream commit, the key buffer was also enlarged from 40 to 52 bytes as
part of the `TRAILING_OVERLAP` / `rss_trailer` refactoring:

-		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];

That refactoring isn't present in 6.12, so the key buffer is still `u8
key[VIRTIO_NET_RSS_MAX_KEY_SIZE]` (40 bytes). Clamping to `NETDEV_RSS_KEY_LEN`
(52) here would allow writing up to 52 bytes into a 40-byte buffer, so the
clamp target had to match the actual buffer size in this tree.

-- 
Thanks,
Sasha

