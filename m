Return-Path: <stable+bounces-273151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ISiEDlCLUGpv1AIAu9opvQ
	(envelope-from <stable+bounces-273151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 08:04:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 180C073780A
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 08:04:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZytSI551;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273151-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273151-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8557C3011061
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 06:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE738228C;
	Fri, 10 Jul 2026 06:03:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBEC23392B;
	Fri, 10 Jul 2026 06:03:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663436; cv=none; b=D9OLDQfHT8E0OC4MeweOw2+sN06+I4Vu+2rwKU5xPbfjrSAaktOgwtMYAEskEZvXgw7UMvqm/YyrgTt94fUvMZ3RO8XLyXSVrd+sZSbvCg/pwGZvE0ArEfk2sdE4qSt9erIVUlC5z7OLMpITnbtaN+t17eEv6cUi+478jzoNEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663436; c=relaxed/simple;
	bh=3v3vmUd0MRPHLOd6bY5pUNbi0H2IDXzu2QgQPQUjN0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujjSGf1kR2Fz1j63nH1u1VOHQfYCg9J/GZxJmd+YwnI2jK1GDDpWfatEcGGh2rCeKPs2FQIuqhUSLIEThCh7vBJK36RS5rErI4EBcCS/A0e1/g9hcoW/IiColFKtSC8EmAlA6M/BBNxbQ6amGSd85HtGMIWw0iGmMYyc7dtCPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZytSI551; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8BC1F00A3A;
	Fri, 10 Jul 2026 06:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783663434;
	bh=5Y74+++guofbvMpr06xrpPUMLDVF0KSDXkgvQiQNbcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZytSI551x6FAEGPu9FBvh1mo+h7Q5fQ64A6KfsUrCrlRP5Qf9DeURA7bER3GTzfPZ
	 waKqNX7q9FSenn8xSHFobMUiLSz7IeJXUq7LQYwm+ulSV3KzmOvkJi9hecPLIrxgs7
	 4iXfKcwvQZbdoewYRnLNNuAOd97ZQbTFFwRZtwYWBcUrDc5HAFQpV1rrGoTKxa1v8M
	 Gh3iRFwlDEnHj5m5okTIZOKwnS1u73Xb17mO15HW1zL3FpyS+61s2kupMvl07SP3pb
	 FjxA0/HKeRHeDCgXhpsAJDFt4cRkN9X97TMmOB+zKUzclFzDIYdbQ0OsClj72yWmC3
	 ANg8KFRiD8e7g==
Message-ID: <5dc6cdf9-1d25-40a5-bbe3-5d57585b46c9@kernel.org>
Date: Fri, 10 Jul 2026 15:03:42 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scsi: scsi_debug: fix REPORT ZONES alloc_len underflow
 OOB write
To: Ibrahim Hashimov <security@auditcode.ai>, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com
Cc: shinichiro.kawasaki@wdc.com, damien.lemoal@opensource.wdc.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <1357dbf9-e135-4ba3-896d-1472a208f82f@kernel.org>
 <20260710055755.53830-1-security@auditcode.ai>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260710055755.53830-1-security@auditcode.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:security@auditcode.ai,m:martin.petersen@oracle.com,m:James.Bottomley@HansenPartnership.com,m:shinichiro.kawasaki@wdc.com,m:damien.lemoal@opensource.wdc.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-273151-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,auditcode.ai:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 180C073780A

On 7/10/26 14:57, Ibrahim Hashimov wrote:
> resp_report_zones() derives the number of zone descriptors that fit in
> the reply buffer from the command allocation length:
> 
> 	rep_max_zones = (alloc_len - 64) >> ilog2(RZONES_DESC_HD);
> 
> 	arr = kzalloc(alloc_len, GFP_ATOMIC | __GFP_NOWARN);
> 
> alloc_len is taken directly from the CDB and is fully controlled by the
> initiator. When alloc_len is smaller than the 64-byte report header
> (RZONES_DESC_HD), the subtraction underflows and rep_max_zones becomes a
> huge value. The buffer is then allocated with only alloc_len bytes, which
> is smaller than the 64-byte header the code unconditionally writes, and
> the descriptor loop is bounded by the bogus rep_max_zones. Both the header
> store and the following zone descriptors are then written past the end of
> the undersized allocation, corrupting adjacent slab memory.
> 
> Fix it by sizing the buffer to a whole number of 64-byte blocks that
> cover the requested allocation length:
> 
> 	rep_max_zones =
> 		(ALIGN((u64)alloc_len, RZONES_DESC_HD) - RZONES_DESC_HD)
> 		>> ilog2(RZONES_DESC_HD);
> 	arr_len = (u64)RZONES_DESC_HD * (rep_max_zones + 1);
> 
> 	arr = kzalloc(arr_len, GFP_ATOMIC | __GFP_NOWARN);
> 
> RZONES_DESC_HD is a power of two, so ALIGN() rounds alloc_len up to the
> next multiple of 64 and rep_max_zones can no longer underflow: for any
> alloc_len of 1 to 64 it is 0, so only the header is built. arr_len is
> always RZONES_DESC_HD * (rep_max_zones + 1), which is exactly large enough
> for the header plus every descriptor the loop may write, so the report is
> always assembled within bounds, including a possibly partial trailing
> zone descriptor. The existing copy-out still transfers only what the host
> asked for:
> 
> 	fill_from_dev_buffer(scp, arr, min_t(u32, alloc_len, rep_len));
> 
> so an allocation length that ends in the middle of a zone descriptor
> returns the correctly truncated partial descriptor, as permitted by the
> SCSI/ZBC specifications, while never reading past arr_len.
> 
> The aligned length and the buffer size are computed in 64-bit (alloc_len
> is cast to u64 before ALIGN and the size product uses a u64 block size) so
> a crafted allocation length near U32_MAX cannot wrap them to a small value;
> such a request simply fails the large allocation and returns a check
> condition instead of overflowing the buffer.
> 
> This was found by static analysis. A KASAN slab-out-of-bounds runtime
> reproduction of the original underflow is being re-run against the ALIGN
> based fix and will be reported separately.
> 
> Fixes: 7db0e0c8190a ("scsi: scsi_debug: Fix buffer size of REPORT ZONES command")
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

