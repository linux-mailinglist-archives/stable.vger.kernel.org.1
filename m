Return-Path: <stable+bounces-242525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CVEZKe0W9WmVIQIAu9opvQ
	(envelope-from <stable+bounces-242525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:11:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0414AFBAB
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55A27300B2AA
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 21:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20858423A9E;
	Fri,  1 May 2026 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilU9xnWx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D750D316192;
	Fri,  1 May 2026 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777669864; cv=none; b=RopFzqE7HzygaadiRcImzg6fhtI+ZYUvVV21Wwf5OQJrv1IJ+Xkb3FCBtrnQOL9bAs+a4nPyUonAfQAICJpBKX4Z1AL3rt46XJGx3YkWO5BlM3NwQCoN2VGQ/1jN/UCbVaYkAE/7tX7njVa8euJYtz6zJ2a+7G+RHxtvJMOfB3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777669864; c=relaxed/simple;
	bh=7NrCLfHiSyMi92eTKRzZ/y+I0FTaYJDj7gmP3R0+aXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thdBan4EjB61XbcypBNxI9ZqhUllzJ5At3CUl99IjQXDsdcIIXKaOLbex5t9D7l8wvCUQwPPyMSZW6/I85qLwwsT2G7ARUWpD98zXbIuZwseuyvAG5RorAMo4SUkfAcFhuFKD3D5V47/ovbgikPRKu71yuf5Abktzo9tKMOPKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilU9xnWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B97C2BCB8;
	Fri,  1 May 2026 21:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777669864;
	bh=7NrCLfHiSyMi92eTKRzZ/y+I0FTaYJDj7gmP3R0+aXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilU9xnWxqfV/JP7lha7zu0G4Z1vIIDEELCKQfF/OU3g7W+TkNQafCfHZm8LjEG1Bi
	 BdcKRI1hL0fn4fXPc6QiBxehVZhPRnYc07MqXpawT/cDocABjIxXAq4HJuep/Q7aOw
	 JCgAk8t+cORRzLxXuc8eM/eJ6R4GRNrxLPwQUC5OdobTTPp5q8sq5f5taETl9JKM4O
	 s9/v0Cq8zMVFJcAtcDpisaNpncZfjrINeBd7NA/E3j99p5DYPJBey6eEXIPo4XXfYY
	 35M9WAsrh2MlgvTMefg3/gFTYO4ZlBI4HY+oVvRjlJpVaMW2D7PcMm5UZ1I2KakqOe
	 CbEQEB619CghQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rong Bao <rong.bao@csmantle.top>,
	WANG Rui <wangrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 6.12.y] perf annotate: Use jump__delete when freeing LoongArch jumps
Date: Fri,  1 May 2026 17:11:00 -0400
Message-ID: <20260501200000.item004-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501123717.4109458-1-rong.bao@csmantle.top>
References: <20260501123717.4109458-1-rong.bao@csmantle.top>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B0414AFBAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242525-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]

On Fri, 01 May 2026 20:37:17 +0800, Rong Bao wrote:
> [ Upstream commit a355eefc36c4481188249b067832b40a2c45fa5c ]

Thanks, queued for 6.12.y.

--
Thanks,
Sasha

