Return-Path: <stable+bounces-253530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBNXAiAJD2rREQYAu9opvQ
	(envelope-from <stable+bounces-253530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:31:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E55A5D06
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4469F333AB49
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D283CA4B9;
	Thu, 21 May 2026 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcUZxqy/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7C3D9048;
	Thu, 21 May 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368170; cv=none; b=GnE5sSquv7kON3CwATDRmk5OSBbx7NSMFwc3/+38c+rOWO0pYaeQqEXz0PFlaR5bxs+sPoYknL7ecOgqNI8RhMk9M22o5n5vUTYJZ2mDE8yueUpkE6qdpi/2+mIdYhWbdHQ2AzYdmrH0kI/F95+ms32Fnlhcpr2+DMAqUQWxnuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368170; c=relaxed/simple;
	bh=VepxYsYDpjHg9Z7X0RJ5ol+6IPwAlvn1EGO+DVPIIgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBC7mN2qOqGD7+vuwXty+rKQfa3C6FebJjETyb2/rGrkC52tqwCOCjkMHFiW+jPPx7WVcm0tNBMimaJVLohvWFTtLKBjgDw1UcpEpleXXiKI+bSdT57/LMp7iMZFeJ8kxAldx7Tvp6h3fJGh2TFlL2iEhQOdguGEuPudTBzP3n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcUZxqy/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5329F1F00A3B;
	Thu, 21 May 2026 12:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368169;
	bh=VepxYsYDpjHg9Z7X0RJ5ol+6IPwAlvn1EGO+DVPIIgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FcUZxqy/HnruWa7YMjwXH5CeSx8ecmsFWT3GQVlpXvC+7L+VFi3VTyf4+76BS0KMg
	 7lLkUB6Mob+eu1L8ZZqy81GL4iyTht5GNpffHiA6CsJQ79cG+CvVGrn426qc2y8cUj
	 SZP0Ub7THhtykmSHX/7ifW5jHX0Ep9nMT45gGLnWd8G5NmFQItRYsYPHmD4dXSso+K
	 DQDfzT2YnGYKrAL8EBMcJMJPuOhf08c/Hh6zTGinVP73UvUjo+m/ihHBzwu2Ia0+0d
	 Topvn+OP9nO9WWoy3Uw1Pvttx/OcoQOY/xiwO/Q0Y1IFGMt7S3SCXXDUd8PeEWFMMO
	 1PFKqx8sgP7Qw==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Songsong Zhang <U2FsdGVkX1@gmail.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>
Subject: Re: [PATCH 7.0 1102/1146] riscv: misaligned: Make enabling delegation depend on NONPORTABLE
Date: Thu, 21 May 2026 08:55:54 -0400
Message-ID: <20260521-riscv-misaligned-drop-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <99c8c715-b37f-4f2a-8100-5ea4970ff34d@iscas.ac.cn>
References: <20260520162148.390695140@linuxfoundation.org> <20260520162213.183375345@linuxfoundation.org> <99c8c715-b37f-4f2a-8100-5ea4970ff34d@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,microchip.com,gmail.com,oss.tenstorrent.com,iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253530-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D94E55A5D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 07:28:54AM +0800, Vivian Wang wrote:
> Can we drop this 7.0 patch and the 6.18 patch [1]? There were boot time
> crashes reported on latest 7.1-rc/linux-next [2] on some
> hardware/firmware. [...]
>
> In other words I retract my Cc stable backport request for now.

Dropped from both the 7.0 and 6.18 queues.

--
Thanks,
Sasha

