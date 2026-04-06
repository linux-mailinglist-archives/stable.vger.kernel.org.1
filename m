Return-Path: <stable+bounces-233400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCDUL3fo02n/ngcAu9opvQ
	(envelope-from <stable+bounces-233400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 19:08:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 293113A592B
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 19:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A97B0301158B
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 17:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BB538CFFE;
	Mon,  6 Apr 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpxPzsWG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9BF27702D;
	Mon,  6 Apr 2026 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495284; cv=none; b=KKdl0If+G/1hgiU5OmR8sUG6qk4Pgbc20GDkcCgNSvRFSBNnSEDbxlFxeXB/ZyXb+T8fZroAQnRpu3T8jhH3kt5kMuBGHZHV+1NjuZh9X50yEgt05GMfuPWGm9X8CZ4uMrMjtzFYM4ez2WecAIqVckoZ/hBTUxf92gR7PYJCQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495284; c=relaxed/simple;
	bh=ID6PaLEDd+oZUUzH34AVPseNbr3AqOulchf/FdRxKfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFF5nLhb71B3ecQs4oKqwjbcHYvRAANK2mAuBbmQH7u0GEVtcWQcv18bHcyMqtwnrs/7jJ6EkACRJ+bzc39IF7PTzDAlKdzL3ye+MAsjXcUxfDXoYX95r8UWeH7sliYTES9pedSJoA5HS5ncxrrmRLe0gdrF8FuXlTdgRq48QVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpxPzsWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E13C4CEF7;
	Mon,  6 Apr 2026 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775495283;
	bh=ID6PaLEDd+oZUUzH34AVPseNbr3AqOulchf/FdRxKfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpxPzsWGafj2AH8ssKC3kNkbvp982AYEfoDnFlhXPUJn53E/wNDrtOa3RO6kjg1tw
	 BornPcTwg+oOQWHvQ0HgIzuuKz1rxjSXcoTigkZvXyBZ4FtqMs68F9mjhnWqgFrag/
	 YzlpBPNtbwrlU/Fp7Qcz1VnF+HhciQoGuLMBwm8QkLVt88vP6qv/oFpJbrFuiG1Pzq
	 ptdvxJzimzFs1ANpykQzUhFRqDp+ro0c9wBPoaC23j/jFif9rzDBBw7W1akrsHwVud
	 PiJon3zBw5ZZDw4wel33fM1S8K2j8gcVBqMIbzUGIQEhNkHpxfhXLeneXoIZSARdJf
	 hwr9ERTEURhuw==
Date: Mon, 6 Apr 2026 13:08:02 -0400
From: Sasha Levin <sashal@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 6.12 044/265] PCI: dw-rockchip: Dont wait for link since
 we can detect Link Up
Message-ID: <adPocsaGAcsKSuR4@laps>
References: <20260312201018.128816016@linuxfoundation.org>
 <20260312201019.793655649@linuxfoundation.org>
 <ffb3f43f-ffd0-4e60-9966-a77e8ed611cf@oracle.com>
 <adPUtsthYnKHekY3@laps>
 <f1c33cef-b20e-42f2-be2b-7c435796e2de@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f1c33cef-b20e-42f2-be2b-7c435796e2de@oracle.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233400-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 293113A592B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 09:28:54PM +0530, Harshit Mogalapalli wrote:
>Hi Sasha,
>
>
>On 06/04/26 21:13, Sasha Levin wrote:
>>>
>>>We need a process improvement here.
>>>
>>>We are pulling in a broken commit as a stable-dep, so we can revert it.
>>>
>>>Patch 45 is the revert, same logic for pair (46 and 47)
>>>
>>>[PATCH 6.12 046/265] PCI: qcom: Dont wait for link if we can 
>>>detect Link Up
>>>[PATCH 6.12 047/265] Revert "PCI: qcom: Dont wait for link if we 
>>>can detect Link Up"
>>
>>This works in our favor: it helps us answer the future question of 
>>"why wasn't
>>this commit backported", and has absolutely no effect on the actual 
>>codebase.
>
>I agree this has no effect, but couldn't we just say, the reason we 
>never backported it because we never have the broken commit(vulnerable 
>commit) backported ?

That's the correct response we should give, yes, but the question is how do we
store this information in a way that is easily accessible to us later without
having to dig through the tree.

-- 
Thanks,
Sasha

