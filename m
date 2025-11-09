Return-Path: <stable+bounces-192828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D78EDC439BC
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 08:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD53B4E495F
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 07:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA2926E16A;
	Sun,  9 Nov 2025 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQQWJMin";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtwONP0E"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F92F23D7E3
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762672357; cv=none; b=EYcIEuqkQBvEHXqGAzEpbfujbHH1a9mCE+AuiXjKr7TxZ4WsrfdsBPjVC86cwil/5J7d0uwwdX47GgjMGYPN40nJVbhUzCBCoRqw4oxiiT8v4/hbD8dKNUWcaxT88pLde/4NjcQdjNDyz+UdjIfzQiPdaFXCDXhz360CkVbr71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762672357; c=relaxed/simple;
	bh=AdHoQjrbJVFhbXbn4e53hG++/4NMIHDDh8uAXYDruqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C05p4mMsAjLDZkhHu8hFSLZX6+7UASZsL7qFroBums5SueNNtWeorqRjaCSyL8umkrl0fd1XAg7RY93UEtlb58Nj2Y4z4g5BCOmFtfFClx5oaW4E8r9Y1nyhLZpwUxgb9Kdop7pm9I8jMIuHSjGZVhuy4xIbJ4W3yeijuVasq0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQQWJMin; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtwONP0E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762672354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m82cK3xRCUvbcWhZbxs+7WqSqZtr7xd6qiGXFqz/RDg=;
	b=dQQWJMin8BoFu9Iz8/O4zl1ZszWz+I8apNdzENFNDj7qX5t0VHWqOPQ8pP0HxUa+joPUug
	vx0Lg8RDN77MNIGfeJZY+iL1duaYfkXlLrJWNftgEOs7Iu4jT1P79gWspBRDMNuLWqulsW
	4dTC9pSVlen1tERg2zYRJt2907IPrZc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-wCUKhJ7QOxGeSAmneGuotg-1; Sun, 09 Nov 2025 02:12:32 -0500
X-MC-Unique: wCUKhJ7QOxGeSAmneGuotg-1
X-Mimecast-MFC-AGG-ID: wCUKhJ7QOxGeSAmneGuotg_1762672352
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29806c42760so8042505ad.2
        for <stable@vger.kernel.org>; Sat, 08 Nov 2025 23:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762672351; x=1763277151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m82cK3xRCUvbcWhZbxs+7WqSqZtr7xd6qiGXFqz/RDg=;
        b=OtwONP0Es+55TGk0aJEIkjpgaQ/DMVMlWXLwLBMHJfTv3apandFkzEAcqym3Ui8Jos
         NhrbT3w6CQ1ZBJs6gOzqNg9cyq7uQEaNc9isTC0tqemkCAYQQGMP+wolasoYWQ+ZQsfM
         qOrDV3+0dL83+BLPCYjt12n6ZuV4I/4pha0BivSod32mgJ7FCbyMZMsctnyUd64e+hUb
         sAI/DtmU6AC8WlKMcJkmG/mXbjDYYObyNAe41/g3rP0ih61iJI5mNHYqnPh0yiYZ12lV
         /52VqGq1+lrIdr9nuirgNrSPo5R+ND3/kMqqxPITYEtaMITjrX0TYqc3UF/kBH4Sc2BK
         ZJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762672351; x=1763277151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m82cK3xRCUvbcWhZbxs+7WqSqZtr7xd6qiGXFqz/RDg=;
        b=M0pS2WRUuWhqC+bdBvqE6eCwqTCIDEaJMBsAFlNQvDvemCclIBJ17jrc+6cZyj9pgn
         4VKPGKTQ18F0tBNUxs1FoLgSroiUOvBGt/8shW1UFsMn9I4fiwomOY+FqfZJBDp1gq99
         2/P7pOfqc9W+jtQYDSH/JGebDMdDO/yp7QIbv4Q4GnBFj7y7ILuEW1sV0XKcwOflp0jB
         0ijKPYLXwNPaxG6ZuCU7Ig6aAp1A9mHhKe5UzeI5CHwMwZu/ns28CoqDgWGn/R/2W0gz
         +O1/QaTiJyQYvrN5M0d9TCCGW8MnK42JeRSAAlM0q/oS0Ys3cDUBFugDfwFtNpayfIRD
         I2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV+03zbQx7PQEOd4Ojw+2TtG5y80QxByEZ9dsvbTdXc0JwxJDAylJciGlQXAMbd+sygLWnyIOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsT8Nm54Cf4PL3DodQzhpvLgdusgEtpI6QyZTOPP/NHbf4P7d0
	UWLwo/gDqd2BIlNsMi5147D8aXFCannHqbn96ADh1SUXYH4nJ+9ITTDYX6kll7cW4+WrZKm5KlR
	AnTxa81y26nDFJyZAJNNBIItIGsjf+N/6QJCA2qufqyJmJk9sZCJpKb4YgCfhdUNXgSN069XI5W
	D0ym0ji4AvW8lduShQEnNSWifqoLJYdaXP
X-Gm-Gg: ASbGncvmRe1ir6eruvo093V7jjoEUixNvBw+8/Yzy+DyF5i+/fF9PcQkV3ZQNUJ6jvL
	IgUyWKzIWdVC4F+wxEU37kEO2MaIKxYrxpQJE6BhHDW79oAoB/xz22GCvi5hfYPCMn3yf5cLCnP
	ETzvVZw5koVn6Nh5UPDQ7kEPOcUSDVeKY/D1xbHcj4g+imvs0elJCvSXep24BGZcUdvuLOtGIll
	8OndtrqdHsIUSMy2ZO+Yj993Lgv8QbNNh+nAwQtc7F/nOPJVgwxGRlsLY6u
X-Received: by 2002:a17:902:e78f:b0:295:68df:da34 with SMTP id d9443c01a7336-297e5718086mr51623605ad.53.1762672351603;
        Sat, 08 Nov 2025 23:12:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmxSGLvw4pgRZ8aTw3qCykYC8xSzISK8rwIn1R2Gkp0ELn8flQDD1U9o+r1UzqIM5FPkf2ioy3/4F0I7hTmD4=
X-Received: by 2002:a17:902:e78f:b0:295:68df:da34 with SMTP id
 d9443c01a7336-297e5718086mr51623375ad.53.1762672351274; Sat, 08 Nov 2025
 23:12:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108120559.1201561-1-maz@kernel.org>
In-Reply-To: <20251108120559.1201561-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 9 Nov 2025 08:12:17 +0100
X-Gm-Features: AWmQ_bkaJ1JaU0aGn42MK0o7nRRGD7HuTETuGXjvrbkmq0cZ5a-Jnj8bQX-Px3w
Message-ID: <CABgObfa2ShbRn-MctT7-y4joG85AgtjgKXM=OJA9_2FbDZ6XPQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 6.18, take #2
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Maximilian Dittgen <mdittgen@amazon.de>, 
	Oliver Upton <oupton@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, 
	Sascha Bischoff <sascha.bischoff@arm.com>, Sebastian Ene <sebastianene@google.com>, 
	Sebastian Ott <sebott@redhat.com>, stable@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>, Will Deacon <will@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 1:06=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> Paolo,
>
> Much later than expected, but here's the second set of fixes KVM/arm64
> for 6.18. The core changes are mostly fixes for a bunch of recent
> regressions, plus a couple that address the way pKVM deals with
> untrusted data. The rest address a couple of selftests, and Oliver's
> new email address.

Pulled, thanks.

Paolo

>
> Please pull,
>
>         M.
>
> The following changes since commit ca88ecdce5f51874a7c151809bd2c936ee0d38=
05:
>
>   arm64: Revamp HCR_EL2.E2H RES1 detection (2025-10-14 08:18:40 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-6.18-2
>
> for you to fetch changes up to 4af235bf645516481a82227d82d1352b9788903a:
>
>   MAINTAINERS: Switch myself to using kernel.org address (2025-11-08 11:2=
1:20 +0000)
>
> ----------------------------------------------------------------
> KVM/arm654 fixes for 6.18, take #2
>
> * Core fixes
>
>   - Fix trapping regression when no in-kernel irqchip is present
>     (20251021094358.1963807-1-sascha.bischoff@arm.com)
>
>   - Check host-provided, untrusted ranges and offsets in pKVM
>     (20251016164541.3771235-1-vdonnefort@google.com)
>     (20251017075710.2605118-1-sebastianene@google.com)
>
>   - Fix regression restoring the ID_PFR1_EL1 register
>     (20251030122707.2033690-1-maz@kernel.org
>
>   - Fix vgic ITS locking issues when LPIs are not directly injected
>     (20251107184847.1784820-1-oupton@kernel.org)
>
> * Test fixes
>
>   - Correct target CPU programming in vgic_lpi_stress selftest
>     (20251020145946.48288-1-mdittgen@amazon.de)
>
>   - Fix exposure of SCTLR2_EL2 and ZCR_EL2 in get-reg-list selftest
>     (20251023-b4-kvm-arm64-get-reg-list-sctlr-el2-v1-1-088f88ff992a@kerne=
l.org)
>     (20251024-kvm-arm64-get-reg-list-zcr-el2-v1-1-0cd0ff75e22f@kernel.org=
)
>
> * Misc
>
>   - Update Oliver's email address
>     (20251107012830.1708225-1-oupton@kernel.org)
>
> ----------------------------------------------------------------
> Marc Zyngier (3):
>       KVM: arm64: Make all 32bit ID registers fully writable
>       KVM: arm64: Set ID_{AA64PFR0,PFR1}_EL1.GIC when GICv3 is configured
>       KVM: arm64: Limit clearing of ID_{AA64PFR0,PFR1}_EL1.GIC to userspa=
ce irqchip
>
> Mark Brown (2):
>       KVM: arm64: selftests: Add SCTLR2_EL2 to get-reg-list
>       KVM: arm64: selftests: Filter ZCR_EL2 in get-reg-list
>
> Maximilian Dittgen (1):
>       KVM: selftests: fix MAPC RDbase target formatting in vgic_lpi_stres=
s
>
> Oliver Upton (3):
>       KVM: arm64: vgic-v3: Reinstate IRQ lock ordering for LPI xarray
>       KVM: arm64: vgic-v3: Release reserved slot outside of lpi_xa's lock
>       MAINTAINERS: Switch myself to using kernel.org address
>
> Sascha Bischoff (1):
>       KVM: arm64: vgic-v3: Trap all if no in-kernel irqchip
>
> Sebastian Ene (1):
>       KVM: arm64: Check the untrusted offset in FF-A memory share
>
> Vincent Donnefort (1):
>       KVM: arm64: Check range args for pKVM mem transitions
>
>  .mailmap                                           |  3 +-
>  MAINTAINERS                                        |  2 +-
>  arch/arm64/kvm/hyp/nvhe/ffa.c                      |  9 ++-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c              | 28 +++++++++
>  arch/arm64/kvm/sys_regs.c                          | 71 ++++++++++++----=
------
>  arch/arm64/kvm/vgic/vgic-debug.c                   | 16 +++--
>  arch/arm64/kvm/vgic/vgic-init.c                    | 16 ++++-
>  arch/arm64/kvm/vgic/vgic-its.c                     | 18 +++---
>  arch/arm64/kvm/vgic/vgic-v3.c                      |  3 +-
>  arch/arm64/kvm/vgic/vgic.c                         | 23 ++++---
>  tools/testing/selftests/kvm/arm64/get-reg-list.c   |  3 +
>  tools/testing/selftests/kvm/lib/arm64/gic_v3_its.c |  9 ++-
>  12 files changed, 137 insertions(+), 64 deletions(-)
>


