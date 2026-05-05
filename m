Return-Path: <stable+bounces-244006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA5uNZuj+Wk6+gIAu9opvQ
	(envelope-from <stable+bounces-244006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:00:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 290344C8632
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3379C302000A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 08:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630133C5DC5;
	Tue,  5 May 2026 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="SWIjxXx0"
X-Original-To: stable@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090D3E866D;
	Tue,  5 May 2026 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.212.184.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967999; cv=none; b=O3eGPcbY2Bgqbxo5pMJKALe35Lm0iBTNBQi9SJ42fCj5aREOC8kFDh1RYn7tN9xvDyfjViiwlScoOnQHwfHO2i97Urg90/EBnqJ5C3S1lCXZGrQJnzC2ZQ15sqe99u69t4rBdVHA7Y1AmPBPXb6vBcYW27kMuAu4D4og8iSAa+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967999; c=relaxed/simple;
	bh=Dg3kC2xZDHMgwWHCpdC/QnZKHbL5rvpcL2jcxIAHtrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUpB3QdZRFlbXiCA8XT6l4DJaikn5e1ntIO0A7TE6NJtVZll4bGAiAcsKt0ayIvZT9NHnfCAED1hPSEU12b3gC3HSnruMmaoCxZHBwE3T2A1E90TpvhYpqha0Gwn/TMPuJ8Tn2tX81ZUJQYepKxSKfeXsx+u29AX/u892e+4uQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=SWIjxXx0; arc=none smtp.client-ip=155.212.184.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rulkc.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C87681006E6;
	Tue,  5 May 2026 10:59:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1777967992; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4OdOBoWJ4ACSfIixekPE8cVTYjRFt/rkbnFpQqOJuxQ=;
	b=SWIjxXx0kmTtkUzX9UBhUNI5cN9FyEAftPaPrNR/30tp+WsbGwZgV71cqRlQAf51OLdPmp
	q60eV1oLadf8IoHlPpyCb2CK4aCD6PrLntsjy3RenGzIYlIRb8be27Rl8IVFWHVPUPHcjU
	0Xy0/Bqir9Kkunwgn56F+dJpqAtvlx21M/xun1nJFLThBJ5fXZfGrZfeYkUeuD95SOC15y
	gR0grlgTEktZZnM3rYnQX1z1UIYN9OAFX8CWtDEJGuFtowYWEHyQwNZfjloGGgkVWf+Pes
	9VH6NsdGuhgnMq/hY9kGSiULY7ihuaM632DbiwtmLWt6iu7lyJ+l0mhOaM8/Zw==
Message-ID: <57b0cc2a-6d62-405c-bfa5-68d1c46dbad9@rulkc.org>
Date: Tue, 5 May 2026 10:59:16 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mtd: rawnand: fix condition in 'nand_select_target()'
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Boris Brezillon <bbrezillon@kernel.org>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, rulkc@linuxtesting.org, oxffffaa@gmail.com,
 stable@vger.kernel.org
References: <20260504221012.1310605-1-avkrasnov@rulkc.org>
 <87mryeqoqs.fsf@bootlin.com>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@rulkc.org>
In-Reply-To: <87mryeqoqs.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 290344C8632
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244006-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[nod.at,ti.com,kontron.de,kernel.org,lists.infradead.org,vger.kernel.org,linuxtesting.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rulkc.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


05.05.2026 10:50, Miquel Raynal wrote:
> Hi,
>
> On 05/05/2026 at 01:10:12 +03, Arseniy Krasnov <avkrasnov@rulkc.org> wrote:
>
> Two important typos in the commit log :-)
>
>> 'cs' here must in range [0:nanddev_ntargets).
>                 be                           [


Hi, sorry, You mean?


'cs' here must be in range [0:nanddev_ntargets]. 


Thanks


>
> Thanks,
> Miquèl

