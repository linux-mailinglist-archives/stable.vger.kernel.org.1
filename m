Return-Path: <stable+bounces-233194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHRlDl/ez2mn1QYAu9opvQ
	(envelope-from <stable+bounces-233194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:35:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A802C395D1A
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DF0B3034A2F
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07CB1D61A3;
	Fri,  3 Apr 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nguVPwDY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2D3BC689
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230478; cv=none; b=qBSZbfKJtPtxnS3zE/bZ0fZ0NJakfuXe9nnCdh9a3OkE31PKKCNRb05wmDxCy+7o2DMcgIsHv+QS/DP0EVAhBXZQ8Od+tkwZ+2wraZHjEaZQlRrSfFFC0bZC3FB5RIk84vxdbbP7YRwn0UoPOAHx4J5fQaEUCMx22fi0f2V9aGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230478; c=relaxed/simple;
	bh=pnTONFLO++i9o+h4aHJcqHOAz1eTweHpgY38cxWoQ64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mnp+gEKazA+ANNKUuP6m4yNTZ4GRPd5Oyt4ShiVYu0I8GXffs+FhXFdbtRNjZvTwyLYHvJhEm5u09+LxHP8Mmoar3HjawBhcYrVkH9aCo0Rz/lRuBUG59EvjYafFgnCBLQwaRKng9KA6TUePeI0NhP6UpKAC3VTOywTB+TBSxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nguVPwDY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9c11eba219so243273366b.2
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775230473; x=1775835273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7re9TIHgFQF++cPTDonCe06+mmw8C8DISy7Otb13OfU=;
        b=nguVPwDYqRKNDkt11FMGshFKvtpmGQ3qRT8AMBnheHlI+SbVzIgqYInQIhZjuDzXD3
         wlvqaz7yXeavserEI212wFCIx6ajFQ+nedentqYRDoLEysliJvcMvkX139vgnqigzzDa
         BqXqVtBzYdwjBG3Z7+1LQym+/OvGB7Af/gcvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230473; x=1775835273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7re9TIHgFQF++cPTDonCe06+mmw8C8DISy7Otb13OfU=;
        b=Nsmv2xm/QQpNXw8GdaZ0r481JLTFn+Nwxk/D63MbOQMP6o9M3LVAEV0NMEMeorW/li
         GhD4wxHWC9hyx6OExwt1aTY9Y4jU5xTcTI0wNwrl8f6P3Tuc5wjEAAoQzyZokbJSyWH5
         eURSnZ/WByvG15UNBqGaLW2dGdNu1ZCttdDQb+orG91fbS8IhNiWN0kAahSQDCM91gcA
         hjFFdCOMDDkYjptSlM/R4A5zCwwKFUNbcnAOndEssCkXDdb9hnNslya0UAYPxAI78vZM
         /l2ImC6Q/qZDv268GNvcI4OVGq7iesyJNmciv1JicbFB+6PuaoaeR8c1cUhOncaR8UFO
         ekXg==
X-Forwarded-Encrypted: i=1; AJvYcCVH6k5MMv7FgHyOe4/fQpK2VBv3S0gVeyYehCzz14VquchG9ORSdhXTqbkUM7F52fWe55ZHO54=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQC6kGmHDINbGhk4X+LLAjJ7reNcr32hEEfOS+Bs7JODjzuKjd
	RlkVAmMzn34rrEQVHfQLY/1pMvce5AXz5yjHPhFiVQl4jhEW6nf2+28MqeHKTFPVK/Hd6m/hv+J
	bEktMzg==
X-Gm-Gg: AeBDieuADAeRm+C4bn5NqlMFsPbhEP8I+jGcX8R/uZ+SR0ZO1Feudtxusp0fV2/x0wV
	YxShAq9s73SoLvxyMAnkgk3nGRLU5fWiyU/ln+5aisKogfYX4iFkDYhj+4aQ0l273bATU7AdXA5
	gdZFcxghL103PKRqZ4ucI/soysZB+mnyEfENU6NXBLe1pP0Wqbix/NJ6Z9fdNLBKDI7o6oQhb3M
	RonHT+CaxhwViMpKOFGInOEWzRoNvZ1cQVNva6jU90tnlfxffIOGexhqb7PRwynyAivGobNqdhO
	wNl29FPMUz0z62MkG/GXxmyB5+ymAeqg2YquBNewJULJy3Zg89aWLh4ogDsbrjIOhtHLBpxn2Cj
	2dLTGEQAd409dsKbcn1px4/42v90ZO88/l8CAVohR7hvjYcgUGzwJ6vvfkfmHp/EEF2hEuQ2Tro
	RPsS1EBT6FuV97jSfDgDcHEIhQVO1lEguvchHD22DRXxHt1woLgAeQ4VO8Rv5/f6drrQdhvMZ+
X-Received: by 2002:a17:907:3d51:b0:b98:7f7:50f1 with SMTP id a640c23a62f3a-b9c6793b40fmr180523566b.27.1775230473420;
        Fri, 03 Apr 2026 08:34:33 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c97229esm205710766b.4.2026.04.03.08.34.32
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 08:34:32 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso1715349f8f.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 08:34:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1oRIJiWXHn8Y73aTIYDuSduhiMnU/MMN7UIt27+BN5tFjqhPwtW7UnW1h+ShHDYXrBZUPECY=@vger.kernel.org
X-Received: by 2002:a05:6000:2485:b0:43d:121c:37d9 with SMTP id
 ffacd0b85a97d-43d29268a8dmr5512092f8f.1.1775230471524; Fri, 03 Apr 2026
 08:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403005005.30424-1-dianders@chromium.org> <20260402174925.v3.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <2026040319-seventeen-humorless-5541@gregkh>
In-Reply-To: <2026040319-seventeen-humorless-5541@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 3 Apr 2026 08:34:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XmnWjVzQcr13GmRKX3cvRortA==5C8TH5D-jRBe0VBqw@mail.gmail.com>
X-Gm-Features: AQROBzBI3qbsutVdmrxjY8uO9-3m7vo2V5fLwzycPlllzj8W2kmat6R3FSfkHcs
Message-ID: <CAD=FV=XmnWjVzQcr13GmRKX3cvRortA==5C8TH5D-jRBe0VBqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] driver core: Don't let a device probe until it's ready
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Eric Dumazet <edumazet@google.com>, Christoph Hellwig <hch@lst.de>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
	Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233194-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: A802C395D1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Fri, Apr 3, 2026 at 12:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> > @@ -458,6 +458,18 @@ struct device_physical_location {
> >       bool lid;
> >  };
> >
> > +/**
> > + * enum struct_device_flags - Flags in struct device
> > + *
> > + * Should be accessed with thread-safe bitops.
> > + *
> > + * @DEV_FLAG_READY_TO_PROBE: If set then device_add() has finished eno=
ugh
> > + *           initialization that probe could be called.
> > + */
> > +enum struct_device_flags {
> > +     DEV_FLAG_READY_TO_PROBE,
> > +};
>
> If you are going to want this to be a bit value, please use BIT(X) and
> not an enum, as that's going to just get confusing over time.

I don't believe I can do that. BIT(x) is not compatible with the
atomic bitops API. BIT(x) will turn the bit number (x) into a hex
value, but the atomic bitops API needs the bit number.

If you wish, I can turn this into something like:

#define DEV_FLAG_READY_TO_PROBE         0
#define DEV_FLAG_CAN_MATCH              1
#define DEV_FLAG_DMA_IOMMU              2
...

...but that seemed worse (to me) than the enum. Please shout if I
misunderstood or you disagree.


> Also, none of this manual test_bit()/set_bit() stuff, please give us
> real "accessors" for this like:
>         bool device_ready_to_probe(struct device *dev);
>
> so that it's obvious what is happening.

Sure, that matches Rafael's request and is a nice improvement. To keep
from having to replicate a bunch of boilerplate code, I'll have macros
define the accessors:

#define __create_dev_flag_accessors(accessor_name, flag_name) \
static inline bool dev_##accessor_name(const struct device *dev) { \
        return test_bit(flag_name, &dev->flags); \
} \
static inline void dev_set_##accessor_name(struct device *dev) { \
        set_bit(flag_name, &dev->flags); \
} \
static inline void dev_clear_##accessor_name(struct device *dev) { \
        clear_bit(flag_name, &dev->flags); \
} \
static inline void dev_assign_##accessor_name(struct device *dev, bool
value) { \
        assign_bit(flag_name, &dev->flags, value); \
} \
static inline bool dev_test_and_set_##accessor_name(struct device *dev) { \
        return test_and_set_bit(flag_name, &dev->flags); \
}

__create_dev_flag_accessors(ready_to_probe, DEV_FLAG_READY_TO_PROBE);
__create_dev_flag_accessors(can_match, DEV_FLAG_CAN_MATCH);
__create_dev_flag_accessors(dma_iommu, DEV_FLAG_DMA_IOMMU);
__create_dev_flag_accessors(dma_skip_sync, DEV_FLAG_DMA_SKIP_SYNC);
__create_dev_flag_accessors(dma_ops_bypass, DEV_FLAG_DMA_OPS_BYPASS);
__create_dev_flag_accessors(state_synced, DEV_FLAG_STATE_SYNCED);
__create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
__create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
__create_dev_flag_accessors(offline_disabled, DEV_FLAG_OFFLINE_DISABLED);
__create_dev_flag_accessors(offline, DEV_FLAG_OFFLINE);

Happy to tweak the above if desired.

-Doug

