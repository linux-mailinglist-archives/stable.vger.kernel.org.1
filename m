Return-Path: <stable+bounces-274508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mkd0L0+DVmpr7wAAu9opvQ
	(envelope-from <stable+bounces-274508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:43:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D524757E93
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:43:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=vS3PrwL9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274508-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274508-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29FFC3006B1F
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D09B41A907;
	Tue, 14 Jul 2026 18:43:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27720377A80
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 18:43:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054596; cv=none; b=j+VUajPQPA9f86T6mOVUDP4bkipJ321OTmPgGG1s1ruW2+Kzjk4jkFRIqlRapQtbvKdQ3TyLx46dvAWj/HVo8pAl16shhvHAYcypTPI12bFavg2kKwOjW2VI39xSz5boOR+ba89dwfmzFU8WgzfaCFucJxpetjQ887YpeAjgHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054596; c=relaxed/simple;
	bh=QMtboOij6SiylMyty5zxOifbocl7KL0C8wQdf1+7zio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tT65jNCuUyKBtCZd3xHWdmQLEAngux++2ItXK00Xm2zWkT1UciZRoqVkX7wQL/ggjR+JBoUcjd2L+fuMu/hrEPwudlm9iFEwRl9ryWp3x1GllnqV5kO0d/0jzQ58lysgvYbBmznvsmLEM+RF+f44jzy5gzBeXwBCEQDCJb9cz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vS3PrwL9; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88ab059052so1468487a12.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054582; x=1784659382; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8a7Ma3SWbuWG4d5N6WsHS2bhQ3Z4xI82D2YlDjqK2yg=;
        b=vS3PrwL9O93UhSRKW2/+GkIkRt0rFPZ24ewFqjz2pNmhT/sTheqMuuc75myRi5uzVB
         hE+S5JgSFSo57HjO39305WTO1TyJ7sV+TvKKgtI4k+HbNti9lf9sIwN8wXyCCxzHO7tp
         qxgkYXA4GS3qpLglFUut4sEyTEqySylE5hroAHmcaaT7S2fG6nTzMx7+vLXvXOZQ2VlG
         V/JDl+N3fa/Rvqrvcg8DuFlDfuseGnPzHgp8XpJp0bufvNMFKvqZGjFieEV/YYZcOq7y
         l3vMxtN8N6q6EEa+bUb1qeOYf/CQXq5pytkfKLU0Dt3wbdfcMKL94YSYkrScwRbgRTrz
         pVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054582; x=1784659382;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8a7Ma3SWbuWG4d5N6WsHS2bhQ3Z4xI82D2YlDjqK2yg=;
        b=BGHhpn5leUVGPFtjBUoF5K3oBt7aBZ541g1G/AeRugaOCXBrJXaB0l3heqozCmhsre
         qwG0sQ0WtBmzRdL7mc/gCjf+ZpfK1lQYeCkDC1y7sqIJXNB36m0ISlGc300xsUzzUEb0
         fdN2UMPIYGAsQo7jcHPvd3mpaye9gjjNdUHiEa1iwuqgf0ugclnve+6ZX/B8AKJdxGiX
         oAB77kxWYyfUbXmnDsNfGbBxEa0bEMyA33VWGQWYHfEFVhqK8sDbyuB7Un4aYreT5q+0
         OMYLjZTOCze7h+LO9izMpTAM106LuzokVjank8Np9ijcOTTQkBC5q24GjwZRbOKIVP5U
         8nSA==
X-Gm-Message-State: AOJu0YxukTrWWSV2XWGP55biHb8NmpIcTpPpxzG0vvFzk4mgz/jVRtSB
	6t5LM4RXjwZr+RLF2Csi4awUzu89M4DC1zR61gjgsQcY9KZM37iKR4N/cPbMFFK0GFmc8EGyG09
	Mk5sSPQ==
X-Received: from pjbqe4.prod.google.com ([2002:a17:90b:4f84:b0:38d:c157:c023])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3901:b0:37f:d265:18d2
 with SMTP id 98e67ed59e1d1-38dc81b0ec8mr11584484a91.7.1784054582147; Tue, 14
 Jul 2026 11:43:02 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:05 -0700
In-Reply-To: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405257201.3111763.16358668642306263283.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: TDX: Reject concurrent change to CPUID entry count
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, kas@kernel.org, 
	rick.p.edgecombe@intel.com, thorsten.blum@linux.dev
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274508-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:binbin.wu@linux.intel.com,m:stable@vger.kernel.org,m:pbonzini@redhat.com,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:thorsten.blum@linux.dev,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D524757E93

On Fri, 10 Jul 2026 11:53:23 +0800, Binbin Wu wrote:
> Reject KVM_TDX_INIT_VM if userspace changes cpuid.nent between the
> initial read and the subsequent copy of the initialization data.
> 
> tdx_td_init() first reads user_data->cpuid.nent to size the flexible
> kvm_tdx_init_vm copy.  The copied structure also contains cpuid.nent,
> and that field can differ from the value used to size the allocation if
> userspace modifies the input concurrently.  setup_tdparams_cpuids() later
> passes init_vm->cpuid.nent to kvm_find_cpuid_entry2(), which uses it as
> the array bound for the copied entries.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: TDX: Reject concurrent change to CPUID entry count
      https://github.com/kvm-x86/linux/commit/cfbebb55e512

--
https://github.com/kvm-x86/linux/tree/next

