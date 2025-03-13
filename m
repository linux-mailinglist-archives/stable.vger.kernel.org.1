Return-Path: <stable+bounces-124387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E21A602CF
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68E619C57A1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC191F0E22;
	Thu, 13 Mar 2025 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT7BpwOd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A86F2F2
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898320; cv=none; b=NQeVv858+Qllm3wa+IHXM5uhPMnM2r+EaKAuSUpQjRtkdUIQd4m9+tem//BxlyjjZsj46dgLneurMD/u8L36IFFM6bbkE4uHrSgGI+I1GvQgTjk5PJMHH18ylGYh3SceEKYvRvQVpNd9gqTTJM91D/3uFVzbc3YScgEhWZAZxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898320; c=relaxed/simple;
	bh=IwUIkEP7WfxcRSMHguY9ee/fkd505b5agpJZxU5A4Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnjWrN67XJDFLJgOFvH0nrZmba4P329ppuWgQMlGMrmC9oTQNmCAy5U0d0yEbKX19Dcevi3JXI8OF1ei6ZPEV6l2ynjXTxFuctrJXAC6lm/PHpyznxMCS6UPtVsgHGo70d/fXfV/CAMmPxsx1GCGZLnQYCOcrMk1hwgytn8lsLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iT7BpwOd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224100e9a5cso30672465ad.2
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741898318; x=1742503118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPK2utcA9dZI7Iv+UBod/VAqR5fflzq27j4XLX2cqUQ=;
        b=iT7BpwOdjsMBHNt8l6i/yuguA2DSm58TEGBYiNNSmi70fA6glSlbMyYuUrCctP4JK3
         CoLG/U78YdYUGSn5IO7jGkhccrLFuHYVttpHeb4HP47ZKTegvdq5umTGuTWHnQ/dBCbB
         WS0BkUMDNfUT7pyS/z2b6HWHn5Lh4nZ14v29kOQ7MjIFpeHhHHO8s2zStVDnPtBpEZfT
         ES+g0nnWKJWlGrLQvINoKMkfoB04q1NIDGJtlumb7ufaqnYY4cZfHyXMzdMPn/AoUBrS
         Qs7Qw4vXkZnSkWsMbDujqA0fBFS+RCfk7zMD7PMLPJ95qlA6/YDlxJ5+Eb+202xD4JcE
         hFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741898318; x=1742503118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPK2utcA9dZI7Iv+UBod/VAqR5fflzq27j4XLX2cqUQ=;
        b=XvPgRLhFghMoYtD5fj9+jLifQyQhYi+0G+LcZJxDi/sEr98rdHL1RQbxjPt3RmQMqa
         7SzBQN6INA9NnzQ7GMcRVi0+YYM/WdJPkmfWla83nkVHzlYwy7l6m+UiKsQXNRJkuRc3
         JtukB3y3SqlULdkoMi8wxiHkvF6mDjWzLnMMFWsOBRXsz3HnU5O6vIQFmhAsVqbZG3sx
         s3Uh7ZY859qfL7Kc/gsh92avGkhL4eADChuE3sOGnHe0UtmeTv3MNwPGmHFgsZuycDfc
         vOgw8C8CUtyN1cj4RGcvmV9DcJNveYmGkEsoUZjLYnG+vXlDOoyY1yXuk6MGobBLFwDG
         4n7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWU4ZJgsE9izNqg5oW8VqBDr/JWoAfp0e0YStNqlvbSnVe/DhfKupQYcdCiUjzczcmgshvrwSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+US0oNuOR596dR38CZQUngPng+ON0kIgw05YEFHkA8xtpWxAE
	DGpeulFnbaE5EHkwdtaF6+mrZ6F2MpRntqj1Ns1c8NNAYapADuM/
X-Gm-Gg: ASbGnct3hNOc9Y3k467472TZdneWfJmzZOIjIzQBRKsdh5KAFKMKW+IyRc61+6y+Clv
	DFLNN8qYw+sPHDXk/vZVaG5DO2t98rqiKoYQ2qQJ7tl7ZSmflOyqNRtJ5L4YqpUkbn88N77nIQ4
	ZoblQQlfNZmbzF7fyDKgcyARWd41hpUFFmjeUE+o08gh+a7KJo3OrMVHXwhvoDvx0nrRfwmTW+e
	MBYYDT1hGYDWgLW1nTkqya68YnyGlfeHyF65swlnf7/ECe417yMJInPyzC9s6IuWEYxAX+xbf5X
	K59tTZb8mBpdTeMub616bJ+oKFD4jqyrnqgEdyz1eHbmEubJYUNsFYPTu1hjejjxUoXbyrl0POw
	ucHYARXIB21uvBvY6rnY=
X-Google-Smtp-Source: AGHT+IH22dq+qiGMKUQnRw0V1VrtsAtsmjgvFYNzqrhTg4Y+/PQ3evjZ+lmixXO8TX3jOgG/5vhwHQ==
X-Received: by 2002:a05:6a00:b4c:b0:736:50c4:3e0f with SMTP id d2e1a72fcca58-7371f0d4cc4mr1051943b3a.10.1741898317719;
        Thu, 13 Mar 2025 13:38:37 -0700 (PDT)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7371152951bsm1852366b3a.15.2025.03.13.13.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:38:37 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: gregkh@linuxfoundation.org
Cc: pkshih@realtek.com,
	stable@vger.kernel.org,
	zenmchen@gmail.com
Subject: Re: [PATCH 6.6.y 1/2] wifi: rtw89: pci: add pre_deinit to be called
Date: Fri, 14 Mar 2025 04:38:33 +0800
Message-ID: <20250313203833.6194-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025031300-ablaze-snazzy-8996@gregkh>
References: <2025031300-ablaze-snazzy-8996@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Tue, Mar 11, 2025 at 04:10:00PM +0800, Zenm Chen wrote:
> > From: Ping-Ke Shih <pkshih@realtek.com>
> > 
> > [ Upstream commit 9e1aff437a560cd72cb6a60ee33fe162b0afdaf1 ]
> > 
> > At probe stage, we only do partial initialization to enable ability to
> > download firmware and read capabilities. After that, we use this pre_deinit
> > to disable HCI to save power.
> > 
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > Signed-off-by: Kalle Valo <kvalo@kernel.org>
> > Link: https://lore.kernel.org/r/20231110012319.12727-4-pkshih@realtek.com
> > [ Zenm: minor fix to make it apply on 6.6.y ]
> 
> That was not "minor" changes, as your diff looks like:
> 
> > Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> > ---
> >  drivers/net/wireless/realtek/rtw89/core.c | 2 ++
> >  drivers/net/wireless/realtek/rtw89/core.h | 6 ++++++
> >  drivers/net/wireless/realtek/rtw89/pci.c  | 8 ++++++++
> >  3 files changed, 16 insertions(+)
>
> But the original was:
>  drivers/net/wireless/realtek/rtw89/core.c   |    2 ++
>  drivers/net/wireless/realtek/rtw89/core.h   |    6 ++++++
>  drivers/net/wireless/realtek/rtw89/pci.c    |    2 ++
>  drivers/net/wireless/realtek/rtw89/pci.h    |   12 ++++++++++++
>  drivers/net/wireless/realtek/rtw89/pci_be.c |   18 ++++++++++++++++++
>  drivers/net/wireless/realtek/rtw89/reg.h    |    9 +++++++++
>  6 files changed, 49 insertions(+)
> 
> That is a big difference.
> 
> Please either backport the whole thing, or document exactly what you
> changed here.  Otherwise this looks like a totally new patch and we
> can't take that for obvious reasons.

Hi Greg,

Sorry about that, I will explain more clearly about the changes in v2, 
please drop this patch series, thanks!

>
> thanks,
>
> greg k-h


