Return-Path: <stable+bounces-270286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NRHVJaCzRWqWEAsAu9opvQ
	(envelope-from <stable+bounces-270286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:41:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 256CF6F2A85
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:41:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FLasALrA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270286-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270286-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFB6430CEE60
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 00:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6FC25A359;
	Thu,  2 Jul 2026 00:38:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8123B61B;
	Thu,  2 Jul 2026 00:38:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952730; cv=none; b=q8MH9dE6KzQXPrUTo244bMUUN/wa52CoFWNVFBsfTAV12vYrPtG4xZJEfCVcYfBBbOYcsD0K97bs6hfxxFLxHtoiDiypJwQd9R7yCQWY9g+E/0cYigkQnZG5vgN9oXxnGp71RgJRbRcmQaxLVsjbhVeJUchdZbFTN1SE3DM/YwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952730; c=relaxed/simple;
	bh=4FEbMQDgH8S/wK4vw6nNRjwLCjNCpuBt0+xHmiav6EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPMMunQ7RezE6t0bfCgseVsIF59MfyTkNJnsGjoEU0AD5JkF2r4jFzj3KG5tIv5mGwfznsbnBySTmSMFidI2gHvPPT0xhEF7QzJFkrLULgOZdhvEnG5pE1zPgYax5jtVNJSpzZ9JJKpYcqgeznJoVLhXTPsm83u0papLZf+Nxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLasALrA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A691F00A3D;
	Thu,  2 Jul 2026 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952725;
	bh=g23Smlgv36tz/nRKQRwM2wZEV9ZS31aK9ItwDzqu71Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FLasALrAikS46IGhf1IHRhYiVYrlA1ThCPGZSHp3xCK6lTe2uimRj82mso70chRMW
	 yNDIr0FUaGMsC7OMVGfH7vcWDkjvoI1iHFubmiTCZzjhHo8vDA4OSehg1Wi5X3gEhj
	 Os/6BcciiNHpNtwbz+1cQ+K501BwkKuz8O7CxA3HuMlqUR25gjelR1z+LG1cwTlHUL
	 azAXWvRAoSn374/E9VkUiGZ82j9ihAVsPGxBa+8jLzcfFDSaJ+vBLV9K11G62L4q5j
	 fRDDzR/VlaOkc1x19nK1CYdqfnVSixsrGPK5V9IlEyN1JImQGIY/TrmX0N0049Bciw
	 Vd4K5fCcykGIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	skumar47@syr.edu,
	kumar.shivam43666@gmail.com,
	kbusch@kernel.org,
	dust.li@linux.alibaba.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philo Lu <lulie@linux.alibaba.com>
Subject: Re: [PATCH 6.6.y] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Wed,  1 Jul 2026 20:38:28 -0400
Message-ID: <stable-reply-nvmet-tcp-icreq-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701134933.66838-1-lulie@linux.alibaba.com>
References: <20260701134933.66838-1-lulie@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:gregkh@linuxfoundation.org,m:skumar47@syr.edu,m:kumar.shivam43666@gmail.com,m:kbusch@kernel.org,m:dust.li@linux.alibaba.com,m:linux-nvme@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:lulie@linux.alibaba.com,m:kumarshivam43666@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270286-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,grimberg.me,nvidia.com,linuxfoundation.org,syr.edu,gmail.com,linux.alibaba.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 256CF6F2A85

> If io_work later processes that ICReq, nvmet_tcp_handle_icreq() can
> still overwrite the state back to NVMET_TCP_Q_LIVE. That defeats the
> DISCONNECTING-state guard in nvmet_tcp_schedule_release_queue() and
> allows a later socket state change to re-enter teardown and issue a
> second kref_put() on an already released queue.

Queued for 6.6.y, thanks.

One follow-up: 6.1.y, 5.15.y, and 5.10.y carry the same unlocked
"queue->state = NVMET_TCP_Q_LIVE" assignment and don't have this fix
either. The upstream Fixes tag (c46a6465bac2) doesn't correspond to a
real mainline commit; the race goes back to the original driver in
872d26a391da ("nvmet-tcp: add NVMe over TCP target driver", v5.0), so
all three older trees are affected. The mainline commit won't pick
cleanly there for the same NVMET_TCP_Q_FAILED reason you adapted for
6.6.

Would you be able to send backports for 6.1.y/5.15.y/5.10.y as well?
Your 6.6 adaptation looks like it should carry over with minimal
context changes.

-- 
Thanks,
Sasha

