Return-Path: <stable+bounces-100450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B09EB5BC
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32550188340A
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AEC1BAEF8;
	Tue, 10 Dec 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNyKLcLf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8723DEA7;
	Tue, 10 Dec 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847153; cv=none; b=Mn0G+hH8gUEnYNB3dsPTYklhQ3JBhkDk39YmSAFwtX+JEfO0y5jAU2hXYUKgTlOiPcpAlgoZKaRqyvMEhvwFyYbYL87jAXydOK0K201ZMDApli6tuZJdMipdj6Z1zZDVEgMCMtlFTPJesYYU0Pfb1SStfEbLLtGbWAsgggykUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847153; c=relaxed/simple;
	bh=aeFcHfhyyi6Hrc1ORc56BM7zT3V7KDTDRrWatg2IVuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbMz5fstnyxC29siXg347DTABSblSVubi5CCTyE8AhJ42EZnITXaSNMwZIq+sRSSlz/neU50Vlb3YGDQSshOFf65U76nd+kXkBWGMoLtu5lpARwCRz1JMzF0uumzeTXaS3OcikKBY3Oa4nKp7tIGN7lMS16euy3pnlIaJOzQ23A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNyKLcLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D41C4CED6;
	Tue, 10 Dec 2024 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733847152;
	bh=aeFcHfhyyi6Hrc1ORc56BM7zT3V7KDTDRrWatg2IVuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNyKLcLf9TBPZY/+magH1b8HAo631nln+OPc5sR6f4ayS8hvBfvwQPECC9oIm9ag5
	 LCeTAGJ8duFEitSd1+oL2LJp9rHp5BH4DocBeF2Bv8BdcJtdCaHyWooP0i2kXRRUvq
	 ZcLqGR+StgEpRHOLLCIw3mPcZElRJNRJuN6fbGm39WIn5xZ55aptvWyx9tlGVKz24c
	 KMF8WTpz3g1u0nx65+IjO2ma/Pj0w759l4H3HgL3Uh0tj4dNNLLMonbl4+8bAZYCu6
	 FTJJv/kq4mgaYBi6sPjghLxgc3fEXCou7AiLit1XNSNqte8p5C7RIE05x9BJ4RVNgS
	 xlERbS1/Oj/2g==
Date: Tue, 10 Dec 2024 11:12:30 -0500
From: Sasha Levin <sashal@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	matthias.bgg@gmail.com, elder@kernel.org, ricardo@marliere.net,
	sumit.garg@linaro.org, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.11 08/15] drm: display: Set fwnode for aux bus
 devices
Message-ID: <Z1hobuvz2S03L9TF@sashalap>
References: <20241204221726.2247988-1-sashal@kernel.org>
 <20241204221726.2247988-8-sashal@kernel.org>
 <CAGETcx8bhzGZKge4qfpNR8FaTWqbo0-5J9c7whc3pn-RECJs3Q@mail.gmail.com>
 <CAGETcx-6yHV5xr1j7krY8LShCF5JATX0NSwjeRUL9+3TLCMq9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx-6yHV5xr1j7krY8LShCF5JATX0NSwjeRUL9+3TLCMq9w@mail.gmail.com>

On Thu, Dec 05, 2024 at 04:07:45PM -0800, Saravana Kannan wrote:
>On Thu, Dec 5, 2024 at 4:06 PM Saravana Kannan <saravanak@google.com> wrote:
>>
>> On Wed, Dec 4, 2024 at 3:29 PM Sasha Levin <sashal@kernel.org> wrote:
>> >
>> > From: Saravana Kannan <saravanak@google.com>
>> >
>> > [ Upstream commit fe2e59aa5d7077c5c564d55b7e2997e83710c314 ]
>> >
>> > fwnode needs to be set for a device for fw_devlink to be able to
>> > track/enforce its dependencies correctly. Without this, you'll see error
>> > messages like this when the supplier has probed and tries to make sure
>> > all its fwnode consumers are linked to it using device links:
>> >
>> > mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0
>> >
>> > Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> > Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca4598@notapiano/
>> > Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> > Reviewed-by: Thierry Reding <treding@nvidia.com>
>> > Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> > Link: https://lore.kernel.org/r/20241024061347.1771063-2-saravanak@google.com
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> As mentioned in the original cover letter:
>>
>> PSA: Do not pull any of these patches into stable kernels. fw_devlink
>> had a lot of changes that landed in the last year. It's hard to ensure
>> cherry-picks have picked up all the dependencies correctly. If any of
>> these really need to get cherry-picked into stable kernels, cc me and
>> wait for my explicit Ack.
>>
>> Is there a pressing need for this in 4.19?
>
>I copy pasted this into several replies. In all those cases I meant
>the kernel version mentioned in the subject.

I'll drop this and the other patch you've pointed out, thanks!

-- 
Thanks,
Sasha

