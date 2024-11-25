Return-Path: <stable+bounces-95329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286059D7988
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 01:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D3016275C
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 00:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE344A2D;
	Mon, 25 Nov 2024 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWr1edR6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC8632
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732495986; cv=none; b=pbrkXtSbRIwzxT48TuVGOfmvNAzZJwnWoOyu543dVVm5DjsyHjgNXd2DInoa7FV1H1b7/mJgMx1Vwc7oJKfCDiaxG1QsscCn2JCFB1PuSeIojYnabPNdsOopEGc7p01t/DX+Oebaw+KzIYusq1apDQP0danW1B0zzVQqnHm/AGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732495986; c=relaxed/simple;
	bh=LviZfhN9wLHGkGwdTJsxWo+fyXaKifA70nBROdiPnBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbHHXs8x0BTl6dx6L/wex6qD+E/JRjn0u1SdhqfZFBbSXisuZpt76AcLiqzwwW22MFku36mxSTCjOGTFMWwmaYn+4GOJozZEpRXSvQj1LHjg545CzwRLglLxQq4vvRnjOhbieTLAd1EXvbOfmOYdD3KukhSBMg34+os/JR+xGB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWr1edR6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732495982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Og/rRZZnoc2/FOYWx0+cNvJMuebsJiZG18iFWhHEBpQ=;
	b=UWr1edR6B1CblT9AWuwN1xERZshYhe6pwLSAaLUpM0w31QloN0xAd5HtuWBy0wsB9wJHIC
	FZm3rTS/IeEW4VfF06Y8iQFzXWpCqWrdNx5JryHlhnuHVu2Uk3XaJNEJ2Di0hKjKDX4l8V
	2iawZegCYNP8dcb2yrr+/o2BwGKMOec=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-HtvCQqjKMw-0I2QGK0lLAw-1; Sun, 24 Nov 2024 19:53:01 -0500
X-MC-Unique: HtvCQqjKMw-0I2QGK0lLAw-1
X-Mimecast-MFC-AGG-ID: HtvCQqjKMw-0I2QGK0lLAw
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7ea6efcd658so3497875a12.3
        for <stable@vger.kernel.org>; Sun, 24 Nov 2024 16:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732495980; x=1733100780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Og/rRZZnoc2/FOYWx0+cNvJMuebsJiZG18iFWhHEBpQ=;
        b=nGqJA/Hm1kfvKATj8P6fFNrMAfcdgEFk6hiXSAOb757tGe9Qv2/TgIiMUqB+bgyFx1
         E8aQSOCBMCk48Hj/ytsPuT+J/sEUzH5Gi1gKDniR0t4WKuWX5HwLTGSh4QHP0FABEEy2
         U5LHSPI1f5uBJgycX5QTKVxl87lSpK3WRwz3YPM2EIN9+ITzbHiRDDfoTkvDeEvt+927
         DyB1i869XC3ybvRGDBbCzLzETpiQJ+p9ID2/b9vtvjMe9SycfbARZQOJbJ2sn6EQ14B0
         gmbEYjhhaQcdx+dZbG6a3PGa4HjqI9QDDPOmqjWBC10/UagN3tduzkB2+xo+tZOgaTDl
         rPCQ==
X-Gm-Message-State: AOJu0YxU+PY/emzh3YQUsZOSXhsbCUoEUZZNRjJsg7UkvUy2iWtLw01O
	/vOvKoNG5oH3spAJp/sFLvmduEZH2WKgFWyyVjkKnOHkbwug3H0epMImhkd+xdtxHlcR3Fnlx/e
	AZ3uUyCyuEoz2b9BbiezAtm2UB86A+65XhiM5b4gk14XhAj03WTcAuw==
X-Gm-Gg: ASbGncvul/PHwZHWJHuW5PyWB1i76uReAwwUbh2UZGD4R/nmbEZpeZvV1lm0SEVSdfb
	X/ubuFzvlj7DDlRkUEPCxlutpigxO4eIuAMPfi4xXBXIeoZRqF87rCVzABPd4ydfQHMf5umtT+W
	GxZuosHLmNSrcwNOkbtoDpGv66b4e00tIAgXnEVAbsQWAN/e2tjl12tOwS4ji3nKbLec0vBSRuw
	IEhtQBmKXHA/4IcIBsGI4iWB90ZCCUlE1YYsGSOfCMUCVBwLAg=
X-Received: by 2002:a05:6a20:1582:b0:1d4:fc66:30e8 with SMTP id adf61e73a8af0-1e09e3f0006mr15957944637.10.1732495980446;
        Sun, 24 Nov 2024 16:53:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6wfZGq3UlSemEP5dLQviUNWOYLTc9QXIUBc6PDL2mjW5iUJ01qPTCvrL0lGUH2zBWvTRnRg==
X-Received: by 2002:a05:6a20:1582:b0:1d4:fc66:30e8 with SMTP id adf61e73a8af0-1e09e3f0006mr15957929637.10.1732495980195;
        Sun, 24 Nov 2024 16:53:00 -0800 (PST)
Received: from [10.72.112.30] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de47d4b7sm5176803b3a.46.2024.11.24.16.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 16:52:59 -0800 (PST)
Message-ID: <32d12a9f-d2c0-45bd-9f9a-e647a2ac7083@redhat.com>
Date: Mon, 25 Nov 2024 08:52:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/ceph/mds_client: pass cred pointer to
 ceph_mds_auth_match()
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241123072121.1897163-1-max.kellermann@ionos.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20241123072121.1897163-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/23/24 15:21, Max Kellermann wrote:
> This eliminates a redundant get_current_cred() call, because
> ceph_mds_check_access() has already obtained this pointer.
>
> As a side effect, this also fixes a reference leak in
> ceph_mds_auth_match(): by omitting the get_current_cred() call, no
> additional cred reference is taken.
>
> Fixes: 596afb0b8933 ("ceph: add ceph_mds_check_access() helper")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   fs/ceph/mds_client.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 6baec1387f7d..e8a5994de8b6 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5615,9 +5615,9 @@ void send_flush_mdlog(struct ceph_mds_session *s)
>   
>   static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
>   			       struct ceph_mds_cap_auth *auth,
> +			       const struct cred *cred,
>   			       char *tpath)
>   {
> -	const struct cred *cred = get_current_cred();
>   	u32 caller_uid = from_kuid(&init_user_ns, cred->fsuid);
>   	u32 caller_gid = from_kgid(&init_user_ns, cred->fsgid);
>   	struct ceph_client *cl = mdsc->fsc->client;
> @@ -5740,7 +5740,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
>   	for (i = 0; i < mdsc->s_cap_auths_num; i++) {
>   		struct ceph_mds_cap_auth *s = &mdsc->s_cap_auths[i];
>   
> -		err = ceph_mds_auth_match(mdsc, s, tpath);
> +		err = ceph_mds_auth_match(mdsc, s, cred, tpath);
>   		if (err < 0) {
>   			return err;
>   		} else if (err > 0) {

Good catch.

Reviewed-by: Xiubo Li <xiubli@redhat.com>



