Return-Path: <stable+bounces-269703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id toS9AMM+Qmp92gkAu9opvQ
	(envelope-from <stable+bounces-269703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:45:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4572E6D8664
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:45:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=DMrU01HW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269703-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269703-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA44F3047BE1
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 09:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EB03FBB6B;
	Mon, 29 Jun 2026 09:35:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D33FA5D8;
	Mon, 29 Jun 2026 09:35:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725757; cv=none; b=DiMiuXfW8ka8Q1f7PqrV9/5QJpHIp6acEDM+Hn/qaMaGjBqvTloLbMD6YhWWn0vdUqaKPX9zP6LLgkXL/Xsk2SCfKyGbVn3qibjmOcm6m8duPqrIpd8TFe8gSNlECijyUl0XocifLIyUlbFblo1a96Cdy8FjyD/L882xKX9oeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725757; c=relaxed/simple;
	bh=t71dDtqkyRt9nKjhx791To5KGBDCv+dCocQrLeqjJlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTFL4rraId3oSIhTcDWF51uamKZiaINshKFEsff6RSDa1L90SrgmmOs9mlajb31l0q6uosEw0UT9vJkWnQLsBLpj768DHDdhtsvsPqe5AAznF3OSDwqs/eN1xY9Vgt5UQggC+MI9viKvbqoCNCzEJ4i37tbLuZBx25Mq8mBWWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=DMrU01HW; arc=none smtp.client-ip=101.71.155.101
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 44277315b;
	Mon, 29 Jun 2026 17:30:36 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: dawei.feng@seu.edu.cn
Cc: gregkh@linuxfoundation.org,
	jianhao.xu@seu.edu.cn,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	stern@rowland.harvard.edu,
	zilin@seu.edu.cn
Subject: Re: [PATCH] usb: free iso schedules on failed submit
Date: Mon, 29 Jun 2026 17:30:37 +0800
Message-Id: <20260629093037.3943535-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629082530.3905845-1-dawei.feng@seu.edu.cn>
References: <20260629082530.3905845-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f12b7638f03a2kunm2221069317030d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDT09MVh9OTUpLTx9DGhhMSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DMrU01HWPYmmRsCVlWhaGW1VAN3F3RUBEwTDDjeQn6yHLu7AsZ5u7HUKtvRPtly2gArOVCYMuu8xl47bq1d7nPDcxGmuKfG2Uo7Kd8tJOMppXh4CSmQce9qM58sC3YMA+qp5MH0VqCPoiqvHevOtAOkd8poO2OdOuD/cPRbxUUk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=t71dDtqkyRt9nKjhx791To5KGBDCv+dCocQrLeqjJlQ=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269703-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:gregkh@linuxfoundation.org,m:jianhao.xu@seu.edu.cn,m:linusw@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:stable@vger.kernel.org,m:stern@rowland.harvard.edu,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:dkim,seu.edu.cn:mid,seu.edu.cn:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4572E6D8664

On Mon, 29 Jun 2026 16:25:30 +0800, Dawei Feng wrote:
>Subject: [PATCH] usb: free iso schedules on failed submit
>EHCI and FOTG210 isochronous submits build an ehci_iso_sched before

Hi all,

Please ignore this patch. It was sent accidentally as a duplicate of the
previous submission. Sorry for the noise.

