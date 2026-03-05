Return-Path: <stable+bounces-223258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJDEF227qWnNDQEAu9opvQ
	(envelope-from <stable+bounces-223258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 18:20:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B069F216105
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 18:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E3A331BFA93
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDC83E5EF0;
	Thu,  5 Mar 2026 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFsGiG73"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03623E1205
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730760; cv=none; b=fhngmm6/1I0NKe2MRdPZKxJx2RBING9UqafI4eTkVf6fW1lhsIVcoRCIjgoePsadbAQlumAeOYuVbizVdsaXfjQnVwm0ld3wIkshElYm7euHnnQRZjCS3v5wMr3e5gSyufoKFVv2PyJYYb7a1XeFXTWttd9Cw4jf26wapLySudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730760; c=relaxed/simple;
	bh=/GBXVfac68MdWpS9IPkjlYgDOQ7R+pVysyaAoMFshkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tD9FmXvRMHP63lDnI4FC2bZDQjW82wA2BtBAI3KHwy7RqooCNAsLhnI2H/UWPhAu/uXlURkfYbjemD+dM6FE46q2GvKbLbFqcI9hCGqll1PKkrxz+Yw6Sduv5zlLar7RrjFQWcaV8HGWUQmbHrB4ApgealsyBMXNgRtV4IyFkD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFsGiG73; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae65d5cc57so126852255ad.2
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 09:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730759; x=1773335559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xVU6FN0uky/dFXnRa2qLZyTUmWtwIpEtVM3+JzMj2G8=;
        b=DFsGiG73oNRHF3ik9JGjRp9oBJeCINfnncqwo8XWR1/TuKmn1kbLHiTuxG82OJt9Iq
         dmvkw3cagc3zEUMsJ2XpKyM/FAM5Ik16KVMrpe5Dy8whkijpviEDfkiN9c0okmXjatDL
         dOCKRtGDVrEP5RUNyqumtec2eExM4T4oyCEZVzRXgVRaslrPACPYYqZDNA+30/ZxvbEK
         XLFEI5gq/RYIL4Ebdgeqo/iD7HvG4bIFsVD1hCgBeX3qTYpgeF+eZ1SZXswMHe5lqOoS
         ElPTHES+1JGyGrVkGYDOdw07U1ddpdgkcxLLqAHmx/9tr2ofKiRgmmUUtZHPdZ/+oPRp
         b/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730759; x=1773335559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVU6FN0uky/dFXnRa2qLZyTUmWtwIpEtVM3+JzMj2G8=;
        b=Qz7OgO5U6IPe56b6OWcjoNb/YrFhzmwxKmSKRQ/lmwOhWeY6m3JoWGUOtPNeLB29Qr
         3vpzO8F/zS3KcmN4wSy/694I8NE83nsXO9dqz8o7ivUvedoC0gL+fU1CJ9zNOUouXPE8
         BiUrHRoAzAXt/K18EADGZKfZEOTQXfo/TUyraJUdX6RHSfwAM9Nb2cFDSmUS0TQIHKaf
         WbM0jRIMLL2nb/a2sVAvo66kBIK6o0Zd11EKIjb9yL/IEUsUpuu6ei6jtDqHUsfQFopb
         w5+8qtZ/xCN6CalpX5tusCbCsUA03vGg9+/19DDeyL5hYUHj+p5T20Xk1wekujQu8zWS
         RNng==
X-Forwarded-Encrypted: i=1; AJvYcCXZj2eEOwIj94Lx0GNrcuuGXAAeX7EM88H3mwv5ZGEaH2thfR1QP7E0hHul7IBonnN3HGHvKTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1iz0MO+FKb7/6kSRoFsVI+/JrhyLSKGyPgVM4zsoE9SFdl/Ny
	ItjtW1MobcZQmT7ul5IXJpUl3kCNL14hrpv4nyrT+mKRF6N5tYRdMlmni0RJTqA57QHuo8+btcs
	fwP0x5Q==
X-Received: from plpg12.prod.google.com ([2002:a17:902:934c:b0:2a9:63f4:124])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8b:b0:2ae:5104:571e
 with SMTP id d9443c01a7336-2ae6a9deed1mr57715595ad.9.1772730758990; Thu, 05
 Mar 2026 09:12:38 -0800 (PST)
Date: Thu,  5 Mar 2026 09:08:21 -0800
In-Reply-To: <20260224225017.3303870-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260224225017.3303870-1-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <177272744743.1549777.12918725553146045215.b4-ty@google.com>
Subject: Re: [PATCH] KVM: nSVM: Ensure AVIC is inhibited when restoring a vCPU
 to guest mode
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: B069F216105
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223258-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 22:50:17 +0000, Yosry Ahmed wrote:
> On nested VMRUN, KVM ensures AVIC is inhibited by requesting
> KVM_REQ_APICV_UPDATE, triggering a check of inhibit reasons, finding
> APICV_INHIBIT_REASON_NESTED, and disabling AVIC.
> 
> However, when KVM_SET_NESTED_STATE is performed on a vCPU not in guest
> mode with AVIC enabled, KVM_REQ_APICV_UPDATE is not requested, and AVIC
> is not inhibited.
> 
> [...]

Applied to kvm-x86 nested, thanks!

[1/1] KVM: nSVM: Ensure AVIC is inhibited when restoring a vCPU to guest mode
      https://github.com/kvm-x86/linux/commit/24f7d36b824b

--
https://github.com/kvm-x86/linux/tree/next

