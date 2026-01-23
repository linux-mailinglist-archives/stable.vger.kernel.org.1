Return-Path: <stable+bounces-211374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKwMMHNYc2nruwAAu9opvQ
	(envelope-from <stable+bounces-211374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 12:16:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 435BB74E53
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 12:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB3813008316
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB2287256;
	Fri, 23 Jan 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SDSVETuy"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478730C361;
	Fri, 23 Jan 2026 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166958; cv=none; b=px7rd77f0scHsTcTOvH+PlvuVADpLRcX7pg7dlXI2XCEJdXtVl5nh66hsupgU8RDzPVqBbNuyU/jQB68Vie2NsUYtc29H1m2LgnUqGdoDPJs6VqU0XmIeTpQpYOCLbRwEHhbmE44rxpYgBo79fKuCsrCjxcrQxzqFaXek9mKjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166958; c=relaxed/simple;
	bh=hbCCTTqf/VoHgYXOFS2JZ/4Xv1Ar1ZhaMccriHZ9cGo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LGrtnzGj9KfL0RTt6hAj9EZyl0EFkNNew884/kpBc2cXBMWe+CPsnufnQFQ9bFSWzVxZn1wxPiUBDJ7nCfauQMRYHIPaWgzdygDTMCSvPGyChdbcmFGVR3gM42nSM8K1OikPCbLwD9IGyabtQY0mR9aXsrZpuPDcdvJDHWr+1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SDSVETuy; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769166953; x=1769771753; i=markus.elfring@web.de;
	bh=yde3Mjb8oaKQZAJ6rJRhWjZDacDDPtcd49QgFCiCTvk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SDSVETuyz5mWgUkhsW1FfpH+T8mZmKBMunWaWsMez11VKExVAPqXKHeNNB5zQ/WU
	 +icqQAp0+1+fsi1gLD9ZStJWxEtJYg9mI7S2GQxG+ihmZt5uIMg8pjacYYAKdDbFC
	 Z/iNnIfa/YiEXRJ7gNg24OKJq+ZOL0TwKg7UR4bXNBlHeCdkTZT1lyjWWyiCsW71h
	 S4AItWwoSEjGLzibTOkiY7LVAErLX2LXYfPdQcQhTUeklR6E6kLHP+EEOR5hHia0E
	 GTLzF9fjAjaonNPjZocLjhPcHzHcmUEOZLZPsKHUBe6PggsZ/Yvn0oLGt66QI/w21
	 P2FlMoxdGvYDda5I7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.224]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKuKH-1vUb4O0wcn-00XIHz; Fri, 23
 Jan 2026 12:15:53 +0100
Message-ID: <969082ca-8af4-420e-992d-c6f4cc79f6c6@web.de>
Date: Fri, 23 Jan 2026 12:15:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Weigang He <geoffreyhe2@gmail.com>, Suman Anna <s-anna@ti.com>,
 Jassi Brar <jassisinghbrar@gmail.com>
Cc: stable@vger.kernel.org, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
References: <20260123035648.1441763-1-geoffreyhe2@gmail.com>
Subject: Re: [PATCH] mailbox: omap: fix reference count leak in
 omap_mbox_probe()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260123035648.1441763-1-geoffreyhe2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M61XyfDR2DFHbhcNrHQMpV1v3J20XO3AFTt+nm6BqdfLPsNqrGG
 RAqKYOTuYSNq8xjsrZOH+hHvYfeIjSVI3Fa0O1vN1+w1sz3Tz6+RhbJLYVRkwgOkwit6awq
 7cN5RbkO50raTmQQ0srS7clsaqoB2o8oVnEN2CEV16mOECRHbzsnVnsasVbD/zIu4lRdESN
 /Dl3hq3rQnMMSx/J2F1RQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NIImDBBm9k8=;65Bl88vc3IWUXws9oLZuUPUBFWO
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211374-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[web.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 435BB74E53
X-Rspamd-Action: no action

=E2=80=A6
> 1. Using goto-based error handling to ensure of_node_put(child) is
>    called on all error paths within the loop
> 2. Adding of_node_put(child) after the loop completes normally to
>    release the last child node reference

How do you think about to increase the application of scope-based resource=
 management
with another patch?

Regards,
Markus

