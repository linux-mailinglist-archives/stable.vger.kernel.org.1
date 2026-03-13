Return-Path: <stable+bounces-225334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB6OIWY0tGn4igAAu9opvQ
	(envelope-from <stable+bounces-225334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:59:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B611286805
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EAC2300C258
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5A5363080;
	Fri, 13 Mar 2026 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBfh9iic"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08498376BF8;
	Fri, 13 Mar 2026 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417525; cv=none; b=Wp5KjOdd6K2OveoFalEQgmlNTXo0eqoyGUEAwpN7smVIlcZf1o2JWkU35o4D/JI9rdge+0Xsrwd9UVNJYcNHe7BmHVQnHZOcQkv47eIAdLenp2I3kQvLJ0Fli3/a1FPvEj4aYoLq/Nw0w1W5Od1KNK0ah3FWn4W3wHkH05Fb+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417525; c=relaxed/simple;
	bh=iX36zAHKKmeN4eHhotzzC+i5yndNh+W3zdQKxVSXZMQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mfR1aGY4IXSRyK25i+2aeBAF6Kvsl10Me74RaLuM9gXtbPg1/5L9VLt0w5vcLo5tQxt+Qmoh4F6zdXMCJEdLJLQFyo8prNmH4egGSaYXCetDE0BOvg8rLnmrZKNFBTrn071SvgulpRyssAjXm9pPgFU2s/NUZsN6nRPmk21NhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBfh9iic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DF9C19421;
	Fri, 13 Mar 2026 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773417524;
	bh=iX36zAHKKmeN4eHhotzzC+i5yndNh+W3zdQKxVSXZMQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IBfh9iicleyvi7qoDfxPMLNSSubivhaZEkTsn/J4yYp0oCrqeRLAohPt18kp83zJl
	 xKb8sDz4GKo7pwx4I7KpkPNuhZrAnbzbdCxlgbjTfbO/9GTmcbwN78/juYDpcIQVKt
	 9ZHuHuUMG3mi7d65PbfCu2eRvEYQzqvROEhgXdiRsXxWPbGa3D/LkVhF7rK8FXxVet
	 NAEz+KoAwh6RSb1nTG4ylfnK4TjvKRR7Gbg4SLE9JG0dTS0gNsXNQb513xAvRuZLqh
	 iKjNyxojsd3szrmvSsOdjtpu6gixp7Nj7UAzDkAqpGaQlbNACavFH1/Qx2XV5K5jDn
	 1sH0C4NyyiCqQ==
Date: Fri, 13 Mar 2026 16:58:41 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
    kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests/hid: fix compilation when bpf_wq and
 hid_device are not exported
In-Reply-To: <20260313-wip-bpf-fixes-v1-1-74b860315060@kernel.org>
Message-ID: <0n8o2qqo-p89o-139r-0s9o-no5sp12n6np3@xreary.bet>
References: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org> <20260313-wip-bpf-fixes-v1-1-74b860315060@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225334-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xreary.bet:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,suse.com:email]
X-Rspamd-Queue-Id: 4B611286805
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026, Benjamin Tissoires wrote:

> This can happen in situations when CONFIG_HID_SUPPORT is set to no, or
> some complex situations where struct bpf_wq is not exported.
> 
> So do the usual dance of hiding them before including vmlinux.h, and
> then redefining them and make use of CO-RE to have the correct offsets.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603111558.KLCIxsZB-lkp@intel.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Acked-by: Jiri Kosina <jkosina@suse.com>

-- 
Jiri Kosina
SUSE Labs


