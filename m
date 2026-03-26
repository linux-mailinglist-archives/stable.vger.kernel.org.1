Return-Path: <stable+bounces-230531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBI8JmCpxWlUAQUAu9opvQ
	(envelope-from <stable+bounces-230531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 22:47:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFDA33C1A5
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 22:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9DDB3025F5B
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 21:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC1238E132;
	Thu, 26 Mar 2026 21:44:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net [50.242.207.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98B1CAA79;
	Thu, 26 Mar 2026 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.242.207.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561467; cv=none; b=ThQMNCJs+eS2Ki1x0VFX70PqHMvFH5ssAr6cPeHP8TOdvq62thqVNpu+ait5NBUNvynQ/0o/89Kepp4PiCW9V/1bUoBnxtDrcIPOKdh81Rv8wMsgj7//zqURu0H49nhPMQ5JtXPEQrArDJhrquhur1MofX8tV/SixOvs/y7eHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561467; c=relaxed/simple;
	bh=IRnMWKdOzI53zeMF/UZ6zWRML4rtXe+3FoU2gylDfcc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qiYaoeEKwtqqYUgP7mVOu9V1wUgPFiOkNCSCWgTpS6rzUY4Fi+8CBOAzYNcVd7I5dhnk0cgn6E9I3mywrlJdlyCNxotiLNOOGYNSMOaSAc5Lmymyk8t4bLtzVZuFnGmXKWXVUapa15XWsobY9FMpFBmU0ceyUO9P+eiIWkCRF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=absolutedigital.net; spf=pass smtp.mailfrom=absolutedigital.net; arc=none smtp.client-ip=50.242.207.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=absolutedigital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=absolutedigital.net
Received: from lancer.cnet.absolutedigital.net (lancer.cnet.absolutedigital.net [10.7.5.10])
	by luxor.inet.absolutedigital.net (8.18.2/8.18.1) with ESMTPS id 62QLhfmn014451
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Thu, 26 Mar 2026 17:43:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by lancer.cnet.absolutedigital.net (8.18.2/8.18.1) with ESMTPS id 62QLhfPg003292
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 26 Mar 2026 17:43:42 -0400
Date: Thu, 26 Mar 2026 17:43:41 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
cc: Mario Limonciello <superm1@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org,
        jslaby@suse.cz, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: Linux 6.18.19 -- amdgpu bug and a new warning
In-Reply-To: <9223c139-3c0e-49b0-a5c2-27025739e8e9@oracle.com>
Message-ID: <8e2fcc37-7192-6eca-e4e-f9d6ebef8ec0@absolutedigital.net>
References: <2026031914-send-embezzle-1648@gregkh> <1df33732-8d66-d669-84a8-259f1b7f3278@absolutedigital.net> <156c7e58-df60-44ca-8c26-78ccab2c1647@kernel.org> <9223c139-3c0e-49b0-a5c2-27025739e8e9@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230531-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[absolutedigital.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cp@absolutedigital.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FFDA33C1A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026, Harshit Mogalapalli wrote:

> I think backporting this would help ?
> 
> commit: e12603bf2c3d ("drm/amd/pm: fix amdgpu_irq enabled counter unbalanced
> on smu v11.0")
> 

Ah, very good find! Thank you, Harshit, this fixes things up.

Greg, please consider commit e12603bf2c3d in mainline for 6.18 stable.

-- 
Cal Peake


