Return-Path: <stable+bounces-233243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGMCHvtF0Gk45QYAu9opvQ
	(envelope-from <stable+bounces-233243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 00:58:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F34A398E42
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 00:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1824301BC22
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 22:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5E43803C1;
	Fri,  3 Apr 2026 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlX/pWjY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8B37F8BD;
	Fri,  3 Apr 2026 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257001; cv=none; b=ev3ChiR05d5OeXWce4m1ycHn7yAzOto9XJZqgm50CvS1+jW+TmoVBbOn8lAwQwKs4xRCGSuYk36KgVInnimmli+LqHHnr2eSlvyDDyeqr0347PkBaDlMHZ1Quonoe2vtl4NW/RzTOKgd9tCbVQSbRlcsDl12kTWiHc5LX+wITFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257001; c=relaxed/simple;
	bh=hXq5aKe1Bem1EjkPLh96GCcPtlZZFtOa8gsnFEtE9fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kg0O5+r4okajKAXJnM5VEhR/UjmV5KAkV9ebLQ2TNzl/PPrdP4wWa9WhUajLaCfTHiIQU5+VXXshIr9SdbpkoqAX3lElhjm4g10JUs+zYTJpPIamFoqGy2xB4wAaiuldHBAt4chotWHNWVA+9semoI3jDnIgC2VyBc8oBZT6lgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlX/pWjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A246BC4CEF7;
	Fri,  3 Apr 2026 22:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257001;
	bh=hXq5aKe1Bem1EjkPLh96GCcPtlZZFtOa8gsnFEtE9fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TlX/pWjYBi4ELtTm+x8LTUEKEMdZb4Rq4UFZcWyAK8/KqYkKj9VHDd5scvx+Qsed9
	 v3QfTJJuRT0bv3QDFuW+a9hmIx3VmPocTI/4c6KsyLWSJeskksVkOAiSFB6if5gH02
	 LDJFcFQUhYlP1knIIxqALo9GlqY8PP0EWPWGME5KOnloDuRg0vUR5V70fbswH+p1Ye
	 Sea/4R6BoNpmMQ/BiDxLt8s2ptV/y6fG6tM3Asiz+ByteQVYKW5ukeOHTVpsOMAOLk
	 UQmCoOQVDMpCYrTvGpt+Gcf2N2xj862F37zhKRm2GIPwgZZyJgGywc0Y61zfZ6pI3f
	 d/tiqAt3CWb4Q==
Date: Fri, 3 Apr 2026 15:56:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: netdev@vger.kernel.org, Lars Poeschel <poeschel@lemonage.de>, Duoming
 Zhou <duoming@zju.edu.cn>, Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nfc: pn533: allocate rx skb before consuming bytes
Message-ID: <20260403155639.070b4243@kernel.org>
In-Reply-To: <20260402042148.65251-1-pengpeng@iscas.ac.cn>
References: <20260402042148.65251-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lemonage.de,zju.edu.cn,gmail.com];
	TAGGED_FROM(0.00)[bounces-233243-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F34A398E42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  2 Apr 2026 12:21:48 +0800 Pengpeng Hou wrote:
> pn532_receive_buf() reports the number of accepted bytes to the serdev
> core. The current code consumes bytes into recv_skb and may already
> hand a complete frame to pn533_recv_frame() before allocating a fresh
> receive buffer.

no longer applies, please rebase on net/main
-- 
pw-bot: cr

