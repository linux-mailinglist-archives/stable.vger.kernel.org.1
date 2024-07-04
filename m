Return-Path: <stable+bounces-58011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBA2927000
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 08:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D381F243BB
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0074C1A0AE4;
	Thu,  4 Jul 2024 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHtHFFRg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930671B960;
	Thu,  4 Jul 2024 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075942; cv=none; b=uMGF9D8mrd8ibv4D6ZUCpHvijqAMl/5obn+O714KfOc+yVFSP97cmWfJY1ZwuBzXM4iY36bZ9pdNY8ON0nchurk2+YCgcBrS0BT/m+LIfnypxHqlJ51wumUYHXzqOxsgm8UzdKNORBOCXK+8Mdmk7c23/3o6+9wztCXgBUjmcW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075942; c=relaxed/simple;
	bh=AbbkD8QGrQK5+Az2vQlPRB5MMIbzZidfDuhnrw52HQ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HH1p4c9LvCRcQYhRMl/I6PE3ag7jh4YxtB4J8Rs7NoOlApr3I2YUDvX5zvSROloGs7lLrfeHDc95CFNWyH/0VdiFxKajT4TQN5psrkyVcV1yIQRpdVS03jL5qMqDgkmZD1sMmfBXYDOGiaXTZ137+PWPO++qmc/9tbNZ2lxMPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHtHFFRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D882C3277B;
	Thu,  4 Jul 2024 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720075942;
	bh=AbbkD8QGrQK5+Az2vQlPRB5MMIbzZidfDuhnrw52HQ8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DHtHFFRgVSbONvqa5SX+U5QoIdZYjOsOvo44/G3l3tm36zbOYLH8iFbyZbC/hhSWV
	 fcJDKapQrGY2L5Siq+TohbYZ1Cd7bcyfPt6n+paqi5TAIBtVUSSGRLAhs9HMWhBQwc
	 AOXFYZeY8iWMIAonS3vqvfIyUHWSwi5ek5oVkbe1kn/2OL1/FNRIS2wzKO1tToOZjn
	 C2rhogX3ubVLVqBiu/YbT8dBpgsYmqvrPXpVrUzCttq/l11tySFVf4SqeV0of6+wn0
	 p27oRoQgU5pgjv48CIgudoGqMaZLtg7dBw1VeVEIj/WECfhU08ytjcNpy6zTbnfWJc
	 VY8gwkCROvc2Q==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 09:52:16 +0300
Message-Id: <D2GK14M15OCE.XO5Y1ZPO01CG@kernel.org>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, <stable@vger.kernel.org>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] tpm: Address !chip->auth in
 tpm_buf_append_hmac_session*()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240703182453.1580888-1-jarkko@kernel.org>
 <20240703182453.1580888-4-jarkko@kernel.org>
 <c90ce151-c6e5-40c6-8d3d-ccec5a97d10f@linux.ibm.com>
In-Reply-To: <c90ce151-c6e5-40c6-8d3d-ccec5a97d10f@linux.ibm.com>

On Thu Jul 4, 2024 at 4:56 AM EEST, Stefan Berger wrote:
> [    1.449673] tpm_ibmvtpm 5000: CRQ initialized
> [    1.449726] tpm_ibmvtpm 5000: CRQ initialization completed
> [    2.483218] tpm tpm0: auth session is not active

This expected result and the driver should work as expected.
And it correctly reports that auth session is not active.

The reported error was exactly the TPM errors, which I guess
do not happen anymore.

Reported-by counts as much as reporting the symptom you are
having, i.e. very different from something more "suggestive".

Does that count as tested-by or not?

BR, Jarkko

