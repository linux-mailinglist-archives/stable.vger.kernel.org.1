Return-Path: <stable+bounces-88134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23169AFCCF
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 10:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7D91C21359
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF301D2B0C;
	Fri, 25 Oct 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQKFRDA2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0A1D2234
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845745; cv=none; b=XHBF8au55ReTc6mdQDcWm/TnFojlgExGQ7CwE17RcAiCPnJ6xzs9EyoTZ2UNIAkXeHlh6QtL4JA+PRHBc5ZiEIH7rPD2dsGI/uStGSycowAHLkBS74MygI216w3FU1yvrb97psF9NE8nXpMqPY6wbODw5eU7dnOlwFK5ecr3z6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845745; c=relaxed/simple;
	bh=fa6jPLAUyoylgiVXw+EMDWO7dRDSrn4n1a/XLj2kxcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5eNMhrWOrpB92zS3vIRtqmy7Fq+cyOexkgcll/kcDDgKaTKRQNddAyaQLC542pacTbd4fTw6G21k/6QfnoIwSgJt2TxzKTArMIxPCvkZLXCZ+Kk4xwJHXFY38iK/mEQCUcLqszrzWFAZMVUODdKButU7ZkTDkQ5GCAIeTOH5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQKFRDA2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729845742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fa6jPLAUyoylgiVXw+EMDWO7dRDSrn4n1a/XLj2kxcs=;
	b=TQKFRDA2U8HSOKIYP8+GqsID/gG5oUulW6gJvxXTiWjgamHAQwusVc/HalziEvC4rfTFNv
	LTOjIRlQI2AAaxrml7dGS5o/AtQw79656BE1IZMMPmeQdrH+FGFYzcRIyJcIdgT1LDAFEx
	zu1atF0qjV35rNJHKNuZGpF289YrHGc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-NlGdxLhqNhaFEK8xBh6l0Q-1; Fri, 25 Oct 2024 04:42:20 -0400
X-MC-Unique: NlGdxLhqNhaFEK8xBh6l0Q-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7202dfaa53fso2687514b3a.0
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 01:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845739; x=1730450539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa6jPLAUyoylgiVXw+EMDWO7dRDSrn4n1a/XLj2kxcs=;
        b=qc06PyAvaZKK5qlnlr19n7jkFfTqUYwBpqZ1beWAAet+g2RK01M/WwRyglF9tppGbd
         UyBXKMJpw7ww9hr0vxAyUphhVRxLQ4TcbbTjUETavQ5PB4pD7oh3VNzqMOxlZc16s+mH
         k2h6zlEkvvTjairovDVPtqcvVLrRUBfQqXnmgKTNPMnLj/xGF8mtqbAx/vdaCTeYWYRy
         grO3ouyN6/QwtTacs7o+LW4L9hJUiZTt9a0g/ywEyOkOVpWyBPi9EkQ0FSijW2X6X9DW
         PZ5cusUaf3p70M9uKdkLBXErf8Y/iiX+JSbjATJPCYvJyOq/GxIxjIjh+9Ub/HQ4irZW
         w6AA==
X-Forwarded-Encrypted: i=1; AJvYcCUewSMdJg9BE3P5nxid/SRLolDalWFT5QwjPkt17wRs+lBbVBBlRycFzH4LtAcR+bRTNS2BxKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTOpc+YLrtNhn8mtgHMHbj6Sbvx45TP9To7KXmg4Z5p0lxjUIY
	F/z/tT3TLb7YCWYuao4Vr7TtjCI2OFiDdpyhJyG6FqDFlzPP2GUoNVPWnggniCRCjXuSHUbzgWZ
	UdKzqtKHH668oAoWhKzIi+thw7uu6kmhK47wwUkd1yz7W+QqY4ymUNnZpKHKnhqS3/iqixP/LHF
	U+i1y4cOLzRUbXyqfOpLzYARq9HozH
X-Received: by 2002:a05:6a00:2d25:b0:71e:6a99:472f with SMTP id d2e1a72fcca58-72030b992eemr10914882b3a.24.1729845739465;
        Fri, 25 Oct 2024 01:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyONlkxsszC6bt2HwLRo0KgqsF5/esIacDeqECLFtgNld+V9hMbY+nI2xXS/5AUrgS8dzn+R2BzN6meo0fD9c=
X-Received: by 2002:a05:6a00:2d25:b0:71e:6a99:472f with SMTP id
 d2e1a72fcca58-72030b992eemr10914845b3a.24.1729845738965; Fri, 25 Oct 2024
 01:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021134040.975221-1-dtatulea@nvidia.com> <20241021134040.975221-2-dtatulea@nvidia.com>
In-Reply-To: <20241021134040.975221-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Oct 2024 16:42:07 +0800
Message-ID: <CACGkMEsmp3q=TQr7qUhdqtAw4ALLXYagn=BKZegks-=CAsF_XQ@mail.gmail.com>
Subject: Re: [PATCH vhost 1/2] vdpa/mlx5: Fix PA offset with unaligned
 starting iotlb map
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:41=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> From: Si-Wei Liu <si-wei.liu@oracle.com>
>
> When calculating the physical address range based on the iotlb and mr
> [start,end) ranges, the offset of mr->start relative to map->start
> is not taken into account. This leads to some incorrect and duplicate
> mappings.
>
> For the case when mr->start < map->start the code is already correct:
> the range in [mr->start, map->start) was handled by a different
> iteration.
>
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


