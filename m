Return-Path: <stable+bounces-267846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cc43GVXqOWoNzAcAu9opvQ
	(envelope-from <stable+bounces-267846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 04:07:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97006B37ED
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 04:07:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=NfcLUwf1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267846-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267846-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEDE83008087
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 02:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC8C385D8B;
	Tue, 23 Jun 2026 02:07:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B72C21FF
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 02:07:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782180434; cv=none; b=asFjB3esgKWysLkRO72gYuMEpFKICZRqqYKy5BDz+dWBlXfCSnVJ8uZId6JB2OuWmkbi90voSKYQ3Z0Qm+R3Y3AIhp0qz+/D1fh74LEYmXl4UCMvLKd3khPj0U8STsrtekgTtTJ0m3BX6fYcLh1LpO0mAV3cGzCf0F5FbGsn29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782180434; c=relaxed/simple;
	bh=4K2rc/keiADBTmcCzAYpI+UXrdsZoBJ6VPBmODXWpBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kt84me1TYmCR4usdGSgMOlYsrvmu61brV3UgtVGNBqBq5u/cWMRlOPKYcHySO4b+FjCgj/TPJJXMgKIpuZZVocvrs5GloH2HDNIXQrDiTYmmFldgd5kJbR7LvH4tnro1KdHfDXoQPA3s7K/H0qdgoglgXgQBfRrmatkuAP4Dc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NfcLUwf1; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b9d265308so3327460a91.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782180433; x=1782785233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=16OIrO/rsCCNlasgtWoObyCXrmjWyog2BYpUhpGypjE=;
        b=NfcLUwf1bqaievrKQIEbLPkxj33AsN9M1CZ+pQDvZ6f7JI2HqnzktzdU6yvmd7SVCu
         67jFrxgwzrawQybdu5AN0crCn3YMpkv72jlrV+qjJreyIE0qSIUX5Wr4GDqKUrArJN9C
         gaiULf3unPMWfiuDlDh/rVhMXnzRyIWUnCrmF9bvQ5Mub3pn3kRlJ137+TUSux0ZOEQT
         wxrlfWrwIXBqYdOwRYl2bFCgIX/YFIJDJ6m3Ew5WBKYRGyRJT7xVUirVrTiAdsRMaF0Y
         FPXht5OUyIijXLkeEGi+ZJktxzSS7y7/kNqOlyqdALdr509lz4A5cAKB5FLhYqhY33Tq
         0qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782180433; x=1782785233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16OIrO/rsCCNlasgtWoObyCXrmjWyog2BYpUhpGypjE=;
        b=eyUdKcgoAyOFx5qNWEscRpzX2zld1g8LCwNz1t042ykaikr9DVlPrHZPzQpCYcvBSh
         ExC9XXBECYEiBNiiFEbm9FXUr0ii62JzANJUDUW1oljH17rCC5FVhKQoHhd4vFCBDGPH
         dCtr7GzH4twpZw0aoyxRrH+hDEsVkmGeqC9DQgEwOvMwYTb2sindq4caxX0r9LwCvx3a
         6/cIMoT2qRnizG2/CiU/SOij8E1IDhXjWW8gGPk/ZsbvxpAkJPadSAG/YiuXvA1SlAkU
         KRE01ijLi08zRgITNozDIXYNsrT1obT+UwzZzGuwoOFQre4jPOQkDNaqxiAt8fVuAxaF
         yt0w==
X-Gm-Message-State: AOJu0Ywpg0Ydzxc7p6O7lIQnRphQrpM5QhEQpsBpdg+siXLY7EqNGTA0
	vBNw7tJEbCPLXNmCceGVECU6hSCxVvOfRaNqMV7gypzfmD2tzYchRnFg6CmF5F49LjVArH9ciwn
	dwbT0pQ==
X-Received: from pjbhi12.prod.google.com ([2002:a17:90b:30cc:b0:37c:b313:3c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c4f:b0:36b:9798:4f67
 with SMTP id 98e67ed59e1d1-37dd16de36fmr630782a91.8.1782180432324; Mon, 22
 Jun 2026 19:07:12 -0700 (PDT)
Date: Mon, 22 Jun 2026 19:07:11 -0700
In-Reply-To: <20260621133722.0003.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619203107.2752678-1-main.kalliope@gmail.com> <20260621133722.0003.sashal@kernel.org>
Message-ID: <ajnqTyhKNqOjKnzF@google.com>
Subject: Re: [PATCH v2 6.1.y 0/3] KVM: nVMX: backport virtual-APIC host
 NULL-deref fix
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, gregkh@linuxfoundation.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 0wn@theori.io, 
	mlevitsk@redhat.com, jmattson@google.com, 
	Nicholas Dudar <main.kalliope@gmail.com>
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267846-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:pbonzini@redhat.com,m:gregkh@linuxfoundation.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:0wn@theori.io,m:mlevitsk@redhat.com,m:jmattson@google.com,m:main.kalliope@gmail.com,m:mainkalliope@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,linuxfoundation.org,theori.io,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C97006B37ED

On Sun, Jun 21, 2026, Sasha Levin wrote:
> > This series backports the fix for a guest-triggerable host NULL pointer
> > dereference in nested-VMX virtual-APIC handling. The bug is present in
> > 6.1.y and fixed in 6.6.y and later.
> 
> Queued the 3-patch series for 6.1, thanks.

Backports LGTM, thanks Nicholas!

