Return-Path: <stable+bounces-233924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNncIlRl1mnIEwgAu9opvQ
	(envelope-from <stable+bounces-233924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:25:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CFB3BD9F3
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F41333031AD2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 14:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674622DCF55;
	Wed,  8 Apr 2026 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVYeCHly";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMsXj/+v"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D134FF40
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658066; cv=none; b=rmEM61GuNrzotcO4uqIW5xM+8NVKgYUeAFZOD9mN90eKMsJgbCZZb1Y+tgV/sYY5/eNVaMqcKMcusQyBuMJRunfY9je1NqGhpvN4bBwEvEVyqwQubCILJ7Tl4zBReXSeipUrH3yWxsdB/mpkC71W0vMfO20Nrn1S6y3o5IC78fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658066; c=relaxed/simple;
	bh=1uUO/5RX55cmdhADFpWw9qHL54J/R3H+mCpF1Wr3VPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMp9VFxfZyEdFrugbbpbh1larHF6/K3pVV21Gn1zA4gi9cp+K0dpYOwABFP70CGBl/ccGZuoEg363j5PEYm31CEkX71+g+TxM00DIEBZ7+vahYoPH14UP/qhO6FBS2e5gVqdHupa+gnBORVXrbILnqM5t0YeUmOkI0Uz9wcAxV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVYeCHly; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMsXj/+v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775658063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ngACgEE02REa4srps1j+zZz7ly8l5So/Pavt/5AjbP0=;
	b=iVYeCHlytelnj7tJik0nGHivnMP93/Vvbfc5JuqG+U2z6iFuYxj8G8TbM4AdrZn0VYQjwc
	Mo3I15U2G8/oxwuh0GeZrQwjJ/RZ2kZKE8kjUFOzDt2mwP1aP4M0IH4n5DJFNSOOEUxIlq
	Fg22YjVQO3EXklNzmkrixuzvrDPABZY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-1gUCq6RZMXyDs2amezEcdg-1; Wed, 08 Apr 2026 10:20:56 -0400
X-MC-Unique: 1gUCq6RZMXyDs2amezEcdg-1
X-Mimecast-MFC-AGG-ID: 1gUCq6RZMXyDs2amezEcdg_1775658054
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48378df3469so8167115e9.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775658054; x=1776262854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngACgEE02REa4srps1j+zZz7ly8l5So/Pavt/5AjbP0=;
        b=aMsXj/+vRnM82aK8Vl1LAuHZkJvQ5AEph6gnDL/NNdpNxpF+SyGtHx86KcOzsuGi5f
         9OGPTa+Lgeqn/+aBvx8apZkCoBBIXeDJ1GBAsO+Tod66yz/4UKsLYRfKpWGTdLKUBU/1
         mpyvXTt3uYbtZHk5+c/778ZiaBW4pP9h24BGBY1x6jUcmcNqW0TIsnHPhaiW7YWeECxf
         +uxf3CnqvdTt+DojdljJlG5ZYLKibDfLhLVrqCVOYOIuMPXh0H6sReeTFIcEvbg0oZgv
         1++bSWjy7DmRUHGovOW3/bi80qZS9CpYigHF2bYVSNLygSpXOj6xLvLjmTj8MTDbZvO2
         bRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658054; x=1776262854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngACgEE02REa4srps1j+zZz7ly8l5So/Pavt/5AjbP0=;
        b=eA7kbo0CAhzIszuOQ1yTv/tgDSS3MebNS7VovN11V8gUD4dKR8LLM8DVUGmHJj+cb/
         1Ry5j2SaUWnN4bamEnSehNa41tmkAF/FW0aoSOZVP+OqEOp6MmhjdH96607HqlNr0qUG
         /91w/ZVRo2krskYRRwyeK80WJigvHQtOMTYeqbtOwwJKgIygSdPY01JBRLfuarPPpw2k
         k3JE7g3BRtQRtGVIGXk9NnNmWCVfTd9A+ru6vg/5wp5B17/U1Ll10hFv5cAKYzV3FbUa
         DuqHZQLMxCit3J3afx4nmbO3TAbaRUd0+CsL+zMnjC+ujOeQZ/CpcKxo6n8c7kVRwVxA
         uiIg==
X-Gm-Message-State: AOJu0Yyfufb9wt+xFiE5zs5prY3eFxRvIPsvxQMFMR/qCQYQOqhyREPP
	/oUqF38IdhH59lB2TMMLcdLX/VuED3lpgdXfRjysAyMXENTfyTb3u9SQiQZNzvf21utk2eMIgtX
	EqXRq2FcGgrxV/62M2Vy8fNXPP8erHO3qjhRqwVs19BrYOhST9VlZzE6mlr3ceWCh+JYW
X-Gm-Gg: AeBDievXZYfe4KlGkbupQhppMLmE5DJiFJUPhW9StNFeYqvFhdFszwi/x9p4SYEDDlJ
	yQQLW5zI0c+BD2ljMn6OZIxcBAAI2rzVc7L/3Qm495C+91Nw9AgYCAiYL4n5RBXDru/VT4zBKKD
	uW9hhYQoH3EKfpASJnAEpSYZ0O9A4AnP7iB+++DHEPg/81J/mzwSlYmtlh91g+Jq9MGt7W2+l0W
	Fb3VR0KcgYHQkb2wQR8GzeK6R3bLOz45QfmOK7Px17BH6doAO87tjKpaDWDXEcswLG2Y+TUy0Oa
	OybjiaiDGybCYBDU7p0IU8M/KeQOOnB1P2+KOF8yOMbYzPUHS/cRga/ZL+OANPfzN53MjFbB/w/
	dFnpLtyvfXdNuBUZxrkgQJyBzMBR3lA2mwBsaCE3WYgs=
X-Received: by 2002:a05:600c:c0cf:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-4889945f8e8mr187167465e9.2.1775658053953;
        Wed, 08 Apr 2026 07:20:53 -0700 (PDT)
X-Received: by 2002:a05:600c:c0cf:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-4889945f8e8mr187167195e9.2.1775658053496;
        Wed, 08 Apr 2026 07:20:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5d855cdsm18909215e9.14.2026.04.08.07.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:20:52 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:20:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Srujana Challa <schalla@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Message-ID: <20260408101810-mutt-send-email-mst@kernel.org>
References: <2026040856-ploy-antiviral-fecc@gregkh>
 <20260408134351.1100654-1-sashal@kernel.org>
 <20260408095309-mutt-send-email-mst@kernel.org>
 <adZjFGvv3VAPLV3I@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adZjFGvv3VAPLV3I@laps>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233924-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: E6CFB3BD9F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 10:15:48AM -0400, Sasha Levin wrote:
> On Wed, Apr 08, 2026 at 09:54:33AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Apr 08, 2026 at 09:43:51AM -0400, Sasha Levin wrote:
> > > From: Srujana Challa <schalla@marvell.com>
> > > 
> > > [ Upstream commit b4e5f04c58a29c499faa85d12952ca9a4faf1cb9 ]
> > > 
> > > rss_max_key_size in the virtio spec is the maximum key size supported by
> > > the device, not a mandatory size the driver must use. Also the value 40
> > > is a spec minimum, not a spec maximum.
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
> > > Link: https://patch.msgid.link/20260326142344.1171317-1-schalla@marvell.com
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > [ changed clamp target from NETDEV_RSS_KEY_LEN to VIRTIO_NET_RSS_MAX_KEY_SIZE ]
> > 
> > Does this not make the subject and the commit log misleading?
> 
> Probably, but changing the commit subject will just create more confusion.
> 
> -- 
> Thanks,
> Sasha

It's not just the subject. The commit log says:

	Also the value 40 is a spec minimum, not a spec maximum.

but the changed patch seems to treat it as a maximum:

+               vi->rss_key_size = min_t(u16, key_sz, VIRTIO_NET_RSS_MAX_KEY_SIZE);


so unless I misread the code, the value is never > 40.


-- 
MST


