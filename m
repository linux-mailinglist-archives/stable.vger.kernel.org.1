Return-Path: <stable+bounces-238621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gYJICcxr5GntVAEAu9opvQ
	(envelope-from <stable+bounces-238621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 07:44:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE1C423303
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 07:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 439983017C34
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 05:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC653783CA;
	Sun, 19 Apr 2026 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="oJaY8S/I"
X-Original-To: stable@vger.kernel.org
Received: from sg-3-45.ptr.tlmpb.com (sg-3-45.ptr.tlmpb.com [101.45.255.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEC0344DB7
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776577433; cv=none; b=CyTKrmrk917e2k5BeQQPdVmhF6tXet4mSasbyp4jIvESN+jdeRSObsL0CeUmgHrNJfM7ELGNLSXvVHkNc7VHl3r+weH7+4zKdqa3kHg6esGQb1E1zJViZfrU9pYyr8gk6y2zk6CRsbGFxn8dQF1LwDT/H/wDQzrWrbTN1lmk9pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776577433; c=relaxed/simple;
	bh=sG8uZdT4JSUekBmPa6OJFhEBusDE1BxpeuK+0BdP/xM=;
	h=References:Subject:Message-Id:From:In-Reply-To:Date:Mime-Version:
	 Content-Type:To:Cc; b=RlOxnsIF1pfwOrBSgNE/6vMRr4A3afe7no/oTNekr3tGrru0Qio7QB72Sb5cttHvp9wC4kh1gbmy74EcD9JiOp/BnlMtZ01BbCK1A7m/UZO2DYMmcpeiwhcEAAKlprRdioKO0NpeopbqsOjAiKVHnTcSWaPteBDjjOYczu0l4Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=oJaY8S/I; arc=none smtp.client-ip=101.45.255.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1776577387;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=5VH2NoxTYDRBtinO5c2xTAnI0ukORwtztZEvNeeBcQE=;
 b=oJaY8S/Idlynn3aPOP+3j+vdYCnM0ka8QZe7L9unrqhPbK1vUuODnlFDy6ejwclzn5nf6J
 PHivEwq7WlcTS8lvIJU3Bus37g++uayFvLBiq5cD3ks6xgiDbQTyWC3pyAzIYpkmQAhQCb
 i9sifKh995EdzPzrPZQUmRDsAjqdwAFgmM6MFGOSFSR1HxDOaUGzfBqbdi/8RefyQ0AQrm
 heg2p9VyabdKbxcUoYgmgsrKW7MQG8jfbjwy05aodvqwk+p1x/NngxB4lLmntsM8omQxKX
 rm/Kn+n8iXcgiVQ06+MoDc6+ZcYwSV76hz8DBfwCqEW6SgJytwnddp6lxWbvvA==
References: <SYBPR01MB7881A5E2556806CC1D318582AF232@SYBPR01MB7881.ausprd01.prod.outlook.com>
Subject: Re: [PATCH] md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
Message-Id: <beca1657-0180-4f9b-8de1-ca7776c9614a@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.feishu.cn with ESMTPS; Sun, 19 Apr 2026 13:43:05 +0800
From: "Yu Kuai" <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <SYBPR01MB7881A5E2556806CC1D318582AF232@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 13:43:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+269e46b69+7574bb+vger.kernel.org+yukuai@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
To: "Junrui Luo" <moonafterrain@outlook.com>, "Song Liu" <song@kernel.org>, 
	"Li Nan" <linan122@huawei.com>, "NeilBrown" <neil@brown.name>, 
	"Jonathan Brassow" <jbrassow@redhat.com>, <yukuai@fnnas.com>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Yuhao Jiang" <danisjiang@gmail.com>, <stable@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238621-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,kernel.org,huawei.com,brown.name,redhat.com,fnnas.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	HAS_REPLYTO(0.00)[yukuai@fnnas.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:replyto,fnnas.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fnnas-com.20200927.dkim.feishu.cn:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 6DE1C423303
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

=E5=9C=A8 2026/4/16 11:39, Junrui Luo =E5=86=99=E9=81=93:
> setup_geo() extracts near_copies (nc) and far_copies (fc) from the
> user-provided layout parameter without checking for zero. When fc=3D0
> with the "improved" far set layout selected, 'geo->far_set_size =3D
> disks / fc' triggers a divide-by-zero.
>
> Validate nc and fc immediately after extraction, returning -1 if
> either is zero.
>
> Fixes: 475901aff158 ("MD RAID10: Improve redundancy for 'far' and 'offset=
' algorithms (part 1)")
> Reported-by: Yuhao Jiang<danisjiang@gmail.com>

So again I can't find a report, and Reported-by usually should be followed
by a Closes link to the original report.

Applied with Reported-by tag removed.

> Cc:stable@vger.kernel.org
> Signed-off-by: Junrui Luo<moonafterrain@outlook.com>
> ---
>   drivers/md/raid10.c | 2 ++
>   1 file changed, 2 insertions(+)

--=20
Thansk,
Kuai

