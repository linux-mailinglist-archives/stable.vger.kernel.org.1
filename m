Return-Path: <stable+bounces-185584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B62DDBD7F59
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171E93B1502
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 07:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D041E2D9491;
	Tue, 14 Oct 2025 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMdIXGjq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AAD2D3EE4
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427297; cv=none; b=AeAx40JwoPTtsiDYPCZkWLTNsL/53X7RhwxG/TReGW353JvlZLeuFmqjwLTQRvj4pC3vexXEoMQ2FT4mdKZmybC5jBa793Rt39X6PP+yOglUzVM64cQf77cMOVvYYO7MJ5CldFojFKLEtWemYVWAmaNsDv/NYmYUwHztKIBgTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427297; c=relaxed/simple;
	bh=insi5QuAvcDo4ELXBPMiD7HNYLAxnQ0SSVuXp/JizwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L0FL1MuuQFWc6d0kN6Di8WYepWwOPnDh2wbn1gEQtnryIq1pvWz/PqnwZr9NcCceZSyG9icBrAdLTYche01qFpVLAQA5pmpNhHEKyWo8F2m/vqjt1XKerTFakXAJ7QSPuZxr7eRbHGTpkBo0RMihl6FbBiwz5XE+bUhXyG++RGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMdIXGjq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZAYJ7xq6WZ4FioBhdfbaQnlgRPAlKAdI8jcSI5iXTs=;
	b=iMdIXGjqdcdMDoRIKCjXv4W8pnoSXZYu+OiqyLVQdbWgVIr8SIaM1OLTk1g/vZKLjsAOYm
	JKaYFOVRx6eakAIoBQn9k7I1XEmSymfiXszJnStjMSTzWnAOSwadZQfb4nOOzODIGRQfFa
	ztu5jaU/mrt/dYAjWbWjsSA7hHuVihA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-5KRLBX65N-mJtYXgFee2FQ-1; Tue, 14 Oct 2025 03:34:53 -0400
X-MC-Unique: 5KRLBX65N-mJtYXgFee2FQ-1
X-Mimecast-MFC-AGG-ID: 5KRLBX65N-mJtYXgFee2FQ_1760427292
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ed9557f976so5254179f8f.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427292; x=1761032092;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZAYJ7xq6WZ4FioBhdfbaQnlgRPAlKAdI8jcSI5iXTs=;
        b=vBkfs/gB1qG2CiAcx85ekTm+F6TBbpL+4KvhJ2I6tu7QHYMvO9U63ZbwOEGakNpj/K
         pLmDDCHS8RasVd0o7EfeBmBfFw26Fsw4juhWHHngvJUPCSIuAujmpcMMsmadNN5+qbXB
         2bKiWVyf50Gl8XbYdCEs6r3zqijSDkX0yKWstzxE5NZ2QNULUGT3slU0fCscBVZeZG6x
         Rp5MLVwpefnfH4CJqfR4pkAnuhYHpwsI4Fo4wRSXJjzJ7ml7NfQJUjpsYGoMkzLcxVHG
         YA+Y/dmyPObsGu4tG4EUSxu0v+6XKljwp7Deo+R4AK6l4M2dYMq5w12HN3f7Tff9Ol5b
         opbg==
X-Gm-Message-State: AOJu0Yw5kkql86S6hTRQP8It1OSTQtYuFXjiMYoLZidQdCDobc2ymGMs
	DA1st/SfPhoxK9GjKICzzxZ1RufOlAqq3fCBahFaMX75Yw6qXlSKTFO4MDcyJxJkyOI+ZCObn6J
	Yw41CYYlgU4lgnswgYUGWnV1YOXyw8+IZuyl4tMn1xjK+fkkIfD1pHV8Ebg==
X-Gm-Gg: ASbGncu1rI8JJK3+pvj25qcB8HgRS+8iN4V5TSPDq9JsC99bh2ugMbWLJaBDfdZx/aX
	PREOpV/cRfUOpk9l5hYub4XYKmx6+VrdIQZNw8V5B/sWK2Ca0khbgu4lTpA4vBjMzlWsqcB2ix3
	NQ8HiwyYA7JIJpKKIuK3g15fafkZNVZkw3GtXFqWkvyLvo8qvjsWm7SG+RY4S4YUn2oVCgAbkVH
	9ThWfcNlvOGzjHjT9KOmlfrQroLZWx8lbRqzHy+/VStj4XVytLtfDsfjozZccDUYd02JEH1IM6x
	eve8kE3XrYnlezCbyXD++w+OhcEHPJgPhBTl28rMMI+fucPG+IM4fJ721LvAbl5HRXMvYl6LJ0L
	jGBFaRfgG8laMttv3LyrY0Ns=
X-Received: by 2002:a05:6000:2401:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-4266e8de2c2mr16860031f8f.44.1760427292309;
        Tue, 14 Oct 2025 00:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxNwSeqZAx1bogXJDeVtjJdr6RSvW9zsie6Xf2fYECED9RUObVAre57ulfyG8aTO0EyMtU8g==
X-Received: by 2002:a05:6000:2401:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-4266e8de2c2mr16860020f8f.44.1760427291948;
        Tue, 14 Oct 2025 00:34:51 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d015esm22720436f8f.33.2025.10.14.00.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:34:51 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jocelyn Falempe <jfalempe@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 3/6] drm/panic: Fix qr_code, ensure vmargin is positive
In-Reply-To: <20251009122955.562888-4-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <20251009122955.562888-4-jfalempe@redhat.com>
Date: Tue, 14 Oct 2025 09:34:50 +0200
Message-ID: <87cy6qq6lh.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> Depending on qr_code size and screen size, the vertical margin can
> be negative, that means there is not enough room to draw the qr_code.
>
> So abort early, to avoid a segfault by trying to draw at negative
> coordinates.
>
> Fixes: cb5164ac43d0f ("drm/panic: Add a QR code panic screen")
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


