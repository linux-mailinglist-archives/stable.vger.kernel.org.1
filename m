Return-Path: <stable+bounces-158647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5E2AE92B8
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 01:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063221883A61
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6CB2D97B9;
	Wed, 25 Jun 2025 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUkqDLvQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BE2D9791
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750894048; cv=none; b=eQ+wJqUJa4LSwMdqTrDJEvfNKG09bNHMe4glL55Zth4F1f3zFBTN3VNPzPG3E1U+z2xQef6cQ7eQmMYrmB3bdnhNhl/dA4jNt0lufa79NQWfdMUhV4vX88ZcZbHEVVeQBGcfLrarAp61vh3v1Cnu1ek/y+3QSaMH4lXc8POZ81o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750894048; c=relaxed/simple;
	bh=kx0FBz5kxfLMHCooOeoxb/WH5qJa7rGUaz7/wvuEWhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpiouXP4e8IN+dyGkCE7iK8dUZWL/QSb2jK4XxBagffIkgKyGXQ/iySc801RprrZ6EpkC/JUmF0Yay+1N3AlvRhD5CgCCZVYfwNEnr6oFS1Id5iuhCYIQ0SGP1yaDjkxuPfzyXr+FvBmEeF02GtlJsco0Uf/vlxNdmbrzj3rYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YUkqDLvQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-237f18108d2so70305ad.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 16:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750894045; x=1751498845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx0FBz5kxfLMHCooOeoxb/WH5qJa7rGUaz7/wvuEWhw=;
        b=YUkqDLvQ9BXyZw5hfVqrjyRmDjIwj6EY4X9vTgZ6DkcnzsntkKjBeDj//XQrxrrK4/
         okgyfq9U0TT6QWHKeL7Fq45ypaNZoow6P2ZtziJyruwdRsuhjCRvNVbt0eH/LdUBTHET
         Tl05OFm+Gog7+AElRqXI4z8pomQjTbjdWASDwAiJPTzvcf26LPOlBVDoJzKvfhqySw1E
         PzRIGdqLU2ln+TrjUQ0xXiG9KTS15fi4x9mgT079oX0yVurs3esP58Pjdz56PIi9GWeE
         t0tALwDGZdWmb6YM5mnavV4q0twzP5z6fUnXdjdR4mOzfXdBhQh5BIieo/9JwwWu+Gmv
         +x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750894045; x=1751498845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kx0FBz5kxfLMHCooOeoxb/WH5qJa7rGUaz7/wvuEWhw=;
        b=bsvMuHPrix4ug++FW3r4OKd9JDIVXLykIpKeI7toBSlGpyq/VcBukCfK6dJwAZ2R0t
         2GWRTChPOV6IX4fHSiJPxSMylJWQ+e9UfT1+SS4oIAHU8RDimexYdm/7sZSAXicyXHdg
         CV4Gg3RjtwxWhngRla+lgLAT0K1mN2eZ0eGVz6MLr6WCOfQJ+nxpM3qNCULcr5EAO/qx
         DphNskiWToJDsskjZvcwj0aXZ5uPHnKCpKjnUGUBfwsKyi3ttZ5Z/w/3AdFWwk93bKZa
         PfjXTOeu00/SpKDL9vEvtvA7pAkXuKfpGaHdvkIfP8G3GqdBjYY4yob4PX1DXNXuNAlg
         kNlg==
X-Forwarded-Encrypted: i=1; AJvYcCUUBfX7tfF3TnTrSHLaLtfNCOB0BFwSFo9wX4iP5+EB7NZmeJFzZmGUXwy26uduNd4UgX0A/ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBSQxP1VW8u4/jDjYhydbTRKaeyodmboYw0sCHiw5bipZhJhY
	XRXSPzuys7FUGBMU9OXDJ7CIWNKGa8cdUR+ZDu17wLhA2ixhvzp2rZ+Uq9S4VN4bhKiy6pbVBY6
	MYGOy+l43blniUfOCNWmE5U2B/848a9LasJq1J2L5
X-Gm-Gg: ASbGncu0JKhZthGwPTTu2B/L41oKhb38K2m7Iav4R8q5a/+Vs5H8fRYIASWS/jii9lt
	WjSO5bfI065rrmvbGYNX04Ep4qUWzUEq2vkfXNZYyHIDz+kKg9PqGVZ87rZfTGsXfJBOkV/0qO+
	/eG0dbQQFtNEpsLVhh/04zmj9v/gciOIYCc37ezVzQWlHQo/zhS9+jhxxYt6LeDnW8WBXnWsCC1
	Q==
X-Google-Smtp-Source: AGHT+IFrGat1M8QP/7zoAcIXKoils2gNnPA0GSx4CmoITbKm6/QYmlQ9DspDtT8SNS7GNjrlk9R+lu+OSoZ7G/MIqco=
X-Received: by 2002:a17:903:1209:b0:223:fd7e:84ab with SMTP id
 d9443c01a7336-23978ba18b0mr1206005ad.24.1750894045108; Wed, 25 Jun 2025
 16:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <434C72BFB40E350A+20250625023924.21821-1-jiawenwu@trustnetic.com>
In-Reply-To: <434C72BFB40E350A+20250625023924.21821-1-jiawenwu@trustnetic.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 25 Jun 2025 16:27:09 -0700
X-Gm-Features: Ac12FXw9dIpBvK2gofOzg6ZIJftbo8Gcj1PZacPrSRZh88xnBf67PtMxM5KLs40
Message-ID: <CAHS8izOCvLBWee3vp-Xv_XATztcTA2Rnu7CDtRfN+2CHo_cgww@mail.gmail.com>
Subject: Re: [PATCH net] net: libwx: fix the creation of page_pool
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	mengyuanlou@net-swift.com, duanqiangwen@net-swift.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 7:41=E2=80=AFPM Jiawen Wu <jiawenwu@trustnetic.com>=
 wrote:
>
> 'rx_ring->size' means the count of ring descriptors multiplied by the
> size of one descriptor. When increasing the count of ring descriptors,
> it may exceed the limit of pool size.
>
> [ 864.209610] page_pool_create_percpu() gave up with errno -7
> [ 864.209613] txgbe 0000:11:00.0: Page pool creation failed: -7
>
> Fix to set the pool_size to the count of ring descriptors.
>
> Fixes: 850b971110b2 ("net: libwx: Allocate Rx and Tx resources")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Looks correct to me. pool_size is meant to be the number of entries in
the ptr_ring indeed, not a size in bytes. wx_setup_rx_resources does
set up rx_ring->size to be the size in bytes based on the
rx_ring->count.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

