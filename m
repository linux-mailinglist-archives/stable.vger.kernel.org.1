Return-Path: <stable+bounces-235276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHIYLpqv1mkLHQgAu9opvQ
	(envelope-from <stable+bounces-235276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:42:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E143C3517
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 582523009809
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F44337E2EE;
	Wed,  8 Apr 2026 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="GGL6mQL8"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4237AA96;
	Wed,  8 Apr 2026 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677318; cv=none; b=EJhMQOAda0emxQu+rf/YcHpOCtw6B5G+qbfJAkJmWXVPixbvcuKr6ObJfAJFI7/GyugcSL7i8J1Sbd/Ufm5IZuN50HMgmR08ZHnKO1c7O1t7DnZHk+KtcyjeWOR0DfZU3jP7PmJbS+s/FfuhagfVjaVjXyP2rLUe+VjwY5IbLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677318; c=relaxed/simple;
	bh=1R+q0brxT5FCSRMOO/LqKS2K1GLvRDjYnI692aiflvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B++A9rN3Ev0hPDzNL5u0TpxkVrfNnvbk7ayMJBibPhO3otLzV9uL9qr0A65dsExboa0GlUCcR9CaGnqUbvFqP5dquW4ITFfdryjLN2b5FcTutxPwloH3Q7inom1/1P4Mncakaywn4X+1nQPyBKCjJWTD2XJukFKtROrGX75o/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=GGL6mQL8; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775677314; x=1776282114; i=rwarsow@gmx.de;
	bh=1R+q0brxT5FCSRMOO/LqKS2K1GLvRDjYnI692aiflvw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GGL6mQL8x1Z+hZbBWfJ4pP3SOe7fG5P3PtEr9LF5oimEHUKqr5TqI5UGl9lkhzy2
	 mI9WDQ2Lo7g5ofU1PdXHvGlBQUTmqAwyxnv3kJCAYsm1Tc1oJd4mF3Vdj9w4Do/Gt
	 j5gqQXmnmvgJzSpNd4Kl4F+aoz2nNnyIk5gd8hzwvQYrspxV9G3x95XhHhSGkoaWJ
	 wPx9dR3QwvKboo32efYOB8PyqFU3MMzgG1siBZyoUUhmJSHFa4h9Z25JDPWjw2oIC
	 0XmGiJJBVVKkMWVxYga2NXB55HNADodRJxQFlJ92WcAlct33miPCZ+iwO0j6qxW3J
	 1GwqDwoI/wqxJZkh9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1vrvTJ3RnI-00Lg9Q; Wed, 08
 Apr 2026 21:41:53 +0200
Message-ID: <ec3c9cf1-a549-4d21-b941-53ba02d73a8c@gmx.de>
Date: Wed, 8 Apr 2026 21:41:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260408175939.393281918@linuxfoundation.org>
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:womJkL1iHVkotgUAyScEMcxLUAkfoI7i1cLx3Jv5BCfE67I5bTN
 hbnChiEH8vwZr0K/Yceww2UjKfuawG6uXp4j8DUjODG5E0Aqv/OPcsYNwXvy5wjt79gk1Pv
 OgTKWilf6Vx2BIMM7e4+wPgVed2a3fS3/fzZCm+Y5xyNuJ/fR4Y+1JTs96FAj2CxABfmMFU
 DdoA1DIQ/CRDPuEnDAmDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hQfatGUKZjo=;FFgCEY0nEYbYpvFc1Rp/cNAnopX
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235276-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rwarsow@gmx.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 94E143C3517
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

no regressions here on x86_64 (Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

