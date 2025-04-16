Return-Path: <stable+bounces-132838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677DA8B7A6
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 13:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8072D189FD81
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 11:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E6423D299;
	Wed, 16 Apr 2025 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYXW3O7H"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910623BD05
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744802735; cv=none; b=SmBkNFsWmw4wUZeWxrFMSWylyi1p1UctzcCX/lM4Yk4hSZPnLQ+QPwhHho8+NeS0kT6afZDJBUTlXdHFg6DZL+lDOS0WJiyu3QC2Ob8wF4LoieIvk7Jw9kMe8tgWK/YaJf4KJDCaSaQLT7hqjXZBrJNukbgNVKTcPkT47IhMdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744802735; c=relaxed/simple;
	bh=M1SJQCGEYPEhCrI3qgX6t+obEkrQ6EqASbeC+/fQb1k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=G66fgm5HmSf2MR+IKNGWf9b5yXH2wU7xRgPUGmi7+qVmdwsdLdkzmp5/28KuePJ1T1WN+enyNf8v3kSH+oP2UWBdk/YHEiuQ7hRxzmJwOwdPRtg13KMwI+Wf0JU8onkEyy4d7vUBEdiL49FeL7yPMgEMZfzVFtY2RvfkEtqIvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sYXW3O7H; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so61100325e9.0
        for <stable@vger.kernel.org>; Wed, 16 Apr 2025 04:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744802732; x=1745407532; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1SJQCGEYPEhCrI3qgX6t+obEkrQ6EqASbeC+/fQb1k=;
        b=sYXW3O7H78ghzbt4JmGX6Yqpr/5CdPE18LsNmE+HuIAtD2aA6oqOjWp6oE89T6eJ+B
         BgnF2TAvYN9kKgBRNKX+Lc1brFuzn7hcyanC2en/eS/uYxjwfRQ/NVc3ehKafh6M1Nro
         PVRSs+lzJR7wb0vswcZ1iSxn0gHJG+AG0J1SYdBur+WpLyh3DK0LSYhQK7PeTNtaox0Y
         enZhCT0rqgCWBjYn8cGBqc2fike4VEXgfIRZmlzmWfscRzcWA7bbtm53liTdf3DiDFVW
         QZ4EZL4EeTx25XlQYscU5Wc+iM5ed6WiFzbw4jkESyIAr5PUiW9Lh9iVEfyKIc1tIplm
         WztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744802732; x=1745407532;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M1SJQCGEYPEhCrI3qgX6t+obEkrQ6EqASbeC+/fQb1k=;
        b=EEJS2oOGrxK+EvWDTuqbNwXOGy2vb4NGQo6ANEfeDsdII7J7gcIIrcCfsPLbUvZsGu
         gl0OGsrlRXHr9VlB243iWH5tQ4NjBxsTvile5C4eZ3f9q7emhfI8i0ubPqd1y6KNT6wT
         HxfCmWMnNoKvQctIJtHNwL9+CTbkr/OgDUsuCVuOq+0aK6xKWzIXKZ4JZVRQspspQkSJ
         nMPIGPEBxMdLvizgEbgfFS5WN9fBoGAFa1QqyTCcdww9g1+gTaG0mnkIbqlCxQckrvxu
         MU9mpOcBarP29XHiFqOYTRxaMgL2LW/5oXHs3elzZx1qmUJseL4z3fVxjTl/xnZFFgt/
         876A==
X-Gm-Message-State: AOJu0YyXOIcB0X0QL+mq/P+BhrqPtBzb0R4NfwdNiBevBy6Q4FmmsOYi
	hDAFA2SF8OvO94VQpUlt7mW2JlIvCqYWNAjU4b1A5S7dqrojJ+NrV4JWtdAr5Eg=
X-Gm-Gg: ASbGnctJPzzE2ttHoJG+7hREELggg0fhEw8XClz9GoHdDGhVcdW15HDHRJi7scpptaX
	bFp5VWIVgRk2Uzb6cLVqfTNd0r+AsuYthmBDZDJDJtObXAshU1XnQm8A0+gQIuVmeNHAu1UceIb
	edgGc+HGAluVtWwELkPTPnc/IaBX7Rjf6egu/BLWsHI21r6LZOWwSCaBoMWGQfsgstNDrmxcww9
	GuMsBjdZFIwneW1pbInsqZ8IDfwP3+G8WrZGYBQWGOkfEIClUnl36lTDOXsJo60vKe2ObdX1EuN
	WQgK2Dv0D4vWqqgwPtPwk2McGyqMO61RpVFX4ptT
X-Google-Smtp-Source: AGHT+IE2uGk7viULXRHwcMC6GtLWc6X+31aPOyWo4guoKeQ4IlVtxGCdVZQNStIgzEReOhLBuSGQSQ==
X-Received: by 2002:a05:600c:3d0c:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-4405d5bd218mr15007975e9.0.1744802731815;
        Wed, 16 Apr 2025 04:25:31 -0700 (PDT)
Received: from localhost ([2.216.7.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b5adb6fsm18524045e9.40.2025.04.16.04.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 04:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Apr 2025 12:25:30 +0100
Message-Id: <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Fugang Duan" <fugang.duan@cixtech.com>, "alexander.deucher@amd.com"
 <alexander.deucher@amd.com>, "frank.min@amd.com" <frank.min@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "david.belanger@amd.com" <david.belanger@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>, "Peter Chen"
 <peter.chen@cixtech.com>, "cix-kernel-upstream"
 <cix-kernel-upstream@cixtech.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: =?utf-8?q?Re:_=E5=9B=9E=E5=A4=8D:_[REGRESSION]_amdgpu:_async_system_error?= =?utf-8?q?_exception_from_hdp=5Fv5=5F0=5Fflush=5Fhdp()?=
X-Mailer: aerc 0.20.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>

On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org> =E5=
=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 2:28
>>#regzbot introduced: v6.12..v6.13

[..]

>>The only change related to hdp_v5_0_flush_hdp() was
>>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP
>>
>>Reverting that commit ^^ did help and resolved that problem. Before sendi=
ng
>>revert as-is I was interested to know if there supposed to be a proper fi=
x for
>>this or maybe someone is interested to debug this or have any suggestions=
.
>>
> Can you revert the change and try again https://gitlab.com/linux-kernel/l=
inux/-/commit/cf424020e040be35df05b682b546b255e74a420f

Please read my email in the first place.
Let me quote just in case:

>The only change related to hdp_v5_0_flush_hdp() was
>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP

>Reverting that commit ^^ did help and resolved that problem.

Thanks,
Alexey


