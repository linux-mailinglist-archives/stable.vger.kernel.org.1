Return-Path: <stable+bounces-235900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEcNO0Bx3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:29:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E0B3E749A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 557633064658
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4C2383C92;
	Mon, 13 Apr 2026 04:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaOqUHnS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698538422B
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053643; cv=none; b=QvifkVVRj79T6vc4osycyDRjGVb9Y1f6TiF0IMlu1qAsKmtKYXMZaQdhOsTTgE90bLeoJWoMzjZk1ZqOy3a8eOx6ACAXtwQezL4oAt483l/jVCVXTAP6umNwusXuuis586bXPzL3Li77V3B8HPy483/RMQeCBLe4AEDNBhh4VGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053643; c=relaxed/simple;
	bh=COMaV1wT6Smb/1qjrLRmQfINNavpFaqp5YitixtMGZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5vTkNwzBcWVuTWsW0a/r7lT3YYNEhkZKP6VfuhFjedRqiELJZDha48yP3RDRvkAdE978X2rY2lJL+nSkVLv33Le8U5Tk6y3/2z2NR2S0NJJzDd3OXeJWqN8/n82UMgz1YgEOVYsjzXbPJoJ5IvF15Nfi0aJ9GvRChGPQyQ9vH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaOqUHnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0560FC2BCB1;
	Mon, 13 Apr 2026 04:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053643;
	bh=COMaV1wT6Smb/1qjrLRmQfINNavpFaqp5YitixtMGZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WaOqUHnSeQZ/POU0J0YGFIWAghrcrylXFTpDy1oWcFP5fFIw4U0Y6Jj7u3XCFy64w
	 jOyXak+lOyJvIZ8pkEAjbO9qU9akZ6X8jhYLKPaVYGa9PLDRm3mjuN6jNwxi4hT0Cc
	 9CtOHuRZ4C+z9efIzhJVYGxHz+bvG0xJSJiVKd8dDclz7Yo7HrM+QOGaVlB+nM1Ugg
	 EauuCtKsJAfIviSIQzr7+J/uhpy2W+qr6g0qrGmy4+vnKjMesXX2j3xk+D4RGDLxAs
	 Eu2XaZcwvNejeVmVok6Goj64xPSkdPYmZQpBNAc18L+iBCI4TfzKEyEF7p/xewqEMF
	 C3guImxUNbYOA==
From: Sasha Levin <sashal@kernel.org>
To: Robert Garcia <rob_garcia@163.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Kent Gibson <warthog618@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 5.15.y] gpiolib: cdev: fix uninitialised kfifo
Date: Mon, 13 Apr 2026 00:14:01 -0400
Message-ID: <20260412120103.gpiolib-kfifo-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409072214.164971-1-rob_garcia@163.com>
References: <20260409072214.164971-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-235900-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,bgdev.pl];
	FREEMAIL_TO(0.00)[163.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4E0B3E749A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH 5.15.y] gpiolib: cdev: fix uninitialised kfifo

Queued for 5.15, thanks.

