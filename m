Return-Path: <stable+bounces-253960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDr3Md3WEWoorQYAu9opvQ
	(envelope-from <stable+bounces-253960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:33:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1ED5BFD74
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D93FF300B9C2
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C84930CDAE;
	Sat, 23 May 2026 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C9AORopB"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0A303A04
	for <stable@vger.kernel.org>; Sat, 23 May 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553959; cv=none; b=Ge5Uxt7bagx2YpNKHUNVEp+4lYBskhKdb5xPsTXhgsx/3ixl0fvnkqpKsZzgD/A1AH54fRs6x1dIeNp798iMLoWjwYrS9as2+XXb+8ki3ftiSpmg6wrU6W0H1NBdKn+J/XTo22OFceskzVXCITMSgLiUtcSjzEvDClTqe/ponVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553959; c=relaxed/simple;
	bh=Z/HVvTp6bqeMXElqfXJMQx4Qn8o/8xX7lEdmUSvDFMU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rK7vFGgMA/vgS4vez70OtM+Qopy4Y8h6CQAFxkOkAo0lVyU0Yqe0Ro70wQsPeViWvI2FBgZVxn7k307JzZ+hI/1/E8CUR6FywzF/PLYhdKlrAR++y5kg/00cIETLkh7uzoZ2Q5ZBbrk237a6FXj/IKt0wSjmzJK/gd2DM+xSoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C9AORopB; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 May 2026 18:32:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779553945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPpBMNYf+uBqXA5a79fqc+GgHVjilTO/Qdq9uXK2cug=;
	b=C9AORopBVxMs4VAZys4RbOh04zs1m0BSF6jeq1L+DOzbrvGg/0fiWO0srYIEecYSFBsVt9
	jQJDYw7ZOuiYW7kQd0fbivFwX7v+hp4+x8iKNmsY3sPluaNI97zOPjxK+sMujQNqGWwjUx
	qXUI48VyrrwkhaCRwjI0SMdh5Z63lLY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, luka.gejak@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7=5D_staging=3A_rtl8723bs=3A_fix_r?=
 =?US-ASCII?Q?emote_heap_info_disclosure_and_OOB_reads?=
In-Reply-To: <2026052313-magnetism-platinum-7ee6@gregkh>
References: <20260523131331.69768-1-luka.gejak@linux.dev> <2026052313-magnetism-platinum-7ee6@gregkh>
Message-ID: <8973C298-B4EF-4DE0-97EB-A6F11BF565DC@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253960-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 3C1ED5BFD74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,
On May 23, 2026 3:44:58 PM GMT+02:00, Greg Kroah-Hartman <gregkh@linuxfoun=
dation=2Eorg> wrote:
>On Sat, May 23, 2026 at 03:13:31PM +0200, luka=2Egejak@linux=2Edev wrote:
>> From: Luka Gejak <luka=2Egejak@linux=2Edev>

=2E=2E=2E

>> Also fix three additional issues discovered during review:
>> - Missing free of pmgntframe and its xmitbuf before jumping to exit
>>   in the WLAN_EID_VENDOR_SPECIFIC lower-bound checks=2E
>> - In is_ap_in_tkip(), add missing lower-bound checks for the RSN and
>>   vendor-specific IE data accesses (pre-existing bug)=2E
>> - Move rtw_buf_update() before dump_mgntframe() to avoid a potential
>>   use-after-free of pwlanhdr, which points into the mgmt frame buffer
>>   (pre-existing bug)=2E
>
>When you say "also" that implies you need to break this patch up into
>smaller pieces, right?  Please do so=2E
>

Well, I just addressed sashiko comments on my patch, so I thought to=20
keep it one patch as it was review of if=2E

>>=20
>> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
>> Cc: stable@vger=2Ekernel=2Eorg
>> Signed-off-by: Luka Gejak <luka=2Egejak@linux=2Edev>
>> ---
>> Changes in v7:
>>  - Address new sashiko comments=2E
>>=20
>
>That does not say _what_ you did, only that you did _something_=2E  Pleas=
e
>be more specific=2E

"Also" part is what was changed due to sashiko's request=2E Should I=20
move it here, provide link to sashiko or write it here completely=2E

>
>thanks,
>
>greg k-h

Best regards,
Luka Gejak


