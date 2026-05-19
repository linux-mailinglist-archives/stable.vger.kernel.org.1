Return-Path: <stable+bounces-249610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id F84rBW50DGoAiAUAu9opvQ
	(envelope-from <stable+bounces-249610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:32:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E39E580937
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A17003100AA9
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD43480DFC;
	Tue, 19 May 2026 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="DqI/32L3"
X-Original-To: stable@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A90919ABD8;
	Tue, 19 May 2026 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200676; cv=none; b=UGL+P6OWYQTC89gUwiY2spF71gaSyNkjLbE13voLfS0wrz1DbS59EdGNrZxbf9Ha7pZuLrJpuEj1mAsbMUB1wKyFyHklI7K+YQQIQkMUIvJXd+J79xTX5os04iaD2NRUpA8m6zkkdAjzdcRJEGHQFi/zbR5cGDeohmJgmAlv8ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200676; c=relaxed/simple;
	bh=ka1TJuL4m08sTG9zn9zPZUp/qOC3cNrQk63WHi7z13I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=td9zz7IyfjZ/Z4M4ArBm/Z8lUtEdES9VW4WSYWEb8miO4xYZAWEmCGr6LoZhmwQroPnYvVVBmXThk0049/U/dFSyucByr2s+KTDcgZxLs2vmLmbvJ9/OwYSTfJ/95mT5/XA57uRgSYqTXhciH/lp7dkixPw0/RDzL2WaY7fnHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=DqI/32L3; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Message-ID: <da97c911-77e1-4d93-be25-ef9f061ae471@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1779200673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRs5JdyXx0CEV0bf2ro8Ws1Nng/pEAIkBKMT3ucgQzM=;
	b=DqI/32L3XNpNFJxTCI1Cd5kwQZkS8KfasilZ46nEOGUzbOPseByZnZEonUgQX01uZ/9uZb
	ueZfFputI5BPgopQIuCgCPG4IEd/PQE76lp9v6wbbavHVbC/b40hVTAlmWS1j7dF1uVN86
	cwa34a1nNAXto4c0pIyHea9yIBkq9XBvpQ54lDu7tjnnb9+57f1c6IGiQi/GTYhg4SXlwX
	+DavHRJ+sOb12pC87viUMnFg7kVMItEQbqhbZS5QX0jZnE7f7/w6aDJrie3VW82N4I1MvM
	OhMEESUFFc7NiTvwDikHXnkgy0tJiDRb5o5X5W2d7avrprLU6+GkqdXPveeneQ==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Tue, 19 May 2026 21:24:26 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] usb: typec: ucsi: Check if power role change actually
 happened before handling
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260519-ucsi-fix-2-v1-0-6f1239535187@qtmlabs.xyz>
 <20260519-ucsi-fix-2-v1-1-6f1239535187@qtmlabs.xyz> <agxwK43LRZytVxPK@kuha>
 <agxyKCo2YPnvZ2lf@kuha>
Content-Language: en-US
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
In-Reply-To: <agxyKCo2YPnvZ2lf@kuha>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qtmlabs.xyz,reject];
	R_DKIM_ALLOW(-0.20)[qtmlabs.xyz:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249610-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[myrrhperiwinkle@qtmlabs.xyz,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qtmlabs.xyz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:url,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qtmlabs.xyz:email,qtmlabs.xyz:mid,qtmlabs.xyz:dkim]
X-Rspamd-Queue-Id: 6E39E580937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On 5/19/26 9:22 PM, Heikki Krogerus wrote:
> On Tue, May 19, 2026 at 05:14:15PM +0300, Heikki Krogerus wrote:
>> On Tue, May 19, 2026 at 06:41:39PM +0700, Myrrh Periwinkle wrote:
>>> The CrOS EC may send a connector status change event with the power
>>> direction changed flag set even if the power direction hasn't actually
>>> changed after initiating a SET_PDR command internally [1]. In practice
>>> this happens on every system suspend due to other changes performed by
>>> the EC [2][3][4], causing suspend to fail.
>>>
>>> Fix this by checking if the power role change actually happened before
>>> handling it.
>>>
>>> [1]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=1689;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
>>> [2]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=3923;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
>>> [3]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=5094;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
>>> [4]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=2229;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
>>> Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Hold on. Shouldn't this actually be fixed in that EC code?
>
> thanks,
>
I'm not responsible for the CrOS EC and the only alternative proposed 
thus far is a full revert: 
https://lore.kernel.org/all/2026051935-flashing-relearn-8444@gregkh/


