Return-Path: <stable+bounces-114167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C2AA2B205
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 20:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1E93AA2ED
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 19:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4181519F464;
	Thu,  6 Feb 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktnqYp0p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4323959B
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738869179; cv=none; b=LCHVQgsJ67zA+3z/IGZu5Undmy8mpE5LwvA87oVF9svKxZug/tAsXo6Bh2/rvU6I0Nkk4Gb5iNyoTq/BwWjE/KE3QddqFi1zetA7do6PWVzVDZiJO1LL7XS8UFjmhcqz78Lmw50E0LiBHThH0VR3uZntY5v8ZUnreyiskvevWL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738869179; c=relaxed/simple;
	bh=g9/g/hpUUywCC6oyxEmQw01HogHxdD6MoRuJVjntsiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrTyBmB0jcRpP3s+rrik7tnHpq1wpOerdF1bT3kWGblLXf/R5JOLdht9sV99/3BMlPhElepjayEGDq2Pmc5QobQHyMPCmmYDe75PKgtAFmapxma8SIlngh7AkrwSv1EZfnBVL8z158m98YmVOkTa5t5k2YDQzWgivLKczzg9m2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktnqYp0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B887BC4CEE0;
	Thu,  6 Feb 2025 19:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738869178;
	bh=g9/g/hpUUywCC6oyxEmQw01HogHxdD6MoRuJVjntsiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktnqYp0p/btUoBkPX5EIvvqEirIqBp/Wz0b38Bh1kBQj17p/6hDw3zy368JIKput7
	 89Rqp7LxNfhNiQ2FqZBfm17aCOSvfWTwa8GAK9Oe6awvMXk7GAXHGGknE8/lD+4/yQ
	 57ppLhBLeawa+kAWYPo9r7sYA+nK92S5X5dx1a4DKVJ+PAFxYXTs2CVRse1nsUK9xA
	 kjHe3vtUBbJsYB5Wp/mphJrtoaK6F/QnZrTvZuRKIOKVg6WD+Q6fd6S9dL+K3llZ9e
	 No5a9bdBpSLXQI4R4ggKoX3h/LxsPOlZ2vbl65D8oab9VklliW2EC2kj6ik+deSR/P
	 oLE9wNyVpUtjw==
Date: Thu, 6 Feb 2025 19:12:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, eric.auger@redhat.com, fweimer@redhat.com,
	jeremy.linton@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	pbonzini@redhat.com, stable@vger.kernel.org, tabba@google.com,
	wilco.dijkstra@arm.com, will@kernel.org
Subject: Re: [PATCH v2 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Message-ID: <9972d29a-1387-408c-9070-d53b025191f2@sirena.org.uk>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-9-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TAjyd6cungso5X+6"
Content-Disposition: inline
In-Reply-To: <20250206141102.954688-9-mark.rutland@arm.com>
X-Cookie: With your bare hands?!?


--TAjyd6cungso5X+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2025 at 02:11:02PM +0000, Mark Rutland wrote:

> +static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
> +{
> +	u64 zcr_el1, zcr_el2;
> +
> +	if (!guest_owns_fp_regs())
> +		return;
> +
> +	if (vcpu_has_sve(vcpu)) {
> +		/* A guest hypervisor may restrict the effective max VL. */
> +		if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu))
> +			zcr_el2 = __vcpu_sys_reg(vcpu, ZCR_EL2);
> +		else
> +			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
> +
> +		write_sysreg_el2(zcr_el2, SYS_ZCR);
> +
> +		zcr_el1 = __vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu));
> +		write_sysreg_el1(zcr_el1, SYS_ZCR);
> +	}
> +}

I don't think we should worry about it for this series but just for
future reference:

These new functions do unconditional writes for EL2, the old code made
use of sve_cond_update_zcr_vq() which suppresses the writes but didn't
have the selection of actual sysreg that write_sysreg_el2() has.  I
believe this was done due to a concern about potential overheads from
writes to the LEN value effective in the current EL.  OTOH that also
introduced an additional read to get the current value, and that was all
done without practical systems to benchmark any actual impacts from noop
writes so there's a reasonable chance it's just not a practical issue.
We should check this on hardware, but that can be done separately.

--TAjyd6cungso5X+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmelCbMACgkQJNaLcl1U
h9CrEgf/TGgo4RVmaJxXS634U8oUIbNEIuXqOQJAqsTazdIud+hAZMt+dIaXwL+7
fNdixA7N2DycoddigmHo+3CMMWlhdqjUx+6KKg/hA/RLflnT3LyT4h/lmRgxiz8d
6MaxnP3+7vRubFCHotGBIQayLt5VhIlOYpwDikHcXAU2xWd7i0tAYqkzUivQJD2z
mT1QjZOh7Dd/AKNOH9z2PeAfEn/EsMksgzWl3p/ElBEQ2Qbyq7GVadyGn6xhLooP
UyQLxrI+ReiZj2kXHa6kez9GYlhABFU9dlz0VDUtKLlgdR2m4mC7HJ4bTWm/xuaD
6pR0opLZp/dGO/Djx6pnmvuH+ri02A==
=FSAp
-----END PGP SIGNATURE-----

--TAjyd6cungso5X+6--

