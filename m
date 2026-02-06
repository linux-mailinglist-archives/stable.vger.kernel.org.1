Return-Path: <stable+bounces-214670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKmYKhoPhmkRJQQAu9opvQ
	(envelope-from <stable+bounces-214670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 16:56:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B14FFF06
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 16:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25A0E304F373
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741AE2DEA8C;
	Fri,  6 Feb 2026 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FC0I4egj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6192DC32A
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393299; cv=none; b=aJt8WsuqGFaxRNh80mqlYwaiF9knl/qMQjwMww7G2FvlW/sk8Hw1/WQuWJvlLzR/KXYEwiIIlqwUcFaZBfja03RzI08Li5yPmx+R4qY7mISSIomTJdE7gp87eXNtiEkk2+ypcqTy+t/K0B9cuEAJKlpoihYx44eQiZvJGqZgAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393299; c=relaxed/simple;
	bh=cgmJVZ880y6fsSrKxXrWzDlfqGTJmjedvvvvXiyLrZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XY8Ym+GefRd+NBYAMt5FRAgCLTZyZdxUQeY5+GTLHJ0em90e9KKJS60CNh2Opi2QWOSkIfhB3vhouGUQ3BPyIoecgLoclczxRObg9nWbFwf8+Hj64Mc6s0+m8IhBa7N+Rx32JRorIjBykDEKZpTLV/wY+pM8L9F1KmSJgnr3xaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FC0I4egj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34cc8bf226cso2398326a91.3
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 07:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770393298; x=1770998098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ub20w3PlllwjJeB9g6N1sMss/WG4eHbIgCfgJZaRr98=;
        b=FC0I4egjFeXp2B0xMjUCPMRqF79/2/J3fL6tuNmPSjR19KijtDe9hW7STZ3mnBI5TK
         u0gKK+PYQl7pW0oeu9cUNRB5G0Yu3Dm7L9UgzpWdxSihxSWjH266Cjy0FtxIe3/cFvwx
         /cWjgOj0d/YbyTeuEvVKhYckk7RTUblwgfmSoyuznKCrb/fHTGs6Eekz5F+mBxxvKHaM
         n9etEpfbg8NF6Et/QpuROXjo6Mx7zJry1MC7La3BeHnIHYhrzGiAnLdkw/zVjdVG59FU
         DmjuhLUwHVP3JLshqdWgG6zh+plPbrF+jzt6c7MJD/O/7yvWNwQlurAun01IhTXuoMXk
         k9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393298; x=1770998098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ub20w3PlllwjJeB9g6N1sMss/WG4eHbIgCfgJZaRr98=;
        b=DDiIlRm078NWaQHVcr4fIL3Uw4+dYM9dQvXoVvnxMDioEgENug70ZMGnvVh2K/5tQU
         T3q+gNCguvo4k7TTZWuj2T9X3DpqjrQs/gttBvbyRisXQrNQSA0W54cELMgii51WJ98m
         d4270p8ZjIn+SmNeVqCqt6yHup78CKIAh8xnOGz7OgBoLiivd1eS+4sAX0xJ8FeX7zbz
         olZbys09ZD8jkBnuITPoBT+GeeJgZIElzmh4B82RhMBj9pOsJyZ5HSAT3TXZSIYeyFqq
         w6pPIsaFJSWKrrn8EYYAaRAxsXHBUHgyyfwICiCufrd0udKQ84sGcNGhGyiMDXWOBLFy
         pasw==
X-Forwarded-Encrypted: i=1; AJvYcCUkZAwqaQtgo0X1QjBUKTmBxHuDHBQr17BBBaIxoNR/K+42d/Ij2tSd0zzYfjd9xIhn56hdgC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6LxOjk9UPfaXtrqcDNSrb3tya7+oIIL6Z3qmxoqllHBvBncTS
	A1Ohjd22rzfni2utJ9UkB7wtevKyNdYswxQMSbODgZWG5stqEPXGVHru1CB9L6O8mPwRfU+xVQh
	rGC+RSw==
X-Received: from pgbcr4.prod.google.com ([2002:a05:6a02:4104:b0:c63:6312:fcb5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1f8e:b0:38b:e750:bc31
 with SMTP id adf61e73a8af0-393acffded6mr3151496637.32.1770393298473; Fri, 06
 Feb 2026 07:54:58 -0800 (PST)
Date: Fri, 6 Feb 2026 07:54:57 -0800
In-Reply-To: <usc5ysverr7gtt4itnw2s22s5hpfbtgwttm74i25gxbqm3b6cb@x2i4nzlo2wbz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115011312.3675857-1-yosry.ahmed@linux.dev>
 <20260115011312.3675857-2-yosry.ahmed@linux.dev> <aYU87QeMg8_kTM-G@google.com>
 <b92c2a7c7bcdc02d49eb0c0d481f682bf5d10c76@linux.dev> <aYVC-1Pk01kQVJqD@google.com>
 <usc5ysverr7gtt4itnw2s22s5hpfbtgwttm74i25gxbqm3b6cb@x2i4nzlo2wbz>
Message-ID: <aYYO0WqVDTSA8siv@google.com>
Subject: Re: [PATCH v4 01/26] KVM: SVM: Switch svm_copy_lbrs() to a macro
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214670-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04B14FFF06
X-Rspamd-Action: no action

On Fri, Feb 06, 2026, Yosry Ahmed wrote:
> On Thu, Feb 05, 2026 at 05:25:15PM -0800, Sean Christopherson wrote:
> > On Fri, Feb 06, 2026, Yosry Ahmed wrote:
> > @@ -848,8 +859,6 @@ void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
> >         to_vmcb->save.br_to             = from_vmcb->save.br_to;
> >         to_vmcb->save.last_excp_from    = from_vmcb->save.last_excp_from;
> >         to_vmcb->save.last_excp_to      = from_vmcb->save.last_excp_to;
> > -
> > -       vmcb_mark_dirty(to_vmcb, VMCB_LBR);
> >  }
> >  
> >  static void __svm_enable_lbrv(struct kvm_vcpu *vcpu)
> > @@ -877,6 +886,8 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
> >                             (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
> >                             (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK));
> >  
> > +       vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
> > +
> 
> Although I would rather keep this in callers of svm_copy_lbrs(), instead
> of hiding it here. 

No objection on my end.

