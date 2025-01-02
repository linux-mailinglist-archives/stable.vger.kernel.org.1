Return-Path: <stable+bounces-106641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8537D9FF71D
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 09:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FC2161A1C
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 08:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5796918FDBE;
	Thu,  2 Jan 2025 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sty2akiH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1650E3209
	for <stable@vger.kernel.org>; Thu,  2 Jan 2025 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735807957; cv=none; b=J7y1WJSaii3v2bXbBQvWJlFkri7UHhr+4BWk/HquViI3dBPHCPiPUjyW/zS7ckvB1mmcI4bzj5Ll57i23f166GnYrBQ3H7FA6DV2TRHrvhVO4bpDX5Cal1C8jM61TH3InPwxH6T36KhGQlJ5kDC9cQmkpKQyndkXFZXzmXxT3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735807957; c=relaxed/simple;
	bh=mcOwPGKo/Nl4ynbYWRAHZeICua7xqk7moHzX3vHAmiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jw5dbJbhzjkfpW8RMhRfOEeb1jf8foNwazW/Ftj907V15U2nizP/pKM+QrGkBjoDC4T0QnmC4+PF3UF2CHZ7x21RAZpqM+fW8/hSsMNKgCw1sHf8eS2LySGkxNe5Q4p/CJpr6t31mKcikXP381AT8kdM+RIevrW4uPiGyIyGFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sty2akiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997B6C4CED0;
	Thu,  2 Jan 2025 08:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735807956;
	bh=mcOwPGKo/Nl4ynbYWRAHZeICua7xqk7moHzX3vHAmiw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sty2akiHOhlJGYSrtjKHjmctd9HXY04ZQ2zabEbkv13dvL2Q68teButh+EHynYVwj
	 UxIZ+Rn7GM1unGgnGwpJE88x6aGT50FQygnmf8iXk0UTiUmboq72xLILVcsQe2as8K
	 yL647iPt6f373ZYjlu8f3EgsuYeKCqPjlO8uU3tEElK5TFIvSpi4FHUxNYFN/3VJ+X
	 IY1qEJwjpheP7q/tgBNFq19xhae6+VUA2jmznx7OYbtIhNb/S/w7kl5BmqzM3aytWI
	 90alpPEDEH4EJR+I9+hZCzu+4IBP/4ACPaDilKaMFXD/Efy7uWuBh8rj7xO1mIn3TG
	 w2SV2/gvB+liA==
Message-ID: <252d24ea-0ad6-4278-8d90-1540a02557a4@kernel.org>
Date: Thu, 2 Jan 2025 09:52:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
To: Greg KH <gregkh@linuxfoundation.org>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org
References: <20241227073700.3102801-1-alexander.deucher@amd.com>
 <2024122742-chili-unvarying-2e32@gregkh>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <2024122742-chili-unvarying-2e32@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27. 12. 24, 8:50, Greg KH wrote:
> On Fri, Dec 27, 2024 at 02:37:00AM -0500, Alex Deucher wrote:
>> Commit 73dae652dcac ("drm/amdgpu: rework resume handling for display (v2)")
>> missed a small code change when it was backported resulting in an automatic
>> backlight control breakage.  Fix the backport.
>>
>> Note that this patch is not in Linus' tree as it is not required there;
>> the bug was introduced in the backport.
>>
>> Fixes: 99a02eab8251 ("drm/amdgpu: rework resume handling for display (v2)")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3853
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: stable@vger.kernel.org # 6.11.x
> 
> So the 6.12.y backport is ok?  What exact trees is this fix for?

IMO all trees which received 73dae652dcac are broken. All the backports 
call "adev->ip_blocks[i].version->funcs->resume()" and not 
"amdgpu_ip_block_resume()" (as in upstream). Incl. 6.12.

And there is a bug report for 6.12 here too:
https://bugzilla.suse.com/show_bug.cgi?id=1234782

$ git grep -A8 'stat.*amdgpu_device_ip_resume_phase3'
> releases/5.15.174/drm-amdgpu-rework-resume-handling-for-display-v2.patch:+static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
> releases/5.15.174/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+{
> releases/5.15.174/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+      int i, r;
> releases/5.15.174/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+
> releases/5.15.174/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+      for (i = 0; i < adev->num_ip_blocks; i++) {
> releases/5.15.174/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+              if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
> releases/5.15.174/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+                      continue;
> releases/5.15.174/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+              if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
> releases/5.15.174/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+                      r = adev->ip_blocks[i].version->funcs->resume(adev);
> --
> releases/6.1.120/drm-amdgpu-rework-resume-handling-for-display-v2.patch:+static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
> releases/6.1.120/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+{
> releases/6.1.120/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+       int i, r;
> releases/6.1.120/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+
> releases/6.1.120/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+       for (i = 0; i < adev->num_ip_blocks; i++) {
> releases/6.1.120/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+               if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
> releases/6.1.120/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+                       continue;
> releases/6.1.120/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+               if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
> releases/6.1.120/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+                       r = adev->ip_blocks[i].version->funcs->resume(adev);
> --
> releases/6.12.5/drm-amdgpu-rework-resume-handling-for-display-v2.patch:+static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
> releases/6.12.5/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+{
> releases/6.12.5/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+        int i, r;
> releases/6.12.5/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+
> releases/6.12.5/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+        for (i = 0; i < adev->num_ip_blocks; i++) {
> releases/6.12.5/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+                if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
> releases/6.12.5/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+                        continue;
> releases/6.12.5/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+                if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
> releases/6.12.5/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+                        r = adev->ip_blocks[i].version->funcs->resume(adev);
> --
> releases/6.6.66/drm-amdgpu-rework-resume-handling-for-display-v2.patch:+static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
> releases/6.6.66/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+{
> releases/6.6.66/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+        int i, r;
> releases/6.6.66/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+
> releases/6.6.66/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+        for (i = 0; i < adev->num_ip_blocks; i++) {
> releases/6.6.66/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+                if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
> releases/6.6.66/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+                        continue;
> releases/6.6.66/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+                if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
> releases/6.6.66/drm-amdgpu-rework-resume-handling-for-display-v2.patch-+                        r = adev->ip_blocks[i].version->funcs->resume(adev);


thanks,
-- 
js
suse labs


