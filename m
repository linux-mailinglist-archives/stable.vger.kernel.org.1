Return-Path: <stable+bounces-249386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAUVOdVmC2qnHAUAu9opvQ
	(envelope-from <stable+bounces-249386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:21:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B315572D0A
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 926F73015784
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B6B390CAE;
	Mon, 18 May 2026 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7DSAIAY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329238F65F;
	Mon, 18 May 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132078; cv=none; b=HK7LQXR4SsITS2shjkXirUQctPH5AQKiRKiG6h36avm02WUx1e2NI+ilSTuVEa0EQu2lhGQQaulJeFmlJAJnNtHW+3Gr9l/PyeKfVtKRDPwqR/TT+A6lUVbgOnxB3Ff5aDlYqD/tsvu3oXJJOWtYcfUgH03Z8n9wa9KzHstnr20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132078; c=relaxed/simple;
	bh=aQU4RQ6ZR1rOLLvgv665SBEu8mh+LEtOS4apP7bMXaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stpHlHM7xiWqvvBq35XOchK9El8lt336XWFVgIshYtfWjeOriz3026Pmh6jTzPILMH32wWvSXeteV0xFVyrvhtJ3uiqtSdBcQXUuM1MGBmhTPiK+fjwkevJ7z70+1c+1orLcd2+5xaHj2YJQtd7fe0mmDGZ8s4TdcnO7sbb4JTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7DSAIAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24193C2BCB7;
	Mon, 18 May 2026 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132076;
	bh=aQU4RQ6ZR1rOLLvgv665SBEu8mh+LEtOS4apP7bMXaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7DSAIAYpNrQKURFUAZAnegtSOgTRT206Tlc8qMFLkcRxzMrvqIJdkWnoQekwVD18
	 AgdjflXjp0AmVIqmGruQrJVxDfj8wz5qwmCmrE6Abd1W/dBKu4Hx4kL3RyDp23/j7m
	 IVDjYjN1HrdQ1m7eozdmgewEUAkaFSCU7onMFKnqz8v8WqvvptWRIoeNbq63k5u0j4
	 3XDmrhcHxwNRjHkEK+pmCwFQ7KtfHdmqJc0iHTeyBHTQu3bkbTYlkJOBwIM/QbS7Bp
	 rrvymjbhiAWVDONB0l8MIgzVBCYw4ODs++4uacZIeZLfBwzFg3HnDoTCtwHSJBKc7Z
	 KrZu2k7nxTErg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	almaz.alexandrovich@paragon-software.com,
	ntfs3@lists.linux.dev,
	Li hongliang <1468888505@139.com>
Subject: Re: [PATCH 6.12.y] ntfs: ->d_compare() must not block
Date: Mon, 18 May 2026 15:20:59 -0400
Message-ID: <20260518155236.reply-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518042130.489507-1-1468888505@139.com>
References: <20260518042130.489507-1-1468888505@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249386-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,paragon-software.com,139.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3B315572D0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026, Li hongliang wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> [ Upstream commit ca2a04e84af79596e5cd9cfe697d5122ec39c8ce ]

Queued for 6.12, thanks.

--
Thanks,
Sasha

