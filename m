Return-Path: <stable+bounces-121318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 484CCA5572D
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DCE3AE098
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40618270EBC;
	Thu,  6 Mar 2025 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtbnLkiD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AB270EC3
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290834; cv=none; b=bhGFKBr48ZQmj0u2s1ivlz1OAXFSZkfMJUi75uHUTHFBgXIcvN23NWCZ2Z3ElRsvYdnxbnRrYPHMnzujISKHVy/LOgqc9H9b138oREXgUPNpLxjued7nkJqc6NECi6CDSyHYPHYPGzVeFhTri0gAM+Wr5GRF7cWWPws1fVctT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290834; c=relaxed/simple;
	bh=dP7uQl2BMFeOM3SUdYefL8q78k3L8s5g81egtx8KBFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gk8adXt/ed1aCv6JstQhOyuJPC3XxGglq26symxGUHxJErH0nffEJ5nXQt/sov+wiW51FsYxam2mAIHtOnU0MPRvLDUfI7q73iemMCFjy+HIbwK6fokUJ4fDKptTIpdL0CX9Qa8M7GYbXZBgcdMSicneUxXvmxAw/9ICOLw8a/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtbnLkiD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741290831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dP7uQl2BMFeOM3SUdYefL8q78k3L8s5g81egtx8KBFU=;
	b=WtbnLkiDYSkazuJnwRFDiy4R3nrrqXpXNZzwj2YNZowDs15UTsvxks6ervqA6g3JDKDfwP
	qhIhJ+TEog2aWZQoBZgFJaaUT7U7dK7hc7hYEGnECKUgxjcpaNEmLAZcUuTbUhtORHVZ+4
	3wgOiOX11rs6FdtuoN7qFH08FPOdnmM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-tKhXNGDzOEKcgoc235DYXw-1; Thu, 06 Mar 2025 14:53:50 -0500
X-MC-Unique: tKhXNGDzOEKcgoc235DYXw-1
X-Mimecast-MFC-AGG-ID: tKhXNGDzOEKcgoc235DYXw_1741290829
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3910b93cb1eso573862f8f.1
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 11:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290827; x=1741895627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dP7uQl2BMFeOM3SUdYefL8q78k3L8s5g81egtx8KBFU=;
        b=Z4n6Ll0ipj0kf4XW/sBJ/HxJE0OOUT4ssCG+TAPrutfiIHNxP4xXrGlqvmpYk1keP+
         g58P+IIahAhRSMeP7OzJmCRfCFqIMkiVQeeTC/yXCmF8NysvQQVaIEH5yTBo3F9sLafA
         Oqan9/qgu3lIKcg1QBYKZEGqXGeaPpkX5w3lR/yTkofFyInZG6U/caoFWjimozR90pCz
         ExNYgt8hqJ177Sjt7fUnM8gbhMt/HjoaUKr2Zh7Hvq/VC6KOjZsGa4jlbRkcBusenawM
         E3piODY2GBMt1dFs8G+nETVvqLXyyIsydMJjVolvni7FPEmHv+wPKFRe0UURg6iE3YAm
         i9JQ==
X-Gm-Message-State: AOJu0YzAGM9Ig1aOenMdLmJZQbfeRwDymRMrxiPLF2roHmPXIGwYVZm6
	5/8vbgyvoguci2FDuKuxKFxPvEzydAlzdqJEILQi/N0c0wr9VvPJILejmFSmRj5zzf0qNWapmPc
	3hMqk/Bnx0023abac+0YHGqqMVzhlaSSKsSfmBZGtYMLhwQtMsTOeilNsMpSqe7rOwgukn7qwga
	330YX6ufpslJKXfIrySybJJy2WqD1x
X-Gm-Gg: ASbGnct0KkM20H03ljVZTNLLX677++Ob6eRRsWR3wp0YBFG1tMheIjR/SKEydtEupL2
	Q7HGqHlQ0tWCDeUxYInqyzKHlUW0WgZjrCK6edb0Pz1O+1EHk1PDrzNWj6fCatzQwZpYGqCzb
X-Received: by 2002:a05:6000:2108:b0:391:2fc9:8198 with SMTP id ffacd0b85a97d-39132d3eebamr354279f8f.16.1741290827373;
        Thu, 06 Mar 2025 11:53:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfPU4Pdu6Tv4gWNNw5J/AN9PVTSatcbgOLan8KvBWd4aqIzPFfeu2tIkm+4D+RbGidot0v53oukX1SCMfsXSQ=
X-Received: by 2002:a05:6000:2108:b0:391:2fc9:8198 with SMTP id
 ffacd0b85a97d-39132d3eebamr354271f8f.16.1741290827091; Thu, 06 Mar 2025
 11:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305144938.212918-1-pbonzini@redhat.com> <20250306113002-205fba433e36aa27@stable.kernel.org>
In-Reply-To: <20250306113002-205fba433e36aa27@stable.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Mar 2025 20:53:35 +0100
X-Gm-Features: AQ5f1JoiEcS7hx1RVIJtKWcUx1td7lodL_hGil1uhx3dINkxl8Qac4_zscD_Akw
Message-ID: <CABgObfZQ8oG2w5CysjH2_51uKBEP0inm3SnyjQDzy1xdYuDnLw@mail.gmail.com>
Subject: Re: [PATCH 6.12] KVM: e500: always restore irqs
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 8:11=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
> Build Errors:
> Patch failed to apply on stable/linux-6.12.y. Reject:

This patch applies on top of a version that actually compiles, i.e. it
assumes that you've reverted all the broken stuff that got into
6.1/6.6/6.12:

6.12
48fe216d7db6b651972c1c1d8e3180cd699971b0
833f69be62ac366b5c23b4a6434389e470dd5c7f
f2623aec7fdc2675667042c85f87502c9139c098
dec857329fb9a66a5bce4f9db14c97ef64725a32

6.6
15d60c13b704f770ba45c58477380d4577cebfa3
59e21c4613b0a46f46eb124984928df46d88ad57
ba3cf83f4a5063edb6ee150633e641954ce30478
b9d93eda1214985d1b3d00a0f9d4306282a5b189

6.1
bce6adebc9c5c4d49ea6b4fcaa56ec590b9516a6
deead14da7478b40a18cc439064c9c1a933e1b4b
d2004572fc3014cae43a0d6374ffabbbab1644d4
8b92e9cc04e71afb2be09f78af1de5492a0af4a4

Paolo


