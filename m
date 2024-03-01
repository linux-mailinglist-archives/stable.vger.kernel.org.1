Return-Path: <stable+bounces-25757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E722586E7D7
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 18:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B771C22731
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD46511C88;
	Fri,  1 Mar 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgZuFGSQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E25816FF5F
	for <stable@vger.kernel.org>; Fri,  1 Mar 2024 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315784; cv=none; b=uVvTdsNqEt6PzX0IGTs7B3UVT4+V/FPJ/5+jdX4GlpKt4d7gLy5nOU+fJ2irREF9XX2eHI6kfoZEuuCsBFByoxUhiU5VqW5rFANsvAZLBhdITguiX4vDWWMTuDaHGalIKvq5+bCcfR1ikQWiXiYAvJN9hnKzECOMmlL4UFBxy38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315784; c=relaxed/simple;
	bh=u6Ct5ps+lTEePCGpgTWhcFPFa3IMqzglwxpXE9bg0/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC8FFnED4B8HZ+hC+N73LCJOLT6tQ2I1rSCKLKjfjE4PCP0J/aig/yok4w83R2oGjmvUm/IGQrKsL1CZGe/f4S+QE4VsqZecNoW2yIHLxZ9X+u7sQi2Kn8cFwVbD4fmx9uVFkr7tfGWLvmuDMXYieXAZJ6/s7b5wtlHVSU0WV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgZuFGSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2CBC433C7;
	Fri,  1 Mar 2024 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709315783;
	bh=u6Ct5ps+lTEePCGpgTWhcFPFa3IMqzglwxpXE9bg0/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgZuFGSQderlq1mxFEPZh73gBGr2GtHAMQRF3Y117DXSveL/OePXG8ge1YyvL1r5F
	 iXtjjWq5IBdcHgWDES/2pE46l0hWcmBVXsyqJ2fUqWuh9ROa2ME/DMsiMAppM0uF4c
	 HFE0Kr4gd6oqKK/h0AvPfjMRttRopq3NiSiMOxLCCrB31thiwaxMIg8MfciXoQSo3T
	 i27g+9jTfWKpVYY7QcUDsv6aJVQPUA20t4R3kmEIAXeAApJBIW6yVGGUchkj5MUYyW
	 VA6BwRmmT4Mt93+MqHLrYReIhOeBf/Qjy36I1bWwXRvszp9P/ddaf6vlDYZ81bHo+/
	 kaeiFMovyAHyg==
Date: Fri, 1 Mar 2024 10:56:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Rainer Fiebig <jrf@mailbox.org>
Subject: Re: 6.6.19 won't compile with " [*] Compile the kernel with warnings
 as errors"
Message-ID: <20240301175621.GA2789855@dev-arch.thelio-3990X>
References: <339c80e4-66bc-818d-89c2-2e89cb41c4b7@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <339c80e4-66bc-818d-89c2-2e89cb41c4b7@mailbox.org>

On Fri, Mar 01, 2024 at 03:42:17PM +0100, Rainer Fiebig wrote:
> fs/ntfs3/frecord.c: In Funktion »ni_read_frame«:
> fs/ntfs3/frecord.c:2460:16: Error: variable >>i_size<< is not used"
> [-Werror=unused-variable]
>  2460 |         loff_t i_size = i_size_read(&ni->vfs_inode);
>       |                ^~~~~~

This is a regression that was inherited from mainline because
commit 4fd6c08a16d7 ("fs/ntfs3: Use i_size_read and i_size_write") was
applied to stable without commit c8e314624a16 ("fs/ntfs3: fix build
without CONFIG_NTFS3_LZX_XPRESS").

Cheers,
Nathan

