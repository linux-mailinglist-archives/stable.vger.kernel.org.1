Return-Path: <stable+bounces-254325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FdnBsaGFWpXWQcAu9opvQ
	(envelope-from <stable+bounces-254325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:40:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBA05D5066
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 601653153941
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899E93E122F;
	Tue, 26 May 2026 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUQ1qKlm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA43E024D;
	Tue, 26 May 2026 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795321; cv=none; b=iW7Iu3qXF00ORiSv58yRNaoBN0oCvR4+Tf37IXc4oxNdqWsG9yr3gCojYLomCAOlT6400aW4KgrVCz6T91vTHuEQeKAB/o2xiP2WtwY3QgyOYxURdsB5EC9saZiVhzPfdP+OMzbtRPsVz4ls+bOfPETiJQBXxpTN3dORiRv0Qg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795321; c=relaxed/simple;
	bh=xFbS2NRNxUg8v4mD3dvMQUrKboOK1PxrdBxR4BATuk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njWFsIiy7BkxFma6RjDSr5kdv1oTBY0Go8my1e3tbUfBTfhSu77vjb2CrsMcaXZO+0qqqCxLAnjggEVkUYIzJdzYF06t4cPjXm+7lsp0P2QcWwnZFuOZILLsNj9Qcro6XUKu4izS4QXiRRo2BWAcn0BvET0msfT3TXzcp+Z3xM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUQ1qKlm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2059A1F00A3A;
	Tue, 26 May 2026 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779795318;
	bh=9MiXCFjJrTYrp4poSbjn2k4yjn+9akquxuakL8hQanA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PUQ1qKlm/G5bd/G1dSjTQpHYeAgNwrzrFd7KOLf4uS6EkJAojz9TA3HdwGddw8ZCd
	 mTa3FMOdiXVGlQYWcTVDpyld1PwZCTGsXsO7LUjGt/KnZjthV2gmuOvl7A+TP3gWb1
	 S1yOQetTFgw98gD3Rmd1wpZpDKk0XHh4YvQP6aRFuoxfqOixafuDuPxGhY2BkEF6Qp
	 mkX/4+DPVCEmIbNSE4GduhI5seGpoawjuHh74kHkxwAkdn+BFumIWIntOHRW74BQ4G
	 +Uchfb81I8Bo41LWyGBX83rsajiOYXfpcMtWOveD2lKXCZf7N6I9STWCtpYW2GOuBu
	 kxxz5LvBK0p5w==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wang Yugui <wangyugui@e16-tech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org,
	lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 6.12.91
Date: Tue, 26 May 2026 07:35:09 -0400
Message-ID: <20260525231000.agent5-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524085640.88D0.409509F4@e16-tech.com>
References: <2026052319-chastity-viper-7530@gregkh> <20260524085640.88D0.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254325-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DFBA05D5066
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Two regressions in 6.12.91 perf:
>
> 1, undefined reference to parse_events__term_type_str.
>    Could we backport "perf parse-events: Expose/rename
>    config_term_name" (d2f3ecb0ca20)?
>
> 2, undefined first_wildcard_match.
>    Could we revert the patch (perf cgroup: Update metric leader in
>    evlist__expand_cgroup)?

Thanks for the report.

Could you share the failing build log?

--
Thanks,
Sasha

