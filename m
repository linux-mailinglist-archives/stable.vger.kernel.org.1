Return-Path: <stable+bounces-214873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JFyOiRDiWmK5QQAu9opvQ
	(envelope-from <stable+bounces-214873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 03:15:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 080C610B02D
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 03:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65FF43001A40
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 02:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ACA291C1F;
	Mon,  9 Feb 2026 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1++qQVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A81A9F8D
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770603295; cv=none; b=cv9LXRXQeXEmhfj0lUC2cvdf3+nAzndvQSTAhWHRk5m40Q2wCnbwH2R54wPfJNPnNXo3OnKbrb89XuH+Kr/hGm/A2W9KnJj41VzMa4eINPsswdynceY1eXTyoEQza3u7BvLnIkssC+r1sPn9yzBxv7q3QKFoSzBNMeMv86ql3/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770603295; c=relaxed/simple;
	bh=oM2+s2sUU2gc5lzKs2rnKm+f1hMaDy3xWomyzJIQSI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9oewbOPsoq9dxDROhxvpkhJuyqqjCaOJuCAbSocslOFxLgskyXnIS97LUPushlHkVFpbFTcguNq51RugiS4pNLt4bdoEZFuo/7JO3w24XxLH+lJeVOBPB8jV+B6IQ9Uue0IdatOq8hBK7k0Fmees6m4OfAlqhL45lrKJQNcixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1++qQVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045FCC4CEF7;
	Mon,  9 Feb 2026 02:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770603295;
	bh=oM2+s2sUU2gc5lzKs2rnKm+f1hMaDy3xWomyzJIQSI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1++qQVb9uHsfLIdW9/BPibZouXBDvEhniEKkRdTCsEJkEtUGnNhYVr+9ZbkDlzof
	 CVhDhqgSx4YHqAvHQ0Zn12zBO3fEVdYfASX/lVXO6Xn+SzPWkR0Zsp+QFqVXUMtOLL
	 gZd1WQvKhVptQOiqZ1gHWZDdsSZjvmbeCC0tdPSTdnJYunqMv/cU+ZJ3ybx2PodX07
	 0y0kiurFrfQ12Em4/zQ4Uxqd43Kin73vz8K0sLuxt3bMOgRELvD+1np0ekx4OgCk2b
	 Bg0WnIRimeTTfpGM1afihQg+8mz5X5em/FG4WRBejb9VF+dcF07ycc6Gha0M9L839b
	 Nv9218Vvs0HSw==
Date: Sun, 8 Feb 2026 21:14:53 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: Patch "net: enetc: fix the deadlock of enetc_mdio_lock" has been
 added to the 6.1-stable tree
Message-ID: <aYlDHeZawq2h9GGY@laps>
References: <20251025224340.3962503-1-sashal@kernel.org>
 <55cfd4dc-3545-4824-845f-13c1c0bc3518@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <55cfd4dc-3545-4824-845f-13c1c0bc3518@windriver.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214873-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 080C610B02D
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:48:18AM +0800, Jianpeng Chang wrote:
>Hi Sasha,
>
>3 months have passed and the patch hasn't appeared in linux-6.1.y, 
>though I see it has been merged into 6.12.y, 6.17.y, and 6.18.y.
>
>The patch is also no longer in the stable-queue/queue-6.1 directory. 
>Could you clarify if there was an issue preventing it from being 
>merged into 6.1.y?

It was dropped from 6.1 here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=a9347bdaea6788ca8687d678bfcd88398bdeaa03

Though you haven't actually tagged the commit to be backported to stable, so
I'm not sure why you'd expect to see it in any tree to begin with.

-- 
Thanks,
Sasha

