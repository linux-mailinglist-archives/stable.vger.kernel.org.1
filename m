Return-Path: <stable+bounces-206383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1CAD047D9
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63D343078127
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825F72877CF;
	Thu,  8 Jan 2026 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Abg6ZQXg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmWeMjhn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177C23C8A0
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889609; cv=none; b=Po0V7zC++iF/klALKhFWIc1yO0xr36S5pvXfLqxZ0uz9g9a6HT12JMfac94dT7iJqH8cbkXpOWVzAyCpNu05GYxEzPyY4KTn/qs+nHpESPc1okJJCCnnlHz9lbaKJcurj/JN1p1+fdd35yL7FwZyMJw4kvGMvIZMAgwWn3rubq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889609; c=relaxed/simple;
	bh=TcDnE5qvaDc3YSS7vXonKFmEf+Fri5utJK1HO3xaxFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCwR2TjaltT7QA0cDmu67QNFZ5S91h2ul51e4oPgyWC47V/z4GZiZ/Xfr+Nc41VUQ35o6tPu/GZlBxIDwU+D1N8tJXtsj6KItIHWEeNsYQr7C+pDtNPkIbUHvVEQLE8mvxBUx9Bvt4F7WTmGxKX6ps3/uot2OzK2Zo7xsc4fWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Abg6ZQXg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmWeMjhn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767889606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcISVsCJgyrXQOFSAZiH/0oamlEfajFIB58IcXKXFQo=;
	b=Abg6ZQXgFpICkp7ZATPYt5MMWPETSNdQ7taML79YjY/xv+YpQqO5BY+RyoguCbjZcNpRxW
	r3CyqeVIycbDckaHWPYtkeXIvHZct9ov75HngWWC9ZFjGrhXk4AH7j4UikMG/oXonb5KFR
	krvVdVN3zjpTN0h+zZxtSyUPnvesP1Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-uetzXnnINEyLrW8m_OqIrw-1; Thu, 08 Jan 2026 11:26:45 -0500
X-MC-Unique: uetzXnnINEyLrW8m_OqIrw-1
X-Mimecast-MFC-AGG-ID: uetzXnnINEyLrW8m_OqIrw_1767889605
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4325ddc5babso1706254f8f.0
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 08:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767889604; x=1768494404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcISVsCJgyrXQOFSAZiH/0oamlEfajFIB58IcXKXFQo=;
        b=PmWeMjhnjyTBU01NHVxEyUs7TY1305x5LstSlY1z9qeEhEYXblRA1R+aDONe0tjqA3
         ca4ECDWT3k5OYiQIubtIoPcjBUaH053BKDGjaV6te+D8gERn7M07wXy6iqY1Bl0KBsuQ
         Z5y62IrX1+RwyBo+ruEUNBztTdVNd8DuFVyKVYej2JILISlGw4dbualomUgA5Fd/3XoO
         5H4mFyq2RVvAgNi1EYj2+0mRTWe+QIj1vNKsVNghJQcHai4revLVXkYWNEfcXJAptYO6
         WwyPCBdToKWY2b0znbMv/kSVRGptc4xemIHtnWsFVfkvYgAjJhgM89PiGG1NKze4k67X
         ohEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767889604; x=1768494404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KcISVsCJgyrXQOFSAZiH/0oamlEfajFIB58IcXKXFQo=;
        b=aGhtgqHgNSF59BdwIx0d4/Jmfppvu3PP6yZdd4xa8gq8/2HSLxZ5h+Ggb2TxJktD6Q
         He/QG2Ol3AziiR1oA/LBVMONLvZClv/eZmgjJhNJgLn5AAKbN+PQwD1LZdW31tFFGlIC
         0tf1fzoH4OeVvCmfTynWfV93Liujg/W92eeVRtwuLa6D50m80u62Ph37Gg0/KxFCvTZ/
         EWQXP1MeGqCxvFHbIA1/6SoxmVtFrU44XLWPlcXQpie/GtgsdFlOiIQwW47+zpLEHD05
         ZpSXb5ps8PwMdiXwQM5T3/yGySlMVw2kQsvzax3A7cT0jBJoDKcFOvBQV7fHFWgO/FCn
         4C7w==
X-Forwarded-Encrypted: i=1; AJvYcCVfR2uSEVR8HR2OXTw2okdgsdloMyHJk/ZPREULPtwEwdFSdWNpju+O07t8JwZjLrSoGguksN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTdLT7FrgaKYK2aoUkUIw7PuQ0vb1TKlBWD0yPy1OvU0S24ksS
	EpZEgF1Pz9H7wcyXcVyoQhI14hac8FckOAWiAWhQxwKHVqmMny3b6SYcGye35z+kmJt5lcb2kvo
	VYozNUX+P7eDKeUCV5yauC131It9sAI3Of4OaNDSOl6u02HxrT+jQdcH/HArdh4MRBYlREP2hHH
	KxNkWgXFVcZizzT1aq92amw0QArVaXxTww
X-Gm-Gg: AY/fxX6V04nsLdAkloA//gc/rOC4SUNDTdTE8iSS25FPwFnZ9fueaZ1bNSRuFpBIS9/
	4f2IA2cAUjkJ9eSwYN+umW/tONVy96Mc69MWcUH9pnuv6fDAfg7d9iOTve73nyCvPdFXWRHv10R
	4xkil5oQyWfwPKgpxMQT/LXrk9kounBN7+CKEnpwrfXIQ1GuxZ7QyywZDFNObk1+wjmHqAb4X3E
	L6YQM1gOcwzMbdtBcJ116zMp+TboD2S24xdPEbNqZDjt/Iqqa2zlBDxvTx90MM5+54N
X-Received: by 2002:a05:6000:2882:b0:42b:55a1:214c with SMTP id ffacd0b85a97d-432c37c1462mr7264863f8f.55.1767889604582;
        Thu, 08 Jan 2026 08:26:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuEIeET8h3W6uEZxJBwbbw9fxFbSf3TPfGzC3PFihaqUtx/tV5O/OFOh8GEgcfVZ0sjWATbOyzNazfJK/JcCI=
X-Received: by 2002:a05:6000:2882:b0:42b:55a1:214c with SMTP id
 ffacd0b85a97d-432c37c1462mr7264842f8f.55.1767889604137; Thu, 08 Jan 2026
 08:26:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101090516.316883-1-pbonzini@redhat.com> <20260101090516.316883-2-pbonzini@redhat.com>
 <959b98b1-fbc4-4515-bc7c-8c146c6c8529@linux.intel.com>
In-Reply-To: <959b98b1-fbc4-4515-bc7c-8c146c6c8529@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 8 Jan 2026 17:26:32 +0100
X-Gm-Features: AQt7F2pBdzRwiZhc6SZz6ZRtf4UB-NlFDQw5YKdy9WxEii3ry597CDwoHXRvJj4
Message-ID: <CABgObfbtdSnzRCsiDHgjnT5OTROMOEgWZL+AMOSFj2+hXOsATw@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/fpu: Clear XSTATE_BV[i] in save state whenever XFD[i]=1
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com, 
	x86@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 4:08=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.com=
> wrote:
> > +     /*
> > +      * KVM's guest ABI is that setting XFD[i]=3D1 *can* immediately r=
evert
> > +      * the save state to initialized.  Likewise, KVM_GET_XSAVE does t=
he
>
> Nit:
> To me "initialized" has the implication that it's active.
> I prefer the description "initial state" or "initial configuration" used =
in
> SDM here.
> I am not a native English speaker though, please ignore it if it's just m=
y
> feeling.

Sure, why not:

   KVM's guest ABI is that setting XFD[i]=3D1 *can* immediately revert the
   save state to its initial configuration.  Likewise, KVM_GET_XSAVE does
   the same as XSAVE and returns XSTATE_BV[i]=3D0 whenever XFD[i]=3D1.

> > +     /*
> > +      * Do not reject non-initialized disabled features for backwards
> > +      * compatibility, but clear XSTATE_BV[i] whenever XFD[i]=3D1.
> > +      * Otherwise, XRSTOR would cause a #NM.
> > +      */

Same here:

   For backwards compatibility, do not expect disabled features to be in
   their initial state.  XSTATE_BV[i] must still be cleared whenever
   XFD[i]=3D1, or XRSTOR would cause a #NM.

Thanks!

Paolo


