Return-Path: <stable+bounces-263016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XFi+KeJuLWoYgQQAu9opvQ
	(envelope-from <stable+bounces-263016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 16:53:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA667ED5C
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 16:53:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S0bOYBD3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263016-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263016-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE663064723
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7FC3403F8;
	Sat, 13 Jun 2026 14:51:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21FF33A6E2;
	Sat, 13 Jun 2026 14:51:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362306; cv=none; b=Q/7733qs6RDFmbHI3FQA1WLN+//6PQeeZHPeCaOTy9IDcWhgEisdYf/n1ldobcL2RBcrf4VOjpIHgNzD95kLn1L775QRYxyCxfQe3FDCvxn+pZhDJeiEXyBYnn2h8OVt8fScu/audk4K39Fr2wd6ILJYEW5kXOzYwbiLhUPXp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362306; c=relaxed/simple;
	bh=XdzmQdtWtqzMGkN+y8D4yfbFb6yGTX8dY6AxsEKD2Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ou8mBJX+6sXLrrY12xlwRr5MdD3A4oC4x0tGPOK8KDHsUR06TFZkAOocnFdlVDoFB2LCIxNUgwHp1Lpc6Zyy+VjziH4Yj2n9vE0SCOzNCx1Yo8YZEZrRvTk2YPy9rK5mFjA8+o8rq6vwDZWWif7kmVvANjIC+6zHFHt7H6hruko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0bOYBD3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF8C1F00ACA;
	Sat, 13 Jun 2026 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781362302;
	bh=XdzmQdtWtqzMGkN+y8D4yfbFb6yGTX8dY6AxsEKD2Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S0bOYBD3+iKMv5HlzMLexwZDTBcCdN4hzfxRLQaRzlI+6dBTfeanoi6wGvRsuFJI/
	 XGvR7t3DCvP32C44JnY+C2FOFWR/TYEhUWrwhd4TxgowI2BwJQ+juwBPT5Lnvuqtoc
	 DMoyvoMZ85+xlM0nSqfXF4ikm4sxPzCE3dVHJj2uCuxgMrVJFQvUe/RFLF4G7WzNvF
	 f3VVitpfdq0WfB97R7lIK6j33F05u+65SwVjPUxohf9OaKLBS8zsxHvZznZy/ooj+t
	 rOvtuS8+sqwdUa77F4dg7ehrNOWY7d8Hs3o9A61PouNqAGsVIEPtTRfrQUX/avh1mP
	 3X4B9IQaa6cLA==
From: Sasha Levin <sashal@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Simon Liebold <lieboldsimonpaul@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Simon Liebold <simonlie@amazon.de>
Subject: Re: [PATCH 6.12.y v3 0/2] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Sat, 13 Jun 2026 10:51:31 -0400
Message-ID: <20260613143005.0006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612111327.1613710-1-simonlie@amazon.de>
References: <20260612111327.1613710-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:lieboldsimonpaul@gmail.com,m:sashal@kernel.org,m:simonlie@amazon.de,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263016-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1AA667ED5C

On Fri, Jun 12, 2026 at 11:13:25AM +0000, Simon Liebold wrote:
> Thanks for the detailed analysis on v2, Sasha. Here's v3.
>
> v3: Backport b05d42eefac7 ("xfrm: hold device only for the asynchronous
> decryption") as a prerequisite, making the tree structurally match mainline so
> the fix applies without the lifetime gap Sasha identified in v2, where the
> dev_put at resume: dropped the ref before the re-hold could cover it.

Whole series queued for 6.12.y, thanks.

--
Thanks,
Sasha

