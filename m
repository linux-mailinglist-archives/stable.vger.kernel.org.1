Return-Path: <stable+bounces-244123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKxaHzrf+WlPEwMAu9opvQ
	(envelope-from <stable+bounces-244123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:14:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D18274CD466
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 459A93036D7B
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB4A421EE1;
	Tue,  5 May 2026 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwiK0gQX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8793803C4;
	Tue,  5 May 2026 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983260; cv=none; b=hwCbHRYE7iZTvBiVu02eZz4POA8/euFCsTH73V5LKugPyHCjcQlCzHlyeGpBG9IB/MCgENo68KGIVoYXo7CINtgS3EXjJFsEhneU7JPm4LqxNpyqcWD/3pQzeirkNENQnFrp/tUx+hXL+uK7CY5XfPxWIij5VWP0xwA4IK6LMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983260; c=relaxed/simple;
	bh=hfyztqPK5iid/4uthMN+1Ans9QSgYmSEDQ+Z9MsAZXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT7wti9XoXX2XuyVDTyS7fGU+9Sy4PMcQwRFt4DaN7VW7RuquG3CyMF9fJNncz1M3z5BQyTFnvI81OsaldVe4aBlTehZWa5PvTJ9EhWQIKkFKSaaWE+S3R+uEJ0bk0xukmaMh+HpTpIbUW6tFxrZc8im8s2/4agShRUmHeWhxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwiK0gQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAD0C2BCB4;
	Tue,  5 May 2026 12:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777983260;
	bh=hfyztqPK5iid/4uthMN+1Ans9QSgYmSEDQ+Z9MsAZXM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gwiK0gQXFtVwyCah5tYV/USU6EPVukS0c0Qx/ePOJjFDfonHrMjTTnBciDvpQKYH+
	 P3zZsqepVrsKnGgAZaoM9Td5eUk4Yxh8CpOQ8N3vqvqN7y7kRfSuOzGACwZqTVRDBS
	 wkicOWXHPKm4zCOSQhDURmrBJgwEtH94t4DEI4OitK2QSQQ99IAQTlsrJEUTJpB5tp
	 hTsUbo1fUU7XtU1ueyZ5/WEJIzIDHxSWlwgKXnU85gtlDXVWDTYpMD43yWzMhZMdl7
	 z/fC9+8xJt9/8jXGb7/dmI/dsmJxkuwqKnVRlOK/CoK6+Brfj3sxU4/46IMyp0Pb4A
	 2JWsecx2rnIyA==
Message-ID: <15ea8185-49ac-4a43-aecf-b650e54a2a9c@kernel.org>
Date: Tue, 5 May 2026 07:14:18 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] firmware: stratix10-svc: Fix probe failure with old
 ATF
Content-Language: en-US
To: Muhammad Amirul Asyraf Mohamad Jamian
 <muhammad.amirul.asyraf.mohamad.jamian@altera.com>
Cc: Mahesh Rao <mahesh.rao@altera.com>,
 Matthew Gerlach <matthew.gerlach@altera.com>,
 Anders Hedlund <anders.hedlund@windriver.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260416072207.27074-1-muhammad.amirul.asyraf.mohamad.jamian@altera.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260416072207.27074-1-muhammad.amirul.asyraf.mohamad.jamian@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D18274CD466
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244123-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dinguyen@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 4/16/26 02:22, Muhammad Amirul Asyraf Mohamad Jamian wrote:
> Since commit bcb9f4f07061 ("firmware: stratix10-svc: Add support for
> async communication"), the SVC driver fails to probe entirely when
> running with ATF versions older than 3.0 (e.g. ATF 2.5) that do not
> support SIP SVC v3 asynchronous operations.
> 
> stratix10_svc_async_init() returns -EINVAL for old ATF, and the probe
> function treats any non-zero return as fatal, causing:
> 
>    stratix10-svc firmware:svc: probe with driver stratix10-svc failed \
>      with error -22
> 
> This prevents all dependent client drivers (hwmon, RSU, FCS) from
> probing even though they can operate correctly via the synchronous V1
> SMC path.
> 
> This series fixes the issue in two steps:
>    1. Return -EOPNOTSUPP (instead of -EINVAL) when ATF async is
>       unsupported, so callers can distinguish "not supported" from
>       "bad argument / programming error".
>    2. Treat -EOPNOTSUPP as non-fatal in probe, allowing the SVC driver
>       to load in sync-only mode so all client drivers can probe normally.
> 
> Both patches fix bcb9f4f07061 and are tagged for stable.
> 
>
I think it makes more sense to squash these 2 patches together. Patch 1 
adds the -EOPNOTSUPP, but does not make use of it. Patch 2 actually 
makes use of the -EOPNOTSUPP. So I was a bit confused on how the change 
is getting used.

Dinh

