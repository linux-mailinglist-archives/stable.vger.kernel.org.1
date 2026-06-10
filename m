Return-Path: <stable+bounces-262513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /GRWGIV9KWo9XwMAu9opvQ
	(envelope-from <stable+bounces-262513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 17:06:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC3466A8EB
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 17:06:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Dvmozrl4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262513-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262513-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5594D3017C27
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F724192E0;
	Wed, 10 Jun 2026 14:59:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB430F7E8;
	Wed, 10 Jun 2026 14:59:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103573; cv=none; b=jdmkSI0IHKu4xQgIZAi875e0PRFQeevinS8KEPNM7A0CmY3rpsuGVDakAlgpXzsot24m6KCcv7Vgnwll2FSXiVaZ1hrLYjSRpJgCTVDbG0J6PO7kr1Dxnsbyhh4k6uBZuVCHi4chLavdcYghJvmiW8CQPWC3/fftk1rmSXnuYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103573; c=relaxed/simple;
	bh=0zFr4ZNgTSNJeZV1Vj0+SB5/anJ2JVjAHU16/FVM0CM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9w/xoBuz9ILotHIJKN3eZbNR8hyLPkEiVvRjdyLveRDgbFk+Z4yqD/wVCOwW9VadEAohK3+fC/H9nGg02MmPNOH2KUf4WUepW5b45nrZJIRxSKYQFTK6+cUpctxH3EuMe9z8m4BNs37fkPmZ/lCHFgV4x5gLcLbDNChr3hmI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvmozrl4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9141F00893;
	Wed, 10 Jun 2026 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781103571;
	bh=L2TxISszzWmB50xJe2/riCd5MF2p9LTabs/uDsxu680=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dvmozrl40W36pZF6hvrZNHCfI97sWBhwHUhg4aw57ziScXMZR6Mf1sCEPwJNT5luq
	 gQy0oe+zzRmWtHtgxNnL8O8zYyyqHcYjYxElTrdoqF0HBbIskh844CNElrDESg2Yy0
	 d7U0B+EzJLcD05uydB8IgpXh+ZiiFrY+l/FXikJ8aeTdjg3YXpxBw83SsIPfIdVt1Y
	 bvUy7e+s8xESUjmz2mGBqgW5YRlxo/ExOmrL8IUnALwzeK0BmdlGYp2kbDeCsSo6hE
	 W2RdonozWp/9mpa7xxaM5BLq2C9V/W28hBCgeeiBnJMstxI0DCu4Xw3NEqrwJWw5Iq
	 UkorpLD6RjRrg==
Date: Wed, 10 Jun 2026 07:59:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, Kito Xu
 <veritas501@foxmail.com>, linux-kernel@vger.kernel.org, Yuxiang Yang
 <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, Xuewei Feng
 <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu
 <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net] appletalk: fix TOCTOU race in atalk_sendmsg
Message-ID: <20260610075930.0df376f4@kernel.org>
In-Reply-To: <20260610052315.64504-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260610052315.64504-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262513-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:veritas501@foxmail.com,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,foxmail.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AC3466A8EB

On Wed, 10 Jun 2026 13:23:14 +0800 Yizhou Zhao wrote:
> +	if (dev)
> +		dev_put(dev);
> +	if (dev_lo)
> +		dev_put(dev_lo);

You should use netdev_put / netdev_hold
Also no need to null check.
Please remember to wait at least 24h before you repost this patch

