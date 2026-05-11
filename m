Return-Path: <stable+bounces-245326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG27FoRTAmpvrQEAu9opvQ
	(envelope-from <stable+bounces-245326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:09:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C10E75169B5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F65B30151CB
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 22:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E1D4D8D8B;
	Mon, 11 May 2026 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RsUuzqPE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bOdtI4p0"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B547CC96;
	Mon, 11 May 2026 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537341; cv=none; b=KHfF/osviW3I9IS+8pVXM0DFuq2WE/LMYvdvc3EirLXl5W+WqZ39QBfUz5+jdv1WMK5a/GKj806CwaNQ4w4UtbCN+JhmL52PvrveuMXlsvzBvBrOwCFEdEg/cVxt57eN/u0iky2AH+16fuLl1LOdz/E2o29D1NPDG5fR8glToss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537341; c=relaxed/simple;
	bh=AfDkvRA0WNlGZEonHbXBHom6GyQnYzGd86xVWsF0x08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnTmK8Sbe6MOoiv3V9siwqAUyNxRFDdIHaelubyZdjGTP6xV92uNNVdYHFocbHTAKH2JZEcosA2Nr/LAluyiCpVOZ9Yofsf6CdejX56yr6kvK8Qan22Dq/34V9sfqV08SRMiKS2ZXxl5nSCNuj6xp/pOvvc+LRgu/6ZHElB8EQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RsUuzqPE; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bOdtI4p0; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gDv550cvNz9thy;
	Tue, 12 May 2026 00:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778537337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwfMOER86C9OyxsWQbr78qu7EgXq0GUCfI5AjQ12ehQ=;
	b=RsUuzqPEdKlT3k/7rfSAih+BLui+KDVee0g9JzJV8XhkfEicf9QyCTVk+GGaRjcVK/VuYG
	qa4yie/4OjOrw8M7wzhzumzr+/PfFKPUl83SLSvyF+yQt52Ak9G4BIONkvqILG83wrr/QS
	vDM304dk5KQYHuOyzwkieZzEcjyefqeffVx55Caok0csBdMMJCLHU2GKeqO7uCZT3zjXMm
	ybUtU+XooWOcZ/73Ot7Dx1fwje95LiA5DWmmZU4YczS4i6kGCbXOy8Iq9EPqVDpz2d5SUd
	BWPql//uTrdr8WTYiPOkddGlU8q40/Ra15Uvho9Fv+iB5NL86XcD4ZsbZ2OJQQ==
Message-ID: <4e31e3b5-fa69-4c4c-a5e9-dea7a8452ee7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778537335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwfMOER86C9OyxsWQbr78qu7EgXq0GUCfI5AjQ12ehQ=;
	b=bOdtI4p0qanRqSbsCa4w1L/vLCLQI2V2bIJsC5Vn45SpOZUkP6UlR1hBwm7b6xiH7Z4LvX
	fgG+bkZj/d++jHtxwpyTxB9hjA7VBtnnKYA3GzmsQrYpoLyFapNlxbvbFH+ZSeYOWJZWGc
	tNfh3ywkcwrgbXC3EzM29DKbh7zK+nNXvlHLuZ9Ei0CPfCVqCZXTJcLZ+Ah5DU7QfNhNJI
	kDdkIy6zBV8pIKezCqp8BOD3/AxdLrTXZpr05/io09b1/3m754zug3R4RvJzO6o/3MCvmE
	QW0ZtVDqY6RmFDjVxsYJJHLYqgvV/bZrg4yeDyPtTPg0HItSlB71ezZmNj7JwQ==
Date: Tue, 12 May 2026 00:08:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION] 6.12.y: d66792919d4f (sched/deadline: Use revised
 wakeup rule for dl_server) causes latencies up to 50ms with PREEMPT_RT
To: Sasha Levin <sashal@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
 linux-rt-users@vger.kernel.org, Lukas Beckmann <lbckmnn@mailbox.org>,
 Mike Galbraith <efault@gmx.de>
References: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
 <20260511141441.stable-reply-0001@kernel.org>
Content-Language: en-US
From: Lukas Beckmann <lukas.beckmann@mailbox.org>
In-Reply-To: <20260511141441.stable-reply-0001@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9wk3frmm1cyqyn9ofpifscrf1adhgy88
X-MBO-RS-ID: 139742fdea8800cf756
X-Rspamd-Queue-Id: C10E75169B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,mailbox.org,gmx.de];
	TAGGED_FROM(0.00)[bounces-245326-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas.beckmann@mailbox.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Action: no action


On 5/11/26 16:21, Sasha Levin wrote:
 > Thanks for the detailed report. Before I revert d66792919d4f from 6.12.y,
 > I'd like to confirm whether the underlying issue is the missing dl_server
 > rework chain on 6.12.y rather than the revised wakeup rule itself.
 >
 > Mike's reply notes that his local 6.12-rt tree carrying the following
 > three commits in cannot reproduce, while the same tree without them
 > reproduces quickly:
 >
 >   cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
 >   4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
 >   a3a70caf7906 ("sched/deadline: Fix dl_server behaviour")
 >
 > d66792919d4f's upstream commit message explicitly says it relies on the
 > state established by a3a70caf7906, and none of the three are in 6.12.y.
 >
 > Could you give those three commits a spin on top of 6.12.y (keeping
 > d66792919d4f in place) and see whether the latency goes away?

If I apply the three commits on 6.12.y, the latencies indeed go away.
This is running for a few hours now, and the latencies showed up after 
30 minutes tops, with plain 6.12.y before.
I will leave this running.

Note:
I also tried applying only cccb45d7c429 ("sched/deadline: Less agressive 
dl_server handling") before, and that also seems to fix the issue.

Thanks
Lukas

