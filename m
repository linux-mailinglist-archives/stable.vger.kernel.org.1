Return-Path: <stable+bounces-121418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8309AA56DF6
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CBF47A7AA0
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D0E23E327;
	Fri,  7 Mar 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="rNQFyeHr";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="S4pCFrPO";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="GaNwo0No"
X-Original-To: stable@vger.kernel.org
Received: from e2i673.smtp2go.com (e2i673.smtp2go.com [103.2.142.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDDF23BD1A
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365456; cv=none; b=cvux9nyM4FqU47uzCX5pbGkZt+FXOkQx5ITAAT5MTeE3tX8A8mofVWsmtNe9EOc9pMxKVUNYAgTXCxVfk4FrTxRI6tMTSPqaszxiZsznDr7rqYUfPXEjEn68jRZJsupyU9wG9u7Nnx/LqrvHPn2Asm8b3pveVKwgw286RqRh18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365456; c=relaxed/simple;
	bh=8pkMiSx6kNFRpn5gsNjnnno8KJoOvB8j1owZq3DBehc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5ivnZsE8ngBsYIW8/x+Um2VsEfFjbxANAcVHaMz/Cu4pOfI7RGw00vg+Ialw+BfKdx8w4WHDqFW2vp7MH5Vpcg5S1NTxtzIHUaNWbZ9uU5L6+bMJphTIYXVVLdeUrfQCqP+zN6gMbuK0vReBOOsyDqhQFSbEUihvMQEsSBshHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=rNQFyeHr reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=S4pCFrPO; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=GaNwo0No; arc=none smtp.client-ip=103.2.142.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1741366350; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=0xuOBCxlXCHTekml4DZ7++gFtkwOTvv3ypU0Gidbuw4=; b=rNQFyeHrOQhQJd+qCoYf8GcKHv
	pi/DDrcM6DVx30uvj8mlcA6tjGkw/RySPKxTtSmVijyehf//e1w1HzaSXaAt5kBoiwsXWGQr7wy8m
	3LkJJNKF1bzHiOixFsEuwkazyyNN17IctGeMfJLKfO8bCLOmG2eow61ZaFyXKfJnZftmRw7Hhr4pe
	95Vo0kB10zL5dmwSnrcxOdqOwKaK15mgoyUQOjI+EZCH2+pOfBUXEWMk3o4n65+ou2MMjijktUyiX
	bt+k6Qdmq4iybME9uotovEi7F2T12/dGJbK8wlMuXluaRxPTEM33KE3byszX71NFAcuqpCEGmjz4N
	kBzVy53A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1741365450; h=from : subject :
 to : message-id : date;
 bh=0xuOBCxlXCHTekml4DZ7++gFtkwOTvv3ypU0Gidbuw4=;
 b=S4pCFrPOAF4V3Ac+CIBKsEoJAEp8HmjCn8WWBhCyNfmY2Z5kP19DpDnOn5baoC8/LKLhw
 0vzDSKk7wayS6Pkr5DN2WE9pG91Dj+KSpkcVPsY6QX8LxBeHJFFYBO7h9Ta+7+i/8PbFtuH
 e5EYFaC0p5fe2vGCfeUVH4rJSqDiVYGac8CXVHwrH4nngqckoM4yYREH7GSOimZSlYj1spT
 +eCx9lEPgjM0zh9HUvwATy+GuCyqLliRMOXmIMR0ROsy7WCWc4aT7C2g3qFZOuT3yZBQbVb
 zqpNAmhgrhaHmrhWc4+VoPTVpZUiPQ12aK471yL79s+KoQpyl/u8XJHbfURw==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1tqagX-qt4Jps-Li; Fri, 07 Mar 2025 16:36:30 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1tqagW-FnQW0hPxooy-mr7k; Fri, 07 Mar 2025 16:36:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1741365386; bh=8pkMiSx6kNFRpn5gsNjnnno8KJoOvB8j1owZq3DBehc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GaNwo0NocK9Qf5t+9vpTeOeQe2VcgvVEv9DF6ASoq1aSSrnil0CAY/YFXPnOk3jBP
 Ivd36LHgu3ApWSUkok+l+gigAwFS4q6OQ95KVLE/kxjASIJuyL1YPW2BXbHxnoHgMN
 /hkMh8Pfu0wJ47bKrJkXne4bx6ONGdhQl7aooRsY=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id B6992499DF; Fri,  7 Mar 2025 17:36:26 +0100 (CET)
Date: Fri, 7 Mar 2025 17:36:26 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc: masahiroy@kernel.org, nathan@kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kbuild: deb-pkg: don't set KBUILD_BUILD_VERSION
 indiscriminately
Message-ID: <Z8sgisZ8FI3wkpfZ@fjasle.eu>
References: <20250305192536.1673099-1-alexandru.gagniuc@hp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305192536.1673099-1-alexandru.gagniuc@hp.com>
X-Smtpcorp-Track: vJQ817p1wn2K.Ds6fVEShyTYp.kah5vwRmUzI
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sQTBgZURN3
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Hi Alexandru,

"indiscriminately" sounds a bit weird to me (but I am a non-native speaker); do
you mean "unconditionally"?

On Wed, Mar 05, 2025 at 07:25:36PM +0000 Alexandru Gagniuc wrote:
> 
> In ThinPro, we use the convention <upstream_ver>+hp<patchlevel> for
> the kernel package. This does not have a dash in the name or version.
> This is built by editing ".version" before a build, and setting
> EXTRAVERSION="+hp" and KDEB_PKGVERSION make variables:
> 
>     echo 68 > .version
>     make -j<n> EXTRAVERSION="+hp" bindeb-pkg KDEB_PKGVERSION=6.6.6+hp69
> 
>     .deb name: linux-image-6.6.6+hp_6.6.6+hp69_amd64.deb
> 
> Since commit 7d4f07d5cb71 ("kbuild: deb-pkg: squash
> scripts/package/deb-build-option to debian/rules"), this no longer
> works. The deb build logic changed, even though, the commit message
> implies that the logic should be unmodified.
> 
> Before, KBUILD_BUILD_VERSION was not set if the KDEB_PKGVERSION did
> not contain a dash. After the change KBUILD_BUILD_VERSION is always
> set to KDEB_PKGVERSION. Since this determines UTS_VERSION,the uname
> output to look off:
> 
>     (now)      uname -a: version 6.6.6+hp ... #6.6.6+hp69
>     (expected) uname -a: version 6.6.6+hp ... #69
> 
> Update the debian/rules logic to restore the original behavior.
> 
> Cc: <stable@vger.kernel.org> # v6.12+

Shouldn't this be v6.8, as 7d4f07d5cb71 got introduced there?

> Fixes: 7d4f07d5cb71 ("kbuild: deb-pkg: squash scripts/package/deb-build-option to debian/rules")
> Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
> ---
>  scripts/package/debian/rules | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index ca07243bd5cd..bbc214f2e6bd 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -21,9 +21,13 @@ ifeq ($(origin KBUILD_VERBOSE),undefined)
>      endif
>  endif
>  
> -revision = $(lastword $(subst -, ,$(shell dpkg-parsechangelog -S Version)))
> +debian_revision = $(shell dpkg-parsechangelog -S Version)
> +revision = $(lastword $(subst -, ,$(debian_revision)))
>  CROSS_COMPILE ?= $(filter-out $(DEB_BUILD_GNU_TYPE)-, $(DEB_HOST_GNU_TYPE)-)
> -make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(revision) $(addprefix CROSS_COMPILE=,$(CROSS_COMPILE))
> +make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) $(addprefix CROSS_COMPILE=,$(CROSS_COMPILE))
> +ifneq ($(revision), $(debian_revision))
> +    make-opts+=KBUILD_BUILD_VERSION=$(revision)
> +endif
>  
>  binary-targets := $(addprefix binary-, image image-dbg headers libc-dev)
>  
> -- 
> 2.48.1
> 

Looks good to me.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


