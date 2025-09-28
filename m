Return-Path: <stable+bounces-181842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5FCBA744C
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 17:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29E318987DA
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC8821FF23;
	Sun, 28 Sep 2025 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHep54s7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440433FE7;
	Sun, 28 Sep 2025 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759074031; cv=none; b=FKKLQfRZFQOZxZBBBp8v1Uu1voVLad4aykga6E4uMzdAZCamH76ktw+4p3bSR3fOa+W/uma3yfQlYFWp4a+RaUY1AiWcqqRpPDAAquSPNlexWj3BszkiFmMw5jZp0GrbQDPAg3PQakQfLlB0o9pu4Hcp9iPJquy6jnSawZ50wlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759074031; c=relaxed/simple;
	bh=b0de0Z/0mGlKlrQQmIMMsn9zuYbulciUJ2X91panIB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6zOezvi/bsufOr/Lmf7R4DTVMc7hPB1lZ1zl+HcA56FBks9D736q9mwdGTKjJ9wygRymMpNqGxk9fBREskdUCmiBHcjbwoJdmg3VZy8DAgZSjS6DokXNTaKLSA1paoreQJKLxSJUB787SR8vX5MhHxmEH/VSBLPgZavoib2+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHep54s7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8094C4CEF0;
	Sun, 28 Sep 2025 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759074031;
	bh=b0de0Z/0mGlKlrQQmIMMsn9zuYbulciUJ2X91panIB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHep54s791Z+5VD8WUmCtOT2r5OfqlnZaoJbGuqhfFH84n8mc9n9Lv23TsXbu6o4O
	 gr42uFFiL5vFWm6CLwq1OaI/n1HZSgQxqRgZSGQYHp2B3MF88lxOaGCb1dy1HrnQgG
	 aNsMa3zeH9yWwI0vvEFFOgDtvpg5XOAfNdVgEzuAv62VLEnayTr4Q16Sy16RTMKmoA
	 UnbY+z9rgW00GnLxjYpEqhWlr5cy7U/ViBpwaQOdXfWkeoeUmZCaRAb+kcOILxE+BB
	 WPuG8E5NWH7vDlQKmO3Z1blqu98nQbGREpWq7DuXVAHa0k+GBiI0ooDVIdNL6ntqGw
	 UuCyptQQAM+eQ==
Date: Sun, 28 Sep 2025 11:40:29 -0400
From: Sasha Levin <sashal@kernel.org>
To: =?iso-8859-1?Q?Iy=E1n_M=E9ndez?= Veiga <me@iyanmv.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org,
	regressions@lists.linux.dev, daniele.ceraolospurio@intel.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] drm/xe/guc: Lenovo Thinkpad X1 Carbon Gen 12 can't
 boot with 6.16.9 and Xe driver
Message-ID: <aNlW7ekiC0dNPxU3@laps>
References: <616f634e-63d2-45cb-a4f9-b34973cc5dfd@iyanmv.com>
 <88ffbb16-bd1a-4d96-a10d-69516f98036e@leemhuis.info>
 <92577e77-3f40-45a3-8e67-d9c6f5ffeb86@iyanmv.com>
 <aa72cb3c-bed3-413d-840d-05aa72a60c5c@leemhuis.info>
 <afd60150-7371-49f4-a95d-d9147e067757@iyanmv.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afd60150-7371-49f4-a95d-d9147e067757@iyanmv.com>

On Sun, Sep 28, 2025 at 01:16:34PM +0200, Iyán Méndez Veiga wrote:
>On 27/09/2025 16:31, Thorsten Leemhuis wrote:
>>Thx. Could you also try if reverting the patch from 6.16.y helps? Note,
>>you might need to revert "drm/xe/guc: Set RCS/CCS yield policy" as well,
>>which apparently depends on the patch that causes your problems.
>
>Yes, reverting both dd1a415dcfd5 "drm/xe/guc: Set RCS/CCS yield 
>policy" and 97207a4fed53 "drm/xe/guc: Enable extended CAT error 
>reporting" from 6.16.y fixes the issue for me.

Thanks for the report and investigation!

I'll revert these two.

-- 
Thanks,
Sasha

