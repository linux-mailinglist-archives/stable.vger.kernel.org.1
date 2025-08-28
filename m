Return-Path: <stable+bounces-176639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2519B3A6BE
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1582F18951E6
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075B32BF20;
	Thu, 28 Aug 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1d5MnBF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C132A3CF
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399476; cv=none; b=NlQXOYOS/3z8rihBhc3PIrQm+stJMTDCzxEveXrmjJ3Zs1sIH1Lwe85xDpTMQ/K4Lpda4qAa+6wgasI1g0KprdFA1R1hRRnfhd0TZaeW50pITsGGtuEf6NM3mSK0v7Ohy8OvqtkLrrU1/ouyF46BvTl4yIRiEcBuBLPXJmZ9kJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399476; c=relaxed/simple;
	bh=16g9F5woniiXrhsLLuxG1053++5xXv7LjCWoyLqXmvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUscNKMF37iYn3t4vBFX92pIQhQEEnjFLk9It3lYyjRIvpEnQbY48DeKQ8hT+0S0YGtPCa8025TovBdd7ffOYyX2LPvwGIzz0yxWJw7s7F9pT12mvBFZ4wsc7GmR1p0CKCakRCZ/4eHxTtPGPZdqcZa3W6ODXXNuZ6Tf9mh+TLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1d5MnBF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756399473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16g9F5woniiXrhsLLuxG1053++5xXv7LjCWoyLqXmvA=;
	b=J1d5MnBFDJMwq2tBjjJyR7sKyY9Nzy9d8T91zDBH/irkmCetXUfNzZJamBQtq/kIhG/6U5
	/6AaDJQbvxDJvMZD4MqkHP83jQ4bVseHnY2BziiZ3F0GjELNFBOtsYUhQwQYJcVNfb1fjb
	+HbHXY/QElOG13SRnKGMPxIFA5FelLk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-eYTYd1e3OmKa_wmeWuFM3A-1; Thu, 28 Aug 2025 12:44:31 -0400
X-MC-Unique: eYTYd1e3OmKa_wmeWuFM3A-1
X-Mimecast-MFC-AGG-ID: eYTYd1e3OmKa_wmeWuFM3A_1756399471
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b7a0d1a71so7118655e9.2
        for <stable@vger.kernel.org>; Thu, 28 Aug 2025 09:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756399470; x=1757004270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16g9F5woniiXrhsLLuxG1053++5xXv7LjCWoyLqXmvA=;
        b=D6v5LpAYRxfwYJJnRdkzZ9TcURCgVV3gZMnBfqmsvQ16uZsOgbmMwME3c0GCnpApkV
         FOZqWiTEqbpzIkikDTRD4phfRdGKV7aQl/88VC/10Ka5/QRvQi4gQ0V4FVBvFe22QGml
         z9ZOOKDRnLt++DRkEtH65qv5IbeE+9DpuhNp0f/a36kC5vZeNEROrKMc3bE6Pq1KAUEt
         8F7T7gvVFx5JMp6NhiqlEUuA7zmSch6UIdVckidBCqUIkUaNZElLQ2fcUBho7n7ZyJBa
         PtHVCyBnqUgQlRFmetpbdW14Bf0qUZCajUpsKus7/rdL3lSrePjEGQ3k56XuJ0pd87TZ
         bCXw==
X-Forwarded-Encrypted: i=1; AJvYcCXUn32M2tuHA0QEe0/hV8h+VsVX5VNGMFTS/6hN0ZIGCoiXJyPq2lJCkc2JAuccFrcfw1W4OqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0yXeaGRKgfVW2zf/Si81S6K+4HfVz8n+h3mIVQ30OMVfCzQoI
	7uWkAfse8uEaxClD68UB7uwGlBcFvn7uKwD8/rE8LuhJW4Vo2qYDX0+53rBmWXLIFBRlTaLOBU+
	zyE/M+O8qXu9QTR5kxkxtOwBqHGDPUqzZ0wWAYg/FRD3SNPtZUa6xE0e3CHrvSf2xf4DFrhW4Jd
	OxXYkTdgNxVyhtymialKZlZFvJX2vH3jnF
X-Gm-Gg: ASbGncsBgB2bGdeR4eXkiQPVaCeQzJU25gVH932qOvi6r0J1bQbhum5pGs/piBEbam9
	cEKA7Kwc3q2p8wWBSGx/VJUcT9z2Go70w6Ib2TD7iWVIZAPqpzeWgbIE8Ddyxh1H6O1yIHlotqJ
	n6mS7PMwqrQXYlXAkFfpsEt/b48PgHqBlt4IGZYzXy++GBoiB+1BCItJWuwwsD3L190+hLHG9fu
	whcboqt5ooz3G7EGAumSmH0
X-Received: by 2002:a05:600c:4715:b0:456:302:6dc3 with SMTP id 5b1f17b1804b1-45b517d4c47mr197984305e9.26.1756399470543;
        Thu, 28 Aug 2025 09:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOQ697WbVXyU99n0waspLzqYpTQQBImj5MyrGfz7lwIURmhpghnGB5Sbe7cWt+MuicJOIRjj3b26keLzpmBNo=
X-Received: by 2002:a05:600c:4715:b0:456:302:6dc3 with SMTP id
 5b1f17b1804b1-45b517d4c47mr197983995e9.26.1756399470139; Thu, 28 Aug 2025
 09:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827152754.12481-1-lifei.shirley@bytedance.com>
 <aK8r11trXDjBnRON@google.com> <CABgObfYqVTK3uB00pAyZAdX=Vx1Xx_M0MOwUzm+D1C04mrVfig@mail.gmail.com>
 <f904b674-98ba-4e13-a64c-fd30b6ac4a2e@bytedance.com>
In-Reply-To: <f904b674-98ba-4e13-a64c-fd30b6ac4a2e@bytedance.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Aug 2025 18:44:18 +0200
X-Gm-Features: Ac12FXxy8RFR1sySn2cIpHgzn1YV9jdcFkuTVaa1o9x9iu2acXvfPgiJQStuG6A
Message-ID: <CABgObfb4ocYcaZixoPD_VZL5Z_SieTGJW3GBCFB-_LuOH5Ut2g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] KVM: x86: Latch INITs only in specific CPU
 states in KVM_SET_VCPU_EVENTS
To: Fei Li <lifei.shirley@bytedance.com>
Cc: Sean Christopherson <seanjc@google.com>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, liran.alon@oracle.com, hpa@zytor.com, 
	wanpeng.li@hotmail.com, kvm@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 5:13=E2=80=AFPM Fei Li <lifei.shirley@bytedance.com=
> wrote:
> Actually this is a bug triggered by one monitor tool in our production
> environment. This monitor executes 'info registers -a' hmp at a fixed
> frequency, even during VM startup process, which makes some AP stay in
> KVM_MP_STATE_UNINITIALIZED forever. But this race only occurs with
> extremely low probability, about 1~2 VM hangs per week.
>
> Considering other emulators, like cloud-hypervisor and firecracker maybe
> also have similar potential race issues, I think KVM had better do some
> handling. But anyway, I will check Qemu code to avoid such race. Thanks
> for both of your comments. =F0=9F=99=82

If you can check whether other emulators invoke KVM_SET_VCPU_EVENTS in
similar cases, that of course would help understanding the situation
better.

In QEMU, it is possible to delay KVM_GET_VCPU_EVENTS until after all
vCPUs have halted.

Paolo


