Return-Path: <stable+bounces-145916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9DCABFB9A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D03F9E74A0
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E78122DF8F;
	Wed, 21 May 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjakcZ/a"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A08622D4D9
	for <stable@vger.kernel.org>; Wed, 21 May 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846201; cv=none; b=RYtO/ilD3aRGM3gitHcEB9D52wJeFQMbtdt5L6jt0Lppc8x6ht8+tskqc5jEhr52B3ztYOQXIumE3lKOZKx1hI2HVWFiWJmbNvMEitZErO7LALyW86wE32yi4HGLCQUJa7UeWXoFpy+7/vF/5m9IXcfgxuXFu7rZ6PLix6SQnAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846201; c=relaxed/simple;
	bh=1dJoHE8GeNtckzx9RFaomoN/xQ5MjUgsn5hhVqqprxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unbnm9kqghsr8PJTa364WFEZ2lu+WcJMKO1xA5XAdao6bO3fhU+ZtRy8beV+F0pa0m3x2rbZp6C518by30PFg+G3ROrQjjSSFwMrMhyET6HZ3EvDKEQ+YK27O8Y+VspdO+mJLA1fNgihSMUtZI5E4EGrxqTLN50vcOA2n7Omm6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjakcZ/a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747846198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqZFNdbupL0eCdCzdn3FtVLd/tCfrZa6LajhRpntDkI=;
	b=MjakcZ/a6RwcYrcawlzN+tGolKkBNLnRNB4RWphj+E5pchh/Lmp0qkIulorjqcSxmgzdQN
	ekBWFRNdaqm8Ab10kczGsg1H7SmAEWaOWuMoP00OGWn5sewyoWAvDmabS87nChda17Ww6x
	+YbjrKcAUPThOSMNR0QLsx0Jukt55h0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-rpiQsBLpMnCaiuPbuzDKPw-1; Wed, 21 May 2025 12:49:56 -0400
X-MC-Unique: rpiQsBLpMnCaiuPbuzDKPw-1
X-Mimecast-MFC-AGG-ID: rpiQsBLpMnCaiuPbuzDKPw_1747846196
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442ffaa7dbeso20824605e9.3
        for <stable@vger.kernel.org>; Wed, 21 May 2025 09:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846196; x=1748450996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqZFNdbupL0eCdCzdn3FtVLd/tCfrZa6LajhRpntDkI=;
        b=txFLeLtFYxl7PGVQYUDKdsTfryQ1PqJTCl79K5utF5vSAvCF/0bBAWBtydCsk9UhB0
         4u55CXhj36MLBhXMoaxaM6QPVmMgWNqHmpfoSHdLgbkLKk9WQQnEFM1OA6016oYhwNHl
         tOfh0YzCVVo2mqb95eDXbmYFmIwnJZCL3qcZBDuOavia8rAFrrsUQpy+wpN0ob4PxBfz
         Ydw6E5B3nkZa/uxX3ScBoj25d7MOeqHAcFrO7768tMCvAbDHXLBmnqXoy2M4xkptZY8I
         978OkKhW7XpPjGMYUvvHJv6kENV97I/eNfJG7lpGALL5eaBKNO/wkhO+D0nTJ2ywtRJv
         gJVg==
X-Forwarded-Encrypted: i=1; AJvYcCXYDmPb4dcPb3/GmixlPYdnmF9Gsxan301MMc9q4IWmPZSVGJIlFctO8iyMloiFcVbOqEaWCg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaT1KcBG3w+IU1uglkK6DrpVq3lMydLrNj0CFjrn5ZZyVCiTkP
	CxayYGfu6MzwZMEWjw/EdA26MzNCVdE70nJIozSAWVSYeV6dS5ZTT9nHRoFQDWsBCBwibl04Rc/
	Vtxnl0Y46bk8+XOdiIVivaH9hOFSvIOCGNot2UH20wF+fB97jcG3v2omoOQ==
X-Gm-Gg: ASbGncvvFJy6cAP+C0dIouXgY6DcDwpKVpNM5t5eYEJkrhtjHbHGbfCmnZTbAfSAhWA
	SenLamGbhzBA5tuPWXvlWLG7R2kOYlB7VPgNd6wYVQl9QL4HRDCJaFGQla4O1t4oW17XoVKwVz3
	RreoufM37a6TvNwOyC2ME9Og08CPY/AVQKryEiq1V8cQaX0Zypotw77syudaI9IbsMczi8TEzom
	eJ8W8HD0vXlDA08PX7fYn64Gv9LpMeu6HJJAfXJSkR9yRPBKdFrOBuRtnApsBmhVoURhAhwIxoi
	+KWe/Q==
X-Received: by 2002:a05:600c:5493:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-442fd618f0dmr252334655e9.10.1747846195662;
        Wed, 21 May 2025 09:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOuXLutdPh0G1kKuu4RDEal4trFfwrT0Z7nnw08VTOi+Znj4RUK/v5fHXWo8/k4A36IsxuQQ==
X-Received: by 2002:a05:600c:5493:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-442fd618f0dmr252334255e9.10.1747846195270;
        Wed, 21 May 2025 09:49:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7ca2de7sm74037525e9.35.2025.05.21.09.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:49:54 -0700 (PDT)
Date: Wed, 21 May 2025 12:49:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250521124926-mutt-send-email-mst@kernel.org>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521051556-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A306A9A8CFE8FFC1B033DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521061236-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A01F9B43B25B19A64770DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521063626-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195200C1F5D877448DF1D3BDC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195200C1F5D877448DF1D3BDC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, May 21, 2025 at 12:40:10PM +0000, Parav Pandit wrote:
> > You can include this in the series if you like. Tweak to taste:
> > 
> Thanks for the patch. This virtio core comment update can be done at later point without fixes tag.
> Will park for the later.

no problem with that, either.


