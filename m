Return-Path: <stable+bounces-254429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNbMBGjxFWp7fQcAu9opvQ
	(envelope-from <stable+bounces-254429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:15:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D65DBE09
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CC80303BB1E
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB573C140E;
	Tue, 26 May 2026 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9Hb7E4l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE63C13E1
	for <stable@vger.kernel.org>; Tue, 26 May 2026 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822897; cv=none; b=tJ1GWuGXJFRQcEXr+6P4Yg4eBt26SdkGZeyBRKSIHos+5405eNr7+z9UHp20HWF/Bq5DUSjfIIrerpCo7c4/s4ykU9i5wCt0RCaNlyQoabgaaEFanAurk9UPdnWN/r9wrs3NkdPf1i6HakHTl0G4xVtJXgS1fyoxPPPsQtWXUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822897; c=relaxed/simple;
	bh=dKF8dhPCpCOpz8wBx+QwX3wSntBAN0hT0/ziOW11cl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B0rUKXqZ8rOZIvnsxg4tuqcxqv9kDtSiJL1+VoGWbDnJGZc4KqVRmfuXRuxiNE55v2NNGq4nyECxyLizbrQVpnf47T9HWei+QrNwzTQMyLfeJlRo057pU5osHAnb+WZQSmEUNz+9k86jc8yv3vb/ZVYmGo2rIHv5EuzvDaJjQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9Hb7E4l; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4678c6171so119286755ad.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779822895; x=1780427695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwn3Zsnn2yuB32x6MdgS3rMVrimBb61d0On2s1kwTYc=;
        b=I9Hb7E4lnhBMLAh1Pki01RhJmumzGYygpjyotfQp2ooYKEzn2bkrKeW6GW8jsVhSCd
         fY1iLviXPW8ZJWeew0X//IjjeKqUOixtntA5f2xEy3eQcKI9PJUHgJ9omIZRrbs8NV3S
         VEfe3Os5STDzzP9F+fkE+8HWieNHvSSkQo0mmpMpRzFZMqjHrEgKYd8NkovLs/KOjutq
         goBKMkThQKgZiV92ltTHEZIAe+LNEZpaxKE27pJR24UBB/fr/YFsdZzvmk2hAzMdRMKE
         qsToqPmyJzJziBtK1I9Txfi7gFzZbeWiniOF94SDcwY2QsL7FhYIkTol+XtYGDqNl6r+
         K8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779822895; x=1780427695;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mwn3Zsnn2yuB32x6MdgS3rMVrimBb61d0On2s1kwTYc=;
        b=DLW9lRihJF7HEYIjn7vJAp2/HpFhfS8QKP//uLDL8JbM16A6G3rDfi0zDD0xmKJf3G
         wotYadprSrAlGXqJiOEhyCsWID0y6G54BqvuBIkozhG9987aTrLnehXjvvFKx/UtRq1Y
         Xp06d6ctr8MwFvqH11L3SALiPCHuAFbZ2BwpdepggS62L+mRIFIgQ6uQB0147oxZxdRS
         FCvBscwEtk1RhFXDDZYRqERYgFB6XY55JtHWnkqZbE+JiCDvmcVy+b3O+LHozTWtW+pD
         LUXnqZI1odgT6gnh/hZrytMFwZmoFtOrrIAGmLU26lIt6s2H2aNnmWb1JOINjjq1zzKe
         U+kQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aoKCDToD3xyklQAkjki2TrSkvE2TRvT3yKHjc+OlNfkBRvLplanWrWA3IYtt8NDvuXehhQ8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/6gQmXfHkmATN58Gg8TDeafqIG8Wwwa4ZfiA4dNH0bll514t
	d08bW4fdPsCBr8C65F3fy6ymqOzGP3IX/NJY69hqSIf1icz0/5TIRg2YQuBatidMCSK/5FutQkz
	axqMuqg==
X-Received: from plec21.prod.google.com ([2002:a17:902:f315:b0:2bc:ae06:63a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b84:b0:2bc:db35:96c7
 with SMTP id d9443c01a7336-2beb07ed803mr208583365ad.28.1779822895127; Tue, 26
 May 2026 12:14:55 -0700 (PDT)
Date: Tue, 26 May 2026 12:14:54 -0700
In-Reply-To: <b4dd2e22-2364-40ed-a06f-4082adb309d1.zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ahBScosf2jUlKdAt@google.com> <b4dd2e22-2364-40ed-a06f-4082adb309d1.zhang_wei@open-hieco.net>
Message-ID: <ahXxLup2MZkyli1W@google.com>
Subject: Re: [PATCH] KVM: SVM: Disable AVIC IPI virtualization on Hygon Family
 18h (erratum #1235)
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?5byg5beN?=" <zhang_wei@open-hieco.net>
Cc: kvm <kvm@vger.kernel.org>, pbonzini <pbonzini@redhat.com>, 
	mlevitsk <mlevitsk@redhat.com>, naveen <naveen@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254429-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 622D65DBE09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026, =E5=BC=A0=E5=B7=8D wrote:
> On Fri, May 22, 2026, Sean Christopherson wrote:
> > IIUC, family 18h is carved out entirely for Hygon, correct?  I.e.
> > there's no risk of disabling IPI virtualization on unaffected AMD CPUs?
>=20
> Yes, that is my understanding.
>=20
> The original Hygon enablement [1] uses Family 18h together with the
> HygonGenuine vendor ID to distinguish Hygon Dhyana from AMD Family 17h,
> and explicitly states that only Hygon is expected to use Family 18h.  So
> this should not affect unaffected AMD CPUs.
>=20
> I can add an X86_VENDOR_HYGON check too if you prefer making the
> dependency explicit.

No need, I just wanted to double check.  And this is already in Linus' tree=
,
commit 9a12fa5213cf ("KVM: SVM: Disable AVIC IPI virtualization on Hygon Fa=
mily
18h (erratum #1235)"), so what I would have preferred is irrelevant :-)

Thanks for the follow-up!

