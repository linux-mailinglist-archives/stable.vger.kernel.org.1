Return-Path: <stable+bounces-217842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE2XHfLynGkvMQQAu9opvQ
	(envelope-from <stable+bounces-217842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 01:38:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A771A180454
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 01:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B06F301BD52
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 00:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCC5233721;
	Tue, 24 Feb 2026 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zKoqDksO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1522A80D
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893485; cv=none; b=b0oB+wgJoXsIRLpIYvZnWgcJfik857/iepPBu9uDtkUuc+U/VSS58XNVp7TUvjRZeZKZb9H/taYf+m/MIQneXYHkjNe6o87mkUxGJVjAVHreTBV0dDYP7FSJCxhZVcOccs2jaJ5LJjtO0NoJWGM5dqVYq3GVbk25WDck7MmGTJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893485; c=relaxed/simple;
	bh=95et0iiZOFvEmrwQk1B0aEKVgA5Luw2xyZ7YltWllHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ks5pYsxIE84alyug0I+ygwuaqKlBQ5WsVk+P0lqUaWtK9VzRFbQxvQ83Lb6O4HEhZz7XmGklhfWD7dJI8v5MqdPOufp72aeupnzGyd8KDgNUS7fYmavf1lgwS15TNcs5L0OqU6gv8CGItfdKyaUiGEY0q8Gkynx2CPtLTNpO3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zKoqDksO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a8c273332cso453550015ad.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 16:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771893484; x=1772498284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRUtYfiuCHkE01sKVfZHqk1HVPwnQ18HuftgTQ+yBvY=;
        b=zKoqDksOgtZ+EHEyMXmGtvjdFyR+nXBkGjpV3iRQBgPirCiu+7sAn3JpbaYU8r00+T
         OPUWLBvuXGpBV5AM3NdvZU91FPE42VG9od5T7dQC7/Wcb7WW5hJR4dwmw4teiVhnQsts
         gEpmcvFCHcpoC2IDXG/o1y6sXDKcq1ZiZAyLhTQZxB+acA7fq+fL3DyYu927E0p8HFNN
         0CYwA5uL6D3TAiUBusV8Jbo+jUhp3i3S/mGD61SaVSHF2Ud0jhBF+muR3/3uED5be9bW
         nVypl8g3vSLLoSr56lyMJs54YcHjvShIMiLPn64y2xa1Zv5XnFGyin7cSckn/g7IX1zt
         SzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771893484; x=1772498284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRUtYfiuCHkE01sKVfZHqk1HVPwnQ18HuftgTQ+yBvY=;
        b=cjoJlPhRZJoW51vaNWpLYQK8CC4nITlRvFGBh9GBtWIHdflu7W566Bb7VU3ap3LtNL
         zxyg5QBCx+2kEIBbwUt2qKzUdSuwHziKCPArtLmDCXEFlgnde1yFzw0fubuub2kRhtkq
         UgwQUM26g9YSElEK+K6tJlZB5gJmUjEjiUFwOdwZF0rTR71LgXl0r+Kdw2qwYo//QPEX
         I+pBnSpzO2nSG8o/VXqEcjjWbDC1oFv7JIyuALefqbZEE/JTMRhjlyEvQKEjbh4DbYNr
         P2xPd2GWxR7oR2dlarCIm1faYUosee232WgTBuSkA1LcZVG9IjXw8Dw6M7suanw8paKj
         AnGw==
X-Forwarded-Encrypted: i=1; AJvYcCVgIUnI3iR98X20oDMX5Ke9g3rxuo0wCPjpHQhGla2XIXXAcKAz3WzD+8ZIIHMv87sgK6Vi8xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/bKqKr1uHaFySsIkiPPYfAUZOM8LMMb5eoqk5MEzRFChR/zbZ
	axdDgSlNi8zIpT8e6Pa/VRyF58YU6E4ZIExiEnb34brmx+AVtAVO0zjRTywAyhS6l9Y4y5gsNrM
	HShpeOQ==
X-Received: from pjbay5.prod.google.com ([2002:a17:90b:305:b0:352:de4e:4038])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2acc:b0:2a0:9755:2e97
 with SMTP id d9443c01a7336-2ad7444c497mr102963395ad.15.1771893483878; Mon, 23
 Feb 2026 16:38:03 -0800 (PST)
Date: Mon, 23 Feb 2026 16:38:02 -0800
In-Reply-To: <20260206190851.860662-8-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206190851.860662-1-yosry.ahmed@linux.dev> <20260206190851.860662-8-yosry.ahmed@linux.dev>
Message-ID: <aZzy6mIkYunIUyZV@google.com>
Subject: Re: [PATCH v5 07/26] KVM: nSVM: Triple fault if restore host CR3
 fails on nested #VMEXIT
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217842-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A771A180454
X-Rspamd-Action: no action

On Fri, Feb 06, 2026, Yosry Ahmed wrote:
> @@ -1140,7 +1140,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>  
>  	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map)) {
>  		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
> -		return 1;
> +		return;
>  	}

And then here I think we can do the same thing, e.g.

	if (nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true))
		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);

