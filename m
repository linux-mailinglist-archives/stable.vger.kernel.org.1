Return-Path: <stable+bounces-223256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCyEBEq7qWnNDQEAu9opvQ
	(envelope-from <stable+bounces-223256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 18:20:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E0F2160EE
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 18:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BF4A31FDFB2
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1F73E5589;
	Thu,  5 Mar 2026 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNgjk0IE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11363E5EFA
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730733; cv=none; b=fsw82FFZQ5BkPDj/yoyrH7qzrHhdgOEsqG6mMIlM+2Sr0qn32+Aq+l53PcfJg3vz2FVZ7nBqWnjBMXP0sJrxXlqL9io6vxWH1dn4RY1x+iNknV7ECo3R2Zz6RdbAwfwyM198xH8dHD5SnrIApX9jY53wiWWKlKLvTSw+YjzyJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730733; c=relaxed/simple;
	bh=ACFr2OhPuCGST6Z9o4HPkpYoodrDKequHtND0/F2Qis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pMR3uhhXIPRCvh+42xpdNH7gL12g3YYBIWFkxygrQhyb45lT3jwT2Jobihn8/yNJbjkGasF5C1Sq1zwRyk5tnqoA3/v0JJiOqYnMjT8x/W20NDPfJBILPuIM+aniUsd5Fp5UsgtiFmvEmsUNzsp77M084k+VkYvhIEmm6O/Lxdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JNgjk0IE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae47b3adacso47000345ad.3
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 09:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730732; x=1773335532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PlM9Daikr6BhoLrUMNCE8WDUjOiic394LLOjxhE0Phk=;
        b=JNgjk0IE4utwnyNBmsmAJS/ewfMV/EFC0hsgbiogOwcEsNVanNUNtw5WuBiePcNz1E
         1bvuLjwVQJB9Lj0xeZedhVwn1U4cr6G2xHdh+Yw2MzV1qXQ1jqlzhl1yJl2/IgT5JN2k
         EAvzvqJh/HhT0T+l9fF0OqU54Juxfx1DI2NrxSSN1jsv4/gJHlttrZf9Sq5eED8LJmNq
         8oGwK3UGgLyTaPLha/r4Px0NGOjde/20KikB3LPRVzNauYiZ42YKtx55ZdQTpeuxkvjo
         2+n02XiSj789N5cG+Bblr7VNgxr5KXdIovCwyW67Ks8vmGtgHRZYm3CE7wXLpMEBjnj8
         2Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730732; x=1773335532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlM9Daikr6BhoLrUMNCE8WDUjOiic394LLOjxhE0Phk=;
        b=NhBlK3hMSun9FM48bYHH3bRhY9aCp6sPBeJu2vvAArRZd70o526dTXBqMEbx5w6qJH
         geFzby4Ot5j1WgU3Y8yKri9MLUhxzgu52YRHWMfExlH0NDaZcw/dXyCUgl+cVJE9DFdm
         oEIxp0+odIU2Iml73t5QnsDVp4K+rCCF42zsP1jf7LjB3Thzuu3Q4Cn/pLeXMxlLOTYQ
         /Do04ZgG6x2Zvyon3zWDcqXTvKngGNmuSKqG8kn7kW7BRn7fLS2ExoL5dR8lj0cwzYWN
         z8vx4xaMUziu8Nw2vi8HK0Anu5uZrIn+iexowaRXtOvTqTYWVt+ehiEW0zt9TonnQ4QZ
         qWvA==
X-Forwarded-Encrypted: i=1; AJvYcCWRaSPJerFF7uOlZoLhtrtkPJ47hnGs2LKiLrRm8w56jeLAtX6nEw82I5Gjpq0L3QRlGqzzjiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuE1JMw/q7Kf55Vc/tWQqSiH9vTicTLotM+pCqQnqXGBW9PVEM
	ZpJ/7IHlODuIZQp9ez/cFgVgN6KC/4dq+A4AN5q6ovE4vPvkiIDea37PUPH0ICTHFPHkpi3+T8V
	fx7E+Tg==
X-Received: from plha5.prod.google.com ([2002:a17:902:ecc5:b0:2ae:4ac1:4017])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:90f:b0:2ae:5848:baf0
 with SMTP id d9443c01a7336-2ae80130936mr4176035ad.2.1772730731970; Thu, 05
 Mar 2026 09:12:11 -0800 (PST)
Date: Thu,  5 Mar 2026 09:08:13 -0800
In-Reply-To: <20260210010806.3204289-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260210010806.3204289-1-yosry.ahmed@linux.dev>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <177272928930.1563279.2472653538935168755.b4-ty@google.com>
Subject: Re: [PATCH] KVM: nSVM: Mark all of vmcb02 dirty when restoring nested state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 63E0F2160EE
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223256-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 01:08:06 +0000, Yosry Ahmed wrote:
> When restoring a vCPU in guest mode, any state restored before
> KVM_SET_NESTED_STATE (e.g. KVM_SET_SREGS) will mark the corresponding
> dirty bits in vmcb01, as it is the active VMCB before switching to
> vmcb02 in svm_set_nested_state().
> 
> Hence, mark all fields in vmcb02 dirty in svm_set_nested_state() to
> capture any previously restored fields.
> 
> [...]

Applied to kvm-x86 nested, thanks!

[1/1] KVM: nSVM: Mark all of vmcb02 dirty when restoring nested state
      https://github.com/kvm-x86/linux/commit/e63fb1379f4b

--
https://github.com/kvm-x86/linux/tree/next

