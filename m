Return-Path: <stable+bounces-94696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491829D6E0F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5941619D1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 12:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3150B187858;
	Sun, 24 Nov 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4cyyXc3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57783BB24
	for <stable@vger.kernel.org>; Sun, 24 Nov 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732450009; cv=none; b=GsVvEc5GGt0Gqbb6h8+y9asLLKaAjsvygeFUxjr5Cs7v+LFTGKW4ytkmn4I8+5tJ3Yl9XsosgpeR2CYNK/n7KtnD5kRM+OVYCLcn0wVIsQyWecJjwu3AjBgYN/jgX/4/b+KMJK3HRbvO1w1IWyfiUVhoDXLmTlowoM9oH/s2dA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732450009; c=relaxed/simple;
	bh=B0Xu/ZoPlTgXTowqveaJ5XHK9bhaY3UFYTwUygaKz9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdsWqGkKzZBw3/tQDnlqiY98kZ4iDdYUQwvVKUZmTn04/n2FFIrTSjZqGjH9B8wMI4QlMAgVbIijxHrJIxbCOBRJXZ0PQh8Zfn4jYXieITLRuSjE+vtom8s0N2T2vcZzPr4W+5VisY2G7CRQ5YeuvN0WTbSDw98+qdZqNAfBi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4cyyXc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F17DC4CECC;
	Sun, 24 Nov 2024 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732450008;
	bh=B0Xu/ZoPlTgXTowqveaJ5XHK9bhaY3UFYTwUygaKz9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4cyyXc3spF62dXBeKFv7o+jb7NazDiqRvleG2SZ3/rsnr9bS7DEWkgCp2tlhXbGm
	 7JXKs9tA524mAMt9Hs9bchMr1ZXr19z88XxXFYneP1SC0shPBotQHQlMwU5DfG4VA4
	 gcKtas7OlNNTFdY5/Fp5R5WF1ewTjiIlwXFuTDtRrqPG5ps8HUHRlhKksWhcXo9XB0
	 IPxxv5qz2sOICJcA52WenseK1E/nkDhA7mS+DS7Pv+RkSx2uDFYEfnrbj2m/7PgJ6Q
	 QM44Riw1NtkQOyvk4q2DJWcEz+srQ0Fl5vlYxnTIthZJdJIZwDWo8ygsea7fwJR7Gc
	 LdzogfY+/yTEg==
Date: Sun, 24 Nov 2024 07:06:46 -0500
From: Sasha Levin <sashal@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6 1/3] net: fec: Move `fec_ptp_read()` to the top of
 the file
Message-ID: <Z0MW1uDtuxOtbl7_@sashalap>
References: <20241122083920-54de22158a92c75d@stable.kernel.org>
 <30b031c5-b3f4-44e4-9217-c364651ab28e@prolan.hu>
 <Z0HoasOBIo1y_vjc@sashalap>
 <fa9bdf83-cfbc-4d80-b4c3-dc04d2e89857@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa9bdf83-cfbc-4d80-b4c3-dc04d2e89857@prolan.hu>

On Sun, Nov 24, 2024 at 11:47:41AM +0100, Csókás Bence wrote:
>On 2024. 11. 23. 15:36, Sasha Levin wrote:
>>On Fri, Nov 22, 2024 at 02:56:40PM +0100, Csókás Bence wrote:
>>>Hi,
>>>
>>>On 2024. 11. 22. 14:51, Sasha Levin wrote:
>>>>[ Sasha's backport helper bot ]
>>>>
>>>>Hi,
>>>>
>>>>Found matching upstream commit: 4374a1fe580a14f6152752390c678d90311df247
>>>>
>>>>WARNING: Author mismatch between patch and found commit:
>>>>Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= 
>>>><csokas.bence@prolan.hu>
>>>>Commit author: Csókás, Bence <csokas.bence@prolan.hu>
>>>>
>>>>
>>>>Status in newer kernel trees:
>>>>6.12.y | Present (exact SHA1)
>>>>6.11.y | Present (different SHA1: 97f35652e0e8)
>>>>6.6.y | Present (different SHA1: 1e1eb62c40e1)
>>>
>>>1/3 and 2/3 of this series was already applied by Greg, only 3/3 was not.
>>>
>>>commit: bf8ca67e2167 ("net: fec: refactor PPS channel configuration")
>>
>>Dare I ask why we need it to begin with? Commit message says:
>>
>>     Preparation patch to allow for PPS channel configuration, no 
>>functional
>>     change intended.
>
>We have patches that depend on it, that we need to maintain on top of 6.6.y.

It doesn't align with the rules at
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html,
right?

-- 
Thanks,
Sasha

