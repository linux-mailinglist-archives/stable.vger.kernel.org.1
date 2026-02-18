Return-Path: <stable+bounces-217202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM2xEBcWlWkELAIAu9opvQ
	(envelope-from <stable+bounces-217202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 02:29:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F8152866
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 02:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F48D3025D2C
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 01:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20828D8F1;
	Wed, 18 Feb 2026 01:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YT7bGol9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CAC222597;
	Wed, 18 Feb 2026 01:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771378190; cv=none; b=rZX/Ig5TiD528EHseqw5GmjCvRM+bnfBSXwLIeqPpmeyH/sRHmYj8Ac5wj1DuuXbHvXGd+O+gdhPsMJKvUfeFC+3ij1+RIaH5pgo+mpBr2an+vRSlREMXe/L28ddbTE38iow2vtv+LOrZ2OSi32wLGJ3L8Txx2L3GCUz4ybnAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771378190; c=relaxed/simple;
	bh=t154XPsuJtjSic5LZ6OsjlWGqPQu+mImLhDXZ/rMWp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcURP+4uI1osHj980SvG3Re5Ba1TDzz1P2i+uw28dx2q1PgLSHN4PjN0Ms6ulSXJE8z85aW5tMm8/18Pkr/M1lXMXNpcIGlJb3pXil72+SGQILglpnutUhFj4a6GVWuewh29857Z2x6mxExhyaOWoRzdMp6+Zal8tyFies/3ys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YT7bGol9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7E5C4CEF7;
	Wed, 18 Feb 2026 01:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771378190;
	bh=t154XPsuJtjSic5LZ6OsjlWGqPQu+mImLhDXZ/rMWp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YT7bGol92xb5yx4B2YmFJbRqCt+R94EwFJKrvQIIKbvK4mSslTIP9fzX/HSbTKfJD
	 Cq75ENevtc+ZiwCwBS8iQGStXlSyRZzo4o4RdQw2rTbusK1YwkK2obXpk1WZ+Q0Y1n
	 z/N5EsJ40Eo6Y58BbKhjs60iQuKNIaVo7GHIMdysHHA0DAQRRU83haV65kY0iRskph
	 7iGtfHUd8mjTkgbFtvmAdCfNagcjG1o0BTxIb7HMkCb0mkuLCrBU+JwVIIo9aXsI34
	 uPsjZWksOwQT+lhH1Jgc7y0ICVcOHmfE1cRaUpmtSfM4+ch7u1zyo5foVcbXH+HfeB
	 XeeTDdF+j2iBg==
Date: Tue, 17 Feb 2026 17:29:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ruitong Liu <cnitlrt@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shuyuan Liu <L0x1c3r@gmail.com>
Subject: Re: [PATCH v3] net/sched: act_skbedit: fix divide-by-zero in
 tcf_skbedit_hash()
Message-ID: <20260217172948.107d3309@kernel.org>
In-Reply-To: <20260213175948.1505257-1-cnitlrt@gmail.com>
References: <20260211184848.731894-1-cnitlrt@gmail.com>
	<20260213175948.1505257-1-cnitlrt@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217202-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,redhat.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C64F8152866
X-Rspamd-Action: no action

On Sat, 14 Feb 2026 01:59:48 +0800 Ruitong Liu wrote:
> Reported-by: Ruitong Liu <cnitlrt@gmail.com>
> Closes: https://lore.kernel.org/all/20260211184848.731894-1-cnitlrt@gmail.com/
> Reported-by: Shuyuan Liu <L0x1c3r@gmail.com>
> Closes: https://lore.kernel.org/all/20260211184848.731894-1-cnitlrt@gmail.com/

Please don't abuse reported-by tags.
These tags are only used when the reporter is not the same
as the author. If you're sending a fix without a reported-by
tag it's implied that you found the issue yourself.

