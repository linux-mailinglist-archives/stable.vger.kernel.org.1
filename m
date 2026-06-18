Return-Path: <stable+bounces-267169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J9WxNVUXNGoQOQYAu9opvQ
	(envelope-from <stable+bounces-267169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 18:05:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF7F6A1777
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 18:05:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h5ujQVV2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267169-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267169-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5330730241BA
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A39A304BB2;
	Thu, 18 Jun 2026 15:59:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD102F0673
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 15:59:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798394; cv=none; b=sRdLnshXN2nh6cepmWB/Yr6UwWyWI4R9vieIdbEDCxtt6y/yWQu0DDO1XJIk6nbwdtv5XsPubGgUbBuxhKKO96MpKyea2PTWpar9Ls6XF3+GlbpAPQ20e8tCllNgFOWB7O4wLk4uyxQg2m23sn6er32lopE9KfKZ5ttS4s9v2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798394; c=relaxed/simple;
	bh=E/y+8JHnTb2d61AU1IWkSWGOzzfnMcc6kvneJqFfPXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJVNX/dhsv2Lt6wHTWYb8V0aPDRSuKMfbE3GJdSv0cIyILvgLsuX5XivRpa0AxaGCea84OGdsNMAPoLfNQcFkh/KXeTe4gkvG+f/eKJw9rBsJYMhRyc5Q5NTirtnuTzlJsh5qOqczZfy/aDaQ30uyNsZUvuufIlZCMOIwiZ4pMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5ujQVV2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0B31F00AC4
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781798393;
	bh=E/y+8JHnTb2d61AU1IWkSWGOzzfnMcc6kvneJqFfPXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h5ujQVV2unfhhUt4y37D9VvddJG3uiubKL/E6PIYh5HGICwvn4/W9jVD9qDIRtyer
	 Aor6nKt33SyXviyzg+R6hmpA1QTgdf4AgvdBgLjIwm4obAKPWd2orntN3xI6SYFpfx
	 fHeAScNm61TpVUXNqcK7te1RUXawZ9QnD8oYKNI+ZUfZSU+QESqjN70FHD1XaQSpH/
	 DmEmyR6tPyfEkcKyuR0wf/gAlut+qEUKFI8T/eGim6ucb+v58bksvDkFxcVodm1oBA
	 PNet5eu+2pnhsPdDkjPl2f7LxagmBm3vFRrDNxS6V9CNYeVXPv1yWfGENZv6vRJMqm
	 w0rKP4LVoWNjg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c07fd4dc2c8so84960766b.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:59:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8dA31G5X7o7k0rIayrDYCkggm5CKjcQ1Z7kKLtvWKttHm8B/fQSOfTdMB7amRtNhpyna10Kpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbES5KPQ3tVP5Kqek1FJNiMDh5VwcLoytr+2JVVntq3iqzvGk
	7qy/BcoQzgDCkPXLWckUQ58skAFs+Mf0y76sLBa52I4Z+Vn6s+fKycffjICgoD/+UhlF7yjjaPN
	bJ37V9pALJvv4I0PbqD4gr7wSsIzUBg8=
X-Received: by 2002:a17:907:26cc:b0:bfe:ed06:5a16 with SMTP id
 a640c23a62f3a-c074e7bdfc7mr268582366b.52.1781798392113; Thu, 18 Jun 2026
 08:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616214652.2157032-1-yosry@kernel.org> <20260616214652.2157032-3-yosry@kernel.org>
 <3551571b85bc94a7b0a9eaf9e3c5561e46c5423f.camel@intel.com>
In-Reply-To: <3551571b85bc94a7b0a9eaf9e3c5561e46c5423f.camel@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 18 Jun 2026 08:59:40 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO7W+nPQWAzZzqqEWs9c_tHgYpb-wp=5PXXx5x0ePG2Mw@mail.gmail.com>
X-Gm-Features: AVVi8Cc8lUAhY1yGX9oBQ_QzAfruGIkFYg_kzzB6F_neljHEng7bFmdzI5Pl7bA
Message-ID: <CAO9r8zO7W+nPQWAzZzqqEWs9c_tHgYpb-wp=5PXXx5x0ePG2Mw@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: nVMX: Decouple INVVPID operand checks from
 flushing of vpid02
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "jmattson@google.com" <jmattson@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267169-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kai.huang@intel.com,m:seanjc@google.com,m:jmattson@google.com,m:kvm@vger.kernel.org,m:pbonzini@redhat.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BF7F6A1777

On Thu, Jun 18, 2026 at 3:57=E2=80=AFAM Huang, Kai <kai.huang@intel.com> wr=
ote:
>
> On Tue, 2026-06-16 at 21:46 +0000, Yosry Ahmed wrote:
> > From: Sean Christopherson <seanjc@google.com>
> >
> > Separate the INVVPID operand checks from the actual flushing of vpid02 =
so
> > the flushing can be adjusted to do the right thing when vmcs12 was last
>
> Nit: vmcs12 or vmcs02?

I think vmcs02 is more accurate here, good eye.

>
> > loaded on a different pCPU, without having to duplicate the logic acros=
s
> > multiple case-statements.
> >
> > Opportunistically let the VM-Fail paths poke out past 80 chars.
> >
> > No functional change intended.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
>
> Reviewed-by: Kai Huang <kai.huang@intel.com>

Thank you!

