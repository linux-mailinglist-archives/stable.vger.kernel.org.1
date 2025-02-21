Return-Path: <stable+bounces-118638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B62A4006D
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 21:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF004236F9
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 20:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E42E20DD63;
	Fri, 21 Feb 2025 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7IvXHof"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B545948
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168540; cv=none; b=bf2E2VNRzMdQ9CmP85tHkKKxGe/NrFpDYcLFojIEwgzwenr/+RiLRALPMIgL3Q4DYLH3pfGkb60Rj01qihHaA9JMkaXvVGEm8OhT7fbtbBseUFRzOBWMLo9sz0XrccLDELli+qwATcOzZFE+xj5tlv3zb7s44gFeyDmgJrWvW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168540; c=relaxed/simple;
	bh=DbUCXyOhPh0MtQ7IHJG7PyASJDY3BKB+F0WcyfBrAe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnKkBaWdudS+F0+zy8KEKtSarfeWcma6V+Ez9SVJxEm7lDPnVA43rI1MqcGQO7T2phRkrCOnwXLxACdeGRh/AZkaLr8+NlTmDvMeDcG7MSnS4F++e0EsfwRbK1mdn3CoRfZD+yUtB1oStHIoBJod9pdWn5drUfWoTjY20a6lis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7IvXHof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4C4C4CED6;
	Fri, 21 Feb 2025 20:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740168539;
	bh=DbUCXyOhPh0MtQ7IHJG7PyASJDY3BKB+F0WcyfBrAe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7IvXHof4mKQZSUEfLwSrK1liGRM8xf+w+Xl+M8llR+LVxR1+5ntAK17WXox5G0yt
	 nXQ9IHwGhQausGgRdR9Hl/y/9r4qu3ZCQtXxpZmPfERQPEQ9zzQ4so4nNT+qWbZfUw
	 7iKll/eS0AxDdWdQT3nokngIX1KQyNsSedPxAG0QZdc1e2pjm5LTVc4fU2pFpIDs72
	 zo+/EuReitwDmAsemflg3828YR5QRxRvZaJbcmvJ+5p0jMbJsyIHmlRasMRVZf15+K
	 /1fwjS9//SMwdAD2lEIGYRulxW+PURmyDG1SfY3SatOdb+syZr/8eM1m+DVdx1Wufc
	 /Io5ouN9Sp9kQ==
Date: Fri, 21 Feb 2025 15:08:55 -0500
From: Sasha Levin <sashal@kernel.org>
To: Kamila Sionek <kamila.sionek@adtran.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Backporting patches to resolve rsa-caam self-test issues in
 kernel 5.10.231
Message-ID: <Z7jdVzOM1rcQzM60@lappy>
References: <BEZP281MB3029E2F4767A20F1571F7E0B81C42@BEZP281MB3029.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <BEZP281MB3029E2F4767A20F1571F7E0B81C42@BEZP281MB3029.DEUP281.PROD.OUTLOOK.COM>

Hi Kamila,

On Thu, Feb 20, 2025 at 02:02:03PM +0000, Kamila Sionek wrote:
>Dear Maintainers,
>
>I would like to bring to your attention the need for a backport of several patches to the 5.10.X kernel to address issues with self-tests for rsa-caam. In kernel version 5.10.231-rt123, the introduction of commit dead96e1c748ff84ecac83ea3c5a4d7a2e57e051 (crypto: caam - add error check to caam_rsa_set_priv_key_form), which added checks for memory allocation errors, has caused the self-test for rsa-caam to fail in FIPS mode, resulting in the following error message:
>
>alg: akcipher: test 1 failed for rsa-caam, err=-12
>Kernel panic - not syncing:
>alg: self-tests for rsa-caam (rsa) failed in fips mode!
>
>The following patches should be backported to resolve this issue:

Thanks for the heads up, I've queued them for the next release.

One nit:

>8aaa4044999863199124991dfa489fd248d73789 (crypto: testmgr - some more fixes to RSA test vectors)
>d824c61df41758f8c045e9522e850b615ee0ca1c (crypto: testmgr - populate RSA CRT parameters in RSA test vectors)
>ceb31f1c4c6894c4f9e65f4381781917a7a4c898 (crypto: testmgr - fix version number of RSA tests)
>88c2d62e7920edb50661656c85932b5cd100069b (crypto: testmgr - Fix wrong test case of RSA)
>1040cf9c9e7518600e7fcc24764d1c4b8a1b62f5 (crypto: testmgr - fix wrong key length for pkcs1pad)

These SHA1s don't seem to correspond to a public tree, so I suspect that
you cherry-picked them locally. This made me feel better as I suspect
that you also thoroughly tested them, but keep it in mind for next time
:)

-- 
Thanks,
Sasha

