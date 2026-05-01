Return-Path: <stable+bounces-242490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNSuMG319GlPGAIAu9opvQ
	(envelope-from <stable+bounces-242490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 20:48:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676C4AEF02
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 20:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A456F301C593
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 18:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF32F3FADEF;
	Fri,  1 May 2026 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSSz+Ixx"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E623D6474
	for <stable@vger.kernel.org>; Fri,  1 May 2026 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661105; cv=pass; b=qWu+Lxj46VrlLUlbDFALzeoO9/+hvvK8f0Xl1id9r4xjeaAdu5CBYRcNuYwY1pJl3NbhKHuXQX+8TZG2u/S2eVQ1wWbHEhQP2TjbHNicRL0VcEgUqMrfscxJqjWaxY7RPW9kW+w9aEdk9/jgJNPkmFuIBi4KVh1tseDITDIGZ3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661105; c=relaxed/simple;
	bh=y8JApZbbblyyxqwWAbL2Lm0l+Wn6ap7FN9cMqj6rFno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roJMP8M0ZPhL4IjHbxyxGGKM5Xe9M63mjvo4bckTK1T388ny6RvcS0lz4stswQYhpAunpDMqMZjIOdRDCYDhZxkdsYIJPY6+m54H+IWkDBOuOEChQgYVpiO1dkmFnSzyt+SRX8Ee1d2QFiqHZCxgTn4WZHGTxbpxYE++4ncTmzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSSz+Ixx; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1270fc2bdf2so1862c88.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 11:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777661103; cv=none;
        d=google.com; s=arc-20240605;
        b=iXGZidx/gK3q2sDSQfaNc3YHKo94ljJCNhbmH+0r7ntQ8q1c4PuTvfEVSTyW3HYTJ+
         +YJZPfbJ1wzFirwWuGRTDQIV2j0k0H1ltTjDZf9gdft+MLktBlMfJrhB8+qYfO7YyvEB
         adfU1DvvPrhZvUtAN8roLrWykg4gC0d8uxi+60N3ybte5Wnpsq2ctY5ZMLUXLoSnFekC
         hBUhNLVotdKuWY9CP8TueCgTPuVc4WRysqEIDKHsPxABksZxavwWlMRBpeGiItrLCnBe
         VIzj/kuR6SGql1+PUD6u2PlVJ8mazETA8jz93+Ba2BFQ4H794PmnZHIJoNbnLoIyWioD
         3dRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y8JApZbbblyyxqwWAbL2Lm0l+Wn6ap7FN9cMqj6rFno=;
        fh=DzQqFMXq4dcsxWcB2xWfSEkN/9raEYBTQ1GZBhgErfU=;
        b=I3hVX4wofNq8LYQOEOs1syPiulsYv6iwG9kFYFA3bGDWJevg0rmWz7Zq36XjX+hOHI
         XZVy+5m3QGHqqj30h5cnXRTTko02olEt+O5NoiBpPK2+kJM2Dl66D9CfAu8V/xzygYiI
         zVt94eQ7MOKMVCR/28oOVuwkBhKdxeCda/ekn+AR2pwXRcnLf5z/aPGCL8ugR5eC4uus
         46omsdrQ9+GldxU/hXhlJ4RlAKWBP4jRrTAwcbedK3ohMdPk/IqCnhP7LFBRn44WDNPl
         w8g87ArI8gAfXkwcn47IWjxkSyTxjffaFqDijSyYrgPILQvw0HIQkmQXWxXjT/I8BzxG
         eDxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777661103; x=1778265903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8JApZbbblyyxqwWAbL2Lm0l+Wn6ap7FN9cMqj6rFno=;
        b=FSSz+IxxgXxy4O3GKOz8MbQ2fR9FAllITZJtV2qkCvmuOWiOzji2ZNEjqVHtx1lOgr
         mH9w/grjWbx0YDrU4OlrAuNxgUGJFTg6YrhqyCy8ApU6Fc6sqtnRa23QwXwxVELkWjdR
         rOzA3AgMv+nHxjt3GI4kIaRHzwdcxNKtEAXy464LdHxoNWMagdBnQdwAi9ri/hwRkw1z
         j1IneRztdoMKMeRiI4ah8G0QUafd+ZLjHAuP89ulwIGu0KpYlOLVqxXuVUjz9Z2kOgGW
         aVtZx8baW2bAZEZHbV+V57gzSwXv8cUilMGU9yL2EgS1QzDIKFf2o92At/f9kCWd7pKv
         dWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777661103; x=1778265903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y8JApZbbblyyxqwWAbL2Lm0l+Wn6ap7FN9cMqj6rFno=;
        b=a2DQH38dFxZcu1MFb1GkFQvZgSmoorvq5mnc+7OuvGU1T6nsm260N5dFOQqBixK7tg
         VbWwTSodGitWjVWApb2i+xUpvzGzzv33OufdEtlS+YGU0ASuua8WjXrVfyx4sJ1UC3ps
         6biMs4rhuYjD//rEiXpztu0+ik0jhvvFlVOvXzhzAu+gYtHAD1qgIGZHzhCLnS5p8Xff
         9pH47IjS955yb/IfsGrwjKOD9R8RYB4wl041p66yBQzcDt7QtYduu93m3jluKnhkaebb
         xGbDlbR49EGmFHXhbdTs73xdFaA3RrGM6X2hdD5PRrdZs4ewQmYqAxcVCj3HkWW2mDLM
         GL/w==
X-Forwarded-Encrypted: i=1; AFNElJ+SzHoUia4VTSxUmJOHJMXI9GwlTy4FJCqVpM6Y46zG2w7VXzPNxU/xEUCMSwUrzMQvK4k0Jqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi8dCxRvFjKzXdis9/2x5FFPA7YdVnJ78nEWDV3EywngZoR+wv
	GEkkofKpA2oxXk37hoboUnE1YWWOls2RNMeY6MAvX3K9lQ7FyNSB9gzQg+Q1GNKK5/bDSlKjSXb
	FU0UDYX2o5kXyME2B+E5cIADKxvnHrNKLBuAsQL31
X-Gm-Gg: AeBDieun2NR7nx7pt9aZtMaa/HrePnBaW+cY0QwG9+ypqDrfhPrve1+b6x9OYVfDg4A
	XdsRbf0ru8U4bJtMsgAkyHWFtBWEpUKFzq5SNRkTqVX9MudGlgh/ShoORvhiKzD9gedcuBvEfqP
	0eFRCUjSkqvHUcdoGjL+UpX/GiGSRd4Zly+9BDl1KwgHffm67S133iP51o4BgHPHQRctwHAmacA
	t4AXYdZD5n7KE1bhBn0rycRLyzaZJGVp99+XuV0WKjdrzOlr8Se7DYjBOHugJbXrVWSkEVktXMy
	frKP2Dy8ZmhykwzjCgkllmzAhceY
X-Received: by 2002:a05:7022:1b0a:b0:128:e4d0:c641 with SMTP id
 a92af1059eb24-12dfda8d22fmr16489c88.19.1777661102744; Fri, 01 May 2026
 11:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429000623.3356606-1-avagin@google.com> <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
In-Reply-To: <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
From: Andrei Vagin <avagin@google.com>
Date: Fri, 1 May 2026 11:44:51 -0700
X-Gm-Features: AVHnY4K0jflN9sHgtdZPpJ1my8yZ3lva3UfcNzS_XcohnR6f1jM2kLF2_2cqSIU
Message-ID: <CAEWA0a5zwHKP51V90A3J960e3o3pdVkSUMYwRJaxiD-fkP-JcQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	criu@lists.linux.dev, x86@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3676C4AEF02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242490-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

On Wed, Apr 29, 2026 at 12:26=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
> On 4/28/2026 5:06 PM, Andrei Vagin wrote:
> >
> > The reverted commit broke applications that construct signal frames in
> > userspace (such as CRIU and gVisor) if the frame's xstate size is
> > smaller than the kernel's fpstate->user_size.
>
> In the extended state area, the sigframe embeds the hardware-defined
> XSAVE format. If CPU A and CPU B support different XSTATE features, the
> layout (size and offsets) differ across systems. However, within a
> system, the layout is invariant. Userspace can query CPUID to obtain the
> exact offset and sizes, which effectively defines the ABI.

I've been thinking about this more, and I believe the claim that XSAVE
offsets can differ across CPUs for the same feature is inaccurate. The
XSAVE standard format uses fixed offsets specifically to allow migration
between different CPU generations. If a feature exists on both the
source and destination CPUs, its data resides at the exact same byte
offset.

This design is what makes virtual machine migration possible.
Hypervisors cannot "translate" XSTATE data hidden in guest memory, so it
relies on these invariant offsets. The CRIU case is very similar: when a
process is in a signal handler, its state is saved on the stack as an
opaque block of memory.

If a future CPU uses different offsets for existing features, it would brea=
k
VM migration. Backward compatibility in this area should be a requirement
even for hardware. If we look at existing CPUs, they follow this principle.

Thanks,
Andrei

