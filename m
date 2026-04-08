Return-Path: <stable+bounces-233927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLJREjtn1mnIEwgAu9opvQ
	(envelope-from <stable+bounces-233927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:33:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E12913BDB2A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C79E33007534
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8732F3C2799;
	Wed,  8 Apr 2026 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFMrRkxK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOZ/ycMd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C883D3D07
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658806; cv=none; b=Yvb0+rKVQxmC4yiN2sp4llMH2iPBYM2NvBpa9pEaZCAoP55q6kVvzWH4PD8DApYOJ39t7ue0eMsrDTE9tCjpYnsV7Dsvhf7haktA3fqjWlg5hm9n39nK00j4Of39lISjL/gowCHPJsKXqXs8s9ywzuXmIoPGKH4AwUCeAHzUaU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658806; c=relaxed/simple;
	bh=b/216TP1HicpioBMzvgLL/8LHDmvYK/UHFPN8xGTe4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukzPDN0hkyOIAymIGN3XDljomxoYxvlupjKg5gQ56CM0DF9+B56hwIdUN6gdw+eyA0AXPIomOpgSsWJ7NxGenm2+4WOH3DKKDn4px0UtTDxuS72Pp4m/HH/Vd4hajAI9xkaakpLsa/hfS6PouJyqV/5IhBW6IhnDCiaM1B8bP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFMrRkxK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOZ/ycMd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775658803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EajRN0+rvOkiL0FT2KHR4XxenHIj16f7/a2l5Bas+u8=;
	b=BFMrRkxKDgdMHplRroZMqqbldDRcVrLA7USVKRYwtQylhjP4RzECSSyTjexDgbommuwffa
	zkY+EweDvgDTcI3nhCJElZpV/T7Brm71yx7Ut0TAriWG77p2omSI8CePn1aBbT++94BcZP
	YW3IJJV+hMG3Q0yL9y/RbmEpHhkQZOw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Xcdz6X7cNpCSlu06avZNnw-1; Wed, 08 Apr 2026 10:33:22 -0400
X-MC-Unique: Xcdz6X7cNpCSlu06avZNnw-1
X-Mimecast-MFC-AGG-ID: Xcdz6X7cNpCSlu06avZNnw_1775658801
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d02fa5860so6536193f8f.0
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775658801; x=1776263601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EajRN0+rvOkiL0FT2KHR4XxenHIj16f7/a2l5Bas+u8=;
        b=bOZ/ycMdwVdA9adRAJnZwvvgsbr8F76Id58o2NsAUEuYNPDMX/x5G9hJWGdMOlIOlz
         Tt+vIVDz/EdVtBFngmD613GNQPmIfTW49Lz1XartuHIjub+KHQyKQFKgbqoFWAHaFkVb
         DPMv67E7CY39ht5jybC6oZE47yirf/kg5q5f4BcXpzTjv90MVwQDcLnhTRj2JJcOZKPo
         2j0424PZYIN69mFADy29ahhrYSqyX3sI4z+3VGdXkGqnIzVzWQWUBSdtsDNtpirSwnaD
         biCkBkuhMUS8xedJUcEVpiWB/XqK5g6HXwv19kZcfPNVABSc0J3OyzUTcEZCljTS2eyw
         avwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658801; x=1776263601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EajRN0+rvOkiL0FT2KHR4XxenHIj16f7/a2l5Bas+u8=;
        b=G+fk7I2pN1opjp/ZXgO9yMZrBVaVHgPDGeQeO0EYSaA5AuXXmc2yuDpzJEukjZqRpu
         HCeIiIbtUNGm9WVScLxztknK3+IqmM/Sdb8aDwUWk/YBN6OnfX9CbN4WMwJ2z+gEeLel
         x024IyEi/ko/X2IBTLgAijmEMhCTP+nnc6Fgpg2z0y8C1oI741HvWhRmhEsFVMam3EUm
         fxf4SBC5bygdaHcXBz5cSDbJsISR2+zFjv2Z6ouVfkaRgdI2lUXxaNym9x4lyMXd/9vf
         KC75Fd3qr+jSHRc9IuHrdgCufFso3twAotoNPj2puBQElW15jEz+7/9/pnwhJ9RC3vN8
         M4Fw==
X-Gm-Message-State: AOJu0YygTaDYBvv5IBzCd/NLo8hDXu/evwTghmuwFXMQQcF+Fk2VFGHe
	o6Tb3I464QiwfImeYtYpi0NEY5L3JOBKPZhqIZgoTBhmsSFyzruLsf9sWZXLuWFvo0myPSFq1bQ
	c8QEnQfNeofOzcJ6ekTv0O8EohLpSl67aiuUvdYOKaR/mcBLpJXVOeWKqO8SrKB2/Jf4I
X-Gm-Gg: AeBDieuhPKbynPQFvZReclFIhKUZrX7Jow6XupN2OMQVfMfD4mLQ6r+pNEC3POm8pIO
	pXBYZyZrOPsuj4wDZgGgCf+1z/QR2sKeiU2wjfWnnY7nAQwqYRMhn3O5/CGHdqsAqKpP23iowkt
	Pllhf96o61gwjgUfyXwJXaaZTqi9roTJNZxId3WQUh7QN63zh8v38ybRNm0nNSLfBbZQVtq/Obn
	daN5LlIf5nu4UM0OQZ+MolFB3mgQN0bpykiXestOf7r0NlGil0ellYnlS4iMDvgNcd/aWiFUEmE
	5Lurn8Jd0P8u1oqkNAwVnM+VKTqoCTHh7ebY4YBtRZLG84icYM+/5GQ07ckpiWCytQfuJa78N10
	5ekTkyKPNceDqHrM/T0+SGHcgKP0BqbhoJVKyZ3xVHXY=
X-Received: by 2002:a05:600c:4752:b0:488:7ff5:2c67 with SMTP id 5b1f17b1804b1-4889976ea80mr304958985e9.12.1775658801029;
        Wed, 08 Apr 2026 07:33:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4752:b0:488:7ff5:2c67 with SMTP id 5b1f17b1804b1-4889976ea80mr304958595e9.12.1775658800583;
        Wed, 08 Apr 2026 07:33:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5ceb914sm36669425e9.3.2026.04.08.07.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:33:20 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:33:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Srujana Challa <schalla@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Message-ID: <20260408103237-mutt-send-email-mst@kernel.org>
References: <2026040856-ploy-antiviral-fecc@gregkh>
 <20260408134351.1100654-1-sashal@kernel.org>
 <20260408095309-mutt-send-email-mst@kernel.org>
 <adZjFGvv3VAPLV3I@laps>
 <20260408101810-mutt-send-email-mst@kernel.org>
 <adZlDssL48EBKzON@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adZlDssL48EBKzON@laps>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233927-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email,msgid.link:url]
X-Rspamd-Queue-Id: E12913BDB2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 10:24:14AM -0400, Sasha Levin wrote:
> On Wed, Apr 08, 2026 at 10:20:50AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Apr 08, 2026 at 10:15:48AM -0400, Sasha Levin wrote:
> > > On Wed, Apr 08, 2026 at 09:54:33AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Apr 08, 2026 at 09:43:51AM -0400, Sasha Levin wrote:
> > > > > From: Srujana Challa <schalla@marvell.com>
> > > > >
> > > > > [ Upstream commit b4e5f04c58a29c499faa85d12952ca9a4faf1cb9 ]
> > > > >
> > > > > rss_max_key_size in the virtio spec is the maximum key size supported by
> > > > > the device, not a mandatory size the driver must use. Also the value 40
> > > > > is a spec minimum, not a spec maximum.
> > > > >
> > > > > The current code rejects RSS and can fail probe when the device reports a
> > > > > larger rss_max_key_size than the driver buffer limit. Instead, clamp the
> > > > > effective key length to min(device rss_max_key_size, NETDEV_RSS_KEY_LEN)
> > > > > and keep RSS enabled.
> > > > >
> > > > > This keeps probe working on devices that advertise larger maximum key sizes
> > > > > while respecting the netdev RSS key buffer size limit.
> > > > >
> > > > > Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > Link: https://patch.msgid.link/20260326142344.1171317-1-schalla@marvell.com
> > > > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > > > [ changed clamp target from NETDEV_RSS_KEY_LEN to VIRTIO_NET_RSS_MAX_KEY_SIZE ]
> > > >
> > > > Does this not make the subject and the commit log misleading?
> > > 
> > > Probably, but changing the commit subject will just create more confusion.
> > > 
> > > --
> > > Thanks,
> > > Sasha
> > 
> > It's not just the subject. The commit log says:
> > 
> > 	Also the value 40 is a spec minimum, not a spec maximum.
> > 
> > but the changed patch seems to treat it as a maximum:
> > 
> > +               vi->rss_key_size = min_t(u16, key_sz, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> > 
> > 
> > so unless I misread the code, the value is never > 40.
> 
> I tried to explain it here: https://lore.kernel.org/all/adZitVex9UGVyH-V@laps/
> 
> -- 
> Thanks,
> Sasha


OK let us take the discussion there.


