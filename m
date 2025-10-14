Return-Path: <stable+bounces-185585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2EABD7F50
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE0B188A51D
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 07:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA70730EF63;
	Tue, 14 Oct 2025 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB3uhROu"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E25E2D9EF2
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427365; cv=none; b=UjW8OSSnl5CeWW1A7Y191CtsKMIGlYrI/6kU3YtGmdXGg6LR1FiJKTJIBEoyykFfnufSoySnfG+PypfRG0gV2ViI0EwNPeb0qy0S3z92m3JXBVqhL3/c3tG3KRKWIgMBDsQB6S27rlOkmTz6+5CCBo0/BEGGsknmJYMY15P0gfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427365; c=relaxed/simple;
	bh=XfX2nsV/d+yZ3Hk6qajB1hKvZGTfh/kspXwGH+T7Yv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Te7+alD5xH13H5jKOIuJaNS7dXCTxvu+V7ai8XfLC1FXybGVKIJg70eO/YHNZcZ57Iljb45M6MmynMF20wxxQ+n9dKwIKYcIygdpjQte+lAmkuRAiUrRU2m944OOikKnldS7n+yAoQ0QhbjFgoqQCBNMHun35fwib/7b3KjE+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KB3uhROu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rp2yi8Bcjq1dxm5BHjQD+Bw0UYm59cbcglHsDw8XOKA=;
	b=KB3uhROu9sIz4ZN5GrSSg48MaiYBhbu6dDwiveWwumueYAbBbv+aTmvKwfBpDuXz3gG1O/
	nu3lBkqsY1LnWd0IAau1M+etok4q7FtJeuVdgHAH5bfgT3idpWOOMz3xBNi1KEtT/2Z/Qj
	19tdv/oLVPmrKWy8MDFUy4MHsw6I5Vk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-_mb9iVz7P7ao2Q72IncZRA-1; Tue, 14 Oct 2025 03:35:59 -0400
X-MC-Unique: _mb9iVz7P7ao2Q72IncZRA-1
X-Mimecast-MFC-AGG-ID: _mb9iVz7P7ao2Q72IncZRA_1760427358
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-426d2cd59e4so2905164f8f.1
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427358; x=1761032158;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rp2yi8Bcjq1dxm5BHjQD+Bw0UYm59cbcglHsDw8XOKA=;
        b=VNug81edPr+stgE+UwI6Tg3m0LkurPCgcS8BEUW3grWVHvTrBIB7b9W3b6SVTbj2re
         ZDB1bwOKyR2pQ49ZZIrHIQe4izzEeAIt7fX1t/ES2BCMcZxpQGrFQEcFm5gsMjtTqbKr
         A/qHV32ekTELsx4HrqcVglkBkYHjviwXeXa1UITtYAQcM4et7qWVinpDnIk8YpjX1dSf
         PMK2hFDs3q/KxYaGU2QDZjKZdqWcYxX0Ic+/X2YXHWDI7Mce0XPYF6UTu3anPhQRyG3N
         kRK22ZOdCCxK3IB2UxsZQwt84Pchr2H0v8Buar8nOVomT8KaDj0qt4tDGduAY9RmjvJR
         /dZQ==
X-Gm-Message-State: AOJu0YxU2WgwhDp8zHPBldilLstMRza6tS4D4V/j8blxPWH0C0VOhclY
	SrUrUcz9SuUjeombJmZrolNipYzx7zxJjm9rUaZ0JzEL8p+C6eNUXcaJ/Uos2T1SUoCqmF7KLiL
	CCA/zIetjHNWCHVyZx/JhaqoYrnyEc5iAtewRLdK5IXGaAUwCf14KMRv0DQ==
X-Gm-Gg: ASbGnctiyJgODhWBtGjeuGi6X69BYN9faP9XI/a3cTudZcbn33XP3HjfE8iRoMvJEWl
	j+3caOwDsGPa1g7zIXZSlAheGYmYr5nggp9ojeagO+piKV+Eo84OC2Jj4xss3hqzeS1dXaNp5R+
	DqDcsVclQ0sCl7ln+G8/7Lh6kFIsFxpF055P1hbJbjeLBsefBIHA/tjP/aGUi58Z1KTBgAD1cPp
	JdL+FAnwiYAdfo3l/imyMSwAZpC+BP5ngXHZFeigwZg/XbAE5HFQm0cmXfxCgDGLhUf8yc7TG+Y
	Zsxv9NpR8FH521xycTyT8U8RUq7jgnbSfcOWkcVyIIafpw3ofS5S7H37BWGxCqWbg669wxAfPhO
	08U8tKUUD9cK1n22R9Q9fFlY=
X-Received: by 2002:a05:600c:198f:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-46fa9af3125mr171576585e9.22.1760427358273;
        Tue, 14 Oct 2025 00:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWYlHv6WiUrgd9vj3CbYtPVGZ9RfLX5CoNkDJzKegevpgk8U/J3XAJpcTsFc+GvZf4Vvir4A==
X-Received: by 2002:a05:600c:198f:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-46fa9af3125mr171576295e9.22.1760427357923;
        Tue, 14 Oct 2025 00:35:57 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb479c171sm224366945e9.0.2025.10.14.00.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:35:57 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jocelyn Falempe <jfalempe@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 4/6] drm/panic: Fix kmsg text drawing rectangle
In-Reply-To: <20251009122955.562888-5-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <20251009122955.562888-5-jfalempe@redhat.com>
Date: Tue, 14 Oct 2025 09:35:56 +0200
Message-ID: <87a51uq6jn.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> The rectangle height was larger than the screen size. This has no
> real impact.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


