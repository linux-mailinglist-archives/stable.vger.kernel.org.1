Return-Path: <stable+bounces-241741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FA/Olvu8GkvbQEAu9opvQ
	(envelope-from <stable+bounces-241741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:28:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62683489F75
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B3F4301DC27
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693363C6A39;
	Tue, 28 Apr 2026 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmSvDPUw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7993D9DDF
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397007; cv=none; b=Qy47hOoq3bD5y4S/MPcsQXEeRZf63smQ2/QBExTkuUE5IPz7cjNj8SltDQBBJZjBVd0rPto80Kou6eWczomsi3Pvz5fkidRYb90Nw5+sGvxilL0jN/pGsDBvptw5ebJEMW8dP9XLlj9T3UekrKMv3bfS6HzKZJqvBIZaLM0ZAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397007; c=relaxed/simple;
	bh=3aMdOtMpqlBTT24ejBqMq7bPGzf+z94awI41Ku254OQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FC9wGfrg5UaOvOimJDn93MciLjL8lnVU2ACNzzuCqhClxUAvie7MGTsDypDZ0xFX7lFviCHfj1Q3vy5hqocYGziE3LQtGrgNXMcOYg4YHb0Iby6QteiNovDUgK7A/y8pbxZjn0akfPu3yZtTuFdp0eXoUCj4hCLy7UR80BzHMzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AmSvDPUw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so33704a12.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777397004; x=1778001804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3aMdOtMpqlBTT24ejBqMq7bPGzf+z94awI41Ku254OQ=;
        b=AmSvDPUwzS5PV7ATUYNBXU/Tmg141K0FcFKNc09gLIya9Isd1DnyU5fsq/JWliYwx4
         PiM9FJFTlDF6f7Xo2BGUrjkp0mMf/cSBFPg0LlS7gcQBIVRWaPSiaI/Ps5QGzPK96hkU
         +FgUiVpfh7nuIlLpHh9MKlRF94l9hgo4Iv58xtV+nxLoP/GWYdHXFgNaZG1DmKoFjfkf
         wdx+6fFMNyXTYMZJ6m1f6VVTFPKNrWUyWUk7QuZslWAHTj49FyqPnfMZesbHSGfHxPD0
         sTDERulTcLDp/LWQ4kZa7rP7tvpmaQ+FvFtrDasG47clQbU3gKegCf6YcS9641LpHUpw
         PvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397004; x=1778001804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3aMdOtMpqlBTT24ejBqMq7bPGzf+z94awI41Ku254OQ=;
        b=G8ddSii5mT0KcHHhNStbgFvidlfS9EyNB2IMbGrK713aU2YqknlH+/phK3OAfqyog6
         pYig5zZxMhZyrpuezM89JGfhKgEPlfA8EDjHM572xHJftgrjpmkfj3SlpGUqdTpc4Zdf
         BRuZZGNm8Y9SEE0FuQ0WD/yAk2Ybv5Y0Ji43F0bWWjW+erCnLCvgvceYbpO/vxFTPmVS
         nv/uOO1YjtwIohOxJR4020nXwJRq3YNfdeqHfhUNvVfNKMjpeGFMdv53LdLWR7qwngMw
         VGua/Q6OPzMIaKveQwXfWWzQtene1nBhR18OrlP63xXy53eSOQZuK+XlmnUEcqa3iPy9
         ww5Q==
X-Gm-Message-State: AOJu0YwaB3z2Y+qPQJbd75wLjg6b3WPmhTLVgP20D4ex+bDuMxb5/BrI
	guMdVzW4X9lNBOQ9ulOp3zrl9sQLUsWSWUA0dytHi5Rl+1kMPzjyzNdoTYG5iHneWCRxI4LjPCJ
	DrO+poA==
X-Received: from pfbmb8.prod.google.com ([2002:a05:6a00:7608:b0:82f:60a5:8a3d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a0:b0:3a0:c285:e511
 with SMTP id adf61e73a8af0-3a39c653fa5mr3681088637.24.1777397003609; Tue, 28
 Apr 2026 10:23:23 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:23:22 -0700
In-Reply-To: <20260428120545.1970058-6-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428120545.1970058-1-d-tatianin@yandex-team.ru> <20260428120545.1970058-6-d-tatianin@yandex-team.ru>
Message-ID: <afDtCg-8DyaPb-0s@google.com>
Subject: Re: [PATCH 6.6.y 5/5] x86/bugs: KVM: Add support for SRSO_MSR_FIX
From: Sean Christopherson <seanjc@google.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Sasha Levin <sashal@kernel.org>, "Xin Li (Intel)" <xin@zytor.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, "Ahmed S. Darwish" <darwi@linutronix.de>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: 62683489F75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241741-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 28, 2026, Daniil Tatianin wrote:
> [ Upstream commit 8442df2b49ed9bcd67833ad4f091d15ac91efd00 ]

This shouldn't be backported without also grabbing upstream commit e3417ab75ab2
("KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 <=> 1 VM count transitions"),
otherwise non-KVM workloads will get hit with performance regressions without
any benefit (to them).

