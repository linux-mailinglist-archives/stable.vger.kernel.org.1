Return-Path: <stable+bounces-145461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC6BABDBCA
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3938188D506
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B89A24C692;
	Tue, 20 May 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATHRvJ49"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BCB24E008;
	Tue, 20 May 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750250; cv=none; b=dl2gbsalQdVrFJRRH1v9gLmHof2vCNNEFgs8WmEvOAMqrujCEwIQ3coGOTKvFATpCo4Tvn1Ht/O60oQR0QCdqPuxEA5zQfVAxF+AwNlUhukYlCiYEBm4LCug1alv2UPUgazy/Nlxb6rsSp2eYUM0b6b4++UKZDDvUndA734a8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750250; c=relaxed/simple;
	bh=cdHyZHYtiVmlTNEcUXDCYu+vQs7EHt7y5KTbaRf7oc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5XLtziXDtTLxhUsxi1eJD6cberMKY4vX/6mcGH3mXGeshBYIMqeh43fIwhucU+W3xmyzVTNgdCEv4hOgJwH42Gd2AC6ZF3hMVoDG5Kh4CtmoPzf+dG3QITWT55oAwcvQ8tzrMrOZ2pfV72+KGKOP7sB/NhcxyQxP7L2P8U93oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATHRvJ49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFB4C4CEE9;
	Tue, 20 May 2025 14:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750249;
	bh=cdHyZHYtiVmlTNEcUXDCYu+vQs7EHt7y5KTbaRf7oc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATHRvJ49L9s3Ghyxau8mpYx7tpHna5mSjzni2b2NjMor5RtMDYSCQy34MVMd50pi/
	 SSjSRBFX4ak5uNfKmdeHsmGXQG2Pl8W2CCjFtjqQw8hvbiZZxrg5odMQy5DH7yeCxy
	 ZtoPwoxCa8kSyAqmUJ0bn2AfbA/juRxLWmW7RaO3Wqk95IfsQLXc4tHRwWn6tujz29
	 uxLOIdG7E1lGiSFPqP+63C/Kbh+TjMaQu2D669zAC1uUZ8jr5+EnIKZht16ACdPKX/
	 utW3WPeslpbN3Q0auca5xK9omT6ujV0nzYCZZZL3se+UwmRo3MnBtw5wGLonp0AzIm
	 ZSDi5xuna7WPQ==
Date: Tue, 20 May 2025 10:10:48 -0400
From: Sasha Levin <sashal@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me,
	jdamato@fastly.com, aleksander.lobakin@intel.com, kuniyu@amazon.com,
	shaw.leon@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 554/642] net-sysfs: remove rtnl_trylock from
 device attributes
Message-ID: <aCyNaDS3w8UEv7El@lappy>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-554-sashal@kernel.org>
 <jj7nizvkfuas57zcfkkbdaqnxzjdlgwtgzlkgzpazbrdnzhlc3@6ohz5cfz3tds>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jj7nizvkfuas57zcfkkbdaqnxzjdlgwtgzlkgzpazbrdnzhlc3@6ohz5cfz3tds>

On Tue, May 06, 2025 at 10:12:40AM +0200, Antoine Tenart wrote:
>Hello,
>
>On Mon, May 05, 2025 at 06:12:50PM -0400, Sasha Levin wrote:
>> From: Antoine Tenart <atenart@kernel.org>
>>
>> [ Upstream commit 79c61899b5eee317907efd1b0d06a1ada0cc00d8 ]
>>
>> There is an ABBA deadlock between net device unregistration and sysfs
>> files being accessed[1][2]. To prevent this from happening all paths
>> taking the rtnl lock after the sysfs one (actually kn->active refcount)
>> use rtnl_trylock and return early (using restart_syscall)[3], which can
>> make syscalls to spin for a long time when there is contention on the
>> rtnl lock[4].
>>
>> There are not many possibilities to improve the above:
>> - Rework the entire net/ locking logic.
>> - Invert two locks in one of the paths — not possible.
>>
>> But here it's actually possible to drop one of the locks safely: the
>> kernfs_node refcount. More details in the code itself, which comes with
>> lots of comments.
>>
>> Note that we check the device is alive in the added sysfs_rtnl_lock
>> helper to disallow sysfs operations to run after device dismantle has
>> started. This also help keeping the same behavior as before. Because of
>> this calls to dev_isalive in sysfs ops were removed.
>>
>> [1] https://lore.kernel.org/netdev/49A4D5D5.5090602@trash.net/
>> [2] https://lore.kernel.org/netdev/m14oyhis31.fsf@fess.ebiederm.org/
>> [3] https://lore.kernel.org/netdev/20090226084924.16cb3e08@nehalam/
>> [4] https://lore.kernel.org/all/20210928125500.167943-1-atenart@kernel.org/T/
>>
>> Signed-off-by: Antoine Tenart <atenart@kernel.org>
>> Link: https://patch.msgid.link/20250204170314.146022-2-atenart@kernel.org
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>I'm not sure why commits from this series were flagged for stable trees,
>but I would not advise to take them. They are not fixing a bug, only
>improving performances by reducing lock contention.
>
>The commits are:
>
>79c61899b5ee  net-sysfs: remove rtnl_trylock from device attributes
>b7ecc1de51ca  net-sysfs: move queue attribute groups outside the default groups
>[It seems this one was missed?]
>7e54f85c6082  net-sysfs: prevent uncleared queues from being re-added
>[My guess is this looks like a real fix, but it's only preventing an
>issue after the changes made in the series]
>b0b6fcfa6ad8  net-sysfs: remove rtnl_trylock from queue attributes
>
>Same applies for the other stable backport requests.

I'll drop them, thanks!

-- 
Thanks,
Sasha

