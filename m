Return-Path: <stable+bounces-244947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBeTD8Qt/2mT3AAAu9opvQ
	(envelope-from <stable+bounces-244947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B951D4FFAD6
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C4C23066597
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F5B361DBF;
	Sat,  9 May 2026 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjz7FpjE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E570C1C5D59
	for <stable@vger.kernel.org>; Sat,  9 May 2026 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330853; cv=none; b=RchPb6glWMxirVOd/VpIUmSosGFVVoDa+Tr35dc/p4GPQnbmCbRbyaussuUJzsw2hIU8Be45TI+lYo0nhPqMhDYPIUG2ZqRWDZ0+pnr4AO10fK2EviUo9LdLc0vVG/DyBTPowDqqQpwVY1aiLDteCiLZ+aOHgEmWonzYrr6xkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330853; c=relaxed/simple;
	bh=Qtw5ufVMhNSZFOy6ndtoHubsoubNAeFTe2UzJEF05DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMRcR9ZJK1uZjoMbfCN8rZNr8CSkaR8JsEvPeXfYiTPpZSueLh0USU5c1W0QUX6Ntc6rblfQJyhYU1Xc6dgy2Q1ZqWkCiyOhnDMDBD9OPmRFRwwePR8Q9np7PjCel06q8SaWLm3yYtrE7jIB1nZuSqtGBj1VRBqw/b05gwMwp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjz7FpjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39882C2BCC7;
	Sat,  9 May 2026 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330852;
	bh=Qtw5ufVMhNSZFOy6ndtoHubsoubNAeFTe2UzJEF05DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjz7FpjE8fsY7gAtkRgpmJj1oc8r8BPZPe0wtc3/hYKc0m1G0lAceHlH0r2HSwWMA
	 1TurNZcTEEpi6KOWsDbp0dgU0Zbj0BF7xooXDbr7nFFXIbEKBr2eXoqZiVkPZAPik1
	 MtV/COvvYysQ4ZugaHXF3Sk8AXdDrskWIdr8fb6fIpDrIzm20ZuG0StRlMHGo71Wwm
	 E3OTHVW4Tr+pxJvfSPoL2zpUvQ+jqarP8K27NoXsBuQ8YYUWanIKvxSoAANjHryaAJ
	 zVo78HV0JqgPPF3WdbVGAKKCsgRJGmVt2Vb5+kPlz31WEqBKwUxGj7Dn/1aQiRoLKE
	 EMc/V6pJfJFGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Li Xiao <252270051@hdu.edu.cn>
Subject: Re: [PATCH 5.15.y] ipmi:ssif: Clean up kthread on errors
Date: Sat,  9 May 2026 08:46:56 -0400
Message-ID: <20260509122858.ae87f8133ecd.re-ipmi-ssif-cleanup-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506022034.1469433-1-corey@minyard.net>
References: <2026050148-politely-tabloid-3059@gregkh> <20260506022034.1469433-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B951D4FFAD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244947-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> [PATCH 5.15.y] ipmi:ssif: Clean up kthread on errors

Thanks for the explicit backports. I'm holding both the 5.15.y and
5.10.y submissions for now.

The folded v2 here calls complete(&ssif_info->wake_thread) before
kthread_stop and sets stopping=true on the error path, which folds
in the fix from upstream a8aebe93a493 ("ipmi:ssif: NULL thread on
error"). However, a8aebe93a493 itself is not yet in 5.15.y or 5.10.y
either, and given how the two upstream commits interact I'd rather not
take the folded form without that follow-up landed first via the
normal route. Could you also send 5.15.y/5.10.y backports of
a8aebe93a493?

--
Sasha

