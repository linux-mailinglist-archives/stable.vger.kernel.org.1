Return-Path: <stable+bounces-222949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBZLLy5Sp2lsgwAAu9opvQ
	(envelope-from <stable+bounces-222949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 22:27:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D841F77BA
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 22:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB9C131081C4
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 21:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E148C417;
	Tue,  3 Mar 2026 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7hqWrvc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA648BD3A;
	Tue,  3 Mar 2026 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572935; cv=none; b=FqGGL9wOjv2ts4yi0NobFVEeLBqPuDb1w7Fl6xEmpNNw+gL7UgwDSaXJQZjpw/MdZU0wENJwbkWYd5lU6GOakJ71eUiVCBKrn5oJZnWbSXb3laTJK1LgQwN1J5N6eEi9J6gMB2Y5vS+yC/4RFAPjJXy5zIEwgWA/NttrfxYU1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572935; c=relaxed/simple;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=r9uxZk2bpr8rdq1TAZ4SZ2Yeu/coQ88nEI12tkOhwyf68DskZ34TC6dTjKr5xxsIgeljQVSxktwIg/L5fueuOv6iiVMlP78yFLJtaT7QY8ADxqvKJTjj2Fx/fTP/D4xxDNzX5bn+wDKVD5ANBThZ8y6TSJi64C5TgHEe6w/mUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7hqWrvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03163C116C6;
	Tue,  3 Mar 2026 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772572935;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J7hqWrvccdNcuYPswkggxEvYSTezXQikuseyqDbj2McaTVH08dLpZ0oESnD9GCcA1
	 lE3FfAmHYTOBFyWTYpdJHDh46aMm7emUra82yDdfOb8xhNqxCIaQVJyOfH2HMNFF6Z
	 sfbLlhPlnTYMH8mQteL5eJQlR72iBHzhZoJEGbV+Jirr8DgviwjFQtWbCHSQTWr7Hm
	 zvHw5S0EEtmvFpyGuS7l+iY4UEfCvTJwhdcv5tJZ0l5Qt+XpmPuI7XjXOsfn4bB6dU
	 ILdJySLdccFuIvAyvttsfuiJXMaVGkHJdxAFF5u4dLNZGqsKTjxGGaW0qoSpQv+JTd
	 ub73pyHtfKq7Q==
Date: Tue, 03 Mar 2026 11:22:14 -1000
Message-ID: <09f4a3f326c6834e2ebb7e02e1a40cc1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.0-fixes] sched_ext: Fix starvation of
 scx_enable() under fair-class saturation
In-Reply-To: <85a171ba1e37f417fbd7e74afe56efc4@kernel.org>
References: <85a171ba1e37f417fbd7e74afe56efc4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 46D841F77BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222949-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun

