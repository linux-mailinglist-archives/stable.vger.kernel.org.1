Return-Path: <stable+bounces-95318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB5D9D7536
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120F92871AB
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF0418C903;
	Sun, 24 Nov 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SShQRmDY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C536C;
	Sun, 24 Nov 2024 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732457758; cv=none; b=nD7B5YLQDEmf3Zp1mL0M3HqqxBgLzVoARP9b/K1+SMF2ElwLOXj/KC+3v5aLtED7FptVwt0EvYgfiygRS3+nfjVBjIG5Q3LfbQ3h8IW+MeDp/W1CTZ0zC9YUGdbkMGKPvRrlGw+D2XlUOVS4RukvPULAAoXDFPzxlFsNFpnJnFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732457758; c=relaxed/simple;
	bh=qu9OZBkktSo6lsEwmjZAR4uzevcMXIWHEGBoICmrueQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyFx3B3eP9RQRst0I7jYxzgik0NyK/G83B/SUwVYWtqbBxHRYtI5SzfuG38jL5lBJAEVeT+y/gRkhRi5GERFgAY7Na51Y+DcoH5kRvJCU3EuizhyzMyyahGcUA5kNyzPNMdHMmyuNruWGuwOZehzIQ993iB0l+cVQ9ex75ktMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SShQRmDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCF0C4CECC;
	Sun, 24 Nov 2024 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732457758;
	bh=qu9OZBkktSo6lsEwmjZAR4uzevcMXIWHEGBoICmrueQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SShQRmDYG7ZehdsMz3/DkZtXUK9iHbCdxmsyj/iK/qQgWzOCN5ctveT7NULnCNvVd
	 XDNe5J1rsNNf5C42VpMEG15qO1upsOU8TCyDyXxy/Jt3eWPSa5aoTGOMvxhM7/Pn5u
	 Fk161jKz96c/wxk4WJ9l1OIew6/6MHmrzH+s7NN5dAGRQBjOhZKEaSK9yWaSqPV/vz
	 3b6ez3RVHs/ICe2SmL7SIyviGHhzBy3m640K3qWkqByLMW4+t2mL5LH84mtqQHnQzy
	 E5hLKrd4Py0c65wh1wqAxs68SEoMlmUxBRbojWI0XuSnMYERXX7vszqRYFA7HyfvHz
	 YtEzHIhqC07ow==
Date: Sun, 24 Nov 2024 09:15:56 -0500
From: Sasha Levin <sashal@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.12 1/5] uprobes: sanitiize xol_free_insn_slot()
Message-ID: <Z0M1HLLE_ufLcGMO@sashalap>
References: <20241124124623.3337983-1-sashal@kernel.org>
 <20241124131357.GA28360@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241124131357.GA28360@redhat.com>

On Sun, Nov 24, 2024 at 02:13:57PM +0100, Oleg Nesterov wrote:
>Hi Sasha,
>
>but why do you think it makes sense to backport these "uprobes" cleanups?

If it doesn't, I'm happy to drop them. This commit was selected mostly
because of:

>> 1. Clear utask->xol_vaddr unconditionally, even if this addr is not valid,
>>    xol_free_insn_slot() should never return with utask->xol_vaddr != NULL.

Which sounded to me like more than a cleanup.

-- 
Thanks,
Sasha

