Return-Path: <stable+bounces-145524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0601AABDD13
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD5716EAB1
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4697B24CEE8;
	Tue, 20 May 2025 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPRwZhPO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299824C66F;
	Tue, 20 May 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750426; cv=none; b=GaD6JQdNMVw9rcJiDPsMDUjijFsNqWqWfjIkpWoCRXV2yKJ3NWPjLpfOF1eKH/JKVNLcUw0/gtSU+sFUaVxkxxOF89wqmqSB/koZRlA1t1vTJoGGP27NdMGGZbjTfEqwDne+bUtYE9H7A3SmMFMDnzmu4G2SkEHl7dig01En/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750426; c=relaxed/simple;
	bh=dGluI3urTIFsxw0widqt9HOdsA3/5BESE287K6pFLo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYN6OJbABrVS0VlKRw5CbRbgHx2PS3cfgIyNNi2NY5cJvbKQKroUTwq2PTmZooFsjTA20WSyTJqZo1NoylOkrE6Z97vpkooSnQtEOrcmUwVdp+9tohlNQLLVWDEQd2bir2SG0uVCqxZ/GOFso79hU7Vw+av4oVQiPya4sDLGNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPRwZhPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4DBC4CEE9;
	Tue, 20 May 2025 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750425;
	bh=dGluI3urTIFsxw0widqt9HOdsA3/5BESE287K6pFLo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPRwZhPOvMiIqYvV+JaD8htPYFlAtPFlUFVmphZykrdlO0JsBOfAne/13RcgQQKsA
	 YiLAHgnlmSDsiC6FxsB1Pi55cRVmLpfb4WkLpvcMyAA8EzyKceBlnvN8x9yOFwly5T
	 AMMC/l6xbBjvbmBeWzT5MGMaLCovVecRKZ4wJHYDnhRtsymrYUxzxhoAy+JN4JFj0f
	 NpzU2Ub0qAa+ZqqXkt06fP7TkKTwDr/uZ2XUInlDBnm7UQWo1Ti9UmFSvfPMscqaPn
	 Q4UAu8Uf4QhS3tnJWvtMAkdjwpYOevBB5N+iNhyUmJKFA1SFxGLja0LN/S8hzlJHh8
	 N0NULWQh3TMTg==
Date: Tue, 20 May 2025 10:13:44 -0400
From: Sasha Levin <sashal@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Xinyu Zhang <xizhang@purestorage.com>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.14 295/642] nvme: map uring_cmd data even if
 address is 0
Message-ID: <aCyOGIDzSaI4p47X@lappy>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-295-sashal@kernel.org>
 <CADUfDZqvwhL3Hz7_u+TsO5XrpeWX9dHtbehXUtwbJdyi_GXT_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CADUfDZqvwhL3Hz7_u+TsO5XrpeWX9dHtbehXUtwbJdyi_GXT_A@mail.gmail.com>

On Mon, May 05, 2025 at 04:15:47PM -0700, Caleb Sander Mateos wrote:
>I wouldn't backport this change to any releases. It's a potential
>behavior change if a userspace application was submitting NVMe
>passthru commands with a NULL data pointer but nonzero data length and
>expecting the data buffer to be ignored. And supporting the data field
>set to 0 is only necessary for ublk zero-copy, which is introduced in
>6.15.

I'll drop it, thanks!

-- 
Thanks,
Sasha

