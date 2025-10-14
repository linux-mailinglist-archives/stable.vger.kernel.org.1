Return-Path: <stable+bounces-185671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DE8BD9D31
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B8E3B30CE
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073613101CE;
	Tue, 14 Oct 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jO2zU59t"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9626A1B6
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450199; cv=none; b=AWt17k3G96exIvJNl8zwgkj5am2jZWRJ8/jYW5ax11MorpODzlMDSn8ydU5tA21gSSmJx6MCZUtsGgzElkx/oN6a12DlZhb97XeCr/YTv6D1STqqdEpGFmRPXCmE+ArFAWLr4eSZrza/nTQSfPE+BmJ7MZcsZm5NCcrwqcu2les=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450199; c=relaxed/simple;
	bh=Q4/GoNBIxcfJU4OvgQlSaRNFKEqeX55zgRostC9LIc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/4hzvGh0zElPy9Q9GT1U1Xch90oSI8Lm45SeSt5H9QGgDKR9NfOFlVZH98EMEla+vnxLqRmynH33ggtX/fHOUmStzmo1a1IIvGCDw2m0GGoG+L+EBkXOk+DXzplk1Rg3QyyhcQIDYxri2BX1Iq8BX8ZdOw8lYuuJUSsmEdZDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jO2zU59t; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2681660d604so59328595ad.0
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760450198; x=1761054998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2JBdlCNVHbh6ekaYzoo4Q2V4kVXYeSiuY6W4L0bPjk=;
        b=jO2zU59tqfHuc+A02ATtPo8yjwx7p1qrnbVxxxT6uo0AZRJrbVxudNjIZFZPqoU3nD
         cARo0HNOrY/YSSuitp+Zua8/28PZ8QS/xfVJoxBd/SdGc/dN1LX/uTTln2S3TZELMZJd
         H3Vi2J2fbFt7gi3Z4t+jYpY+/AiTLL+RVPecM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450198; x=1761054998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2JBdlCNVHbh6ekaYzoo4Q2V4kVXYeSiuY6W4L0bPjk=;
        b=TRvKf5FMKDtQtKIZaApYdOLxz77R14DZ1U+/8jf78eoK5dsncgvns8FN5DH5A2ZAUd
         lLubJWgwIeTKgBsC6OvyJsQ8BBNkHGt/Dd7rQ6mCzv667j7H0iooxVNKhQY0GSDjpCgg
         PtN98w1mA58QSzjMJ3UIPNIfkD7MhnIhk1PrUevZrxZyITkxVV9FsMZVVOFrmwCNTnIA
         UKDTpE/1lCW/YBITkEP+Y45+ixEa+zSJAUelPcYeYAEgD5Kf41I6hdhwyE4Zlo4b3Ag4
         4AzQaignwCWXBe4WVkSLgL6Lirtp8eMk2Szkwlv+7c5jYd+YWuHz8cjRlgKOJpMEManq
         2CNw==
X-Forwarded-Encrypted: i=1; AJvYcCVIyHFHbmvUWJ2VtHTxQGWtpBgO+WSQAizHq/Ec0ifDiKRVeE+LYJigmgASeGIZQOAk0Qw1+9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCjkHKVnrDKoX0PNHs5GFpkFksJ38KMTr92KxgFGS/91LBrujA
	pd9ipssMg3y4li4jb16j7zR1lhRXNLdg35LOk07r8a4G/0IzzQRbcRP9K7Np7GIesA==
X-Gm-Gg: ASbGncutYyRqyXT0sy6C9ARLYb1J3ZRXKuSoTDpfSrWoZx5JSaMNRtRXH+UlCi8kdDo
	LFKTc3d1NW8mcHSD5ATcLk4frmCFq99fbez0wzsavBOjBbTzPAcK+HV5Wx9hJTb+4TcvzQt5T0/
	ZHjJizyp3y85/2KkIAwrwGoaBFHlMrb58gg5ycC4SeiZ0dZdf5wUsIZmwYOEj88LeHdjLuf0P9e
	3ihcIiGlpk+P5ZhIK67WUIpkOGUiA2DSUcJdJxGfoQGhV8TsOVmkT/0LJ6GAsCBPY+iMb+sXg66
	ZB4iYfI2Kkprmk3qgk7SmnLcKe4NFuA54QvEzP0ZUDuyr/0Aj+Cm3qKUuhLG2sEeHYjcacckyI3
	s0uXyxYVfsflboFOXCc7rFsHM21Wc4WkAuId2bb1PLd1Njwj2axkOBw==
X-Google-Smtp-Source: AGHT+IFom6gnN5okXgH4ljiWIYO99mKWEOVLNkApX62i3COUI3Ge2cjYBTcSk6VjeaaXYz+cDhldKg==
X-Received: by 2002:a17:903:1b4b:b0:271:479d:3dcb with SMTP id d9443c01a7336-29027213537mr324664955ad.6.1760450197603;
        Tue, 14 Oct 2025 06:56:37 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de658bsm166127145ad.22.2025.10.14.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:56:37 -0700 (PDT)
Date: Tue, 14 Oct 2025 22:56:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, 
	stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <ns2dglxkdqiidj445xal2w4onk56njkzllgoads377oaix7wuh@afvq7yinhpl7>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>

On (25/10/14 15:47), Rafael J. Wysocki wrote:
> On Tue, Oct 14, 2025 at 12:23 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > > Any details would be much appreciated.
> > > How do the idle state usages differ with and without
> > > "cpuidle: menu: Avoid discarding useful information"?
> > > What do the idle states look like in your platform?
> >
> > Sure, I can run tests.
> 
> Would it be possible to check if the mainline has this issue?  That
> is, compare the benchmark results on unmodified 6.17 (say) and on 6.17
> with commit 85975daeaa4 reverted?

I don't think mainline kernel can run on those devices (due to
a bunch of downstream patches).  Best bet is 6.12, I guess.

