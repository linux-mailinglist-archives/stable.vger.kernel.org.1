Return-Path: <stable+bounces-224724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBWpCXWesWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:55:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD91B267984
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72A0B302D521
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8D63E2766;
	Wed, 11 Mar 2026 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNAUMuqy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5psMziM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5203E1236
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248032; cv=pass; b=atVc8u46nh3lOwKOk5yKo3u0a/TaMll7sbWf/Vc/T18sphwrWtzbEsaxT0oSLfalckDmUNtAvmCSDZYPxV4mlSLU8WrBEIMYV1bedbMrnSYkp/YG7g5YutPYqOP01eCznSl1Im7M5Gk66AmaGBAgm43Xf7mu7sMfNpL4aqiSe20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248032; c=relaxed/simple;
	bh=VvpqnR3wUSSH16tTVi6dlcFDyUG5FgFSGstFAfteAKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcQil3gOzVj91Xy0hxnQ0bsF1mC8ek5iOSglos03b7WMtx5OwiexBePf46nESgDUCegKDhJR8wJ89Hc95YjDW44yYKPoadmTGiNSh4QNyPDPK8TzPux7m3JwE99sOpygs5fMhtWoqDmBF+jB3pdokQrkbF3YyMazmCaJPV0mVKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNAUMuqy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5psMziM; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773248030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W6ouqFOpofiRNlkZSgBBuN2FHJVkzx00Pt6fyeGhUD8=;
	b=VNAUMuqykAN6mKkdhUQZrzLi7e4+7e8juURrcAJJgdCMmxjiaxkzqcfXpvoHlzTQ9kHs5B
	WLVLP0kDM0yFx4kCy9i7AwYhTnmyI2b7czpWl/ZEuPY78sHotY4eWBzFZD/1qxbZ7AISwn
	fXP99stZ4PzqZ7bOGgLGYdtDLvzZ7P4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-jXIgNFouPBuYA3OTT7fZgQ-1; Wed, 11 Mar 2026 12:53:49 -0400
X-MC-Unique: jXIgNFouPBuYA3OTT7fZgQ-1
X-Mimecast-MFC-AGG-ID: jXIgNFouPBuYA3OTT7fZgQ_1773248028
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439bab2d095so47611f8f.3
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 09:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773248028; cv=none;
        d=google.com; s=arc-20240605;
        b=YdyuBH3HUepllmnhXxTiGxYF6vNk+v2hGGmEkBeRGs9RozrJu1lZQq4/BuEOW+TD4f
         CTbCPWbOR6IMfoRg96kLxKQw7igsu+MmhRBq4YYxXR8oiL6UZ+DNrwq6kgP4qG6sAiGV
         pkIxXB2VVb77N3x+SxpEEg5QesDd1//HGoKusRiXtok+yIcusDKHEfHVJSLLIJn3jJ4Q
         RqBOKwR9gbrd2633XEsf8GZZ8fxLFLKnuO9K/SnIGyx58dJGfEzzdrYI6lUwEWK8JR9p
         cadkQS39vZB24IwRUqa65TCkl89ZvcBbxF6FEIPfEyuerKMoO7Evezr94+alD2idrukv
         NYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W6ouqFOpofiRNlkZSgBBuN2FHJVkzx00Pt6fyeGhUD8=;
        fh=E0x7QCjoye3gBtbRK70iZ0iSgHBBr3eONJX5iTqOZHg=;
        b=ll+U7MHbNIJLuKRm1AJh+LY1EJKPYUE5xaPHOvC7x6P2moaUw0Lo4x0jhhjUTUq83F
         QGmvrV9D5B58KU5ZKL6KbRRZEgbehakCSutjp/QG78Yy6xCycbpu8T9BX5PSr2yya7NW
         2OMI7V9Wo4J41Mb6Xi9uP8EXefjxzLxZt2DTEfIvwoNTVrWFYRZOlSIV4DX7vLMvkw6p
         gv69ItmexQ+w0XDuvuc8wmnnu3KVfnsFKKPmigY1bNum49RV2XaPuihd8XjXudPSHci2
         C4D6W+45bmbVHZTYaKm5PXYEotSlAAwWyXF4VZCuoYh4TPAiGmfSakj97ivHl452YgpY
         YvpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773248028; x=1773852828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W6ouqFOpofiRNlkZSgBBuN2FHJVkzx00Pt6fyeGhUD8=;
        b=K5psMziMnsNsBll+US0sqolkkJSP8B7siT/wXm2/Y+4/05IQIJVXNXyP8AWJUAYYOK
         6w5FTaaNCb/K3CIP9tw4IESQqYiBtAC+ygr/bwOIrEfe2PVzP7aiDQr/0xSyW61LQfVl
         rSpypyePeAijJvcPdqxw3OctsvZmpaQoE29wpReCNkOvD8EH5o3R04ef1yP8Gve5s5U6
         lzNk7NnKkjwXC8fobCkx+tGt+SbuZqWkdqm8BHenwMFgrO+wKIkdvgvMNig9/iVQUeBt
         +e/0iQlicEtLEr8sLVLUydLrr6eEm+XgybgUCfOFfAl8oWOyT0ju2NsZ70kscFALu1X/
         ZDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248028; x=1773852828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6ouqFOpofiRNlkZSgBBuN2FHJVkzx00Pt6fyeGhUD8=;
        b=D5be0mU5yGadgYWuNw0VZCMdvmHBrcX13PTS2W3Rae4yoixyB3mBhk8znueU/5h7tb
         pGOUlXKr3ZvIion0ZEYJBMYWByTkDyVMwVfLE0Q/9XbR20nosZOTKXkkrf02mflH7Nb8
         xmPswP5sXyFPAjk9nl8Ix0UJ5OIa2UbE34IjIrAIlhMsmCh2UwNvGoMDpatakS0kbvFX
         P6//gQUzR5EabITNyQQDQ3LblA8TyRCQwozCXhNKbDBnDGjWHyjU2WmLLItV5A7kPM7g
         waAXujyCgw1/VhH/TTjY/1NKVq5hlpury9uVi5dFkG5YrXG3fTJHAIQISB2Wt24HPqNb
         Hlwg==
X-Forwarded-Encrypted: i=1; AJvYcCUkicfzSfB3AkdFWV2t31rnbFaQdB4AwgzWjlO5vq/ZrLgv6QmyP95e/bBbiQXHckqrhjvrYjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzne3k4N4mNZOHupUhrvrOSwURzCZMPPnobd4i+5uyJmuDm0huS
	2B7R4sFBKHwB1ZUMocTf2DmVGxak3h2DwEwMlNnuPY+e9Yeqg39Z1CI/OMw9KAHYsl+IdIyYTD5
	+3Z0BrwZZqaXSvK0fic8w8jlJT6z77rgbCn8Gd9WuwvsnsgPBOwRG7VcdtnwoObj0ubiOidoGZp
	urbRKFoDIAsZsDL2takGAbVuMX7OdHnkQc
X-Gm-Gg: ATEYQzwJxGfKmrZ2x8BFCgbhgOo2fQSJ9FgCOHbKj38cjF+GnFAwHkswgLZJRil+U7C
	R6zxPHIbminwEtYH5OJrRmiMKofyl2UgVc6tpwdlM5/sJf6w8Tt4cJ3DxQtfE8MD2jImLP3frxt
	/ttUdBfkQ3fk8PImeW1d9k2qxeTw7D65GSLSsc4PHAmb3tr9X52wjrJttO8SbvlXmEuOewbMQ37
	4oqAgjZwYXXHHjVhNCmrUrXwrIlC7wsCg3+DJcW3/141iKN6maXsvc+BFZGUML+XzgsXNnFIyMu
	/dfRgAc=
X-Received: by 2002:a5d:64c4:0:b0:439:ac98:751a with SMTP id ffacd0b85a97d-439f8222f77mr6548989f8f.34.1773248027841;
        Wed, 11 Mar 2026 09:53:47 -0700 (PDT)
X-Received: by 2002:a5d:64c4:0:b0:439:ac98:751a with SMTP id
 ffacd0b85a97d-439f8222f77mr6548943f8f.34.1773248027390; Wed, 11 Mar 2026
 09:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310202414.406078-1-pbonzini@redhat.com> <20260310202414.406078-3-pbonzini@redhat.com>
 <CAO9r8zOLc030xTsnkYWvp5yUtnzQgVZnXXhvKZWC__1wRSP61A@mail.gmail.com> <abCRA_B2kHp6T7Zn@google.com>
In-Reply-To: <abCRA_B2kHp6T7Zn@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Mar 2026 17:53:35 +0100
X-Gm-Features: AaiRm50TIIp3y6fvJJ__bDA_OJxo0z7OHXqTxBoJsDcFI0RUbVklP5XL8G89zrI
Message-ID: <CABgObfbkkFA3akgEdwFZ0YHsKUKJNUUPujBQrBbHhCNtpW_8+Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] KVM: SVM: check validity of VMCB when returning from SMM
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Xinyang Ge <xinyang@anthropic.com>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224724-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AD91B267984
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il mar 10 mar 2026, 22:45 Sean Christopherson <seanjc@google.com> ha scritto:
>
> On Tue, Mar 10, 2026, Yosry Ahmed wrote:
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 12 ++++++++++--
> > >  arch/x86/kvm/svm/svm.c    |  4 ++++
> > >  arch/x86/kvm/svm/svm.h    |  1 +
> > >  3 files changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index 7b61124051a7..de9906adb73b 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -419,6 +419,15 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
> > >         return __nested_vmcb_check_controls(vcpu, ctl);
> > >  }
> > >
> > > +int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> > > +{
> > > +       if (!nested_vmcb_check_save(vcpu) ||
> > > +           !nested_vmcb_check_controls(vcpu))
> > > +               return -EINVAL;
> > > +
> > > +       return 0;
> > > +}
> >
> > Nit: if we make this a boolean we could just do:
> >
> > bool nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> > {
> >        return nested_vmcb_check_save(vcpu) && nested_vmcb_check_controls(vcpu);
>
> I don't care one way or the other for this particular patch, but once the dust
> settles on nSVM (assuming it ever does) I do think we should align the "nested
> check" return types across nVMX and nSVM (which is likely why Paolo ended up with
> the above; I requested using -EINVAL for the nVMXx) patch.

I was indeed aiming for more similar code between the two. The last
few nSVM shakedowns prior to Yosry's (nested_run_pending/live
migration, vmcb01/02 split) already took some inspiration from nVMX
code and naming, so most of the low hanging fruit is gone and I didn't
want to actually make things worse...

Paolo


> My fairly strong preference is to use 0/-errno as "return -EINVAL" is more
> obviously an error than "return true".  But we can bikeshed later :-)
>


