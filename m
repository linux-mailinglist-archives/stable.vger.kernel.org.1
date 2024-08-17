Return-Path: <stable+bounces-69397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DDC955987
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 22:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCBE1F218DA
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 20:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D5914EC55;
	Sat, 17 Aug 2024 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=holm.dev header.i=@holm.dev header.b="xAEGVIcP"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682CF824AF
	for <stable@vger.kernel.org>; Sat, 17 Aug 2024 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723926651; cv=none; b=nH6X8SfpzUY5FpykaBXqHx4PbWXFv0OvSToss7HuC7McJylUckIT0cmsAYFo3tQGLxuWBtfuQ7EGx3RTTc0NEinKYzdEhNQXjs3Wfv39sbts9Wo/kwl0KqmKudp+zlI3saCU0EXadslxu+MdfAK4JMCabfN1y7mHWCoM/L6g6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723926651; c=relaxed/simple;
	bh=9pVBnF/IoqoTA9giQFUXONfm/EXkOUlqKduLvu0uTR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/uTZgxGWFgLzvxLp12LM0BJCLCwSg1zcSUoc+CFdvKwFGxcAktDLwNUEWgYVIUz+2S1Mpy8xMWXi4Aj0H5H7xGFFt3TUWRuwW/da7UEqEj+bq6009F9yE3dTzimurKtrFx7nuq3GqkEpkqYAQ4Nu0oaBg5fspipGfJ42M2UJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=holm.dev; spf=pass smtp.mailfrom=holm.dev; dkim=pass (2048-bit key) header.d=holm.dev header.i=@holm.dev header.b=xAEGVIcP; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=holm.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holm.dev
Message-ID: <e518ef00-4c7a-4719-bc58-90d782e34b30@holm.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holm.dev; s=key1;
	t=1723926645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiMzr2mOghlf7iiDaqEMg26CjM/eQ8wr+mNOVNBO9T4=;
	b=xAEGVIcPQJt5llu96Y8JewrBti+W3MjnLAKMZadCVm5MruQjiBAKEN2skzp8aTFjwPjX8u
	8HPDBLLrEA7tyzsraZrdiWCfBGKVC7AlK0OQ+zpB7UqoMsN/VLkXb1YhdBlvHye/+vxKXk
	qGi2JTZ1s+lprhbPrkppOY+2AiBxGNaZfQRb94U7Hx918DkNMuh2mNLCiup2x1CpAcw6NY
	d+fQ1eL2yJKm/IKfaSHooV3SMJHHhxjYwNi9vBM6ZOW+hAWpN9EZRyESmoUtK9wg22Iqr5
	KPYzKv4eHL5r82wuOVG6+EE74AHBgs0U9ZLWL+DaR6WwAdMtti910CvHdnSdxA==
Date: Sat, 17 Aug 2024 22:30:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.10] drm/amd/display: Refactor function
 dm_dp_mst_is_port_support_mode()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, ML dri-devel
 <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>,
 Wayne Lin <wayne.lin@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 Zaeem Mohamed <zaeem.mohamed@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240730185339.543359-1-kevin@holm.dev>
 <2024081739-suburb-manor-e6c3@gregkh>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kevin Holm <kevin@holm.dev>
Content-Language: en-US
In-Reply-To: <2024081739-suburb-manor-e6c3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 17.08.24 10:42, Greg KH wrote:
> On Tue, Jul 30, 2024 at 08:53:39PM +0200, Kevin Holm wrote:
>> From: Wayne Lin <wayne.lin@amd.com>
>>
>> [ Upstream commit fa57924c76d995e87ca3533ec60d1d5e55769a27 ]
>>
>> [Why]
>> dm_dp_mst_is_port_support_mode() is a bit not following the original design rule and cause
>> light up issue with multiple 4k monitors after mst dsc hub.
>>
>> [How]
>> Refactor function dm_dp_mst_is_port_support_mode() a bit to solve the light up issue.
>>
>> Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
>> Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
>> Signed-off-by: Wayne Lin <wayne.lin@amd.com>
>> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> [kevin@holm.dev: Resolved merge conflict in .../amdgpu_dm_mst_types.c]
>> Fixes: 4df96ba6676034 ("drm/amd/display: Add timing pixel encoding for mst mode validation")
>> Link: https://lore.kernel.org/stable/d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev/T/#u
>> Signed-off-by: Kevin Holm <kevin@holm.dev>
>> ---
>> I resolved the merge conflict so that, after this patch is applied to the
>> linux-6.10.y branch of the stable git repository, the resulting function
>> dm_dp_mst_is_port_support_mode (and also the new function
>> dp_get_link_current_set_bw) is identical to the original commit.
>>
>> I've confirmed that it fixes the regression I reported for my use case.
> 
> And it turns out this change breaks the arm and arm64 builds.  I tried
> to fix it up by applying the fixup afterward for this file, but it's
> just too much of a mess to unwind this, so I'm going to have to revert
> this now, sorry.
That sucks, sorry for the problems my patch caused. :(

> See:
> 	https://lore.kernel.org/r/b27c5434-f1b1-4697-985b-91bb3e9a22df@roeck-us.net
> for details.
I unfortunately don't know the amdgpu driver and kernel code in general enough to help fix
that. The back-ported patch I send was my first patch to the kernel.

In the email thread where I reported the problem I send a patch that reverts
4df96ba6676034 ("drm/amd/display: Add timing pixel encoding for mst mode validation") to
fix the problem that way [1]. I've included a copy of that below.
I've tested that it still applies to 6.10.6-rc3 without conflicts and compiles for me. I
could not test if the 6.10.6-rc3 with the revert applied fixes the problem as I'm
traveling and don't have access to my normal setup. I can only say that reverting it on
v6.10.2 fixed the problem for me.

I don't know how to compile for other architectures so I did not test that.

Not sure what would be best, reverting the problem commit so the regression is fixed in
the 6.10 stable kernel (and maybe breaking something else?) or waiting for someone at AMD
with better knowledge of the amdgpu driver to back-port the fixing commit in a non-broken
way.

~kevin

[1] https://lore.kernel.org/regressions/7bf26283474fbb6ea915f93f4db0bc614a627617@holm.dev/
> 
> greg k-h
---
  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 33 +++----------------
  1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c 
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index a5e1a93ddaea..5c555a37e367 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1599,7 +1599,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
         struct amdgpu_dm_connector *aconnector,
         struct dc_stream_state *stream)
  {
-       int pbn, branch_max_throughput_mps = 0;
+       int bpp, pbn, branch_max_throughput_mps = 0;
         struct dc_link_settings cur_link_settings;
         unsigned int end_to_end_bw_in_kbps = 0;
         unsigned int upper_link_bw_in_kbps = 0, down_link_bw_in_kbps = 0;
@@ -1649,34 +1649,11 @@ enum dc_status dm_dp_mst_is_port_support_mode(
                         }
                 }
         } else {
-               /* Check if mode could be supported within max slot
-                * number of current mst link and full_pbn of mst links.
-                */
-               int pbn_div, slot_num, max_slot_num;
-               enum dc_link_encoding_format link_encoding;
-               uint32_t stream_kbps =
-                       dc_bandwidth_in_kbps_from_timing(&stream->timing,
-                               dc_link_get_highest_encoding_format(stream->link));
-
-               pbn = kbps_to_peak_pbn(stream_kbps);
-               pbn_div = dm_mst_get_pbn_divider(stream->link);
-               slot_num = DIV_ROUND_UP(pbn, pbn_div);
-
-               link_encoding = dc_link_get_highest_encoding_format(stream->link);
-               if (link_encoding == DC_LINK_ENCODING_DP_8b_10b)
-                       max_slot_num = 63;
-               else if (link_encoding == DC_LINK_ENCODING_DP_128b_132b)
-                       max_slot_num = 64;
-               else {
-                       DRM_DEBUG_DRIVER("Invalid link encoding format\n");
+               /* check if mode could be supported within full_pbn */
+               bpp = convert_dc_color_depth_into_bpc(stream->timing.display_color_depth) * 3;
+               pbn = drm_dp_calc_pbn_mode(stream->timing.pix_clk_100hz / 10, bpp << 4);
+               if (pbn > aconnector->mst_output_port->full_pbn)
                         return DC_FAIL_BANDWIDTH_VALIDATE;
-               }
-
-               if (slot_num > max_slot_num ||
-                       pbn > aconnector->mst_output_port->full_pbn) {
-                       DRM_DEBUG_DRIVER("Mode can not be supported within mst links!");
-                       return DC_FAIL_BANDWIDTH_VALIDATE;
-               }
         }

         /* check is mst dsc output bandwidth branch_overall_throughput_0_mps */
-- 
2.45.2

