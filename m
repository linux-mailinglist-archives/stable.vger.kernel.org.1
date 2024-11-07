Return-Path: <stable+bounces-91756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6AA9BFDDF
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 06:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D21F236C9
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 05:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF77191F7C;
	Thu,  7 Nov 2024 05:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX+UqT/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C6AD53F
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 05:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958782; cv=none; b=Dor9IitCNPPfIwNV4B1ejWIEjspJBaJNMGsyRYb7xkIlyATMVTw3VaTyGn0qzh3x3QwmlljUF/4Eyu/c0nGdhK7nqeS6HC7u9UH5i3DXUmPZdnnllG+UIDy4cTJWE10BQHb81w4fs1zVheI9AMQfwpFkmRGW9kCb2C3CtcsVkwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958782; c=relaxed/simple;
	bh=TWcIjPGGwV3z3FC13bF+QCOLKwkr0d3GBOt+2WYp06Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Yuydx4ivhNovvK8GffTt/WVhQQdjFgp9AT7K90n4cVeoXSYED1yt0soEmssBVIaZb7QHjuOw7eLlQhMVUBf6J4LSZmp5y33rS6QXHFe6uVPg6RYXDjzLlc3zFQfllSzhWxAAzX7hAXrdb0qmJ+XqCkT1BHdwmSBs/Gik/6r01hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX+UqT/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88C1C4CECC;
	Thu,  7 Nov 2024 05:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730958782;
	bh=TWcIjPGGwV3z3FC13bF+QCOLKwkr0d3GBOt+2WYp06Y=;
	h=Date:To:Cc:From:Subject:From;
	b=PX+UqT/MctaxRbyJMOljxc4ovEvL/B5nRIYyj8ZxwjjeKTsNkjgwKA1FvP/nK3i/v
	 Rwbkf8V/2Cn40n9J4wMwikGZVLqoPjgB5nMlgPuU8kkOwddf8vtqdtENwQLsOepfA4
	 OKzeu1wMYwoQAFV3YhrnjLccBXFHu67KUqUhGs+fIN3kpTf9GDXybsILzkSOrgSVn8
	 WQnjcqdWTxXbqo2UQVSIEM/vtP/uMCY/sjhBsXWAwanA9vV0Na3ccoInIkVxfVGtwe
	 sw65DflNZZzKm5/BBK2ilWc2OCF2hfpwf6mYzSE+mFo3zeV7RdjXVJyYrvSmWbWrMS
	 Xei4Htku0foHQ==
Message-ID: <478eac36-fc71-4564-959c-422da304f139@kernel.org>
Date: Wed, 6 Nov 2024 23:52:58 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Gong, Richard" <Richard.Gong@amd.com>
From: Mario Limonciello <superm1@kernel.org>
Subject: AMD PMF on 6.11.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

6.11 already supports most functionality of AMD family 0x1a model 0x60, 
but the amd-pmf driver doesn't load due to a missing device ID.

The device ID was added in 6.12 with:

commit 8ca8d07857c69 ("platform/x86/amd/pmf: Add SMU metrics table 
support for 1Ah family 60h model")

Can this please come back to 6.11.y to enable it more widely?

Thanks!

