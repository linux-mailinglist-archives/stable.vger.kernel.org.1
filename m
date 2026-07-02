Return-Path: <stable+bounces-270288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WNOBHTKzRWqDEAsAu9opvQ
	(envelope-from <stable+bounces-270288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:39:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 111B56F2A60
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:39:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DRSYZ+cN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270288-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270288-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CF553040CB1
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC9F26ED59;
	Thu,  2 Jul 2026 00:38:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6C242D65;
	Thu,  2 Jul 2026 00:38:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952730; cv=none; b=aL8TcbVPK/49Gquxse7IrPqzqZJM5ARoQVhxmedBltrIeHs6jfHYmAroJp7YXVB8QYkIUoFoFcD36UhuzBUQn4cIkwb25dhoccUnIj7gnm3gh+xdh45fpqY8BMIB/WQ8RNl6M5091ScfMpK7hgXRKpPAkvh1hFiRsMzhfxTkn5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952730; c=relaxed/simple;
	bh=kT/NBqQunlWsQ7ubvjZhQleFnca7dO290+Jy4yB4+cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/xbjw1ODO4chm1y7e5mzpRVz1D7x77ESTt4O0IlqbRaT4cs8qVTZhpYmvtRB3y0zy3WFyapAPokOk8/w1BkRbrkk4pmGBoM+h6OFCM85Bo3n33JgJ6b7Q3JxvbsVj3K8phIZVSisIo5SXZNEpuviBt8BoIfUsi5Hc6T6ECefe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRSYZ+cN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EC21F000E9;
	Thu,  2 Jul 2026 00:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952729;
	bh=RQBnHF1qtS6KGf+wzw5MMQOAlTk6sYRCuY6XAJaTSS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DRSYZ+cNrD4eaUMA1Yzo5UAlyJZNYfyijYcOlj2OVeGlPPY9GsH1pOdugbAyeMoS4
	 NChqDFgyYeU7McLKXTf0nYvCFkvviI+yaTpiOFcxsTVGdyZj95XW0xUy0o3yTcmnaj
	 jI1eyP2zW2Zlrg0MQYoKJf9U4OpRVUMCxFcbvYtydGwRdlQKjJ+ytNKInAj/TZNUQS
	 Bkw6/sI5mR0fLWCnN8523HCIJej/TfLJnRwUUvMSzmIn8eVgBvMv94iHsyODWSO6Ac
	 e0/MvxdoPGsBKr2E9i5v6Mg7fGYruiA73OUsMQbwnsQitQYYtbfbfPdJz/zE3qu6cd
	 rr7sQRTyK90Jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Elizaveta Tereshkina <etereshkina@astralinux.ru>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Wenshan Lan <jetlan9@163.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
Date: Wed,  1 Jul 2026 20:38:31 -0400
Message-ID: <stable-reply-cpsw-new-510-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630200717.1994713-1-etereshkina@astralinux.ru>
References: <20260630200717.1994713-1-etereshkina@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:etereshkina@astralinux.ru,m:grygorii.strashko@ti.com,m:davem@davemloft.net,m:kuba@kernel.org,m:haokexin@gmail.com,m:alexander.sverdlin@gmail.com,m:jetlan9@163.com,m:ilias.apalodimas@linaro.org,m:m-karicheri2@ti.com,m:linux-omap@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:alexandersverdlin@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270288-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,astralinux.ru,ti.com,davemloft.net,gmail.com,163.com,linaro.org,vger.kernel.org,linuxtesting.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 111B56F2A60

> If an error occurs during register_netdev() for the first MAC in
> cpsw_register_ports(), even though cpsw->slaves[0].ndev is set to NULL,
> cpsw->slaves[1].ndev would remain unchanged. This could later cause
> cpsw_unregister_ports() to attempt unregistering the second MAC.

Queued for 5.10.y, thanks.

-- 
Thanks,
Sasha

