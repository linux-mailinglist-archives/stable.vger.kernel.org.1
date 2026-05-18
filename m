Return-Path: <stable+bounces-249246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD/2G93iCmoV9AQAu9opvQ
	(envelope-from <stable+bounces-249246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:58:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE056A2FB
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A181F3049E38
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3433E3169;
	Mon, 18 May 2026 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPAMh194";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFkYWu4E"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA5732D0CF
	for <stable@vger.kernel.org>; Mon, 18 May 2026 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098138; cv=none; b=IIGdLTLsnrdiArHfBbRIsh+yx+N/AUkI7I4lzV1BwXcdST8lRjfE16HGL7IMMwCsfpf/vimMgF9vphKVO1HBhARNyaoBCnX9R4rWV7AaWHfMBPqRyBgfXxbBQ1DZf1Ae1vIgctqI0xt7DY5BUZ+E2w+cvoVJ3r/T20nR22sGYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098138; c=relaxed/simple;
	bh=ZBhj2Q6rqsIeG71DxmrjLD034wo9u2IYHUiX5foSzKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fyeIKuqAptpAGqvytD/zB4pkE8vVBboUSnu83ElaLwrO3swzpQtpNg0GdXtMt2DrbXSQv4bCqPjrRehnp/7aGm8zWOMU/Ezs2T938GJp4PAbYYw36JWEbS9dUtAvyft1juLCWvUBE2bXtaG4CPAt8+FY8P8C7/og7caHtfLzwQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPAMh194; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFkYWu4E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779098136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xudk4GOO+l3lmPzk8MU5bwUvZOAX00ItJJurhMyKKiw=;
	b=cPAMh194UlSAkwbKgJQf3Tp4w2ptY85v8kFiQI0bOHxvJa82/l7MNlTd15dzCIYqRZM4Pf
	op4O4RFtembmb4mZFL3N6CJ2op1dVhL0BloifEtimqQ26IZoRoi5IEXS9XxUcO3wqSZ7AC
	rVyvBNo+GpEHKWVvirovVsahVkuoLoU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-NPb1-s1SNCacOrY55hdctg-1; Mon, 18 May 2026 05:55:34 -0400
X-MC-Unique: NPb1-s1SNCacOrY55hdctg-1
X-Mimecast-MFC-AGG-ID: NPb1-s1SNCacOrY55hdctg_1779098133
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44b186b715aso1281975f8f.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779098133; x=1779702933; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xudk4GOO+l3lmPzk8MU5bwUvZOAX00ItJJurhMyKKiw=;
        b=aFkYWu4EZktjRMUaaRgXB1Flv7hiOfraQwvoNtk4OfakyLT+0w4EdnbadfCf3lF0MF
         dpUMHHyl+RqLcw1P+Fmt+uiPB/MISz9kIHygRay0WwYTyLa/4O4IAz3kG0aIol6cP3E3
         Z7QZkSFcDYVqKi4BdniyMR7KGwK91j78Ftq/MzYs2S5d+cAmU0naZv/+69h0IdW5djGJ
         neGw/DEi2v0OMv81nmDwIFaVrepypHnNhD5eW8VF3aVzM9D4shf+ErjqvjVyeKtuHtTJ
         Cv301q3oN5X/wGkMoCYnyIBvv4HIoqURBuvS5zNyhGe8Opv5BU2Wjbk92B3Pm8ExGAXp
         jRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098133; x=1779702933;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xudk4GOO+l3lmPzk8MU5bwUvZOAX00ItJJurhMyKKiw=;
        b=lXplMDCh86agtruSjHlydtjPbHnGQEEerRmjyzCeTCbL9MfSJ1yk21xHxE4Km/OCXI
         FZyBjklB5hb5WdE8Lza6InGEsY6Ug4BKJ/c6/L4NV+pXD9OuVmgQ6fDpsHTAu8uvT4eR
         pTLWPkgqqHAoZBn0RvDY00mvXW5VtDD7M9N2+bfL7q/7l9c+fS4gM/7yBHssqpmr3qxs
         6F7gn+d4h8A45MuQ9E0QD9cJHTqp08MX5abhNBspBz4GZzGQBm60ZPVjDLf5ZVQ56i77
         jZf8hzP7r5Nd8dVbIK+qcOXQIGsRreA67Dniq2yPMuCdZqvTfiEQHWbl5IEFazH6J4q1
         bgcg==
X-Forwarded-Encrypted: i=1; AFNElJ/RmYAuCujJ4OfalaLxTMODRllrS2ssnJZQ5Tz35Opj88kcpQX3MzuI345+GewfCGrkCAvCItw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwITnYdbgcCDW9aZh66Oqeg3tnfGVaviJWSaAmMRSl9PAgy2D8F
	cK6L8W48HJgWxTI7EDD78S62KUCrwXpVS1AIN4I84MPCGRm3S/OtJZwKnGcjDUiWfbKEDOpBk5z
	DLTrHlvl4cxzLtygUPF9ZK6uaqkf2miFDQ2uCv0m33n3NkbKJa6sEx8qecg==
X-Gm-Gg: Acq92OH3v/q6iVAXTUl1DLXCg9Vsxv+w7dOUoK4ShfYOJlI9qHZrzxJxKF0YOW+tzag
	WvcmQUub2kz+hZgvGm8JAUyd3n/uiRsQ0XVjp4Vnkyg3MPGmDhwsby9OPOqtbAhXTi7cALKxou3
	l2b021tJiG17R/cyI4s2P9uroPrAw1tpD2qROO5ePYcjstWcWsRmbsLnGUZj4KFY1Ve+ZaLMf9n
	JHLWeU+GziDqnsvnNeoOEfJy5PSZfy5gYHmXDUGA3jI3PBS3ZCt1wsXLzS/UJZLBZJOPOnKwRV0
	cfL6Xq1RXKU/nSMmSn5osGDkbwo4+dTvgd48sKp9/G394vt7u8W1aAAWbyiSbEUcwYMuKnPCqzo
	xq1dgV0LluuaOkZuzfRvTkyOaRum2CydpRQmoIZDH4wb6nCjCWBgXgxIKDhBb3tgnnaieGgnzMI
	9uYSzN
X-Received: by 2002:a05:6000:230d:b0:446:96b1:f5f with SMTP id ffacd0b85a97d-45e5c35da70mr19965372f8f.8.1779098133054;
        Mon, 18 May 2026 02:55:33 -0700 (PDT)
X-Received: by 2002:a05:6000:230d:b0:446:96b1:f5f with SMTP id ffacd0b85a97d-45e5c35da70mr19965330f8f.8.1779098132650;
        Mon, 18 May 2026 02:55:32 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39806sm35212353f8f.9.2026.05.18.02.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:55:32 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Julien Chauveau <chauveau.julien@gmail.com>, Phong LE
 <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Julien Chauveau
 <chauveau.julien@gmail.com>
Subject: Re: [PATCH] drm/bridge: it66121: acquire reset GPIO in probe
In-Reply-To: <87lddhxebe.fsf@ocarina.mail-host-address-is-not-set>
References: <20260324193011.16583-1-chauveau.julien@gmail.com>
 <87lddhxebe.fsf@ocarina.mail-host-address-is-not-set>
Date: Mon, 18 May 2026 11:55:31 +0200
Message-ID: <87ik8lxcrw.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E0EE056A2FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249246-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,baylibre.com,linaro.org,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[javierm@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ocarina.mail-host-address-is-not-set:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Javier Martinez Canillas <javierm@redhat.com> writes:

> Julien Chauveau <chauveau.julien@gmail.com> writes:
>
> Hello Julien,
>
>> The it66121_ctx structure has a gpio_reset field, and it66121_hw_reset()
>> calls gpiod_set_value() on it. However, the GPIO descriptor is never
>> acquired via devm_gpiod_get(), leaving gpio_reset as NULL throughout
>> the driver lifetime.
>>
>> gpiod_set_value() silently returns when passed a NULL descriptor, so
>> the hardware reset sequence in it66121_hw_reset() is a no-op. This
>> leaves the chip in an undefined state at probe time, which can prevent
>> it from responding on the I2C bus.
>>
>> The DT binding marks reset-gpios as a required property, so all
>> compliant device trees provide this GPIO. Add the missing
>> devm_gpiod_get() call after enabling power supplies and before the
>> hardware reset, so the chip is properly reset with power applied.
>>
>> Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Julien Chauveau <chauveau.julien@gmail.com>
>> ---
>
> The patch looks good to me. I've also tested it on my BeaglePlay board.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Tested-by: Javier Martinez Canillas <javierm@redhat.com>
>

Pushed to drm-misc (drm-misc-fixes). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


