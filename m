Return-Path: <stable+bounces-95330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 097289D798C
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 01:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F96FB220F5
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 00:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DC68827;
	Mon, 25 Nov 2024 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjENRZAF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68FBFC0B
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496002; cv=none; b=o3RfvJImW5QDVybnVdNlCFRW+OKO62Cak2gG4+88/WbGXVmBqkLFS2KiyCV/ptftu/bN7cPrui23QzZ29FFN/OHpfPDeS4awNM/aLUUhXgDn+CuNW0CZvasFB3qZIEDQNZdI9PSuibgy5+adfe46h0dymjm9/KthYoSmI1p6Hr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496002; c=relaxed/simple;
	bh=rBiPXAWhL7prSEE+oWNLyafaf94BI4KgDg7Xs99syVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LscqRBl+mwhDW25StoGjMuRaosPxz16htmVHHY1w7JUTZntLk9aEDJbmqVy7zYE25QSip06WxAK4CSvjB6zRc/NXCNUtX4rPT4lrrb/34MSgSTcmECMTl5RzOtuUNRjXHJNY723Hg2EpNDiqDXj1FhfLAms1gyXR7A0PVQg7zg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjENRZAF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732495998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYCrh/uGGFSMSiT9SxGgZt0ghT6J1XSTHnQBI60venY=;
	b=QjENRZAFMZ/HQ4NSXTQKWTYDRnhm5oWRALXx5Cq5UqvTKlgoCaNorV2S22PKDE5868eRfD
	woB07xeV52CPPozM7wFv8igwj0C4L+B8MHiDGKEjUiVzlyv5rPutQ3z7G2xGug1aEKHe3h
	jjb/lTI3cC8Xedkm9vTaVit9ULsZh4s=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-IpFfWXcZMl-1tI2aXapXyw-1; Sun, 24 Nov 2024 19:53:17 -0500
X-MC-Unique: IpFfWXcZMl-1tI2aXapXyw-1
X-Mimecast-MFC-AGG-ID: IpFfWXcZMl-1tI2aXapXyw
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-724f9ff5627so1022287b3a.0
        for <stable@vger.kernel.org>; Sun, 24 Nov 2024 16:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732495996; x=1733100796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYCrh/uGGFSMSiT9SxGgZt0ghT6J1XSTHnQBI60venY=;
        b=CrfcpQUXSDt8uSMduLA1grnOR4HTEyVSKF/r8V+0E35N6Ipl1+ZUF/R4GZZvSbIdAw
         NyUEOM2lNuHSmAoRSYi20WSbg9OtYTKixa/7vYa7yBFZjWg62KlUqtit7WJ6JeNyi+dy
         9v/XSO+IqMJLScH8AUEWHJl5Rtao8ppQXMe7JzFqlyD1S5Lj70DFns1X4LcjIJjbsEex
         P/yEwVFuEr52cY7HAgAVqzs159L6VaN1QSxKTNCzubpUUn+hqUwuUKj0YpmDlanJM/0E
         MOPfVy/ktswVkamtRYktm9q9CKDDOC9BkRgL3NNBrgzwDdRCLMFFILfCnXo7R5uWq0Bg
         YAWQ==
X-Gm-Message-State: AOJu0YxKSr2FfFQGhPlFL3bFT3sV+nIM81IDQaO1idodaXWzEqEvy/gI
	m5CyZR27UHfJTkIOapvNKF58bkLnyh5WgkZcsdRG2ZgojUa8h1EAtyT0x7Kr8gnJIt785lLOskY
	A3WF6LU4+LuZANiWA6TBBAEOTmQJzzFdUnt4X4YMszTaSTIaIJt0sTg==
X-Gm-Gg: ASbGncsRPDvrF3JrBdProngDY4LrXTAElWugdUGRbyQjfGjYoEAKTW+tjVl8N3ChBrF
	henTvdnBbSpKIvsa1QwIPac+J3tpxC/YSe2O5MkTr4l8v9Jku2WArKmoh88qmBU0A5hmKUz9evC
	kgVdXVUZn4xUbAtJyqxgvEXrDy7CGC0wKF5j5BB2+1aD53hZmbmPSB7kZZv/kVeW1wWs4L+JoUX
	h2hdxJ6aGtYSmZK7xgD09M5rJ6gHksU+kAusNcvFko8NrTjgdc=
X-Received: by 2002:a17:902:dad1:b0:20c:b052:7e14 with SMTP id d9443c01a7336-2129f28eca5mr115297575ad.50.1732495996306;
        Sun, 24 Nov 2024 16:53:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAh+2ElGAo++jlH3jK1mILWLPx5UAnw782BdEH0pmmssykaMkDOYS40gPooRfs1G0LDoOczQ==
X-Received: by 2002:a17:902:dad1:b0:20c:b052:7e14 with SMTP id d9443c01a7336-2129f28eca5mr115297435ad.50.1732495996002;
        Sun, 24 Nov 2024 16:53:16 -0800 (PST)
Received: from [10.72.112.30] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba27dfsm52456895ad.111.2024.11.24.16.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 16:53:15 -0800 (PST)
Message-ID: <b52a83ea-6e74-4bf4-b634-8d77e369e873@redhat.com>
Date: Mon, 25 Nov 2024 08:53:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fs/ceph/mds_client: fix cred leak in
 ceph_mds_check_access()
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241123072121.1897163-1-max.kellermann@ionos.com>
 <20241123072121.1897163-2-max.kellermann@ionos.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20241123072121.1897163-2-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/23/24 15:21, Max Kellermann wrote:
> get_current_cred() increments the reference counter, but the
> put_cred() call was missing.
>
> Fixes: 596afb0b8933 ("ceph: add ceph_mds_check_access() helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   fs/ceph/mds_client.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index e8a5994de8b6..35d83c8c2874 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5742,6 +5742,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
>   
>   		err = ceph_mds_auth_match(mdsc, s, cred, tpath);
>   		if (err < 0) {
> +			put_cred(cred);
>   			return err;
>   		} else if (err > 0) {
>   			/* always follow the last auth caps' permision */
> @@ -5757,6 +5758,8 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
>   		}
>   	}
>   
> +	put_cred(cred);
> +
>   	doutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
>   	      rw_perms_s);
>   	if (root_squash_perms && rw_perms_s == NULL) {

Good catch.

Reviewed-by: Xiubo Li <xiubli@redhat.com>



