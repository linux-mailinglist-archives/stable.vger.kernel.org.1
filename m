Return-Path: <stable+bounces-230737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /v0jOu0dx2kgTQUAu9opvQ
	(envelope-from <stable+bounces-230737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:16:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8A434CA89
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B7883030EAB
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 00:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D00D175A62;
	Sat, 28 Mar 2026 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4UL/RdA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030415FA81
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774657002; cv=none; b=pSRboBnENbluQl+/CBGm2fIMDclGj+TE0B2Nq+p9lJpm9K4jhUGHqFIDTVbGG9UTuSlaWZtwXA3J9YCtO2rOKtNnCrRKLt23ANUtpFFFJpdeiqXAyl0gx6t2dOmD5if2qCYvQ/3nYEVpmChTg6TTdNa4Sjc+bvk/heALmHI+2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774657002; c=relaxed/simple;
	bh=AwzYlsMDUsH3mn3UN17QGh3mvbvULDCbCpM39oPXkAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8FG8XSwtQ/jhSTvJbLIG9MLNtQ77pAAxqDQ5fBBx3KFVqSSPbDZnEk2RiuEfhNBpAvk8wnnHbJSHtq9oResgf79qu+LYVzBpxzSLrRbs9GrFrvI1Xszh7GjgWNUglT7c2AKM1e/7c4/wLfCne7f2wtuDdwT5sYx4PeANuxMEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4UL/RdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52302C19423;
	Sat, 28 Mar 2026 00:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774657001;
	bh=AwzYlsMDUsH3mn3UN17QGh3mvbvULDCbCpM39oPXkAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4UL/RdAzEN2L5IwQMtWSW2CZQxzkAKOUj/2t+jU6BE9uUQzi6yx+O6P7Z596BUHS
	 75UKoyL4p7KY7rRrt9yrSgfUI5eB/bLjVggOO9ESq42hQXWdKldS5jrzij5mQTOffW
	 rGfnQY6U8iRehBHODYf/m0QC+R56olcgLnBo3aAmJauMlgrnxCwteR1iz+LyI3b02S
	 Ii7scGSF3vcRFuoI0vsMxeHG0Yr4aIeOfhJMBnkRxL4/nmjaL9nbnOsAR3tcsIlO+E
	 WFztuu2yhVtnUl12ZM8pv5IPadiHjiQZ2drVcWFtjtZAONamPFfyqyJPgSLwbpRsg1
	 zIWYU4lcQkobg==
Date: Fri, 27 Mar 2026 20:16:40 -0400
From: Sasha Levin <sashal@kernel.org>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: apais@microsoft.com, stable@vger.kernel.org, tariqt@nvidia.com,
	leon@kernel.org, mbloch@nvidia.com, shshitrit@nvidia.com
Subject: Re: [Regression] net: tls: Change async resync helpers argument
Message-ID: <accd6CGZat7m84Qg@laps>
References: <CAE5sdEiLuFj_8m89PGJwFit0QHg1=TL6=O==Mirt39BfbrRkVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE5sdEiLuFj_8m89PGJwFit0QHg1=TL6=O==Mirt39BfbrRkVA@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230737-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D8A434CA89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 11:13:37AM -0700, Siddharth Chintamaneni wrote:
>Commit 74bf749662a29 [upstream e98cda764aa9c] is backported to match
>the function signature of tls_offload_rx_resync_async_request_cancel
>function that is introduced in Patch 2 of this series -
>https://lore.kernel.org/all/1760943954-909301-1-git-send-email-tariqt@nvidia.com/
>but this break nvidia's mlx-ofa driver build which is still
>referencing the old driver signature.
>
>Build environment:
>  - mlnx-ofa_kernel-25.{07,10}
>  - kernel: 6.12.68.1-1.azl3
>
>Failure
>
>466 |         tls_offload_rx_resync_async_request_end(priv_rx->sk,
>cpu_to_be32(hw_seq));"
>      |                                                 ~~~~~~~^~~~"
>      |                                                        |"
>      |                                                        struct sock *"
>In file included from
>/usr/src/azl/BUILD/mlnx-ofa_kernel-25.10/obj/default/include/net/tls.h:6,"
>                 from
>/usr/src/azl/BUILD/mlnx-ofa_kernel-25.10/obj/default/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h:9,"
>                 from
>/usr/src/azl/BUILD/mlnx-ofa_kernel-25.10/obj/default/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h:40,"
>                 from
>/usr/src/azl/BUILD/mlnx-ofa_kernel-25.10/obj/default/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c:6:"
>./include/net/tls.h:461:74: note: expected 'struct
>tls_offload_resync_async *' but argument is of type 'struct sock *'"
>  461 | tls_offload_rx_resync_async_request_end(struct
>tls_offload_resync_async *resync_async,"
>      |
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~"

So it looks like it broke an out of tree driver. Nothing we can do about it
here...

-- 
Thanks,
Sasha

