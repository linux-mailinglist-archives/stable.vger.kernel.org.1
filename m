Return-Path: <stable+bounces-233928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKb8Bupo1mmgFAgAu9opvQ
	(envelope-from <stable+bounces-233928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:40:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7569B3BDC95
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C0B306EB6A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220F33D3CEA;
	Wed,  8 Apr 2026 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAnB3L2F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pDquGTlJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A42345752
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658901; cv=none; b=AwYsxijxK+PJS1RMQZHZLTZOKvXwbIjE9k87Ch90pe8x8Hmh2Qcz1U3JOr9xRGYDTMCDI9s5rXmGNve1z4B7FtFXpeL0ci57ftLmSesA67NB7OPE34HoUtz0kBxlIYFuy+HZ5dA1smAXilfqxsrWVagxBuJPJwNyAZU4lgbpNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658901; c=relaxed/simple;
	bh=N7XK2sc9Y3RBBMpaH0o/Ed414b2BWZC+QsSoE0jg1II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIomxilJlJDLUIvQk+Q52B1M1eT2v+trsIDBjSL8io+HCv+s/5500okb+oCi33quKP/X8gcxxaTQYwrOYy0KIswqn6DfG1eLtcijPoyfTWcswxfxG0MFFT4zNfQIHfJVOX972dhZO04m967wlbURowZARy/HjQ637weMHkUSimY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aAnB3L2F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pDquGTlJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775658899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4/BN8y0SPi4BZrletYbddWuxFfzk7dPv2eFPKQlKnM=;
	b=aAnB3L2FAgGlv9YKGgaoQkBWn0ygb2aK1miVCPDsXxzQS6s0XyVkOO/lbxOuksfif4wNBl
	jxok3dPkOL2LRahBgpTAUJRr9v52OOhei7sUVEgyX7rcexXd9GQiw8Ekpx7plJWjf3peoj
	bccNuTU24sQQWJnp+uc0TpLhg0wI6ug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-S4sVfwyRNX-QoWiLmHuH6w-1; Wed, 08 Apr 2026 10:34:56 -0400
X-MC-Unique: S4sVfwyRNX-QoWiLmHuH6w-1
X-Mimecast-MFC-AGG-ID: S4sVfwyRNX-QoWiLmHuH6w_1775658896
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4888b17ffa6so49320145e9.3
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775658896; x=1776263696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4/BN8y0SPi4BZrletYbddWuxFfzk7dPv2eFPKQlKnM=;
        b=pDquGTlJnD+5uMAb036rGsMin89OhBQC0lcjyPXFVvhky3/wxE1eswixNwK8Dz5RUo
         4Hq2sKLmWyuZ9MgeyjvW3RTMdJAcOrxhIK94RPsrbQ8rdmdzbK72hSCeEU2xWVZCbUQZ
         ACb//SuWKgv48zdizzGPJGAorghO4coSNAoukbmOu3Qs+bOFMgjrVeuM4BGFWns+S2uK
         s9r86H7sZzV1ziifU9m2zbGGP0aBvwX/ZGgw4G/SSSiOCy52CZ/UDhix8r3bQb4kTK85
         2o7RIcdcxyROlBQf3IYCwNRNgOLpBKyTa9/zeRkiZOg12ARWGpXhS+uKz2pvE5o/BVln
         QCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658896; x=1776263696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4/BN8y0SPi4BZrletYbddWuxFfzk7dPv2eFPKQlKnM=;
        b=b89+VQk/FlE34MJqedlWivtw+VtE51IOmZRoAR5BfETTrHtiaiBqYWHeda/7BEXQfV
         p4QO1pScHUoGHhvikq9t5AGrVXsogHOO1cPmVFSKBfaM0lvmFtRtFC5GYPoxNU/f8DNx
         dRZJ82D/zAoLdi4eeDQA7JWggmMiyJm8DaSldZJ6iilGg55lIL7jfMnVeqkRWznC3/wx
         ZU+5vW1/MyyePVeaJpVn8jP4H7psG0HUYi9VZCmGvaTPPZ4lI1jarX8cIAsyI7F5TiUJ
         bcgWZu8FMCzll1qypNwHB2MWtDTGoLteY2czldDpb/p5h0DpU8V78cN+rs6dA8kxM9mI
         9UUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHjIm+4qo/Lvo+hi68onCZ7QsX4nQzXVjPfIcwhA9H+yhIkQfGqE+bqwGQpZ7uyPkhX8QiaTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhZJuhqu72AAFsTNvPzRIyErsggW7h8jzz0UeUrZFE4XyRGAfa
	MoH4Ysma7MTozEiDGzUe4+vZAfOoowGjdwY5gma1ooEvgxdAC2D3Z1OP3RLeslasIljaeXtcHIO
	iYA3NBPox1LlxKxFBF1yPe2ryeB1+B+zVV2cOAc9K++ZXMqSUjIBf4PAjzw==
X-Gm-Gg: AeBDietFwE/z8IPoeL5pPb6LQLbbUN4z3QYvlvcPk2IFYaiDmO9GKmGN3zwMJkQjYX6
	YM7euGpPgZ9AW0u8RESlzGmn2leK9YAJfq3zx4UcgSEAAGzG6zynzKTjiwxTxQreWQmm/QNQdml
	HIQv4T1zmOZDAgL+OVBmaQOKDxdznD4O7xtS6OO8XL1ZvHIu/+xKcWOVoZCnmLb5XToxgMlIn1x
	4Rd1+iqdCtHYB1DBSwiUJcN84YdZOS9ree7X8M9MpRJnS3NPXyizDidKwweG7g7FdWx5ZU56dQE
	Dd5cucazLWv8Qb3SuIgercJY4ehupI9dDo+s7b+FYRsE1jQ2ed+YHSZ2cNo35u9NdJCZtV2SOZw
	duBw5K14iVxAKYcxsb+D0Atsx7p6UK5ztBtZac/TUmKE=
X-Received: by 2002:a05:600c:c11b:b0:488:be58:bb5b with SMTP id 5b1f17b1804b1-488be58c8fbmr73118295e9.24.1775658895502;
        Wed, 08 Apr 2026 07:34:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c11b:b0:488:be58:bb5b with SMTP id 5b1f17b1804b1-488be58c8fbmr73118015e9.24.1775658894950;
        Wed, 08 Apr 2026 07:34:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a7165aasm651511625e9.14.2026.04.08.07.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:34:54 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:34:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [EXTERNAL] [PATCH 6.12.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Message-ID: <20260408103355-mutt-send-email-mst@kernel.org>
References: <2026040855-hatless-marbled-c4ed@gregkh>
 <20260408131906.1087303-1-sashal@kernel.org>
 <CH3PR18MB6379BBB26D572A68D09D8CB1A05BA@CH3PR18MB6379.namprd18.prod.outlook.com>
 <adZitVex9UGVyH-V@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adZitVex9UGVyH-V@laps>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-233928-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proofpoint.com:url]
X-Rspamd-Queue-Id: 7569B3BDC95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 10:14:13AM -0400, Sasha Levin wrote:
> On Wed, Apr 08, 2026 at 01:49:48PM +0000, Srujana Challa wrote:
> > > From: Srujana Challa <schalla@marvell.com>
> > > 
> > > [ Upstream commit b4e5f04c58a29c499faa85d12952ca9a4faf1cb9 ]
> > > 
> > > rss_max_key_size in the virtio spec is the maximum key size supported by the
> > > device, not a mandatory size the driver must use. Also the value 40 is a spec
> > > minimum, not a spec maximum.
> > > 
> > > The current code rejects RSS and can fail probe when the device reports a
> > > larger rss_max_key_size than the driver buffer limit. Instead, clamp the
> > > effective key length to min(device rss_max_key_size, NETDEV_RSS_KEY_LEN)
> > > and keep RSS enabled.
> > > 
> > > This keeps probe working on devices that advertise larger maximum key sizes
> > > while respecting the netdev RSS key buffer size limit.
> > > 
> > > Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > Link: https://urldefense.proofpoint.com/v2/url?u=https-
> > > 3A__patch.msgid.link_20260326142344.1171317-2D1-2Dschalla-
> > > 40marvell.com&d=DwIDAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=Fj4OoD5hcKFp
> > > ANhTWdwQzjT1Jpf7veC5263T47JVpnc&m=0XuKVXgk9_1LUIZHeqL0znGhAh
> > > x5KvAOLvrCl-orVeQSt__4o6Djr-79rwCl6KNp&s=cfQpAcZTTE7nTYku-
> > > MVkfip0xUJoBBw4ikqm9iEdgcc&e=
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org> [ changed clamp target from
> > > NETDEV_RSS_KEY_LEN to VIRTIO_NET_RSS_MAX_KEY_SIZE ]
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  drivers/net/virtio_net.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > > 5c83983f0eb3f..5a31ccdae2e22 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -6502,6 +6502,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >  	struct virtnet_info *vi;
> > >  	u16 max_queue_pairs;
> > >  	int mtu = 0;
> > > +	u16 key_sz;
> > > 
> > >  	/* Find if host supports multiqueue/rss virtio_net device */
> > >  	max_queue_pairs = 1;
> > > @@ -6624,14 +6625,13 @@ static int virtnet_probe(struct virtio_device
> > > *vdev)
> > >  		goto free;
> > > 
> > >  	if (vi->has_rss || vi->has_rss_hash_report) {
> > > -		vi->rss_key_size =
> > > -			virtio_cread8(vdev, offsetof(struct virtio_net_config,
> > > rss_max_key_size));
> > > -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> > > -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds
> > > the limit %u.\n",
> > > -				vi->rss_key_size,
> > > VIRTIO_NET_RSS_MAX_KEY_SIZE);
> > > -			err = -EINVAL;
> > > -			goto free;
> > > -		}
> > > +		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config,
> > > +rss_max_key_size));
> > > +
> > > +		vi->rss_key_size = min_t(u16, key_sz,
> > > VIRTIO_NET_RSS_MAX_KEY_SIZE);
> > > +		if (key_sz > vi->rss_key_size)
> > > +			dev_warn(&vdev->dev,
> > > +				 "rss_max_key_size=%u exceeds driver limit
> > > %u, clamping\n",
> > > +				 key_sz, vi->rss_key_size);
> > > 
> > >  		vi->rss_hash_types_supported =
> > >  		    virtio_cread32(vdev, offsetof(struct virtio_net_config,
> > > supported_hash_types));
> > > --
> > > 2.53.0
> > 
> > We used `NETDEV_RSS_KEY_LEN` intentionally for clamping.
> > `rss_max_key_size` is the maximum supported by the device,
> > while `40` is a spec minimum, not a maximum.
> > Clamping to `VIRTIO_NET_RSS_MAX_KEY_SIZE` would unnecessarily
> > limit valid devices(for example devices advertising 48/52 bytes) and
> > could reintroduce the original issue.
> > 
> > Could you please share the reason for changing the clamp target
> > from `NETDEV_RSS_KEY_LEN` to `VIRTIO_NET_RSS_MAX_KEY_SIZE`?
> 
> Hi Srujana,
> 
> In the upstream commit, the key buffer was also enlarged from 40 to 52 bytes as
> part of the `TRAILING_OVERLAP` / `rss_trailer` refactoring:
> 
> -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
> 
> That refactoring isn't present in 6.12, so the key buffer is still `u8
> key[VIRTIO_NET_RSS_MAX_KEY_SIZE]` (40 bytes). Clamping to `NETDEV_RSS_KEY_LEN`
> (52) here would allow writing up to 52 bytes into a 40-byte buffer, so the
> clamp target had to match the actual buffer size in this tree.
> 
> -- 
> Thanks,
> Sasha


problem is, the commit log now says one thing and the patch does
a completely different, and in fact opposite, thing.


Why not pick that dependency then?

-- 
MST


