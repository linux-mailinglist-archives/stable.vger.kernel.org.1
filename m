Return-Path: <stable+bounces-254708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE+2LzqxF2p+NggAu9opvQ
	(envelope-from <stable+bounces-254708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 05:06:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1AC5EC0FE
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 05:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10C5F301FC0D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 03:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26DE305057;
	Thu, 28 May 2026 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QPPZgK09"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7971A9F96
	for <stable@vger.kernel.org>; Thu, 28 May 2026 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937588; cv=none; b=ecZSaZdXWeAPhGUqXD3GSneakFT1dvbTW2yAv5JzsAEHsju/UaIKrIO5UpQHV85LSmoKJI63FXeCR6RTKsRYcD0o1SvyDNTba/NakArVXPHzvDsHHVUQ01DaPJDFFlIXmBC8yDa+nmvo1yMJyEax6MfZXUS8eZ5h4wGl5INhN1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937588; c=relaxed/simple;
	bh=FjEGp8HMT0oolbQ26cn1yayF1giLEkRPKwUDUeUuvQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tVeLAfHh/zQ4P6QuOcGHOKVaLgTsD9rWLVr+72dTtvqF9NDLUlx7SaAgdtprYoZlAshzFN+kTaBEXOrWoxa7BeMHnuKwZzOiTAeJI7PIWglv2ylG+7yLSWVEic0psMehLi2OB9eCIiNIWt9B8HNeLPow6o2AY/37AQr9qnzJ4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QPPZgK09; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36865d109dcso11368495a91.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 20:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779937586; x=1780542386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4J5mJMP9YWZVlhj9armvKuV994c2vU0LljAhFOdkDPE=;
        b=QPPZgK09Mu5/ZwRwDq9UNDEhwTbLbVhf8t6KHMjBMBSeqx0WbN17pQ7EBaFDyAgCbu
         vi6PF38RXrApE9aJ+7PlHUxRjQB7EyLdIbIWFnvljT1PWzpntr9BdZW9i96CniTNKqcC
         qxB5I5Y/lVO0hYLRlhye4lmQM90PBGWwr4i9mof4u6VOlWa2b4THJsRXJfhsIgChHVsa
         mYhI1sLqTavCRHO36UdiInQBQhe3oHs9/n2JpeRo4y9ULheD34D/SkHTnn9gO/B02nkY
         mgZuPwiGqHTUcS/9fT60BvpeoSmG7lY2TcO8m5f2fy74L9VqNSB4MUUqbZZJup1P8zpK
         mUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779937586; x=1780542386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4J5mJMP9YWZVlhj9armvKuV994c2vU0LljAhFOdkDPE=;
        b=VvNrKr2n9Aa3NKz81DwXQl8w0PyxLCVQbZThzIJqDvsc9KaBpguzkk1HqkxNqcF2Z7
         mHPayl909enqneoTWIU3nRT1azYWNLrh7N618zVKqJaCoHaXjN8OTxN/f+gRNwmP+bGQ
         MHlsxkLbnTBIpnL0Rtl4jcXpOQROWarM+FUbwmzHfkGpRTyD7d+rJEeWHnXZSQfkyTJV
         uiYDxReSq8whK0AWq+4waUbxhOFedKEzSKMdEwK4Hn3b0IBrsk1tc1rILyjGmR4JsHAb
         c1CHyU/VpfAWMRwPkO+gKdI9RJoYayuUzNGZffPG20Yhwh8+WhKjHFB9PNuT+yd0Z/x1
         S0Tw==
X-Forwarded-Encrypted: i=1; AFNElJ89sjJ3NUJJOGlbQiFmHZr4wNNUWpNvswHreCd071mcWED2hqASGw8WA9CT5cLOp/IACA5/ebk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoaJDoOvpcH3ajpPPuJ2nsUhoJ75tMo/OFqF11fHV07YLwDhB
	ez8r1wMmjT0IiUvYrv0N2NGENIZDyrNSPm4HcFcQKTp+PKh1tgv8WfC39W7orrnlDYzxmvuNtHp
	ESZLBiCLS03pSxA==
X-Received: from pjbfa6.prod.google.com ([2002:a17:90a:f0c6:b0:366:260e:87a8])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5188:b0:369:7421:b36f with SMTP id 98e67ed59e1d1-36a678479d6mr24285194a91.21.1779937586208;
 Wed, 27 May 2026 20:06:26 -0700 (PDT)
Date: Wed, 27 May 2026 20:06:04 -0700
In-Reply-To: <20250421192205.7CC1A7D9@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250421192205.7CC1A7D9@davehans-spike.ostc.intel.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260528030604.2669758-1-jmattson@google.com>
Subject: Re: [PATCH] Handle Ice Lake MONITOR erratum
From: Jim Mattson <jmattson@google.com>
To: dave.hansen@linux.intel.com
Cc: andrew.cooper3@citrix.com, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, 
	rafael.j.wysocki@intel.com, srinivas.pandruvada@linux.intel.com, 
	stable@vger.kernel.org, x86@kernel.org, meenashanmugam@google.com, 
	eranian@google.com, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254708-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmattson@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:url]
X-Rspamd-Queue-Id: BD1AC5EC0FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 21, 2025 at 12:22:05PM -0700, Dave Hansen wrote:
> Andrew Cooper reported some boot issues on Ice Lake servers when
> running Xen that he tracked down to MWAIT not waking up. Do the safe
> thing and consider them buggy since there's a published erratum.
> Note: I've seen no reports of this occurring on Linux.
> 
> Add Ice Lake servers to the list of shaky MONITOR implementations with
> no workaround available. Also, before the if() gets too unwieldy, move
> it over to a x86_cpu_id array. Additionally, add a comment to the
> X86_BUG_MONITOR consumption site to make it clear how and why affected
> CPUs get IPIs to wake them up.
> 
> There is no equivalent erratum for the "Xeon D" Ice Lakes so
> INTEL_ICELAKE_D is not affected.
> 
> The erratum is called ICX143 in the "3rd Gen Intel Xeon Scalable
> Processors, Codename Ice Lake Specification Update". It is Intel
> document 637780, currently available here:
> 
> 	https://cdrdv2.intel.com/v1/dl/getContent/637780

The erratum says, "Due to this erratum, the processor may hang."

We are seeing some Ice Lake Xeon E5 machines panic due to hard lockups, and
then the kdump kernel dies with "Fatal machine check from unknown source."
Is this behavior consistent with this erratum?

This seems to only happen on Cloud machines, but we always intercept
MONITOR and MWAIT on Ice Lake hosts, so I'm not sure why virtualization
would be a factor.

Thanks,

--jim

