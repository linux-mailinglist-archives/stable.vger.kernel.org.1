Return-Path: <stable+bounces-119754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397DBA46CA2
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 21:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC9716E2D2
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 20:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582D5244E8C;
	Wed, 26 Feb 2025 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9Zcg1oJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1120F060
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602636; cv=none; b=u9cEXN5hVJez29F6CgYs08g/n7RGqEmEZvAWik93Jf4B7HvD2wryqLzRXEvrd9dMTmJhxTg4LEozKknbXvv5zU67F4ki2DUQ7QHxEgQ7niZIBB+/iMTbAcdp2ElTqrdavRaPz5SR0eNcGz/iuXpMg7i8DLNSffgilf0g8sMp3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602636; c=relaxed/simple;
	bh=+ruaCMehGYFua+tFCSHEmxudmg2YDhg0fq3RTLX1bos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaqLJFXhzNqGgM0pDiIpYZMmLF9f5WpI2H85CE97V21kX23GRrKzs/TWKcMXotDRlHSAIgp8YFhPfhJgwa/FzCvTy/K3K2esy3AhQRsZuGyJJUAwWFfODq83ix+tgSymvq/1otip+X9f5wMLmL+Xc4TgicEfFY8+UKoAT4E6U0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9Zcg1oJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740602633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0dzl5SDcbfWTKxhGQl5HtUv9pp6OHwLmqZpG5FxCO8=;
	b=K9Zcg1oJRao7q65zlGfOL4vYPhG3UMGyEY9AYCZIa9U3qCXVHUqJGPJM8QycqKtUefBKEf
	RjTkx9qzuxIylIVEgmcUolTvafqvCM2V3m/SveXU5I+Q2Ogjor7OoPaVv3JZYDsfzcYC/O
	uXYGbCeL5u7bEbZ8eA3LbvbQkT5gdFg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-MYkE3lvaNE-m2QydFZYJyw-1; Wed, 26 Feb 2025 15:43:47 -0500
X-MC-Unique: MYkE3lvaNE-m2QydFZYJyw-1
X-Mimecast-MFC-AGG-ID: MYkE3lvaNE-m2QydFZYJyw_1740602626
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e682a1c92aso2920756d6.2
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 12:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740602626; x=1741207426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0dzl5SDcbfWTKxhGQl5HtUv9pp6OHwLmqZpG5FxCO8=;
        b=A/2NjST/QVA2+EQjjBmmNruwCAAGPJNwUW5odWKBRfkyjZ/6dQCTEGMo42tK3I2tEY
         CUgzDRNnosRLVV4VzawvyrG70w+iXNS7nfYJgc7PZ0TlIOsP1o8tOc9RfHSiFikh6X7x
         i2wLHtMEuIooB7E736DWRtyCXudm+DqcKMk8/DSdHpnJ4wNtsCLLV7POLA9DQ95qS6sf
         +z8S2QBk3aPc9ZbfQK/Im3CSM2nmAWDHeZEIEyxe8iNQ/JrFXZcUFX4mvhf5uA5ucf1A
         xyzfNmDuVacEuwngmvWuTBiCf8uO7xkxUUpok/ZEUClPOAYEaK9d5zLZe1b9M76A3QKf
         RhjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu52OSjdthHSZGpbhqPz631M/zuic8gnwtukB9XOeVJp+wcvrkZZHRd80dcQ6LNk1DWsPeCYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8gGC0m7TXbN/mK62F8MqsJsDQlI4KOyB1LcSWS07+bnM4Aun8
	E4SE9IwjkP5IoDGo9RZOKyMk+mC7/BckWKPq7rCmCz9lJZe8sVsAkwDSx/GZnuzU4QxGK5/IsQ/
	X01958unsEVqgx0yhOaQSlOR+ZMihiSIOB5UZlsq5IIyZvgmy2M3LxA==
X-Gm-Gg: ASbGnct5/v6/W8mh7kG08LIuAFVDk1GB5VnEbDzzsnrkODZu5VwXlC8fa0kg/0JRRV2
	mgHmw35BFOj6hhIGgkUX+94PCVExcHDRIK72/Mq7eA3R0JZZFvWA6r4m/TG0HgxMorEGffvcCOR
	tV/zYvmjYbo9QiDqZZzJunD8j6dqjZPsDKDE6ZKj481gCEeZtEzpj5ha0walchy7lXOkoXzwrbI
	/g3RXUVKJxgQoGJrm1RNuxtwd/DPh7A9KJuRxaQvN688QzuLMjtVqTyejJt9F1Z7nfuow==
X-Received: by 2002:a05:6214:492:b0:6e6:630c:71e8 with SMTP id 6a1803df08f44-6e886870f50mr77100506d6.7.1740602626556;
        Wed, 26 Feb 2025 12:43:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKXwQVAgk3jgl/49xngaYBX6oKJbXhVjpUcSNtUjB7QKk0vvqdGgR/UdpT1mhsnTG/+3HOWQ==
X-Received: by 2002:a05:6214:492:b0:6e6:630c:71e8 with SMTP id 6a1803df08f44-6e886870f50mr77100256d6.7.1740602626235;
        Wed, 26 Feb 2025 12:43:46 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976608e7sm514216d6.51.2025.02.26.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:43:44 -0800 (PST)
Date: Wed, 26 Feb 2025 15:43:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, lokeshgidra@google.com, aarcange@redhat.com,
	21cnbao@gmail.com, v-songbaohua@oppo.com, david@redhat.com,
	willy@infradead.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, hughd@google.com, jannh@google.com,
	kaleshsingh@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] userfaultfd: fix PTE unmapping stack-allocated PTE
 copies
Message-ID: <Z798_nEvv6YVZntx@x1.local>
References: <20250226185510.2732648-1-surenb@google.com>
 <20250226185510.2732648-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226185510.2732648-3-surenb@google.com>

On Wed, Feb 26, 2025 at 10:55:09AM -0800, Suren Baghdasaryan wrote:
> Current implementation of move_pages_pte() copies source and destination
> PTEs in order to detect concurrent changes to PTEs involved in the move.
> However these copies are also used to unmap the PTEs, which will fail if
> CONFIG_HIGHPTE is enabled because the copies are allocated on the stack.
> Fix this by using the actual PTEs which were kmap()ed.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


