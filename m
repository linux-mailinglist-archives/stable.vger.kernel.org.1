Return-Path: <stable+bounces-56354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5EE9240FA
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 16:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C081428279B
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03F316C6BD;
	Tue,  2 Jul 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzXFPyfb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702671E50F
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930864; cv=none; b=ZDHPXAPB7gNgFd5Q8a+sGmgw1mAPXr9GWTBCv8A8pnFyPVJNpHVPFgbDHSNTTlepvnRUXv4Qc1+2uRI4X9Q0+jRJdu3bK88qnfKoffEFow3O5zKmyXjkBs0fGtB6Jks39vCVfazM3Ni5UwYpbKxfZ6NEOqeiTLsdLwidw4Q2N4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930864; c=relaxed/simple;
	bh=mojNYh3uNQO75hHSGvw6JO3ulgr5yNRSA2t8lCJMkWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG2nobonSoWlGUUmXFKHtqfzpuPo8BdDRLnqWc3FJeaEf1LyYCHxz6MBEcL8Wpn3TGh8Eyb2Ck88IHF0Le/2nlfXZZok3rImLXflWdTnFzp4cs+HQocG6M5lVcSPvtc+2HsFJNbtGs6UI5tuFMDu7EL5LUtN5RIBru8FoXuYAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzXFPyfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8CDC116B1;
	Tue,  2 Jul 2024 14:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719930864;
	bh=mojNYh3uNQO75hHSGvw6JO3ulgr5yNRSA2t8lCJMkWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzXFPyfbfY1e6lCMS+qIYZrQShym7mgsnaFlXNXuyoYtCywG33I7CkekXs5aUZWX9
	 408MAHHmtAcLiFVkhr/EZnZ7+eB6L4MrVYHkBiT6O28CVR5MjV+Q/mRjfJXY2/p1yi
	 5YS/ULKTMDOOHPOicGZdJNjo6mn0S+WAJndET63aW5EGUn+Wrl0SPLU+h0fHgIaGqb
	 Yhezpvs/ycdmqbYJTtSvtUo0K81m+wggPNUM0TH/k7hDINBDQt5W0jvOx/X4akqfLK
	 lyHb/axzXVunqU5bS1Jq5BpThmWVFEFhD4dlraokHefXOeq36ZS6VCYx3GsJjpgHta
	 MBVvewbcZI7iw==
Date: Tue, 2 Jul 2024 07:51:35 -0400
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, cassel@kernel.org, hare@suse.de,
	john.g.garry@oracle.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ata: libata-core: Fix null pointer
 dereference on error" failed to apply to 6.9-stable tree
Message-ID: <ZoPpx32wXDpZ9dFQ@sashalap>
References: <2024070105-falsify-surrender-babc@gregkh>
 <64b91917-f2bc-48a2-9382-e4045c91dad9@kernel.org>
 <2024070208-dazzling-charging-d5db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2024070208-dazzling-charging-d5db@gregkh>

On Tue, Jul 02, 2024 at 11:11:22AM +0200, Greg KH wrote:
>On Tue, Jul 02, 2024 at 06:50:05AM +0900, Damien Le Moal wrote:
>> On 7/1/24 23:31, gregkh@linuxfoundation.org wrote:
>> >
>> > The patch below does not apply to the 6.9-stable tree.
>> > If someone wants it applied there, or to any other stable or longterm
>> > tree, then please email the backport, including the original git commit
>> > id to <stable@vger.kernel.org>.
>> >
>> > To reproduce the conflict and resubmit, you may use the following commands:
>> >
>> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
>> > git checkout FETCH_HEAD
>> > git cherry-pick -x 5d92c7c566dc76d96e0e19e481d926bbe6631c1e
>> > # <resolve conflicts, build, test, etc.>
>> > git commit -s
>> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070105-falsify-surrender-babc@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..
>> >
>> > Possible dependencies:
>> >
>> > 5d92c7c566dc ("ata: libata-core: Fix null pointer dereference on error")
>>
>> Greg,
>>
>> I am confused... This patch applies cleanly to linux-6.9.y. The procedure above
>> also works just fine. And the "Possible dependencies" on itself does not make
>> sense. Bot problem ?
>
>Odd, this seems to already be in the tree, sorry for the noise.

Sorry, I didn't expect something like this would happen, but it went in
as a dependency for a different patch.

-- 
Thanks,
Sasha

