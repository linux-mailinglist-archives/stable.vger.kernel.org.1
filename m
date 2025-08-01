Return-Path: <stable+bounces-165774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3541B1882F
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 22:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A533581FE3
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 20:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4132153E7;
	Fri,  1 Aug 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GKibgmCZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE71F4628
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080515; cv=none; b=dcrzFnKCrFLNx4rb6jeGne9jaxWt06BtGlnM/l6mqmEqVi+JzeFsut616+WGyQeBtm8A/jVBGeOOoG1I+gTmYBK1tS9GbpzgW7vSSyaX2Ea+VjvxeV0lyYyo/9tIW/LjVu8EpWWPVz7rCgLuNh3hmfC0eve7KzzlzD03YceqA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080515; c=relaxed/simple;
	bh=ft1GtVlHTumH5n9zAoqypec1LBFsX5MTL+yaj3JjcSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNGmm9h9lNVRSQfecpXBY4wMq1x53yX/JtVi4s+wxhpoN6W+WDa/PfuOwvju/7qzAqgdjwHQ1gexRKU6XdGMkA3MF67HuMLrukO2hsPtrRJFRcGwO+//lbphSBJ7xcXOutySSTxOw8DZjm8FhNDN3A3JHycmLMIpuBXiD8Qedb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GKibgmCZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so3591694a12.1
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754080511; x=1754685311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXkdEcm3dcCFEHiiyHz9se6bX6iRUxFV0EivrOFS6/U=;
        b=GKibgmCZlZTg/2jfmyQmK4sWMiknySj11/9/5kLeQbfSGdP3S8OiSSDcPZ6YT+4R9z
         Id+jnAr36/WRrub3eU5WWPqsRAHmRfHqkrO/JpFdtM7byTrUfudPO/y7CHMrIOc267h0
         olgB3tUg3jjgvt/XVUPdfJa6PevhMcpapa0ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080511; x=1754685311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXkdEcm3dcCFEHiiyHz9se6bX6iRUxFV0EivrOFS6/U=;
        b=ibGHMCyMVOJ6SyNYCS54c5kZdm38OuWTvI/1noZe7/urqThuzpKveN28jE5pRljZ3p
         cG96hrrzWtNb56S1gWLhEBdNYDDCJwe3YTibqjNCd9ESYGefdJgaShzVuqYVlFDxr5M9
         CYPvnQSRpvVodWp470r3IHHaT8+SW9FtZq50PKM3wSVby3el0vp0BIHpYKyQxJfEF5C7
         Bb18aoYUWL4sf3EKEmioGjucLjTs1hB6CIV82WwFppsYISNlyLosrTjk/rKU6vcbR3Ds
         qJ08ll5li7+fCFpEpcK2sgPekLAcxSEEdbG6BErASMxJYEgj07nfggAV596ZDa2ctNS5
         sUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVJaO8x1oElHyg2bQHDMnQXGrFCGm1ztaWPk11scSXXNQskDlTlHysPVeKPPk2E4MuLtnkK7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/GtCnU7Mt4jBV/Do7Ixi8kM16DsGl3hTzSh5XyHKh/uwAEB+
	nNsJYzncY0FvYb8kxNVHpf4f53JJLWIynySaQwQ7FefDI3GOAvBsLZhue+/lxROS9FjgXszh2EN
	MhA4QL5Y=
X-Gm-Gg: ASbGncsrdasDuFnLPfc6WiXuzSsKwuCqzAiERhqwnHPjhFxJ0t3JzkE1C9b15JjrJ5A
	AeIA4Y3ss6SqBQoS71/lFKpCHwmZo6SvLJzdt5ss3wd34vtNu1sX9hzQjUrM3Qc1kL1r1FQW3Jt
	hOxEsFhGFWBuRG+ZOKM0y5xLAshiOSVgY2eMUB5QaQtcs8ogxOv+n+8Zd1+DUIIlYsRgE9OD6Ud
	JCnZzeNFxCWLzEccppJ73DsAN1vYEg5I0Ij48ZHCh4O0U7xZyRm1mqKgOAUQPNthHRjQVkYWhqh
	yDZCenVyXf+7St5z1bTr1kxh/kuCfUgtE+688H0soaUdkd06ODXCMOoPOPtT2ZWyqZ6OceJhMV+
	xFcvCraTZ/yjIeRxRDicbG8fx0fEZUzHgYlYkBenie7zjXer3keGmbYxkW9s0QhhEc7NpkaWX
X-Google-Smtp-Source: AGHT+IEHxeO9TWHrAuSaKbSB0Jq/SYE5Mhre9WTgmkcxL6ntAP60L8/WiIM8wPQKeAmujcaBQ1se3Q==
X-Received: by 2002:a17:907:8688:b0:ade:43e8:8fa4 with SMTP id a640c23a62f3a-af94008422dmr148986066b.18.1754080511364;
        Fri, 01 Aug 2025 13:35:11 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2436c2sm327664566b.141.2025.08.01.13.35.10
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:35:11 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adfb562266cso414705066b.0
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 13:35:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDIM5CSrZzi4ai/3F7Tnsbkhmj7Aw5q142dzAkXLja+IiKtR23GwesTcUTZE7bqEPAzMdWn+4=@vger.kernel.org
X-Received: by 2002:aa7:cb0d:0:b0:615:8012:a365 with SMTP id
 4fb4d7f45d1cf-615e715f7a6mr469886a12.25.1754080158122; Fri, 01 Aug 2025
 13:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801091318-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250801091318-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 13:29:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
X-Gm-Features: Ac12FXxywlhxHC92NneGnmmt5Hm9rlPrKO5mJOfIsb2I5ZMf5olIOr9KL1pDLfc
Message-ID: <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alok.a.tiwari@oracle.com, anders.roxell@linaro.org, dtatulea@nvidia.com, 
	eperezma@redhat.com, eric.auger@redhat.com, jasowang@redhat.com, 
	jonah.palmer@oracle.com, kraxel@redhat.com, leiyang@redhat.com, 
	linux@treblig.org, lulu@redhat.com, michael.christie@oracle.com, 
	parav@nvidia.com, si-wei.liu@oracle.com, stable@vger.kernel.org, 
	viresh.kumar@linaro.org, wangyuli@uniontech.com, will@kernel.org, 
	wquan@redhat.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 06:13, Michael S. Tsirkin <mst@redhat.com> wrote:
>
>         drop commits that I put in there by mistake. Sorry!

Not only does this mean they were all recently rebased, absolutely
*NONE* of this has been in linux-next as fat as I can tell. Not in a
rebased form _or_ in the pre-rebased form.

So no. This is not acceptable, you can try again next time when you do
it properly.

            Linus

