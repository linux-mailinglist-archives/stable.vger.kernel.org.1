Return-Path: <stable+bounces-254678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KaRFWlLF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:52:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF645E9B73
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DDB330B6973
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE723B19DE;
	Wed, 27 May 2026 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg7Yu50C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F9C3B19B1;
	Wed, 27 May 2026 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911378; cv=none; b=AwAP19f0mnZ51BrOD1Rbft48r+Q5qJ1MkSLEWMT10xJIZemEGDYVR73MOjcTOze2P7WorH9vUulcOwzv0q5AUmJ0nn569MeladZ1HAq3zFx0kpUKHmQ5gYgJFKugi3xe15vFVEt4dz5OCCoGTuqtm+JtuuYV0x5odCO/hdLjCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911378; c=relaxed/simple;
	bh=AAui/35BdXAduW1BLpfpXGcfFy5asK/kJ+Fe6tFyXWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKEYtESaSBiG26IELStptKAgbyFhW5iYr/Ic+tsZlLFFna5GEdXYq4UqYOJUuUsBrXX+Jdmjo2DCqGs77pvN4p9RYphFP5M4tF8gNdHLUsEYSKKe/tjOhDuH7pQvYaMvX1DEYx9SKzA8bp9vmN741jFORjEyNDneK9IiCYBCLfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg7Yu50C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B5D1F00A3D;
	Wed, 27 May 2026 19:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911377;
	bh=AAui/35BdXAduW1BLpfpXGcfFy5asK/kJ+Fe6tFyXWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eg7Yu50CLmeomDkgpi6/9HXsOwbQwhVMdCa46yIB3jB8UsteWD7HCyCk937fZlV/v
	 QPo6BuRLt181aC6tvyRk8rxdhMQziK+rtTh7WKjC9+33AJY7meYCRz+tPhdWev2kIQ
	 m2hgpzQyRdBckkyBJQV7Yc0Ltx7MnVyEMitIW0cP690IGR0rFd3xuennFgSqioMvnM
	 snTl6GfAkn6yQtWWJOQEgsrs1E8xTexclHp/ciXsQnXwenEiKXTa3+Q9DVgNLWhBfp
	 BhjcdMzY2W4l4rcdls12opOq8R9rJzqkSBU7bheJAU0vjTKbb41Z1JISoRW1cFdgdH
	 WiSZVrRE/tr1A==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	adrian.hunter@intel.com
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	billy_tsai@aspeedtech.com,
	npitre@baylibre.com,
	boris.brezillon@collabora.com,
	linux-i3c@lists.infradead.org,
	Jianqiang kang <jianqkang@sina.cn>
Subject: Re: [PATCH 6.12.y] i3c: mipi-i3c-hci: Correct RING_CTRL_ABORT handling in DMA dequeue
Date: Wed, 27 May 2026 15:49:10 -0400
Message-ID: <20260527-agent5-item018-i3c@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527061933.3612126-1-jianqkang@sina.cn>
References: <20260527061933.3612126-1-jianqkang@sina.cn>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254678-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,bootlin.com,nxp.com,aspeedtech.com,baylibre.com,collabora.com,lists.infradead.org,sina.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DBF645E9B73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [ Upstream commit b795e68bf3073d67bebbb5a44d93f49efc5b8cc7 ]

Queued for 6.12.y, 6.6.y, 6.1.y and 5.15.y, thanks. The 6.12 backport
required dropping the upstream guard(mutex) usage (control_mutex doesn't
exist on these branches); the rest of the change applied cleanly.

--
Thanks,
Sasha

