Return-Path: <stable+bounces-56083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F391C510
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 19:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0BC1C21A90
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 17:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41A31C9ECF;
	Fri, 28 Jun 2024 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqHwdn6c"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26AD1B94F
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596421; cv=none; b=S6n3T/5GzO0gJ+bAxzQ9Nub8sk2GeVMWlARmaMzzIivE/FQMw+y+8iwaNez5X9Lg2JG3uiNKGDqIs4ZHpgC7Tz/vWxtRUK33lcoD89f2hIvMkInEEW/ucH838otthdfcaVxkA+AJfroNGtRWFiLEz2MIgYPU5SpwSUGkCp6mar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596421; c=relaxed/simple;
	bh=SP48UMwRjN/EBU8LVvAPVSE3bd+HHCSeXFaARhB6zhU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cRW38f1su2XyAqLSHJVWH7Ytvktl/vaXiyIIrqvsXiwavhAhGlg+PW3iaz6h/87ZOX/oHd9DBPg9QjRyqungZBemUeHlv+2ck7mcH4qvrsFD0GbgdokgavQ803m9TGCaeBy4fKDTip0hLOQUZmm82eF+jpWxEW3R/AwqrU8M1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZqHwdn6c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719596418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SP48UMwRjN/EBU8LVvAPVSE3bd+HHCSeXFaARhB6zhU=;
	b=ZqHwdn6crHI3hzAtarCMqPh0blHFCeTa1zrEqjPhiipLrubhxsF84v2xQpn2WfbkmEA/07
	kisPycAZEnBxZKnuGh1v4GYPJMUuV0vsc3SnZmUIPD94E8UbYJ4gRNM/cqcqBIdL0WgBTT
	pLXSiqxytI9WKJgBI66J2T9clXGBQsk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-dJSTBVW8Mt-1p85tmQhguA-1; Fri, 28 Jun 2024 13:40:17 -0400
X-MC-Unique: dJSTBVW8Mt-1p85tmQhguA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44502b8579cso14548491cf.2
        for <stable@vger.kernel.org>; Fri, 28 Jun 2024 10:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719596416; x=1720201216;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SP48UMwRjN/EBU8LVvAPVSE3bd+HHCSeXFaARhB6zhU=;
        b=sAbw68bqMOLEd/AZQGWf0lofu2sIayERlB+lK8HBUS022mTB2l4sqMpeeNNpyOKuvV
         Znm8a52VN1arjVRLiKUuIXBT9T2YpuAa8qiuoV8EFQ1Yh7J1QDYhQjXw9uxJK9G1YSIq
         UGlXb5XWPN/LSi3vr9dbU68o/+7OSNDeyAw2GNfQlHxnsVDAiGuqZgpqRkTtcP/3p4kp
         36nHmvmld4YeFZH5g23GvQIw7Gidbrl4iCH1iNR+L5+DCIr4G3Mn2bANUNoa4NUQKBKb
         kSq4no1e1hlPhSH8FVeNBrJfXCSXon3CksbIHb8UwVzVGlarA9I1pHHd4skiK4yrzDCH
         CUpA==
X-Forwarded-Encrypted: i=1; AJvYcCUnt4olEld7jSsViN7YDp+uJy7LvL5eEAHzCRTi9qYTTDo2vDG4OF6EanIHyBlUhkfj7NhC+hFTrRYyqYQp+SLIYEx6hgf8
X-Gm-Message-State: AOJu0Yy68B+kCb7QGfdhxif9vb8h0DRvETOrFA1dJMgUAgOeTtSghmNJ
	1UrgLwg1AYkfkKJ1hWc8X5PwHOFMnqvswKljmurpx+I01z6GUkjN3vouZox39pRTXeLg2AvDc4R
	QZRD3bUWieuhnGo7wIwMAZxtsKGhsMFnsl+TO/4eojZIpMEJuubCViQ==
X-Received: by 2002:a05:622a:1aa1:b0:446:4749:88aa with SMTP id d75a77b69052e-4464749894emr59113091cf.32.1719596416665;
        Fri, 28 Jun 2024 10:40:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlk4mMP1ndQUm6VugscFP6Lg5KMqYcxhuueZsOuz4e2OVo+yEy7Ux31iC4UszjGEQFeRcEbQ==
X-Received: by 2002:a05:622a:1aa1:b0:446:4749:88aa with SMTP id d75a77b69052e-4464749894emr59112891cf.32.1719596416334;
        Fri, 28 Jun 2024 10:40:16 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44651498178sm8840761cf.60.2024.06.28.10.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 10:40:15 -0700 (PDT)
Message-ID: <9004911c3b8c44afecb354db736f4d7d84c0cf19.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/dp_mst: Skip CSN if topology probing is not
 done yet
From: Lyude Paul <lyude@redhat.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
	 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	 <dri-devel@lists.freedesktop.org>
Cc: "jani.nikula@intel.com" <jani.nikula@intel.com>, "imre.deak@intel.com"
 <imre.deak@intel.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Date: Fri, 28 Jun 2024 13:40:14 -0400
In-Reply-To: <CO6PR12MB5489CB4E5CFB71CF8E812BEEFCD72@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20240626084825.878565-1-Wayne.Lin@amd.com>
	 <20240626084825.878565-3-Wayne.Lin@amd.com>
	 <7da3ccf156a858c1a7d2691fbedfa7aa2ceccdf7.camel@redhat.com>
	 <CO6PR12MB5489CB4E5CFB71CF8E812BEEFCD72@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-27 at 09:04 +0000, Lin, Wayne wrote:
>=20
> I understand your concern. My patch will just check whether mst
> manager starts
> the probing process or not by confirming whether we sent LINK_ADDRESS
> to
> the 1st mst branch already. It will drop the CSN event only when the
> event comes
> earlier than the probing. The CSN events occur during topology
> probing should
> still have chance to be handled after probing process release the
> mgr->probe_lock
> I think. Does this make sense to you please? Thanks!

Yeah - that seems like the perfect solution :), sounds good to me

>=20
> > > =C2=A0=C2=A0=C2=A0 } else if (up_req->msg.req_type =3D=3D
> > > DP_RESOURCE_STATUS_NOTIFY) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst struct drm_dp_resource_status_notify *res_stat
> > > =3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &up_req->msg.u.resource_stat;
> >=20
> > --
> > Cheers,
> > =C2=A0Lyude Paul (she/her)
> > =C2=A0Software Engineer at Red Hat
>=20
> --
> Regards,
> Wayne Lin
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


