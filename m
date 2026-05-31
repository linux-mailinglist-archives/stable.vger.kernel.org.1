Return-Path: <stable+bounces-259338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vejsI+sjHGrbKAkAu9opvQ
	(envelope-from <stable+bounces-259338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 14:04:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCAA615F33
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 14:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7D803004D33
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 12:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CE126C385;
	Sun, 31 May 2026 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b="GXmDwvEi"
X-Original-To: stable@vger.kernel.org
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5526026ACC
	for <stable@vger.kernel.org>; Sun, 31 May 2026 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780229095; cv=none; b=SDQPh+S9XMD7wXFA9WMyDD68dVIGX5TRowdaVdKlYgp7/TL3BX5k935X9CVLYgNnGfUuhPWjiR0NO/w1+hdOJEIdWKd01Ywo/vgJFO8nH2DdXdfkDybqF/wZ9csaszmC/zypoL9LsVo5wc/pgnTHUoALy5PODoezLql1Rr8T7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780229095; c=relaxed/simple;
	bh=05p/vf2Uy4yVgyTuiD8+N3iJWxL/mfHAcfY1RDrfx6k=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=RIvElL/R7IfVNBNmjBeas7KR5/srAfYLY8fkH38tdbu3N4oE2WXhyAFZjebVlH0xCAGcp6nVmV1u8NP2TgqH40PKUajeujMyf/nhIxmvGgW0m/kQuWA2Xgkcgi9nRnbyL45+I4RhLlHqi2CUEL3FfXQSghJT2RFM4tWQzTHZW+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm; spf=pass smtp.mailfrom=poczta.fm; dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b=GXmDwvEi; arc=none smtp.client-ip=217.74.67.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Received: from Stacjonarny (62-133-144-026.dynamicip.ostnet.pl [62.133.144.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTPSA;
	Sun, 31 May 2026 14:04:48 +0200 (CEST)
From: "Artur Chlebek" <achlebek@poczta.fm>
To: "'Greg KH'" <gregkh@linuxfoundation.org>
Cc: <amd-gfx@lists.freedesktop.org>,
	<regressions@lists.linux.dev>,
	<stable@vger.kernel.org>
References: <002901dcf0eb$9472e210$bd58a630$@poczta.fm> <2026053159-unread-disagree-0da7@gregkh>
In-Reply-To: <2026053159-unread-disagree-0da7@gregkh>
Subject: RE: 7.0.9 vs 7.0.10/7.1 Radeon 260X regression
Date: Sun, 31 May 2026 14:04:48 +0200
Message-ID: <003701dcf0f5$ae8ef350$0bacd9f0$@poczta.fm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFDUGtZMJYvTWCxG+Cy9+QRqeP05ADRSPyrt1S/MJA=
Content-Language: pl
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1780229090; bh=e7/qcnShqUBBb/+p6q0GSpdsFle8DuDHsO56XnzqioA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=GXmDwvEiA9rdPLAcNyoiRs7Uub7f7a/9nEZ4ZoZGHkQxImZiDAyvHdco+9Iabd1F5
	 a0waF3I0hT7NSjIeiiqiUSR6w+haAUCjJkg98zRO8qKKn50erchdMod/whlE3Vo61X
	 KY/FkU3AZcd0YVjMRPHgEebkeBHWos+FyRxOj9Mk=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[poczta.fm,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[poczta.fm:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259338-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achlebek@poczta.fm,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[poczta.fm:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[poczta.fm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:email,poczta.fm:email,poczta.fm:mid,poczta.fm:dkim]
X-Rspamd-Queue-Id: 5CCAA615F33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org> 
Sent: Sunday, May 31, 2026 1:43 PM
To: Artur Chlebek <achlebek@poczta.fm>
Cc: amd-gfx@lists.freedesktop.org; regressions@lists.linux.dev;
stable@vger.kernel.org
Subject: Re: 7.0.9 vs 7.0.10/7.1 Radeon 260X regression

On Sun, May 31, 2026 at 12:52:30PM +0200, Artur Chlebek wrote:
>> Hi, I have 5x fps drop on amdgpu Radeon 260X 1GB between kernel 7.0.9 
>> and
>> 7.0.10 or 7.1rc
>> 
>> Original sparse mail got flagged as spam so let me elaborate:
>> Newest vanilla Fedora with Plasma, Gigabyte GA-H97-D3H, looked into 
>> things like clocks, PM, ASPM, tried flags, GTTSIZE, .dc=0 - all seems 
>> fine nothing helps.
> 
> Can you use 'git bisect' to find the offending commit?
> 
> thanks,
> 
> greg k-h

I'm sorry I'm not familiar with git at all, and very new to Linux. I can do
some local tests if led by hand...


