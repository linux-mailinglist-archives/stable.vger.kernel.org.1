Return-Path: <stable+bounces-238228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDGQNIYO4GmzcAAAu9opvQ
	(envelope-from <stable+bounces-238228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:17:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C8C408859
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9994C30B932D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E970390207;
	Wed, 15 Apr 2026 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtSfmn4f"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CEE21A434
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291413; cv=none; b=KsKtrG0y6+xKuJGMzkVM3fGGXgojgV9CWU5rJHLjQvCofNgYGlw8E8r3YaSMBQ0o3PLDfocsR6tydQeO1n3uxG8wGw/p2HRaCidyT+YMf4EURLOvYVmXXBIFTQ7Pt5iXQIaMt5GDv0C3yC0z5BIgr1lf/bUbP3AHgkVVziKhkBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291413; c=relaxed/simple;
	bh=vdpdh0xkIajBHZM7qoM+xUEgxrphiImhs+GqNY7hsgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E08wckPqsGy1GSWRy7JGs4uhijQB+F8CETIo2kCvXANsf/lb0zG2yKdWwrOLBexdxhDH4D+jWdgRcGiK3nkKTKvz6OHLaozHkAmEDDlUc15giAEBMK2auOJMRLdDvafIc/CsGo35UIfQFkmNrctEgWsbJ5m8c7uChy41xePz/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtSfmn4f; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82cf8dcd079so1070922b3a.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 15:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776291411; x=1776896211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QToygMVPGVk7KubMavoRHu5zoGCxschPTOHOfHs+CAE=;
        b=dtSfmn4fG+BilwHWSZ9DEDIvMp8GN0Aqex3xc8B/qx8hb7wSt5YB5PKXzyjpgde1tp
         3ji/znldq7kXLbowozcRMPMaEPekboNFsVsDiLxvCY03BeRiR3kxm72ris7qZm+7+PQb
         QbKq1Q+4WkhsulUlHJiLRAgam6H7F/yk4gMGgLCGf/6JOW3x5f27rRB7424pVnlWWI2y
         zY3Pt6qdtdpuYGjl+htEi+FMglNfzYQeYJLzcIPdj+SxihBcCAzzRqhG4HlyfTH9sv03
         vaevOQz9u/ceT8FMjKnbw2UCuetnPgGolvZqO1jo7eSUMqSGBAMLOZM2GgQJr1vZFFL+
         w36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291411; x=1776896211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QToygMVPGVk7KubMavoRHu5zoGCxschPTOHOfHs+CAE=;
        b=b2e7Li8or2kG4jdBzMxQmvwA15WL6ds6CNTKchYoI4VNugQSpvLSSJd1B1xUCam7T1
         SA8CJ9Jc0INE8s6C98SOQ+cdIm2iefMxcf0z6HMsGCnAo5wO2TyVV05Z/eS2SKYsUxQ4
         f2QyCQ/ZL4oQTlYW7YiyCzDHBrahxRYUNTF62ZFlWbIskfu7+LL6uyMowtfP/kTGi1CG
         53OmLODh9aMo0xTW5owBUL9R2yFSkdMWal0ZQha5QKSXIzhkZF7qWj3Lxd05hgnXsPMe
         SSAsoP5imrpZOrW78fLIO0rq0Jwd2IesZQJxjdYJWmkLZssRLObxqzj0voJKxKC3cBhB
         qPgg==
X-Gm-Message-State: AOJu0YyvhHFbqnXbYcmvn7wxL7BHgdol7YIcfRXKVy1e+53l+HcFt//U
	Kjsx8Tqq1RD/4DD01SEQmGDdYy1YwzM48JCIgasaaujxj6uovrNCLv3mrgRwPuw7Iz7ivj454+g
	3wStEbQ==
X-Received: from pfbeq4.prod.google.com ([2002:a05:6a00:37c4:b0:82f:42bc:3383])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:950e:b0:82d:24f:2516
 with SMTP id d2e1a72fcca58-82f0c132246mr25086484b3a.11.1776291411250; Wed, 15
 Apr 2026 15:16:51 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:16:50 -0700
In-Reply-To: <20260413130125.2879436-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026041317-engaged-onset-3db3@gregkh> <20260413130125.2879436-1-sashal@kernel.org>
Message-ID: <aeAOUvAe6a4qZ4Yy@google.com>
Subject: Re: [PATCH 6.18.y 1/2] KVM: Remove subtle "struct kvm_stats_desc" pseudo-overlay
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Bibo Mao <maobibo@loongson.cn>
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238228-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email,msgid.link:url,brainfault.org:email]
X-Rspamd-Queue-Id: 23C8C408859
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit da142f3d373a6ddaca0119615a8db2175ddc4121 ]
> 
> Remove KVM's internal pseudo-overlay of kvm_stats_desc, which subtly
> aliases the flexible name[] in the uAPI definition with a fixed-size array
> of the same name.  The unusual embedded structure results in compiler
> warnings due to -Wflex-array-member-not-at-end, and also necessitates an
> extra level of dereferencing in KVM.  To avoid the "overlay", define the
> uAPI structure to have a fixed-size name when building for the kernel.
> 
> Opportunistically clean up the indentation for the stats macros, and
> replace spaces with tabs.
> 
> No functional change intended.
> 
> Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Closes: https://lore.kernel.org/all/aPfNKRpLfhmhYqfP@kspp
> Acked-by: Marc Zyngier <maz@kernel.org>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> [..]
> Acked-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Link: https://patch.msgid.link/20251205232655.445294-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 2619da73bb2f ("KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

