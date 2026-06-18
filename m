Return-Path: <stable+bounces-267092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qaF2F6/MM2rYGQYAu9opvQ
	(envelope-from <stable+bounces-267092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 12:47:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C868069F7C1
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 12:47:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Fa01i96T;
	dkim=pass header.d=redhat.com header.s=google header.b=GxQHc3g5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267092-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267092-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50B5D302F771
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB123EFD0B;
	Thu, 18 Jun 2026 10:46:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C13EF649
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 10:46:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779607; cv=none; b=HJda3tbY0pgGqKW27PadX30adnQca3dO2jquMTxovp/HglXWugcxAUKLbcrA/11uzItHJ2C6WXXeb0RbB+JTlWVlycIYDrRrqKYNJGticgn9LbgLi27tXaDbwOp05sIMzL8g2D3qhBIwjqMkhFJ7roHJ4qhpVHbitUusdze1gDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779607; c=relaxed/simple;
	bh=v76H2FD+cZQGbYA3goj0IQWAE2ubh/oEvvY3ydCbt5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qliW0pot8Bd1DnuEJJFBU3eZ37I7m8ZAcNx4Kh8N0OGv1kAJIyXT8jPo/H2paEcRGM5x5rE36EDtqgExl8aOhTR1FCLWWcW2QFyirvBzW6VJRRXFN//ZJaKHcN9CLeyTA6lfjqBC1cny5ww0/jbEiSdlF16iwn5iY6rrQXPw924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fa01i96T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxQHc3g5; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781779604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JBl2ts2yYWW7grI0RMNRI+ZePWjfZxzm9ZlftbJqKkQ=;
	b=Fa01i96TPYOKVfSj0fDt+oHEhaLQ3L5q9BDKRpl+XJ00irku014dckBkxE0gF/bi/XT2dv
	dxyWqlEWXFLhU3rlIEdNmaMlVzKluEiaxLEmcp8LKc9uGEFzycJRLZLUKbJidBkfh50oOQ
	aDU0ECApfNavNXUQsPPe5uj5dDb9+V8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-lxAogD19O76OA6iDoMzdEA-1; Thu, 18 Jun 2026 06:46:41 -0400
X-MC-Unique: lxAogD19O76OA6iDoMzdEA-1
X-Mimecast-MFC-AGG-ID: lxAogD19O76OA6iDoMzdEA_1781779600
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46010392f89so744987f8f.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781779600; x=1782384400; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBl2ts2yYWW7grI0RMNRI+ZePWjfZxzm9ZlftbJqKkQ=;
        b=GxQHc3g5khk0DADKRURFtpMUQy16jpxziMcYXmRCw5afMLT1N+XC9mvwFMsl73QbBL
         PfG394o6okkNh4sE2bUS9UKYA80fVmldlqZiTi8GQk8kp9bpeWFrgS7ljTRSMiCrGKUK
         65fdQxPYeypgMpzzVtNRFmJ34HUYsL2eg7uTNM0geFKtPRIzk4XVHHcNWf8GBpKh/Glh
         y4zjpaaxyGFzpUtIWpHLtjPml+JpEd9ROyjKei0HjHiLFz7pYJLVx7XktYYSd2V2dzaN
         B2ItWj5bspYwPKekGlVNJX+U98zyLCfNdMjmjS/bbDcxFCNRe9jcUEBdMJH7cCfSATsc
         AXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779600; x=1782384400;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBl2ts2yYWW7grI0RMNRI+ZePWjfZxzm9ZlftbJqKkQ=;
        b=qh4TaQ2wURLpMS4MP+IFjJrVwu9orWq8dc9cnnlImGQlnpvB8Rt+rbKryfFY4EUnQF
         z61zsf5eb7/T66fAxE+/nRdQ3sHoaWFiLHP3SvWX3TMka7ae1zZKjyEKCD5TCz7596dE
         tGSS3+7RkrhqmYCIM2US4jdpDTbvtl9kFzYqU2XQPTtjQzc7+oICJQA/qFVK9sgtpB6h
         3HwwS46WiPo3SPVIYQl123gQsVXMiFi51UKfQBKWVDbymtC7l498vR2U9QKHTWbmD9a/
         TN5xRPSF6ckCM6HTomSzP0HCWfGnk1WQ3BI8f355IH2XTQ9ZfGGZpuQeCIz1YwAMwSai
         U5hA==
X-Forwarded-Encrypted: i=1; AFNElJ+CIoiXn3kURCTvI4LNX780shDiTOZ1vtSL1w9YZG/K8NQQ/deG8qdJxqQrMzH8bo/uowMrnww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHNuDNeGLnQccfScQ1NH95//arv6tDAvjLmaQXv2e4GVThMar
	SnP1vwvJxteW+KHH8suJ7qCunpcuB3VtCVV2BgxZK/guUoi456PtF0FCYRcjKHz+MStrh8CwhEX
	2meE3D5KnRGGeu0QsWGiguK6mbTp6ZDDME3uO5cauCBnasEQodnE4CVR7mA==
X-Gm-Gg: AfdE7cniosYrb/+KqGmsPnzFyUnVLbDvYH5sKh5jbeAXdjWDOr5V12Fx8MZOB6VgsxR
	9p9w5YbWDK2V2TqhNwxrfVEUDc7GQfWaTtxTitAYpJuixhEQF9GbaOWbblea6oIkK78jyURHFhv
	+xjLOhmJdylBKGoVhCDnnJpVuR/Itl20LmlxXlzbSPdgAv6HyIQMC6o5qf8KEQpRGpkmmPUsRtK
	oXRle/sypChjfSAEWb/zFM0ua2MHprHrGlyw5t8wj0Z+1HrgUWoTP/v5Mo1TvLkk4rRzlt1j8w8
	BzdnboS+BXfA4n96yV6KKOsDDfbamnwRCD5hUgmONMhB5FxdBT7y0E0kBeQplJa5BdURyWUfXyB
	DnnzzRJMOj3UVPAoyG8CUPtdUnSHE/jnmRFJog9BpW0h3k26RLn6H/7nY1prtaE5SOCP/RA==
X-Received: by 2002:a05:6000:4602:b0:460:70d1:c75 with SMTP id ffacd0b85a97d-4623f3e0a31mr12353285f8f.13.1781779600420;
        Thu, 18 Jun 2026 03:46:40 -0700 (PDT)
X-Received: by 2002:a05:6000:4602:b0:460:70d1:c75 with SMTP id ffacd0b85a97d-4623f3e0a31mr12353226f8f.13.1781779599890;
        Thu, 18 Jun 2026 03:46:39 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c473bsm66965343f8f.28.2026.06.18.03.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:46:39 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/sysfb: Avoid truncating maximum stride
In-Reply-To: <20260618084327.46567-5-tzimmermann@suse.de>
References: <20260618084327.46567-1-tzimmermann@suse.de>
 <20260618084327.46567-5-tzimmermann@suse.de>
Date: Thu, 18 Jun 2026 12:46:37 +0200
Message-ID: <87a4ssjfci.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267092-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[suse.de,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[javierm@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tzimmermann@suse.de,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:dri-devel@lists.freedesktop.org,m:sashiko-reviews@lists.linux.dev,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javierm@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email,ocarina.mail-host-address-is-not-set:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C868069F7C1

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Passing a maximum as 64-bit type to drm_sysfb_get_validated_int0()
> can truncate the value to 32 bits. Use drm_sysfb_get_validated_size0(),
> which uses 64-bit arithmetics. Then test the returned stride against
> the limits of int to avoid truncations in the returned value. A valid
> stride is in the range of [1, INT_MAX] inclusive.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/dri-devel/20260617114016.5A5991F000E9@smtp.kernel.org/
> Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
> Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+
> ---
> I've added Reported-by and Closes tags because this is a pre-existing issue.
> ---
>  drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


