Return-Path: <stable+bounces-26826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2DA872651
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 19:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284F81F27903
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 18:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4262617C71;
	Tue,  5 Mar 2024 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dOXjcMB6"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6E17BCF
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662324; cv=none; b=C/5B2m6g1LtSqnuKOUMcg9URnClUZcp6+n4Dl92V/tbcVErOIH8RFJNTf+kWlelFhwKruVikg89UklMVG9TvJ3mR9a2euHwOUVEbaUN++KSw9BMoeWGDMpVeYna6+SNR9OJBoOZWaU96xQQhnBCk1j+M8kcOQheI2fJEy5StiTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662324; c=relaxed/simple;
	bh=q00v78Eum2+9+5tw85fvYICffuiBpCY/+uXx3ZSwQ8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmBXmFkmD8Ug6iLe2acxekneRJ+h3EfxwAuXBeC/0KKFW0DGy8c+ApQfuEz8iqDjOmzwtkZ37634xn0agcQ3DKpPZ5Kmno/IPHQ/cHz+XniWbgyxzSCY8absJPnwHf1wzeCom9K2WBOjF/CElEwxbnhS1rm0/MktXdkrHivIsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dOXjcMB6; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e2f2562e-5500-4afd-9e9d-fb92c7271758@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709662319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9Dsn2WPTt1gxnLIJd9P9kOtBBptuwiSlUTg3Plrn6E=;
	b=dOXjcMB6qf82D4brLcfIhPHiWn8Bw1227UmuP2b/HWkL3cgkTZsvr7NUqYasKtaQpYtER8
	ijTW6JOJie7DsAxXpo9h+eNM+fiZm+KAQfkGpycNGg4wMLuDBJHEd5oBWpmHgjIJiSzyel
	LHO0VWZkssF+kRIyTT+FHAhSAHPjDM0=
Date: Tue, 5 Mar 2024 10:11:47 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kbuild: Disable two Clang specific enumeration warnings
To: Nathan Chancellor <nathan@kernel.org>, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, arnd@arndb.de, linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
References: <20240305-disable-extra-clang-enum-warnings-v1-1-6a93ef3d35ff@kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240305-disable-extra-clang-enum-warnings-v1-1-6a93ef3d35ff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/5/24 9:42 AM, Nathan Chancellor wrote:
> Clang enables -Wenum-enum-conversion and -Wenum-compare-conditional
> under -Wenum-conversion. A recent change in Clang strengthened these
> warnings and they appear frequently in common builds, primarily due to
> several instances in common headers but there are quite a few drivers
> that have individual instances as well.
>
>    include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      509 |                            item];
>          |                            ~~~~
>
>    drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c:955:24: warning: conditional expression between different enumeration types ('enum iwl_mac_beacon_flags' and 'enum iwl_mac_beacon_flags_v1') [-Wenum-compare-conditional]
>      955 |                 flags |= is_new_rate ? IWL_MAC_BEACON_CCK
>          |                                      ^ ~~~~~~~~~~~~~~~~~~
>      956 |                           : IWL_MAC_BEACON_CCK_V1;
>          |                             ~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c:1120:21: warning: conditional expression between different enumeration types ('enum iwl_mac_beacon_flags' and 'enum iwl_mac_beacon_flags_v1') [-Wenum-compare-conditional]
>     1120 |                                                0) > 10 ?
>          |                                                        ^
>     1121 |                         IWL_MAC_BEACON_FILS :
>          |                         ~~~~~~~~~~~~~~~~~~~
>     1122 |                         IWL_MAC_BEACON_FILS_V1;
>          |                         ~~~~~~~~~~~~~~~~~~~~~~
>
> While doing arithmetic with different types of enums may be potentially
> problematic, inspecting several instances of the warning does not reveal
> any obvious problems. To silence the warnings at the source level, an
> integral cast must be added to each mismatched enum (which is incredibly
> ugly when done frequently) or the value must moved out of the enum to a
> macro, which can remove the type safety offered by enums in other
> places, such as assignments that would trigger -Wenum-conversion.
>
> As the warnings do not appear to have a high signal to noise ratio and
> the source level silencing options are not sustainable, disable the
> warnings unconditionally, as they will be enabled with -Wenum-conversion
> and are supported in all versions of clang that can build the kernel.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2002
> Link: https://github.com/llvm/llvm-project/commit/8c2ae42b3e1c6aa7c18f873edcebff7c0b45a37e
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the fix. LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


