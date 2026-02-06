Return-Path: <stable+bounces-214632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKGVJD6+hWnEFwQAu9opvQ
	(envelope-from <stable+bounces-214632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:11:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17947FC86F
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0322A304EA7F
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D63624A1;
	Fri,  6 Feb 2026 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="WWUS3nAU"
X-Original-To: stable@vger.kernel.org
Received: from mail-108-mta142.mxroute.com (mail-108-mta142.mxroute.com [136.175.108.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019335D5FF
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372592; cv=none; b=LEe7ZTrzJ2AnMJm40URb0bQp03torQRm9dSago18bhD3lD5GPUXmsmHS5tXmGL/L5MzpfIaCpDogqp5QH5oMMkSBbETMTpJQAF/VNRlB8es4hu3NvvZGYLRBjnuUSQVpNiSIvtw6lQd78TVtQ82XdOgu007ow+PFDZ8AUestfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372592; c=relaxed/simple;
	bh=BLVTGc0SxbUogCnTPMH9R2bXRrqgqMWuW0GLBam5NVw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ioLEyochz5t7q9PE0U6eOJpZewDcIdog6lffB0GKfGo2R6D4rrqULf9S8/hmT8At45J0EPLvGQdfS3j+BDTUWCN7UYj8jnqkivOf3mrbm+Ox1CRMBUWVMMgN0yGlDIKliEaIZ1tQApNsO7Mxw+ITa1Nt4Nxr0BnlQfqkHcqSQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=WWUS3nAU; arc=none smtp.client-ip=136.175.108.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta142.mxroute.com (ZoneMTA) with ESMTPSA id 19c326dc6ad0009140.00e
 for <stable@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 06 Feb 2026 10:09:41 +0000
X-Zone-Loop: 7fef6b66d138435a4db44da56e7700a33eba917ed909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kJpak91eIUlTOToQNHsWSarIXpdN2cKIEjsn3XsOx/w=; b=WWUS3nAUOyxnZcaBzp9kKdtMLw
	HtTXlNParmw5+eHgPUmu8DBNKGQ8Q07esKfq8TNOip8WVPsHMOyxEiEuQLd7bBUnhR/VxmquxPULM
	8fIFqxTcOlpAkB45KBQPpt+Rspp8uwN6+2DnwpQ69OruMty8oZiuMLBXCW0hKD1qom8qi2+lOEbAZ
	3xqPfb3OaVQR3CMgVRQBQFGsvvmsyut+520ui/JkQqBH4KI+f5pzoDeQRZoPItLH1+11EUsx/QnoV
	tUalVi0m+MEeRjENvvP8BDdjcY1T8leBwIfcAkbQqGSAr1+pOiwyD5wwb0MC5efgG6tVI6MxDUIe8
	kT7XULeQ==;
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Feb 2026 18:09:38 +0800
From: bo@mboxify.com
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] octeontx2-af: CGX: fix bitmap leaks
In-Reply-To: <20260205074859.27392792@kernel.org>
References: <20251020143112.357819-1-bo@mboxify.com>
 <20251020143112.357819-2-bo@mboxify.com>
 <20251022182226.00967149@kernel.org>
 <ba2c3143-0761-4903-ac0e-88ca502b4e50@mboxify.com>
 <20260205074859.27392792@kernel.org>
Message-ID: <14217efc565a011da5cc8cd724794d81@mboxify.com>
X-Sender: bo@mboxify.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: bo@mboxify.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[mboxify.com : SPF not aligned (strict),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[mboxify.com:s=x];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214632-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[mboxify.com:-];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bo@mboxify.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17947FC86F
X-Rspamd-Action: no action

On 2026-02-05 23:48, Jakub Kicinski wrote:
> On Thu, 5 Feb 2026 21:35:29 +0800 Bo Sun wrote:
>> >> Fixes: e740003874ed ("octeontx2-af: Flow control resource management")
>> >> Cc: stable@vger.kernel.org
>> >> Signed-off-by: Bo Sun <bo@mboxify.com>
>> >
>> > Looks like rvu_free_bitmap() exists. We should probably use it?
>> 
>> Apologies for the late reply.
>> You're right that rvu_free_bitmap() exists. I stayed with direct 
>> kfree()
>> for consistency with the existing code in cgx_lmac_exit(), because 
>> which
>> already uses kfree(lmac->mac_to_index_bmap.bmap).
>> 
>> That said, I'm OK with either way:
>> 1. Keep kfree() to match the existing pattern in this function
>> 2. Switch all three bitmap frees (including mac_to_index_bmap) to use
>> rvu_free_bitmap() for consistency with the alloc/free API pairing
>> 
>> What's your preference?
> 
> 3. do what I implied, just use rvu_free_bitmap() in this single case
> for the fix. Follow up separately with a patch to remaining sites if
> any to convert from kfree() to rvu_free_bitmap(). We want the fix
> itself to be small, the cleanup should be separate.

Thanks, I'll send v2.

