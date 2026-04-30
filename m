Return-Path: <stable+bounces-242182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKzHJs6W82nO5AEAu9opvQ
	(envelope-from <stable+bounces-242182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:52:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7B84A699F
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE1F63027B4B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C66E423151;
	Thu, 30 Apr 2026 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBaNlHRT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2B472794
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571402; cv=none; b=agRKiqfCIGMsN+2MK6JJBCI1DOfsPw7GIXmWWhBnljQk0KARat7oNi2UsgMUq94Q1/5GG5xEL/5QxKzQ91Q7osL8fxlZ9CZIhwVaPOrziTVNC3e2K54RNDQYmqVUt+1Z6bzUFAP2t8zQDdce24pN56DJoFMIBrgvad4OLAjfufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571402; c=relaxed/simple;
	bh=bAo8v4msbUQnPcMyR7HVCpTLMFUCUyjlyaQuBRHlX14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tVl7KjNJ3VgDXtEUfq2bCnf8aPTiE/n2OE/X6jwpQ6dgIPHXMKCgpjr1L/QqW0O/JbiTj71r0DJYNL9KHZOj592iv/GkqNz9fIfMWX1pKeXeIKZaVHmFfwk9zrGYZdTa+ptR/tbTi+dh5zecArHuv3vg5IwUDKEA2IbCpv2xCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBaNlHRT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-362d9dd9a49so1359694a91.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777571401; x=1778176201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W5etxh7iVspx/KsrA2k+irf74wVM21/2JymPeDe2+4s=;
        b=EBaNlHRTgy2fYzrT8JfKjoJrhT8JhQhlpcApXuc8xVz2/qbb2w4+eZS5d27+UiLEXA
         +DJUQSOZExJmPr55Tp+h9QYOoStBr6g4fa/DMje4kh+8l78tIEP9AmbbLbOLFb4k7Q4p
         0cnByE+SMRVrcJLjMvRjqgfchZA+O+mK6m5+uD/z5tJqLlwOrf7I333quGXvL45+g986
         FHSX9olmHABr4SJdwC90jVfHpK+j/OADFFZiJJHLt4QwtHYPkro2e4ccagpARxwlzMNc
         EDR7HuCo6J3s0phJhJ4KKyZptxjfBvR4KiEKeqFcwaIiRiDBSY4XJE+gPUjBXWGF15LG
         DV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777571401; x=1778176201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5etxh7iVspx/KsrA2k+irf74wVM21/2JymPeDe2+4s=;
        b=LhukH4q3889eKnbuVrYDEhux6XtR+6sIouVoZw3sCe9O0H7qkrE/fe62bYeat/ZbFR
         eu2kAIfrR4SeXVhW+1JdFDhmot406MEPUfLkmdESmNFkt3clJwWRKrIf+Kv1+XRUMvU3
         HjHSIYKRObGeXnSbTYu8Uzo0NKMLbHnv1dbqjdYE84V1/vzVgB7KanRdp4yWcrm6K/TO
         Z+JdxiBkImNimfolJT8K7F9UNpDj4YICB6a/2B9kSWa/fTPQwxug6+8+YW46ygs6F/tQ
         DszgYe3+mSkmyNliJoqH9ysU5Y5zMGpZ9N1zilpGPLwj7vOVzbBvLij6tIeK4P5M9hJo
         WyFA==
X-Gm-Message-State: AOJu0YywX8TRKSXsRfEW4wUfoi1tSGJEiJglgoQ8KBKmwyZcD/sHDFA0
	JfWRE3zb2Hagi5RXlp/fzbuxrj7UEQIXGHhPHKjWwVIeAkmXOev+pGQHW6Gx8giu/eSJ2q/a8Xh
	amfBh/w==
X-Received: from pjom3.prod.google.com ([2002:a17:90a:9203:b0:35e:53dc:9197])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3812:b0:35f:b5df:448
 with SMTP id 98e67ed59e1d1-364c30ed945mr4048979a91.24.1777571400802; Thu, 30
 Apr 2026 10:50:00 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:49:59 -0700
In-Reply-To: <20260429171550.srso-zen5-6.6.y@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428214610.2138600-1-d-tatianin@yandex-team.ru> <20260429171550.srso-zen5-6.6.y@kernel.org>
Message-ID: <afOWRxpjd1sAQu4b@google.com>
Subject: Re: [PATCH 6.6.y v1 0/6] SRSO handling for Zen5 CPUs
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Daniil Tatianin <d-tatianin@yandex-team.ru>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Xin Li (Intel)" <xin@zytor.com>, Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	"Ahmed S. Darwish" <darwi@linutronix.de>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: BE7B84A699F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242182-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026, Sasha Levin wrote:
> On Wed, Apr 29, 2026 at 12:46:04AM +0300, Daniil Tatianin wrote:
> > This series backports a few SRSO handling features for Zen5 CPUs from the
> > mainline kernel. The only important ones are
> > "x86/bugs: KVM: Add support for SRSO_MSR_FIX" and
> > "x86/bugs: Add SRSO_USER_KERNEL_NO support". The rest are added to avoid
> > conflicts when applying the aforementioned patches.
> >
> > Changes since v0:
> > - Add e3417ab75ab2 ("KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 <=> 1 VM count transitions")
> >   to fix a performance regression introduced by 8442df2b49ed ("x86/bugs: KVM: Add support for SRSO_MSR_FIX")
> >   (Suggested by Sean Christopherson)
> 
> Sean, are you OK with this 6.6.y backport as it stands?

Looks good from a KVM perspective, but someone that knows the x86/bugs side of
things should take a look at the non-KVM changes.

