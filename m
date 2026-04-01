Return-Path: <stable+bounces-232826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD1sJ7pPzWkWbwYAu9opvQ
	(envelope-from <stable+bounces-232826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:02:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD8B37E57D
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53FA5301E7D8
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A0B47B410;
	Wed,  1 Apr 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLuvfoMV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B3347A0DA
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062625; cv=none; b=MBOevpVV6rjz3XXtGI+XQ570VZpdiFEjqytdJgauQ12dKUZzrxh0lro07gJhWXtc3Fm9BJd+UjaCbW0FTe5bo09He6+Zgbt7WgUZvOn7zJ6dbE/eKUZEOW7xB3X1vGYrMjINsLCnNqWpiHhfQ0Fz+N+Xx9e5b7iVh/0FuGKsDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062625; c=relaxed/simple;
	bh=9K8qEXFqyzKJpC8ZLLoahNwvyalEjitEt7cWRXS0mT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MdczlozncdX1jOoMkK7Y0gBNtm/YNcuAghHYBMKdPKy4WkK+gmAX2JtQFPRhg1HPHqP111VXNTqQBm8obhVd8SGmR8RBn+CBK2Ebqr91F5NiXvHb0DHgbCQVly8Gm937OVfKB7C+3toyn60Y6uDM3qCEaUYy7ebZz/teF5Cmgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLuvfoMV; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so4474507a12.3
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775062623; x=1775667423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rM2u8ZzUGBvIFzvvpzHw03ujiSHlUv6pEE3M+q9IjM0=;
        b=nLuvfoMV6TZkguTeKhuDEQqxZ8mfUiBdEjsogtcZgmaMMuOF1naOURzGE2v+fDYtb9
         JmFXXKKLMuGvVXRxqrHhhQq+x8n8cDkrUp5/FLvceYDA0CQftVZX6WC6tsfuQiyXnIsP
         bzkKO2Il5VKZHLDsMBSzJ10z3gncjpz1NTjrG7AvnVYAnPs0Ui0TqKYyXQ+Oa24xhvqv
         WDKhdv8zfCK9uqRvHCJloyXs7D9qRZ4HdcC4GmkbhT7R70g6wUnw6n1Nf4HmzoLmDPYu
         YPAknKi3Z8LQWWUTFV5BXBFzLxuwcjKm/SmBpqrxSYTidgW8/bOZaCV/WfXPbn0vPLnK
         XXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775062623; x=1775667423;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rM2u8ZzUGBvIFzvvpzHw03ujiSHlUv6pEE3M+q9IjM0=;
        b=LNUOz28KOlXWT9Obe7N3/DpXmmeDnJVRmTjPyD91OcQ3wpx17EGh7A9vTJLyeXFWRw
         iU0mhrv/+3fFl0Z8Tww7ChtJqEzvr16TVG0MG/+fL6aYaYTxbNV7VAmwVoEafiqe14WA
         1xZADyXNI5V1ZEaPh7isswy/pFfr06HZtn0JjxGGl0mxC9wX9jJzvshlL3yGh4bBqcSt
         ylCLqcxyJsNYDx+XcRWAC+9x6gc8polCRNr4O/W7YoUyweY/jMXG9k8piwPhqGx/l/1z
         cACFtIh/OAtvrmEUgbkeEoS3b1ubF7s04yHd2FcplQTM+z3ft65Wa61mMBtBp0iTfxR5
         ViCw==
X-Forwarded-Encrypted: i=1; AJvYcCVFUgRfe2LXuzqL83q/eNTBynT20+l9n23mATuSt7scl0zYWeaplpB8/1wghyFJQU3uV9j0a4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2PJiDCEcTWN/Wu1v/zFd48YsQpevA5coBa1iEiQ1p5yWJPx0y
	koKZqzjxuvaz5YvAJ+/lN/+tbmW6QDc7CSf3RMVJSLaOCm0GcdutNyUkmR41T4nIP4YUnVxPG/Y
	ZJ6CnUA==
X-Received: from pfbmu26.prod.google.com ([2002:a05:6a00:6e9a:b0:82c:989e:71f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430e:b0:398:9fc9:e077
 with SMTP id adf61e73a8af0-39ef76b219dmr4645406637.29.1775062622958; Wed, 01
 Apr 2026 09:57:02 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:57:01 -0700
In-Reply-To: <CAB29vr=U=SaQR9m_O_cZwEKAG2LTnbYGjE+uT0snUT7Jco_3bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAB29vr=U=SaQR9m_O_cZwEKAG2LTnbYGjE+uT0snUT7Jco_3bQ@mail.gmail.com>
Message-ID: <ac1OXbMbAY4snEPg@google.com>
Subject: Re: [PATCH] KVM: nSVM: Snapshot vmcb12 save.rip to prevent TOCTOU race
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?7ZmN6ri464+Z?=" <jeon1691951@gmail.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, gregkh@linuxfoundation.org, 
	yosryahmed@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232826-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5DD8B37E57D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+Yosry's email used for upstream stuff

On Thu, Mar 26, 2026, =ED=99=8D=EA=B8=B8=EB=8F=99 wrote:
> Hi all,
>=20
> Following Greg's suggestion to turn the proposed fix into a real patch,
> here is a minimal fix for the vmcb12->save.rip TOCTOU race in KVM's
> nested SVM implementation.
>=20
> Background
> ----------
>=20
> The CVE-2021-29657 fix introduced nested_copy_vmcb_save_to_cache() to
> snapshot vmcb12 fields before validation and use, preventing a racing L1
> vCPU from modifying vmcb12 between check and use. However, the save area
> cache deliberately excluded rip, rsp, and rax -- only efer, cr0, cr3,
> cr4, dr6, and dr7 are snapshotted.
>=20
> As a result, vmcb12->save.rip is still read three separate times from
> the live guest-mapped HVA pointer during a single nested VMRUN:
>=20
>   1) enter_svm_guest_mode() passes vmcb12->save.rip to
>      nested_vmcb02_prepare_control(), where it is stored in
>      svm->soft_int_old_rip, svm->soft_int_next_rip, and
>      vmcb02->control.next_rip
>=20
>   2) nested_vmcb02_prepare_save() calls
>      kvm_rip_write(vcpu, vmcb12->save.rip), setting the KVM-internal
>      vCPU register state
>=20
>   3) nested_vmcb02_prepare_save() then does
>      vmcb02->save.rip =3D vmcb12->save.rip, setting the hardware VMCB02
>      save areaq
>=20
> Since vmcb12 is mapped via kvm_vcpu_map() as a direct HVA into guest
> physical memory with no write protection, a concurrent L1 vCPU can
> modify vmcb12->save.rip between these reads, producing a three-way RIP
> inconsistency. This is the save-area analog of CVE-2021-29657.
>=20
> The inconsistency is particularly dangerous when combined with soft

Eh, I wouldn't call this dangerous per se.  Problematic, sure, but AFAICT t=
he
host is never at risk.  My official stance is that any panics due to KVM WA=
RNs
when running with panic_on_warn=3D1 are NOT considered KVM DoS issues.

KVM WARNs are 100% worth fixing, especially if they're guest- and/or user-t=
riggerable,
but the WARNs themselves aren't security/DoS issues, because in my very str=
ong
opinion, allowing use of /dev/kvm with panic_on_warn=3D1 when the platform =
owner
cares about host uptime is user/admin error.

> interrupt injection (event_inj with TYPE_SOFT): KVM records
> soft_int_old_rip from read #1 but the vCPU state and hardware VMCB
> reflect reads #2 and #3 respectively. If interrupt delivery faults,
> svm_complete_interrupts() uses the stale soft_int_old_rip to
> reconstruct pre-injection state, which no longer matches reality.

None of this matches reality though, in the sense that the instant L1 mucks=
 with
vmcb12->save.rip while VMRUN is in-flight, all bets are off.  I.e. from an
architectural perspective, KVM doesn't need to get anything "right", becaus=
e
the L1 hypervisor has firmly triggered undefined behavior.

What exactly goes wrong?  The changelog mentions a WARN, and at glance, the=
 only
one that seems relevant is this one in kvm_requeue_exception():

	WARN_ON_ONCE(kvm_is_exception_pending(vcpu));

> I am aware of Yosry Ahmed's larger patch series (v3-v6) that
> reworks the entire vmcb12 caching architecture and would subsume
> this fix. However, that series is still under review and has not
> yet been merged. This patch is a minimal, self-contained fix that
> can be applied immediately to close the TOCTOU window on rip, rsp,
> and rax.
>
> Fix
> ---
>=20
> Add rip, rsp, and rax to struct vmcb_save_area_cached, snapshot them
> in __nested_copy_vmcb_save_to_cache(), and replace all direct reads
> of vmcb12->save.{rip,rsp,rax} with reads from the cached copy. This
> ensures all consumers within a single nested VMRUN see consistent
> register values.

What is actually visibliy problematic?
=20
Assuming the worst case scenario is a WARN, then I'm very strongly inclined=
 to
either (a) not apply this patch at all and instead wait for Yosry's full se=
ries,
or (b) have Yosry slot in the most minimal fix (e.g. for just RIP) in a sta=
ble@
friendly location in his series.

There are many, many nSVM issues that need to be fixed, many of which are f=
unctional
problems for well-behaved setups.  For me, those are by far the priority.  =
I also
want to fix the a guest-triggerable WARN_ON_ONCE(), but it's not urgent, an=
d not
something I want to spend a lot of effort on with respect to providing an L=
TS-friendly
commit (though if we can get one cheaply, that'd be great).

