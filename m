Return-Path: <stable+bounces-23381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE66860074
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 19:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2CB1C23516
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA6F1586C2;
	Thu, 22 Feb 2024 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgXd3PU1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D71586CB
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625323; cv=none; b=nep2PEMImF6ClAhsiJa1s0tYgNDF2aomlzlDrsQb7MsJgt5y7p4/7ZFD2VDIDbay9pQXVpcxOIbuuFixjG6YzgIkBYe79l2M70H6HXr7hDV58h0IN5EsHdx+wgK0w79VVI5e5S6+0uPZ4FP43PUKX/uSfF+JbXGqOmjZwJkG3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625323; c=relaxed/simple;
	bh=fy4liYg48gPvnH1kE6+qcZ1q7Bfu0MU2FGcOfrrT0bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNyhWmGZPsYiSVvWgHOnvp+6aXgwhtaghoB6j13E6jVSi/zpI6uhNqtGVYCuzGFMOeYcUwj4CRIY39dji208f0UnDONadiCvpsipLy7A2SVnMR+HjNmjFekzro1a4MHoOpwtTcMOQI6Gi7l69tYIY0gpMws2nEiMtKiZaov8A38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgXd3PU1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708625321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CJoex4NkBFusthzZP64VSRgiIqDu+jmbcl9OVx+65A=;
	b=dgXd3PU15yaiL7IpGEq8376HiNFZNUDsYNbAntQ+roYbXSXAv3Eabh2On0OLD/t7/E7SzH
	pPk/PxrqDSEngvieARJqY8BCJblAb5ksVVXD+++3L11dWG/fyu9X7SOWbNMhTeXYdgUnTQ
	hljXzWttdHEACsvNDkuahFPPKLar1vU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-FFtBoAVgPjqkYOPdCSEIQg-1; Thu, 22 Feb 2024 13:08:39 -0500
X-MC-Unique: FFtBoAVgPjqkYOPdCSEIQg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d8b4175dbso8061f8f.0
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 10:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625318; x=1709230118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CJoex4NkBFusthzZP64VSRgiIqDu+jmbcl9OVx+65A=;
        b=Mgs+dO5+K7N8R2iMGYisruJYnSisDVZueOPchRtha7P04Tk1+JgqVy6pTEDe+gPqbJ
         PivkR235a/rzFSae3JzTSknKhg4ZC/3ks/3d6Ppz79BVBLcUAh4PlXWGNW2rqYX9zybk
         3Z9DnfkiC6FVhJsNPJ8BcCZd2eY3U3HXY8GzI6CLkhz1kJVWDIxWR0uUYhaziTrevPma
         QdUCFAkxyL/Ss1fv1c9EgbW9frEzqB82cdLW0pAgEnBHhlbj757NpdpHAZ+1VTziou4o
         JFrXHSYj/tDp1q4Ch3LTdzQrrZzcB20f7IbgVgojWp8fdb0/IPegD9bkKn0vxKS35iBf
         ByMg==
X-Forwarded-Encrypted: i=1; AJvYcCUfAhB1SAv0S3xL2waAe+OL33i0l2dVtu4eorQ4+uVIOZGTrQbWNS4xGh9/AGlUqM049/7AuoFPrRAq3a4wCOcA4B6o6ZAN
X-Gm-Message-State: AOJu0YzvCi956QDjhU2Oj6gJVyrnB0MS+YpbQtCz+SPp+9gYd31BIxbB
	gH7F/MoLImjJgWLv4IU8F3Npq0XHS1ibDnGjvWgjTSIRjFNbOajRufxdxWBcY1WskQ/xG8cWsQ2
	jFzioF8YJxUKT0VRFChPomk4roct5iowQzjm53LKT29ftQJVTwukraZh70x9rAdk8jbRTBVNEzg
	t21/bZB7KbK4xB9OggR9jjyhPmVqYz
X-Received: by 2002:a5d:55cb:0:b0:33d:8783:1e0e with SMTP id i11-20020a5d55cb000000b0033d87831e0emr2256753wrw.70.1708625318229;
        Thu, 22 Feb 2024 10:08:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIUQS8ouwPxlaKQVxX9DLq/Mvc03qLzRTc8yg50FNvecbYAl2IuBempcl7FEGw8G6iGj5LeAgPO9VoiSe7Mgg=
X-Received: by 2002:a5d:55cb:0:b0:33d:8783:1e0e with SMTP id
 i11-20020a5d55cb000000b0033d87831e0emr2256741wrw.70.1708625317940; Thu, 22
 Feb 2024 10:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230902.1867092-1-pbonzini@redhat.com> <2b5e6d68-007e-48bd-be61-9a354be2ccbf@intel.com>
 <CABgObfa_7ZAq1Kb9G=ehkzHfc5if3wnFi-kj3MZLE3oYLrArdQ@mail.gmail.com>
 <CABgObfbetwO=4whrCE+cFfCPJa0nsK=h6sQAaoamJH=UqaJqTg@mail.gmail.com>
 <CABgObfbUcG5NyKhLOnihWKNVM0OZ7zb9R=ADzq7mjbyOCg3tUw@mail.gmail.com>
 <eefbce80-18c5-42e7-8cde-3a352d5811de@intel.com> <CABgObfY=3msvJ2M-gHMqawcoaW5CDVDVxCO0jWi+6wrcrsEtAw@mail.gmail.com>
 <9c4ee2ca-007d-42f3-b23d-c8e67a103ad8@intel.com>
In-Reply-To: <9c4ee2ca-007d-42f3-b23d-c8e67a103ad8@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Feb 2024 19:08:25 +0100
Message-ID: <CABgObfYttER8yZBTReO+Cd5VqQCpEY9UdHH5E8BKuA1+2CsimA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/cpu: fix invalid MTRR mask values for SEV or TME
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Zixi Chen <zixchen@redhat.com>, Adam Dunlap <acdunlap@google.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 7:07=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
> > Ping, in the end are we applying these patches for either 6.8 or 6.9?
>
> Let me poke at them and see if we can stick them in x86/urgent early
> next week.  They do fix an actual bug that's biting people, right?

Yes, I have gotten reports of {Sapphire,Emerald} Rapids machines that
don't boot at all without either these patches or
"disable_mtrr_cleanup".

Paolo


