Return-Path: <stable+bounces-145471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A07FABDC60
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116274E3F9C
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40DB243367;
	Tue, 20 May 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCJaUFEo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B39248F4B;
	Tue, 20 May 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750275; cv=none; b=tOdy0IFWJPLRkwAYkKVaBUtoPDHPsKI29Q982V8Xqix+h8onXN7N7X27UffKgKav7oi6+V70pnJ2RkEwUg66d4spyO5pKam33qpSXFDL/AFoeLXWil+iWNXH2cIhV2SSo2fb3m1b8SnL0On7pVcMNqnDIu6P/afqeeZwhlwiSDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750275; c=relaxed/simple;
	bh=Wmye9rgmcw4aNuvfwOZVlm7omj0IV0kKjwZnvPcMZKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwqojmYYdlfOOf9MrBU3bWfifjRZ8lJenF3S8C9jLFZZ2vEpIHK9C2J1SI66EDW92AhHf6F2Uy236eGgcTtiNgCRbQLXHpmSbRRjPBsGEzb/VyuzpB9jO7MlNUbdeCc5AR+qf6tcpxcl7R71WmS3qBimuaPmYCnj/qQDQoBXREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCJaUFEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20159C4CEE9;
	Tue, 20 May 2025 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750275;
	bh=Wmye9rgmcw4aNuvfwOZVlm7omj0IV0kKjwZnvPcMZKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCJaUFEofhpHo4BBG4xKMQijcAU9oPDYGTzyCaecDybwIWLK1g+LDtVBvu9cSsZwe
	 2YZ/JNNPvURB697XKETW+coAI11yMK7hi3gGZU3a9mGFKG5+C/6vK9+J2AaIexvpoo
	 U+RDgYubzIaBh1dnhNCEbo74vN4/eB/gR5JJ+cHFZAevMCzMCbxYTm+wR8UrFP+SZ0
	 lkKfWnCIDbBeRIAeXsw3VsWnrpshRlRke4UivyxyTNe/tYG2Huj0pdqIZz0YtOFLNo
	 ZvoX2EAyyIC6ozn6muPuOa4trOsSqbnhPgSlcyrMehNKndoJnUUqehMLP2bePK/mZC
	 rIWx04A68KkaA==
Date: Tue, 20 May 2025 10:11:13 -0400
From: Sasha Levin <sashal@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, daniel.zahka@gmail.com,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 519/642] net: ethtool: prevent flow steering
 to RSS contexts which don't exist
Message-ID: <aCyNgeW_ooLYD3Gt@lappy>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-519-sashal@kernel.org>
 <dc61b9f7-bc3c-4fec-8386-0f40fa869dd6@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dc61b9f7-bc3c-4fec-8386-0f40fa869dd6@nvidia.com>

On Tue, May 06, 2025 at 09:31:55AM +0300, Gal Pressman wrote:
>On 06/05/2025 1:12, Sasha Levin wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>>
>> [ Upstream commit de7f7582dff292832fbdeaeff34e6b2ee6f9f95f ]
>>
>> Since commit 42dc431f5d0e ("ethtool: rss: prevent rss ctx deletion
>> when in use") we prevent removal of RSS contexts pointed to by
>> existing flow rules. Core should also prevent creation of rules
>> which point to RSS context which don't exist in the first place.
>>
>> Reviewed-by: Joe Damato <jdamato@fastly.com>
>> Link: https://patch.msgid.link/20250206235334.1425329-2-kuba@kernel.org
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This patch caused a user-visible regression, I don't recommend taking it
>to stable.
>
>FWIW, I tried to fix it:
>https://lore.kernel.org/netdev/20250225071348.509432-1-gal@nvidia.com/

I'll drop it, thanks!

-- 
Thanks,
Sasha

