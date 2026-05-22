Return-Path: <stable+bounces-253790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCtENUZbEGqDWgYAu9opvQ
	(envelope-from <stable+bounces-253790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:33:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D075B5378
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6685A310D9DD
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC3B3A48DB;
	Fri, 22 May 2026 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLtxUYmM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE635675F;
	Fri, 22 May 2026 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455565; cv=none; b=JjHL+HhhF9jXacCifky/wPq66E881kVTxqi+beB8nUVsQaANPLrQDARuuyMKnlVsnt6Sg39bkzxTNLsrQ3GB4936WFJvKZgnHKPbpwBnofo8RSVFvjv6cLy6Wmx2rNG5uVDRHBBhvk4weAibNT09y/WnDLIwVUmTMeDHEgpnwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455565; c=relaxed/simple;
	bh=xHP99JOSb7QXdOdGYHj8nJnQwp268iIMFoEmZ1tmNZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcYXhpqNGlrw0ExsMBo8BQecWlrX+CGkKQD9LgnCIF6LQg8k5que3GpSiB1aGiTFaYWf4aEtVdOmjL64xt8z7WvNxJwGmmlzfrwY/DIRvgtHn1Y4kiQyokfXUBVFuA2O3kWTSE9CMVbEyazcz8xVYU/EN86MMK7LWxYRDelHaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLtxUYmM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9901F000E9;
	Fri, 22 May 2026 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779455564;
	bh=xHP99JOSb7QXdOdGYHj8nJnQwp268iIMFoEmZ1tmNZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OLtxUYmMZY0TnFtclx7kgoRGfX/ERw6VL6tZbcUEh5Nc4yPnahQCPB8xiwQjeF+bU
	 KKGikSBu26knMFZZRQjZMVaaG9qAQInyeaXHke6UjtJZcYIWyPmPl5qD2ybupiMq29
	 GWY5FQftWcvKidivgEWkV4jh9SQYf7w+A484UgzffOmTs6zIIm18B3b/7mhLLTWNza
	 1Wwzgn1O1cBGAQJBITKCXwxHYeVueOTiPMG3MsuSyhM3J+3mL0PKdke1yqof4SRPWw
	 +mDth16krBOcbwZFSz1eQI0B+ZaOLZ6pxkAwhpEMAHS47NT0w+tyWH/aLrpWtl2c9W
	 yMMtDYDu8+a4g==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Song Liu <song@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 6.12 346/666] bpf, riscv: Remove redundant bpf_flush_icache() after pack allocator finalize
Date: Fri, 22 May 2026 09:12:28 -0400
Message-ID: <20260522123641.rc-drop-46ee1342b887@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b8ef921f-e2ab-4cfb-b75c-89e4277214cf@oracle.com>
References: <20260520162111.222830634@linuxfoundation.org> <20260520162118.730164877@linuxfoundation.org> <b8ef921f-e2ab-4cfb-b75c-89e4277214cf@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,huawei.com,gmail.com,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-253790-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 53D075B5378
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 03:27:13PM +0530, Harshit Mogalapalli wrote:
> Upstream doesn't have this problem because this call is removed in
> commit: 6798668ab195 ("riscv, bpf: Remove duplicated
> bpf_flush_icache()") but this is not present in 6.12.91 so I think it is
> incorrect to backport this, should we drop this ?

Dropped from the 6.12 and 6.6 queues — 6.6 has the same missing
prerequisite. Thanks for the report.

--
Thanks,
Sasha

