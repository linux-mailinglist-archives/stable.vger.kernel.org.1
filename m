Return-Path: <stable+bounces-115118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556D3A33CDF
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 11:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB811682B5
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BBF212F9A;
	Thu, 13 Feb 2025 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="H2FNE6/8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F3211A06
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443227; cv=none; b=t3iOxHIVkzfulyXlnUZfBDwt7bhcXuWhXD5fObJkXbG1LFrpyP9Q6055GDMLaR1EL4pJhUvPeUiqB9aRJPnIEb7nTmU09O8a7goF3FitJqYG/QL/3XoM8FT0ppUbD7VRlkRF6Pdv9wWzlW5mi7HUV6jaMFWcR1Z0te5FY4AfozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443227; c=relaxed/simple;
	bh=JsVXYWKYEmqlueQ5Dmhe4uJrs2X53jk8MY1CucfezlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVrPMnQNffByItFMRCptXMnOdxyMkNAuLDvN1wEsZaD3qxqBH2sW5Hc458QbI9zoE/dg41w7nb6lY0yyncj+hSHhE//CM1lxqCLQdWzrEUutRS/zb4oCvv7LGWKOi3ARSx/nUxeaKKIZhSgT41I522Nd44kqhS1ZH77DLJLA5dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=H2FNE6/8; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c072d6199eso35922985a.1
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 02:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739443225; x=1740048025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JsVXYWKYEmqlueQ5Dmhe4uJrs2X53jk8MY1CucfezlY=;
        b=H2FNE6/8+ao5s3Rubq4Vcq1qewNccgBcXGVv55TMCMxkAFZTw4d7Yvd5p7QCp5gpx0
         xUJMSq6FbeJOXoqrxi8/rju0m8Alid17eiRU//QMtGb+yhb5pKMFvs9hQt5ADj0xOlQD
         DcdeSEpq+fdN/sI7P/8qffMT2pGAEsQ8Ij6uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739443225; x=1740048025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsVXYWKYEmqlueQ5Dmhe4uJrs2X53jk8MY1CucfezlY=;
        b=eHIy5vMrG29JGgtdc/kpkO/GbQjY03nL0grGyoxCfyVBNY9n4Zp/aAOVLUzK1ZCBg5
         1gcaxpMJZsAPcH1z2UCD7PhYUOIxERwn6UP+q6ZY04oaM8oyelXvM1tUE7/Dvn/43GAu
         Kj7JwI8JCBq/ugy5Se/xtmi872GJFEbxHNkyxNHylRQewmMKSv+weNbvj8AqyFQqAFRm
         9ScKVxg4NgLNVgfYpeaXViO8VylaGrhyvMZGpOwJ/7zXQgElwS8JsyHLR5GEHkN+tcPg
         GYwlzQUpIjthESYkbmXf+1Ck9AdsVAYv1/J2U+vdouTLQWx8ATtwDhwSoXKMjESUn3JQ
         Nptw==
X-Forwarded-Encrypted: i=1; AJvYcCULs6g9qzXwNuAgMdWIngD1bPMMEZz5tf+INA7dvjPWkDrjj/nZj+BPBf/H9f+SOmIMvItXdgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvA/Jf4SFKn6/3L7rgQavwVc9BLVlVAFYTvDexbb1epaD4+gce
	cgTRXLGuZfrltRBBpT6RpwDtwT/PuoYEvaxgrRRbo/XX8cgNoHEUQ/UV7QbIxxrhMvRUSLaoIxJ
	ICNyZsWtEMf5e1D9JjZ7p5oep5cT0Pm1dF5FWOA==
X-Gm-Gg: ASbGncunENZOLjVF570uTJ5LxCXuzXCHVS6dEgkzsWArOfxcYKZqGxARORJfnz7CvSK
	UY0KlvAH1eSx/E+QWGZIBApXqH3rjmSVWG8c08cqyWUduvwB51FXmTEzEvYyujnR/Yf5R2A==
X-Google-Smtp-Source: AGHT+IES7Wq/c8Wha7OQPciT4W4vsKg4h55hXzDfZBmTqkbm4nWumYHNj5nAJMi7S6W4FwEcaH6bfqCs+of3dBRm+AA=
X-Received: by 2002:a05:622a:1449:b0:471:c14f:5ef6 with SMTP id
 d75a77b69052e-471c14f6144mr27620461cf.17.1739443224991; Thu, 13 Feb 2025
 02:40:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211214750.1527026-1-joannelkoong@gmail.com>
In-Reply-To: <20250211214750.1527026-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Feb 2025 11:40:14 +0100
X-Gm-Features: AWEUYZnH71sCx2vS7F-ixqQY8DRlp00tM7NXt4xsKY8ZKjLN5VbJHLl2N1KwWi8
Message-ID: <CAJfpegs58oGMrjCpmYbzZ1ZLPzMXTOm86TXbdko9ndYE4F7NRQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: revert back to __readahead_folio() for readahead
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org, josef@toxicpanda.com, 
	vbabka@suse.cz, bernd.schubert@fastmail.fm, christian@heusel.eu, 
	grawity@gmail.com, willy@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 22:48, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> In 3eab9d7bc2f4 ("fuse: convert readahead to use folios"), the logic
> was converted to using the new folio readahead code, which drops the
> reference on the folio once it is locked, using an inferred reference
> on the folio. Previously we held a reference on the folio for the
> entire duration of the readpages call.

Applied to #for-next

Thanks everyone for taking care of this.

Miklos

