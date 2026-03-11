Return-Path: <stable+bounces-224767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLSzF2besWm2GgAAu9opvQ
	(envelope-from <stable+bounces-224767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 22:28:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E0226A655
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 22:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 507C8307E84E
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD834EEF9;
	Wed, 11 Mar 2026 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LgrzI6x+"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30532AAB5
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264482; cv=pass; b=dwYLOrlmV2l3RsgtnxFr2BwZFDw++oaG3clhPcvssSr/wKP2KHfK66px/AAqwK1wfssRH1MSJiFTcT6OlGWvNwd2hiZ/9ityVHKjf6vzIUgY520IYkwfBEACSB+jOEaxMc+++vdavIWgbBHGDhbYkZKKIj7EWOuQHoYirCEIEtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264482; c=relaxed/simple;
	bh=RmS7wYS8Jzhr/lMEOKbcBY/EHfzfw9Nb/Q+uINT0q/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWpZX7NQRjDcSQpfaH45KcLLOb+vh400fe1OIqfdo0b/Txm6FFqcLzfVSysPi6taP+P7GXiPQ05XbeC9eMumrlmmqz57nylv1yWNMKAonqY6AREQcvx+bWfBIQBZBuKsX0g3Ficezv+g2MkpsqvpDdXYogK0TJm9suDHXrT10Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LgrzI6x+; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4648447e29bso169360b6e.0
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 14:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773264480; cv=none;
        d=google.com; s=arc-20240605;
        b=VrnHOhw5Aow0RMrf3N0gly0MyweGGAl5mu2bYEUSSlBxgE0GQHbQyJXwuTaxoolXzv
         isGWfhsmZ7PdeIsaxaLZ8tafma2CBAidDVSRdsFu+EnxXxD9n38uzgPcvu2f/2XSuInU
         JmuPFSx5qpAZToBHgNzRZG47ha3fEwuU8U8wT2LyOy5rooRQZuBH7aNoaKOUAkK+K9NN
         Nh2ifaaMJm1sNfOg/PdmBS5JCtMvWOEPNhoXCgoTLOpG+9AVdA71oYtpe78Raat6q+LB
         vPlQ54Lte37KCWyffwmy91FALIx3Wjd1tCBmgDV6BXnWwwpnbrVBt/IHgm+vq5557RLw
         i5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1AfpscOl23y0kgBvUSVae0SftirJC1B+VE/VgHXoA/E=;
        fh=979N3qmwvc69vHPxVonw6hKxzSWV2OVR4ZEOOGVYIPk=;
        b=SUPH+fCoKyNJ943yZ4S5xhi/Q+S8hmegppxAUADtu1qhdnRts+GyRxT0bFy19thVXC
         p+dH7SheOm7C85V8wfgvGZ3yk8rb8/QqcnJGFkMnJAc56aZmEay4dYSMvmSn1RLkPZVb
         5lZLgkZsfPzld92L2B5sYbUq9d7u6+/BjashSb7puJV5QFeSBKtfaadK0cRifj+TFcG2
         WsWi2w3ogiv9rI6oQ2Jat0BzfPabQ4vvsQgCmz8NfLpi5KTcJgEl92sGGxb54peT9av5
         YPP0mvv+o2YGAmoYATSCUKnl6G+FWQwAiRQv9u3ey8jRgUCwDh2sh7msQOX+fGCEcB2T
         YvIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773264480; x=1773869280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AfpscOl23y0kgBvUSVae0SftirJC1B+VE/VgHXoA/E=;
        b=LgrzI6x+GX1mRxy6psZsL2ps9BtK5Xm/DrWGSaCv9IOU4O6oma5dqpdM86lTzY1T78
         n81Re8ZvTLDlVTjDHQRqNlE6Xext+JHVUVOjDXW7NlxVb2PYMGcqpUCHLXoZMt1pr/MX
         Gy/AIiwbVI2q7hMUm0K22AaUMmo3DR7VGJsjNJJk7BuXM5G6AG+3vtS2MWJADf+X53fa
         fgJ1nUjCqwUGRojQCd/BlYzYi++ZdeNd2rz0VzMVnhP0FifVn3LgzZUnI9eTQZZ/Ur6R
         Rf1WfAa6ff8a7X3lN4xvqS3ItLVZLrGz9rd1Xkw3RqCT6dOFEfpGsHzGW1F0qxGz4o9A
         bBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773264480; x=1773869280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1AfpscOl23y0kgBvUSVae0SftirJC1B+VE/VgHXoA/E=;
        b=pRK02wqkRf2+uf/2tDPiy6SeL+M01uF8wqJAqZDLz0lcjbIqIrnF3RjFhi1pl3fy/g
         6u2aquDKeeemlC590W1I4j+/+gmYYfHxgBRZ1gNqiW4vvVltU4rnL7k1QMFCfAXIeCB0
         S6TTgFqtIcj272z8PvOFuR8CceyatS6hSExedN/Z9a1nb5Mk0bGxm8l++8EE0bl4nRRM
         FnnqgJCrIZnoiv6ruxaecJQ4cUzFfQZ0+fd7eRBMRuoDsZyWzUiVGk0886829VwbvRlC
         iq1AQh76cwbtAI0MtgSn5Q8r6NllcCHcMCPXpI2hijgKwGzPaNXELeSvOSeHqT447y4g
         iEpA==
X-Forwarded-Encrypted: i=1; AJvYcCXoRiZ/iUkPcAqCxmqTlIjDw38mDmq9TcBh9PvaP9NioI3nj3I5qhMeYdeBaERHAUQIRYdrsik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFdFAdWZb8QoZRb2LdgdcuEpCI21vctRcBFqd8uiB2OELcctJ
	Fc491+E1ceK06bJnjMDGos+9X4b9uK0JSIZrqq0YHbM/FH8aFEPY9hgAluxgatSx6OPv+5irdM4
	uEUBUJzplwg3Mgd+6b1V0uK8YftI4FEYbVLvIE1eK
X-Gm-Gg: ATEYQzyIW5dqFRMr4iLWawpmYO5xaDPKyXgZjS+e2OVyji4J4ow/RycefudSW3E8tj6
	s4uSLc9Rg1//eE9XlA9wD8/8SWbPUyQVJ/aaMzb5Zh4s9X0WndV06qvE1sqLhtC2LaRiKBabYlL
	DZnedurUcPo/f4HA4jTRhdxSir+aWgpvpPmiConvhh18X5cdMhqiTk3rLe33rUbIQImnFo7BhIl
	pQ/6KCYuEILNNjgFsqI1WB6XgDvnej6Ui60zQQeLrN7OWjZTfIXskkKGSrhBxBCKMjFowcBHiW9
	KVMrgThGSCeKvHMXxDlh2RZbHUsGV4bb6CLlMDoOEpjV8aW2KpMNw1mrC9PVMKoNAGdFNXSZYG1
	0gWIhnQ==
X-Received: by 2002:a4a:ec43:0:b0:67b:b4b3:821e with SMTP id
 006d021491bc7-67bc8a5a4c1mr2166715eaf.64.1773264479583; Wed, 11 Mar 2026
 14:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216173716.2279847-1-nogikh@google.com> <CACT4Y+b1UZpV_i68cSP3XOBsr9EfbX+SAbXRdL3btmAnSvmMBA@mail.gmail.com>
In-Reply-To: <CACT4Y+b1UZpV_i68cSP3XOBsr9EfbX+SAbXRdL3btmAnSvmMBA@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 11 Mar 2026 21:27:48 +0000
X-Gm-Features: AaiRm51S07yNuW3cPcrVSq28S7hXGinZghFBDdce6BA-XJE8j8KP7kq7NftJAfo
Message-ID: <CANp29Y6xexyfGo0umf38JK=6k4Mg+EGRyDmVfuxyAgpX8FxE9Q@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: Disable KCOV instrumentation after load_segments()
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224767-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nogikh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B4E0226A655
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+Cc linux-mm

On Fri, Feb 27, 2026 at 2:26=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com> =
wrote:
>
> On Mon, 16 Feb 2026 at 18:37, Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > The load_segments() function changes segment registers, invalidating
> > GS base (which KCOV relies on for per-cpu data). When CONFIG_KCOV is
> > enabled, any subsequent instrumented C code call (e.g.
> > native_gdt_invalidate()) begins crashing the kernel in an
> > endless loop.
> >
> > To reproduce the problem, it's sufficient to do kexec on a
> > KCOV-instrumented kernel:
> > $ kexec -l /boot/otherKernel
> > $ kexec -e
> >
> > (additional problems arise when the kernel is booting into a crash
> > kernel)
> >
> > Disabling instrumentation for the individual functions would be too
> > fragile, so let's fix the bug by disabling KCOV instrumentation for
> > the whole machine_kexec_64.c and physaddr.c.
> >
> > The problem is not relevant for 32 bit kernels as CONFIG_KCOV is not
> > supported there.
> >
> > Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> > Cc: stable@vger.kernel.org
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>
> > ---
> >  arch/x86/kernel/Makefile | 4 ++++
> >  arch/x86/mm/Makefile     | 4 ++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > index e9aeeeafad173..5703fa6027866 100644
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -43,6 +43,10 @@ KCOV_INSTRUMENT_dumpstack_$(BITS).o                 =
 :=3D n
> >  KCOV_INSTRUMENT_unwind_orc.o                           :=3D n
> >  KCOV_INSTRUMENT_unwind_frame.o                         :=3D n
> >  KCOV_INSTRUMENT_unwind_guess.o                         :=3D n
> > +# When a kexec kernel is loaded, calling load_segments() breaks all
> > +# subsequent KCOV instrumentation until new kernel takes control.
> > +# Keep KCOV instrumentation disabled to prevent kernel crashes.
> > +KCOV_INSTRUMENT_machine_kexec_64.o                     :=3D n
> >
> >  CFLAGS_head32.o :=3D -fno-stack-protector
> >  CFLAGS_head64.o :=3D -fno-stack-protector
> > diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> > index 5b9908f13dcfd..a678a38a40266 100644
> > --- a/arch/x86/mm/Makefile
> > +++ b/arch/x86/mm/Makefile
> > @@ -4,6 +4,10 @@ KCOV_INSTRUMENT_tlb.o                  :=3D n
> >  KCOV_INSTRUMENT_mem_encrypt.o          :=3D n
> >  KCOV_INSTRUMENT_mem_encrypt_amd.o      :=3D n
> >  KCOV_INSTRUMENT_pgprot.o               :=3D n
> > +# When a kexec kernel is loaded, calling load_segments() breaks all
> > +# subsequent KCOV instrumentation until new kernel takes control.
> > +# Keep KCOV instrumentation disabled to prevent kernel crashes.
> > +KCOV_INSTRUMENT_physaddr.o             :=3D n
> >
> >  KASAN_SANITIZE_mem_encrypt.o           :=3D n
> >  KASAN_SANITIZE_mem_encrypt_amd.o       :=3D n
> > --
> > 2.53.0.273.g2a3d683680-goog
> >

