Return-Path: <stable+bounces-273893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LsEDNnocVWo+kAAAu9opvQ
	(envelope-from <stable+bounces-273893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:12:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E9274DE59
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:12:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=Aw0zskxL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273893-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273893-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A47853001FFB
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D72C3446A7;
	Mon, 13 Jul 2026 17:12:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC4344D83;
	Mon, 13 Jul 2026 17:12:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962742; cv=none; b=mDxT4tgnEMDwglQxVhmzbnAqSNhjJsjwy41ovtVPNKsi9ERHXfFeYY6MQt5uWqxK06egA13rWABJ/x8YvcJLsKbjjKSF6geHaJ7irHP/JHBO/5O16EvzjZhuBSK9MQgNq4Py/axjd3hLYp523gXYzbdUG1xrLv/HXRIZj7lFuKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962742; c=relaxed/simple;
	bh=LcDJfk9uAA8GpXhdM3BLWHuxHJLeab3IiWM2VbO+NbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8mI+6x2xlKtOfMOcDx2GfWKJejge2OScc6uibASIapQWjFlqJdPmiJXjcbZSRZMlM1Km8TFeQJkvb/gK76iW9k/zjE1/FDSmoHg+23SYpCceBaMMErYDS9JEbuSeoUN4ZK3zb/KukvU80fdwcZXb2Cr/4INXF8mOebq7c2U970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Aw0zskxL; arc=none smtp.client-ip=199.89.1.16
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gzTWl6fF2zlh30T;
	Mon, 13 Jul 2026 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783962736; x=1786554737; bh=LcDJfk9uAA8GpXhdM3BLWHux
	HJLeab3IiWM2VbO+NbE=; b=Aw0zskxL0CsQ40qx0AWoR/wai8Ko95dh0n0hGIVJ
	kxApLJWZUG/TXwYy2PmTZoeBKpHf6+CbyLvYlxU1mYWAi4aesaspdTi2qgg1HUkQ
	nijyjYAb0tcmWNr8jbTu0XyVlmcfElLfrTGmRouFu0S+gaRR4K9Qd7JBQ3RQRMiW
	+PsaCNmJ5JXGvD8va1XZilf6Y/I1eLeRrVm31LPqtqbRWfbNKs6YV9WTRX4dtFRd
	BMt9LVyWkFQqgikjACQrSSok8PXrgZOrpxpgy/VefC1iAzgWU8iZZaciEH+2+M+X
	pB33Q2xKtRjYNiT3jlaK1li1PBfr/+KC+FSwrmPO9ZkFRw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qoJ5ryD0sC1y; Mon, 13 Jul 2026 17:12:16 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gzTWf0Xl0zlfl7l;
	Mon, 13 Jul 2026 17:12:13 +0000 (UTC)
Message-ID: <a235cc9a-9d4c-486e-81a0-b7df2fd1bbfe@acm.org>
Date: Mon, 13 Jul 2026 10:12:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: scsi_debug: fix REPORT ZONES alloc_len underflow
 OOB write
To: Ibrahim Hashimov <security@auditcode.ai>, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com, dlemoal@kernel.org
Cc: shinichiro.kawasaki@wdc.com, damien.lemoal@opensource.wdc.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260710055755.53830-1-security@auditcode.ai>
 <20260712183739.83915-1-security@auditcode.ai>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260712183739.83915-1-security@auditcode.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273893-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:security@auditcode.ai,m:martin.petersen@oracle.com,m:James.Bottomley@HansenPartnership.com,m:dlemoal@kernel.org,m:shinichiro.kawasaki@wdc.com,m:damien.lemoal@opensource.wdc.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bvanassche@acm.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,acm.org:from_mime,acm.org:mid,acm.org:email,acm.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63E9274DE59

On 7/12/26 11:37 AM, Ibrahim Hashimov wrote:
> Clamp rep_max_zones to devip->nr_zones. The loop already stops at
> sdebug_capacity (after nr_zones zones), so a report can never hold more
> than nr_zones descriptors; the clamp does not change the report, it
> only bounds arr_len to (nr_zones + 1) * RZONES_DESC_HD, a real device
> property that can never reach 0x100000000.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


