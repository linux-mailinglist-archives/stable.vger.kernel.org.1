Return-Path: <stable+bounces-226922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKYIHOfXuWlHOgIAu9opvQ
	(envelope-from <stable+bounces-226922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:38:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B59FC2B3215
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06A9D3063AC2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302FD3E51F7;
	Tue, 17 Mar 2026 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpQDzL4w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8058304BBC;
	Tue, 17 Mar 2026 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787106; cv=none; b=QfhmePmcjLjKQ59zQtQ6mRf/9noG/s7Qv6OyhL6lbsFzSiHrlxEGVkKqND7fZbRHhD0VFHjXVziPyJ3xLOuBqEywe+4wKM7N0OloJBvwQF6KVjNE2vWG2gGIAd654SNLQ83zQAJkMTzd6vi1e/puUbu+e3RbEgez/Esoy3MQjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787106; c=relaxed/simple;
	bh=E1J05oPXmMboWQHafG2b6za/eMfN+FONpPBmlN/5bz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEVSGLIDZoHDipzyNWYxau7QAJcdz3zFb/7PdncjktD12GgHPHw+lgUf0osEeTEYooRkpe3ofUBLGHkN19Lz/rlRxVWaKThuXsWlWFJ090Atb7yz4d+33eWEl6/PfCfYGA549viEbVfRorURCmjKJviq/DdIzuu00Yw+fhTH7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpQDzL4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF524C4CEF7;
	Tue, 17 Mar 2026 22:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773787105;
	bh=E1J05oPXmMboWQHafG2b6za/eMfN+FONpPBmlN/5bz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KpQDzL4wZPqjCIH7vJQMTEihJjut3ZFEUN629sxIj3PV8gUwRk4d7mnKoTsv8i2W8
	 Xs2dvQSw/v7Ze3cIU+O3fUywYzAs0nkAwMd01Eo7wirjLqsLsYE5TdO4S/vwjlr1bq
	 Rlb0JR3l38qH3Fah7XCRoy8Xih36fjc93lXL0X3Skn6A6roCKZW0TZyi5ADEuAeaYx
	 4jhVRrp2Em4qjN+v6hQ1fjVQy3sWvdE1rcjaiDQE2H0JODbziUIqn1eqFONkq2J29L
	 FdnvPh94oKEgYj1EgLTCOlZkXoaI2ZongqN42Qh20bH0x7QcVJRAZJDIKPBbreNdOm
	 1lIdTV4ZuXzEA==
Date: Tue, 17 Mar 2026 15:38:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Junrui Luo <moonafterrain@outlook.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shruti Parab <shruti.parab@broadcom.com>,
 Hongguang Gao <hongguang.gao@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3] bnxt_en: fix OOB access in DBG_BUF_PRODUCER
 async event handler
Message-ID: <20260317153824.7671cfde@kernel.org>
In-Reply-To: <SYBPR01MB7881A253A1C9775D277F30E9AF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881A253A1C9775D277F30E9AF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226922-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B59FC2B3215
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 17:41:04 +0800 Junrui Luo wrote:
> The ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER handler in
> bnxt_async_event_process() uses a firmware-supplied 'type' field
> directly as an index into bp->bs_trace[] without bounds validation.
> 
> The 'type' field is a 16-bit value extracted from DMA-mapped completion
> ring memory that the NIC writes directly to host RAM. A malicious or
> compromised NIC can supply any value from 0 to 65535, causing an
> out-of-bounds access into kernel heap memory.
> 
> The bnxt_bs_trace_check_wrap() call then dereferences bs_trace->magic_byte
> and writes to bs_trace->last_offset and bs_trace->wrapped, leading to
> kernel memory corruption or a crash.
> 
> Fix by adding a bounds check and defining BNXT_TRACE_MAX as
> DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ERR_QPC_TRACE + 1 to cover all currently
> defined firmware trace types (0x0 through 0xc).

Hi Micheal, looks like it now does what you asked in v2? 

