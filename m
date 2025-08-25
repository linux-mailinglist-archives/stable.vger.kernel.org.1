Return-Path: <stable+bounces-172889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97746B34C17
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 22:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE00A1B22FA7
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 20:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D7723A99F;
	Mon, 25 Aug 2025 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElhzTwIz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A55393DE3
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154072; cv=none; b=s6pqECwKIjEdsjuHqCr4I8o2j5IutCxScEysBZIhuV8uB1qyKC2hbo1c0QXL1bJHleLjudmDidR90o2mDcS/rXrWLJ9u80ytwF/OgiQnD20lKoJna9tTCd55/qU0BC93up4/dvMF3vFAbE5Rcb/DQZBvCPGYTjbOs0PKJzUAnYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154072; c=relaxed/simple;
	bh=aDP7K9/kZj9nMgnK5D4ZzDEcJkxOAUQHNi5eDsmgUrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vqd2T5idtcxryZLJxv7aD1DITBbnN5yDS3LLzhFjneVUog5p52NAk9aLio0pN1gcPNGwqkeR16lsgrL3NB2Fcmd2ATlecNsk23wcIzrhPx+ggcqHzC8o2+TzxBhenprzx9qitPXQjHm73o0+o2Rq2OpMRlPj97bt2eDRJuUojo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElhzTwIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F08C4CEED;
	Mon, 25 Aug 2025 20:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756154071;
	bh=aDP7K9/kZj9nMgnK5D4ZzDEcJkxOAUQHNi5eDsmgUrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElhzTwIz+FFltcle9/h9SKXk1oqwsoUwqNT3jdHSKgvmgB1k4rfy9wXlPtEV9rOWU
	 Z2am7IZQu96EPnE3XnaP1sqEC2ln5kJpOlAopB6AVyoRmab+QSbxKFBtpSeTl04qg5
	 JenZGDwLc03Tw3SvaHhKP73EoQhtclRtGJ4JJ/Y3AVMxq6OKHcGgEf/tdNnMQXLxY0
	 tlAJSE9/gPn/iRxJ414b3hSqg58nyDGll4tzR10rZKW/dXL5enpDieYB3CFiU41eqE
	 8THXkqB5SAqNG8CmU/pKv7vdmMzEYDN/TbL4BoaXLNLTBVnv8CK6T2iDQv6fFQQsCh
	 Shg0GNCRqLMBQ==
Date: Mon, 25 Aug 2025 16:34:30 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Subramaniam, Sujana" <sujana.subramaniam@sap.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"akendo@akendo.eu" <akendo@akendo.eu>
Subject: Re: Backport of Patch CVE-2025-21751 to kernel 6.12.43
Message-ID: <aKzI1g0ixwmI_KQM@laps>
References: <GVXPR02MB8399DEBA4EA261A5F173FE268B3EA@GVXPR02MB8399.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <GVXPR02MB8399DEBA4EA261A5F173FE268B3EA@GVXPR02MB8399.eurprd02.prod.outlook.com>

On Mon, Aug 25, 2025 at 01:12:27PM +0000, Subramaniam, Sujana wrote:
>   Dear Kernel Developers,
>
>
>   Hereby we attach patch backported from kernel 6.13 (as proposed by Greg
>   k-h on the full disclosure mailing list) to 6.12 for CVE-2025-21751
>   vulnerability.
>
>
>   This patch was tested on metal and virtual machines and rolled out in
>   production.
>
>
>   I hope patch is sufficient for cherry-pick. Please let us know if
>   something has to be updated/modified.

Hi Sujana,

Thanks for the backports! There are a few issues that needs to be addressed first:

1. Every stable backport must reference the upstream commit being backported.
The patch description must contain the line "commit XXXX upstream" where XXXX
is the full SHA-1 of the mainline commit. This is mandatory per
Documentation/process/stable-kernel-rules.rst section 2. Without this
reference, we cannot verify what is being backported or whether it has been
properly tested upstream.

2. Stable patches cannot be submitted as attachments, especially not
base64-encoded ones. All patches must be sent inline in the email body using
git send-email. This allows for proper review, commenting, and application by
maintainers. See Documentation/process/submitting-patches.rst section 7 "No
MIME, no links, no compression, no attachments. Just plain text" and
Documentation/process/email-clients.rst for configuration guidance.

3. Missing original commit message: The patch must include the complete
original upstream commit message, including the problem description, solution
explanation, and all tags (Signed-off-by, Reviewed-by, etc.) from the original
commit. You cannot replace this with your own description. The original commit
message documents why the change was made and is essential for understanding
the fix. See Documentation/process/stable-kernel-rules.rst which states
backports should be "equivalent" to the upstream commit or a subset thereof.

Please resubmit following the documented process. You can find examples of
properly formatted stable backports on the stable mailing list archives.

-- 
Thanks,
Sasha

